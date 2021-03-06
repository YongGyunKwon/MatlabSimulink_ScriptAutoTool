
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
%ModelingGuideStandardInfo.ModelScreenColorSecondDepth="white";

%filelist=["D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample.slx","D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample11.slx"];
Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);


function Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    disp(ModelSetInfo_Multi_Size);
    
    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
        %ModelName
        Result_message_info(ModelSetInfo_Multi_Index).ModelName=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName;
        
        %Check Model ScreenColor
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelScreenColor ~= ModelingGuideStandardInfo.ModelScreenColor
            %0 Wrong
            Result_message_info(ModelSetInfo_Multi_Index).ScreenColorCheck = 0;
        else
            %1 정상
            Result_message_info(ModelSetInfo_Multi_Index).ScreenColorCheck = 1;
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
            disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            DataCheck_result=contains(ModelingGuideStandardInfo.DataType,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            
            if find(DataCheck_result,1)
                %Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;
            else
                %disp("Wrong Data Type");
                Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 0;
                
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Name=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Name;
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Port=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Port);
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).DataType=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType;
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Path=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Path;
                DataCheckResult_index=DataCheckResult_index+1;
            end
        end
        
        %StateChart Size
        ModelSet_State_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet,2);

        for ModelSet_State_Index=1:ModelSet_State_Size
            
            %StateChartName
            Result_message_info(ModelSetInfo_Multi_Index).StateCheckResult(ModelSet_State_Index).ChartName=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path;
             
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
        
        %result_message=append(result_message,"---------------------------------------------------------------------\n");
    end

end