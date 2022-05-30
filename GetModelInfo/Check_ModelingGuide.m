%REQ-0005
%모델링 가이드 준수

%Modeling Guide Info
ModelingGuideStandardInfo.DataType=["uint8","uint32","single","boolean"];
ModelingGuideStandardInfo.SolverType="FixedStepDiscrete";
ModelingGuideStandardInfo.FixedStep="dT";
ModelingGuideStandardInfo.ActionLanguage="C";
ModelingGuideStandardInfo.Decomposition="PARALLEL_AND";
ModelingGuideStandardInfo.ChartColor="#FFFCEC";%fffcec
ModelingGuideStandardInfo.TransitionColor="#528BC5";%528bc5
ModelingGuideStandardInfo.TransitionLabelColor="#528BC5";%528bc5
ModelingGuideStandardInfo.JunctionColor="#C67F00"; %c67f00
ModelingGuideStandardInfo.ModelScreenColor="white";

% Get ModelSetting Information
filelist=["D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample.slx","D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample11.slx"];

ModelSetInfo_Multi=ModelSetInfo_Mudlti(filelist);
Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);
textmessage=Disp_Result_message(Result_message_info);

%Get ModelSet Info for Multi
function ModelSetInfo_Multi=ModelSetInfo_Mudlti(filelist)
    filelist_size=size(filelist,2);
    
    for filelist_index=1:filelist_size
        ModelSetInfo_Multi(filelist_index).FileName=string(filelist(filelist_index));
        ModelSetInfo_Multi(filelist_index).ModelFileInfo=Get_ModelSetInfo(string(filelist(filelist_index)));
    end
end

