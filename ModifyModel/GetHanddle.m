

modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';

open_system(modelfilepath);

s=sfroot;
Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Path','Sample_v_0_1');
%Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);

for i=1:Outport_sysport_handle_list_size
    disp(Outport_sysport_handle_list(i).Name);
    disp(Outport_sysport_handle_list(i).Path);
end