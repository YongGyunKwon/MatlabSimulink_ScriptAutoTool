
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
Result_message_Data=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);
disp("----result---")
%aa=sprintf(result_message);

function Result_message_info=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    disp(ModelSetInfo_Multi_Size);
    
    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
            
        Result_message_info(ModelSetInfo_Multi_Index).ModelName=ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName;
        Result_message_info(ModelSetInfo_Multi_Index).ClearCheck=1; %ClearCheck

        %지우기
        %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName);
        
        %Model Data Check
        ModelGuideDataCheck_Size=size(ModelingGuideStandardInfo.DataType,2);
        %disp(ModelGuideDataCheck_Size);
        ModelSet_Data_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo,2);
        %disp(ModelSet_Data_Size);
        
        %Check Data Type
        %배열 검색 함수 찾아서 하기
        DataCheckResult_index=1;

        for ModelSet_Data_Index=1:ModelSet_Data_Size
            
            disp("now");
            disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            DataCheck_result=contains(ModelingGuideStandardInfo.DataType,ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
            
            if find(DataCheck_result,1)
                Result_message_info(ModelSetInfo_Multi_Index).DataTypeCheck = 1;
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
        
    end
end