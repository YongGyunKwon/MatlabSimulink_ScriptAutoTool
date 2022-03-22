
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting

Origin_Data='Input_AAA';
Modify_Data='Input_ThisisModify';

open_system(filename);

%Inport = find_system('SearchDepth',1,'BlockType','Inport');
%Outport = find_system('SearchDepth',1,'BlockType','Outport');

%Inport(1);

s=slroot;


%input_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Input');
%Inport_subsystem=s.find('-isa','Simulink.Inport','-and','BlockType','Inport');

%Search Origin Outport for handle
%Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name','Input_BBB');

Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);

for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
    Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name=Modify_Data;
    Inport_sysport_handle_list(Inport_sysport_handle_list_index).PortName=Modify_Data;
end



%Search Origin Outport for handle
Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);

for Outport_sysport_handle_list_index=1:Outport_sysport_handle_list_size
    Outport_sysport_handle_list(Outport_sysport_handle_list_index).Name=Modify_Data;
    Outport_sysport_handle_list(Outport_sysport_handle_list_index).PortName=Modify_Data;
end


function Inport_sysport_Modify(Origin_Data,Modify_Data)
    %Search Origin Outport for handle
    %Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name','Input_BBB');
    
    s=slroot;

    Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
    Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);
    
    for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name=Modify_Data;
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).PortName=Modify_Data;
    end

end






%Inport_sysport_handle_list(1).Name='Input_asdasdasdas';
%Inport_sysport_handle_list(2).Name='Input_asdasdasdas';
%Inport_sysport_handle_list(3).Name='Input_asdasdasdas';

%둘다 바꿔주기
%Inport_sysport_handle_list(1).Name='Input_ASDF';
%Inport_sysport_handle_list(1).PortName='Input_ASDF';

%aa=find_system('BlockType','Inport');

%Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];


%Inport(1).set_param('Name','Input_ASDF');
%set(Inport(1),'Name','Input_ASDF');


%portData = get_param('Sample_v_0_1/Input_AAA');
