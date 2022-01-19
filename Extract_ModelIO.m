%Extract IO list in Model

% Issue: Depth2 이상일 경우 필요없는 값들이 불러와서 해결필요


clear;

filename = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Sample.slx';
Depth = 1; %Modify Value what you want(Depth)



open_system(filename);

Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
Outport = find_system('SearchDepth',Depth,'BlockType','Outport');


Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];


close_system();

