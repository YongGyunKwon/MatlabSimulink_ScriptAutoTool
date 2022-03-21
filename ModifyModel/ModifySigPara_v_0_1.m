%REQ-0004

modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';
parafilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1_Parameter.m';

%[Inport_Info,Outport_Info]=Get_Model_IO_Info(modelfilepath);
%Parameter_Info=Extract_ParameterInfo(parafilepath);


open_system(modelfilepath);
Input_Hand=find_system('SearchDepth',1,'BlockType','Inport','Name','Input_AAA');
%Input_Handle = slreportgen.utils.getModelHandle(Input_Hand);
%set(c(1),'Name','Input_ASDF');

%^modelHandle_blk = slreportgen.utils.getModelHandle('Sample_v_0_1/Input_AAA');


%Inport_ff= find_system('SearchDepth',Depth,'BlockType','Inport');
%a=replace_block('Sample_v_0_1','Sample_v_0_1/Input_AAA','Sample_v_0_1/Input_CCC');

s=slroot;
c=s.find('-isa','Stateflow.Data','-and','Scope','Input');
%c(1).Name='Input_ASDF';
set(c(1),'Name','Input_ASDF');

save_system();
close_system();


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

% Extract Parameterlist
% Data
function Parameter_Info=Extract_ParameterInfo(parafilepath)
    Parameter_Import=importdata(parafilepath);
    Scan_Index=1;

    for PI_Index=1:size(Parameter_Import,1)
        Parameter_Format="%s = %s ;";
        Parameter_Scan_temp=textscan(string(Parameter_Import(PI_Index)),Parameter_Format);
        
        
        if contains(string(Parameter_Scan_temp(1)),'%')==0

            %ParameterName: 파라미터 이름
            %Value: 파라미터 값
            
            Parameter_Info(Scan_Index).ParameterName=string(Parameter_Scan_temp(1));
            Parameter_Scan_temper=split(string(Parameter_Scan_temp(2)),';');
            Parameter_Info(Scan_Index).Value=Parameter_Scan_temper(1);
    
            Scan_Index=Scan_Index+1;
    
        end
    
    end
    
end


function ModifySigPara_Info(Inport_Info,Outport_Info,Parameter_Info,modelfilepath,parafilepath)
    
    
    
    
    
    
    
end

