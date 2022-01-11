%Extract IO list in Model

clear;

filename = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Sample11.slx';

open_system(filename);

Inport = find_system('SearchDepth',1,'BlockType','Inport');
Outport = find_system('SearchDepth',1,'BlockType','Outport');


Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];


close_system();
