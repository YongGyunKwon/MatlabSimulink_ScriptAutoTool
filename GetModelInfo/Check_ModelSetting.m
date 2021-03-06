

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
result_message=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);
disp("----result---")
aa=sprintf(result_message);

function result_message=CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    disp(ModelSetInfo_Multi_Size);
    
    result_message="";

    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
        
        %Disp ModelName
        %result_message=append(result_message,"ModelFileName:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).FileName,"\n");
        %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).FileName);
        
        result_message=append(result_message,"ModelName:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName,"\n");
        
        disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelName);
        

        %Check Model ScreenColor
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.ModelScreenColor ~= ModelingGuideStandardInfo.ModelScreenColor
            disp("Wrong Model ScreenColor");
            result_message=append(result_message,"Wrong ModelScreenColor\n");
        end

        %Check Solver Type
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.SolverType ~= ModelingGuideStandardInfo.SolverType
            disp("Wrong SolverType");
            result_message=append(result_message,"Wrong SolverType\n");
        end

        %Check Fixed-Step
        if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.FixedStep ~= ModelingGuideStandardInfo.FixedStep
            disp("Wrong Fixed Step");
            result_message=append(result_message,"Wrong Fixed Step\n");
        end

        
        %Model Data Check
        ModelGuideDataCheck_Size=size(ModelingGuideStandardInfo.DataType,2);
        %disp(ModelGuideDataCheck_Size);
        ModelSet_Data_Size=size(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo,2);
        %disp(ModelSet_Data_Size);
        
        %Check Data Type
        %?????? ?????? ?????? ????????? ??????
        for ModelSet_Data_Index=1:ModelSet_Data_Size
            %disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index));
            
            for ModelGuideDataCheck_Index=1:ModelGuideDataCheck_Size
                check=0;
                if ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType~=ModelingGuideStandardInfo.DataType(ModelGuideDataCheck_Index)
                    check=1;
                end
            end
            if check==1
                disp("Wrong Data Type");
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Name);
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Port);
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
                disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Path);

                result_message=append(result_message,"Wrong Data Type\n");
                result_message=append(result_message,"Name:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Name);
                result_message=append(result_message,"  Port:",string(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Port));
                result_message=append(result_message,"  DataType:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).DataType);
                result_message=append(result_message,"  Path:",ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelFileInfo.DataInfo(ModelSet_Data_Index).Path);
                result_message=append(result_message,"\n");
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
        
        result_message=append(result_message,"---------------------------------------------------------------------\n");
    end

    

end