CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo);

ModelingGuideStandardInfo.DataType=["uint8","uint32","single","boolean"];
ModelingGuideStandardInfo.SolverType="FixedStepDiscrete";
ModelingGuideStandardInfo.FixedStep="dT";
ModelingGuideStandardInfo.ActionLanguage="C";
ModelingGuideStandardInfo.Decomposition="PARALLEL_AND";
ModelingGuideStandardInfo.ChartColor="fffcec";
ModelingGuideStandardInfo.TransitionColor="528bc5";
ModelingGuideStandardInfo.TransitionColor="528bc5";
ModelingGuideStandardInfo.JunctionColor="c67f00";
ModelingGuideStandardInfo.ModelScreenColorFirstDepth="white";
ModelingGuideStandardInfo.ModelScreenColorSecondDepth="white";


function CheckModelingGuide(ModelSetInfo_Multi,ModelingGuideStandardInfo)
    ModelSetInfo_Multi_Size=size(ModelSetInfo_Multi,2);
    disp(ModelSetInfo_Multi_Size);
    
    for ModelSetInfo_Multi_Index=1:ModelSetInfo_Multi_Size
        
        %Disp ModelName
        disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).FileName);
        disp(ModelSetInfo_Multi(ModelSetInfo_Multi_Index).ModelName);

        %Model Data Check
        ModelGuideDataCheck_Size=size(ModelingGuideStandardInfo.DataType,2);

        






    end

end