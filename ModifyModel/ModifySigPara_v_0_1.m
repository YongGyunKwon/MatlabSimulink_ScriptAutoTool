%REQ-0004

modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';
parafilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1_Parameter.m';

[Inport_Info,Outport_Info]=Get_Model_IO_Info(modelfilepath);
Parameter_Info=Extract_ParameterInfo(parafilepath);

Depth = 1; %Modify Value what you want(Depth)
open_system(modelfilepath);
find_system('SearchDepth',Depth);


%IOPara_Info
function [Inport_Info,Outport_Info] = Get_Model_IO_Info(modelfilepath)
    Depth = 1; %Modify Value what you want(Depth)

    open_system(modelfilepath);
    
    Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
    Outport = find_system('SearchDepth',Depth,'BlockType','Outport');

    Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
    Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];


    close_system();
end

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
    
end


function ModifySigPara_Info(Inport_Info,Outport_Info,Parameter_Info,modelfilepath,parafilepath)
    
    
    
    
    
    
    
end