%Get ModelSet Info
function ModelSetInfo=Get_ModelSetInfo(filepath)
    
    ModelName_split=split(filepath,'\');
    ModelName_file=string(ModelName_split(end));
        
    ModelName_file_split_a=split(ModelName_file,'.slx');
    ModelFileName=string(ModelName_file_split_a(1));
    

    open_system(filepath);
    %modelpath=find_system(SearchDepth','1');
    
    s=slroot;
    
    SubSystemPath=find_system('SearchDepth',1,'BlockType','SubSystem');
    ModelFilename_a=split(SubSystemPath,"/");
    FirstDepthName=string(ModelFilename_a(1));
    
    %ModelFileName
    ModelSetInfo.ModelName=FirstDepthName;

    statechart_handle=s.find('-isa','Stateflow.Chart');
    statechart_handle_size=size(statechart_handle,1);

    % Extract StateChart Color
    for statechart_handle_index=1:statechart_handle_size
        ModelSetInfo.StateChartSet(statechart_handle_index).Path=statechart_handle(statechart_handle_index).Path;
        ModelSetInfo.StateChartSet(statechart_handle_index).ActionLanguage=statechart_handle(statechart_handle_index).ActionLanguage;
        ModelSetInfo.StateChartSet(statechart_handle_index).Decomposition=statechart_handle(statechart_handle_index).Decomposition;
        ModelSetInfo.StateChartSet(statechart_handle_index).ChartColor=rgb2hex(statechart_handle(statechart_handle_index).ChartColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).TransitionColor=rgb2hex(statechart_handle(statechart_handle_index).TransitionColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).TransitionLabelColor=rgb2hex(statechart_handle(statechart_handle_index).TransitionLabelColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).JunctionColor=rgb2hex(statechart_handle(statechart_handle_index).JunctionColor);
    
    end
    
    
    % Extract Data Type Information
    statechart_data_handle=s.find('-isa','Stateflow.Data');
    statechart_data_handle_size=size(statechart_data_handle,1);
    
    for statechart_data_handle_index=1:statechart_data_handle_size
        ModelSetInfo.DataInfo(statechart_data_handle_index).Name=statechart_data_handle(statechart_data_handle_index).Name;
        ModelSetInfo.DataInfo(statechart_data_handle_index).Port=statechart_data_handle(statechart_data_handle_index).Port;
        ModelSetInfo.DataInfo(statechart_data_handle_index).Scope=statechart_data_handle(statechart_data_handle_index).Scope;
        ModelSetInfo.DataInfo(statechart_data_handle_index).Path=statechart_data_handle(statechart_data_handle_index).Path;
        ModelSetInfo.DataInfo(statechart_data_handle_index).DataType=statechart_data_handle(statechart_data_handle_index).DataType;
        
    end
    
    %Extract Solver Information
    myConfigObj = getActiveConfigSet(FirstDepthName); %매개변수에 모델명 넣기
    slxConfigset =myConfigObj.find('Name','Solver');
    
    % Solver Type
    ModelSetInfo.SolverType=slxConfigset.SolverName;
    % Fixed-Step
    ModelSetInfo.FixedStep=slxConfigset.FixedStep;
    
    %Get ScreenColor
    ModelSetInfo.ModelScreenColor=string(get_param(FirstDepthName,'ScreenColor')); 
    
    close_system(filepath);

end

%Change Color rgb to Hex
function [ hex ] = rgb2hex(rgb)
    
    assert(nargin==1,'This function requires an RGB input.') 
    assert(isnumeric(rgb)==1,'Function input must be numeric.') 
    sizergb = size(rgb); 
    assert(sizergb(2)==3,'rgb value must have three components in the form [r g b].')
    assert(max(rgb(:))<=255& min(rgb(:))>=0,'rgb values must be on a scale of 0 to 1 or 0 to 255')
    
    % If no value in RGB exceeds unity, scale from 0 to 255: 
    if max(rgb(:))<=1
        rgb = round(rgb*255); 
    else
        rgb = round(rgb); 
    end
    % Convert (Thanks to Stephen Cobeldick for this clever, efficient solution):
    hex(:,2:7) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
    hex(:,1) = '#';
end


function Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    %disp(ModelSetInfo_Multi_Size);
    
    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
        %ModelName
        Result_message_info(ModelSetInfo_Multi_Index).ModelName=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName);
        
        %Check Model ScreenColor
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelScreenColor ~= ModelingGuideStandardInfo.ModelScreenColor
            %0 Wrong
            Result_message_info(ModelSetInfo_Multi_Index).CheckScreenColor = 0;
        else
            %1 정상
            Result_message_info(ModelSetInfo_Multi_Index).CheckScreenColor = 1;
        end

        %Check Solver Type
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.SolverType ~= ModelingGuideStandardInfo.SolverType
            %0 Wrong
            Result_message_info(ModelSetInfo_Multi_Index).CheckSolverType = 0;
        else
            %1 정상
            Result_message_info(ModelSetInfo_Multi_Index).CheckSolverType = 1;
        end

        %Check Fixed-Step
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.FixedStep ~= ModelingGuideStandardInfo.FixedStep
            %0 Wrong
            Result_message_info(ModelSetInfo_Multi_Index).CheckFixedStep = 0;
        else
            %1 정상
            Result_message_info(ModelSetInfo_Multi_Index).CheckFixedStep = 1;
        end

        
        %Model Data Check
        %여기먼저 검토하기
        ModelGuideDataCheck_Size=size(ModelingGuideStandardInfo.DataType,2);
        ModelSet_Data_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo,2);
        
        %Check Data Type
        DataCheckResult_index=1;
        
        Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;

        for ModelSet_Data_Index=1:ModelSet_Data_Size

            %DataType Check Logic
            %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            DataCheck_result=contains(ModelingGuideStandardInfo.DataType,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            
            if find(DataCheck_result,1)
                %Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;
            else
                %disp("Wrong Data Type");
                Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 0;
                
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Name=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Name);
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Port=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Port);
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).DataType=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Path=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Path);
                DataCheckResult_index=DataCheckResult_index+1;
            end
        end
        
        %StateChart Size
        ModelSet_State_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet,2);

        for ModelSet_State_Index=1:ModelSet_State_Size
            
            %StateChartName
            Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).ChartName=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
             
            %Check Action Language
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).ActionLanguage~=ModelingGuideStandardInfo.ActionLanguage
                %0 Wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckActionLanguage=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckActionLanguage=1;
            end
            
            %Check Decomposition
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Decomposition~=ModelingGuideStandardInfo.Decomposition
                %0 Wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckDecomposition=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckDecomposition=1;
            end
            
            %Check ChartColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).ChartColor~=ModelingGuideStandardInfo.ChartColor
                %0 Wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckChartColor=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckChartColor=1;
            end

            %Check TransitionColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).TransitionColor~=ModelingGuideStandardInfo.TransitionColor
                %0 Wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckTransitionColor=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckTransitionColor=1;
            end

            %Check TransitionLabelColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).TransitionLabelColor~=ModelingGuideStandardInfo.TransitionLabelColor
                %0 wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckTransitionLabelColor=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckTransitionLabelColor=1;
            end

            %Check Junction Color
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).JunctionColor~=ModelingGuideStandardInfo.JunctionColor
                %0 Wrong
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckJunctionColor=0;
            else
                %1 정상
                Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).CheckJunctionColor=1;
            end
        end
    end
