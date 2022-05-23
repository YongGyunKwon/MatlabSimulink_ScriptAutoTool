
%Modeling Guide Info
ModelingGuideStandardInfo.DataType=["uint8","uint32","single","boolean"];
ModelingGuideStandardInfo.SolverType="FixedStepDiscrete";
ModelingGuideStandardInfo.FixedStep="dT";
ModelingGuideStandardInfo.ActionLanguage="C";
ModelingGuideStandardInfo.Decomposition="PARALLEL_AND";
ModelingGuideStandardInfo.ChartColor="fffcec";
ModelingGuideStandardInfo.TransitionColor="528bc5";
ModelingGuideStandardInfo.TransitionLabelColor="528bc5";
ModelingGuideStandardInfo.JunctionColor="c67f00";
ModelingGuideStandardInfo.ModelScreenColor="white";
%ModelingGuideStandardInfo.ModelScreenColorSecondDepth="white";

%filelist=["D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample.slx","D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample11.slx"];
Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);
disp("----result---")
%aa=sprintf(result_message);

function Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    disp(ModelSetInfo_Multi_Size);
    
    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
        
        result_message='';

        %Disp ModelName
        %result_message=append(result_message,"ModelFileName:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).FileName,"\n");
        %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).FileName);
        
        %지우기
        result_message=append(result_message,"ModelName:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName,"\n");
        
        Result_message_info(ModelSetInfo_Multi_Index).ModelName=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName;
        Result_message_info(ModelSetInfo_Multi_Index).ClearCheck=1; %ClearCheck

        %지우기
        disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName);
        

        %Check Model ScreenColor
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelScreenColor ~= ModelingGuideStandardInfo.ModelScreenColor
            disp("Wrong Model ScreenColor");
            %result_message=append(result_message,"Wrong ModelScreenColor\n");
            
            Result_message_info(ModelSetInfo_Multi_Index).ClearCheck=0;
            Result_message_info(ModelSetInfo_Multi_Index).ScreenColorCheck = 0;
        
        else
            Result_message_info(ModelSetInfo_Multi_Index).ScreenColorCheck = 1;
            
        end

        %Check Solver Type
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.SolverType ~= ModelingGuideStandardInfo.SolverType
            disp("Wrong SolverType");
            %result_message=append(result_message,"Wrong SolverType\n");
            Result_message_info(ModelSetInfo_Multi_Index).SolverTypeCheck = 1;
        else
            Result_message_info(ModelSetInfo_Multi_Index).ClearCheck=0;
            Result_message_info(ModelSetInfo_Multi_Index).SolverTypeCheck = 0;
        end

        %Check Fixed-Step
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.FixedStep ~= ModelingGuideStandardInfo.FixedStep
            disp("Wrong Fixed Step");
            %result_message=append(result_message,"Wrong Fixed Step\n");
            Result_message_info(ModelSetInfo_Multi_Index).SolverTypeCheck = 1;
        else
            Result_message_info(ModelSetInfo_Multi_Index).ClearCheck=0;
            Result_message_info(ModelSetInfo_Multi_Index).SolverTypeCheck = 0;

        end

        
        %Model Data Check
        %여기먼저 검토하기
        ModelGuideDataCheck_Size=size(ModelingGuideStandardInfo.DataType,2);
        %disp(ModelGuideDataCheck_Size);
        ModelSet_Data_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo,2);
        %disp(ModelSet_Data_Size);
        
        %Check Data Type
        DataCheckResult_index=1;
        
        Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;

        for ModelSet_Data_Index=1:ModelSet_Data_Size
            
            disp("now");
            disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            DataCheck_result=contains(ModelingGuideStandardInfo.DataType,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            
            if find(DataCheck_result,1)
                %Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;
            else
                disp("Wrong Data Type");
                Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 0;
                
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Name=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Name;
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Port=string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Port);
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).DataType=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType;
                Result_message_info(ModelSetInfo_Multi_Index).DataCheckResult(DataCheckResult_index).Path=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Path;
                DataCheckResult_index=DataCheckResult_index+1;
            end
        end
        
        %StateChart Check
        ModelSet_State_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet);
        
        for ModelSet_State_Index=1:ModelSet_State_Size
            %ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index)
            disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index));
            
            %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);

            %Check Action Language
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).ActionLanguage~=ModelingGuideStandardInfo.ActionLanguage

                disp("Wrong ActionLanguage");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append(result_message,"Wrong ActionLanguage ");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append(result_message,"\n");
            end
            
            %Check Decomposition
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Decomposition~=ModelingGuideStandardInfo.Decomposition
                disp("Wrong Decomposition");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                
                result_message=append(result_message,"Wrong Decomposition ");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append(result_message,"\n");
            end
            
            %Check ChartColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).ChartColor~=ModelingGuideStandardInfo.ChartColor
                disp("Wrong Chart Color");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                
                result_message=append(result_message,"Wrong Chart Color ");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append("\n");

            end
            %Check TransitionColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).TransitionColor~=ModelingGuideStandardInfo.TransitionColor
                disp("Wrong Transition Color");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append(result_message,"Wrong Transition Color ");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append(result_message,"\n");
            end

            %Check TransitionLabelColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).TransitionLabelColor~=ModelingGuideStandardInfo.TransitionLabelColor
                disp("Wrong TransitionLabel Color");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                
                result_message=append(result_message,"Wrong Transition Color");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append("\n");

            end

            %Check JunctionColor
            if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).JunctionColor~=ModelingGuideStandardInfo.JunctionColor
                disp("Wrong Junction Color");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);

                result_message=append(result_message,"Wrong Junction Color");
                result_message=append(result_message,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.StateChartSet(ModelSet_State_Index).Path);
                result_message=append("\n");
            end
            
        end
        
        %result_message=append(result_message,"---------------------------------------------------------------------\n");
    end

    

end