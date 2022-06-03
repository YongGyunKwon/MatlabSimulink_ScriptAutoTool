AnalysisFilepath = "1.xlsx";
Analysis_To_Excel(AnalysisFilepath);

function Analysis_To_Excel(Analysis_Result,AnalysisFilepath)
    
    ExcelInternal=struct2table(Analysis_Result.Internal);
    ExcelOutnernal=struct2table(Analysis_Result.Outernal);
    ExcelParameter=struct2table(Analysis_Result.Parameter);
    
    if isstring(Analysis_Result.Local)==0
        ExcelLocal=struct2table(Analysis_Result.Local);
    end
    
    Internal_Table_Size=size(ExcelInternal,1);
    Outernal_Table_Size=size(ExcelOutnernal,1);
    Parameter_Table_Size=size(ExcelParameter,1);
    
    Internal_Index=1;
    Internal_Table_Start=2;
    Outernal_Index=Internal_Table_Start+Internal_Table_Size+2;
    Outernal_Table_Start=Outernal_Index+1;
    Parameter_Index=Outernal_Table_Start+Outernal_Table_Size+2;
    Parameter_Table_Start=Parameter_Index+1;
    
    InternalIndexcell=sprintf("B%d",Internal_Index);
    InternalTablecell=sprintf("B%d",Internal_Table_Start);
    OuternalIndexcell=sprintf("B%d",Outernal_Index);
    OuternalTablecell=sprintf("B%d",Outernal_Table_Start);
    ParameterIndexcell=sprintf("B%d",Parameter_Index);
    ParameterTablecell=sprintf("B%d",Parameter_Table_Start);
    
    
    if isstring(Analysis_Result.Local)==0
        Local_Index=Parameter_Index+Parameter_Table_Size+1;
        Local_Table_Start=Local_Index+1;
        
        LocalIndexcell=sprintf("B%d",Local_Index);
        LocalTablecell=sprintf("B%d",Local_Table_Start);
    end
    
    
    writematrix("Internal",AnalysisFilepath,'Sheet','AnalysisResult','Range',InternalIndexcell);
    writetable(ExcelInternal,AnalysisFilepath,'Sheet','AnalysisResult','Range',InternalTablecell);
    writematrix("Outernal",AnalysisFilepath,'Sheet','AnalysisResult','Range',OuternalIndexcell);
    writetable(ExcelOutnernal,AnalysisFilepath,'Sheet','AnalysisResult','Range',OuternalTablecell);
    
    writematrix("Parameter",AnalysisFilepath,'Sheet','AnalysisResult','Range',ParameterIndexcell);
    writetable(ExcelParameter,AnalysisFilepath,'Sheet','AnalysisResult','Range',ParameterTablecell);
    
    if isstring(Analysis_Result.Local)==0
        writematrix("Local",AnalysisFilepath,'Sheet','AnalysisResult','Range',LocalIndexcell);
        writetable(ExcelLocal,AnalysisFilepath,'Sheet','AnalysisResult','Range',LocalTablecell);
    end
    
end