end

function Result_message_Text=Disp_Result_message(Result_message_info)

    Result_message_info_Size=size(Result_message_info,2);
    Result_message_Text="";
    for Result_message_Index=1:Result_message_info_Size
       fprintf("ModelName: %s\n",Result_message_info(Result_message_Index).ModelName);
       aa=sprintf("ModelName: %s\n",Result_message_info(Result_message_Index).ModelName);
       Result_message_Text=append(Result_message_Text,aa);
       
       if Result_message_info(Result_message_Index).CheckScreenColor == 0
           fprintf("Wrong Screen Color\n");
           Result_message_Text=append(Result_message_Text,"Wrong Screen Color\n");
       end
       
       if Result_message_info(Result_message_Index).CheckSolverType == 0
           fprintf("Wrong Solver Type\n");
           Result_message_Text=append(Result_message_Text,"Wrong Solver Type\n");
       end

       if Result_message_info(Result_message_Index).CheckFixedStep == 0
           fprintf("Wrong Fixed-Step\n");
           Result_message_Text=append(Result_message_Text,"Wrong Fixed-Step\n");
       end

       if Result_message_info(Result_message_Index).DataTypeCheck == 0
           fprintf("Wrong DataType\n");
           Result_message_Text=append(Result_message_Text,"Wrong DataType\n");
           DataCheck_Size=size(Result_message_info(Result_message_Index).DataCheckResult,2);
           
           for DataCheck_Index=1:DataCheck_Size
               fprintf("SignalName:%s\t DataType: %s\t Path: %s\n",Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).Name,Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).DataType,Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).Path);
               bb=sprintf("SignalName:%s\t DataType: %s\t Path: %s\n",Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).Name,Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).DataType,Result_message_info(Result_message_Index).DataCheckResult(DataCheck_Index).Path);
               Result_message_Text=append(Result_message_Text,bb);
           end

       end
        
       StateCheck_Result_Size=size(Result_message_info(Result_message_Index).StateCheckResult,2);
       
       for StateCheck_Result_Index=1:StateCheck_Result_Size
            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckActionLanguage==0
                fprintf("%s\t Wrong Action Language\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                cc=sprintf("%s\t Wrong Action Language\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,cc);
            end
            
            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckDecomposition==0
                fprintf("%s\t Wrong Decomposition\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                dd=sprintf("%s\t Wrong Decomposition\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,dd);
            end
            
            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckChartColor==0
                fprintf("%s\t Wrong Chart Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                ee=sprintf("%s\t Wrong Chart Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,ee);
            end

            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckTransitionColor==0
                fprintf("%s\t Wrong Transition Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                ff=sprintf("%s\t Wrong Transition Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,ff);
            end
            
            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckTransitionLabelColor==0
                fprintf("%s\t Wrong Transition Label Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                gg=sprintf("%s\t Wrong Transition Label Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,gg);

            end

            if Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).CheckJunctionColor==0
                fprintf("%s\t Wrong Junction Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                hh=sprintf("%s\t Wrong Junction Color\n",Result_message_info(Result_message_Index).StateCheckResult(StateCheck_Result_Index).ChartName);
                Result_message_Text=append(Result_message_Text,hh);
            end

       end
    end
end