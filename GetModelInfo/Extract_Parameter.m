% Extract_Parameter
% M파일 파라미터를 불러와서 파라미터의 정보를 저장
% Key


parafilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1_Parameter.m';

Parameter_Info=Extract_ParameterInfo(parafilepath);

function Parameter_Info=Extract_ParameterInfo(parafilepath)
    Parameter_Import=importdata(parafilepath);
    Scan_Index=1;

    for PI_Index=1:size(Parameter_Import,1)
        Parameter_Format="%s = %s ;";
        Parameter_Scan_temp=textscan(string(Parameter_Import(PI_Index)),Parameter_Format);
        
        
        if contains(string(Parameter_Scan_temp(1)),'%')==0
            Parameter_Info(Scan_Index).ParameterName=string(Parameter_Scan_temp(1));
    
            Parameter_Scan_temper=split(string(Parameter_Scan_temp(2)),';');
    
            Parameter_Info(Scan_Index).Value=Parameter_Scan_temper(1);
    
            Scan_Index=Scan_Index+1;
    
        end
    
    end
    
    %disp(Parameter_Info);
end



