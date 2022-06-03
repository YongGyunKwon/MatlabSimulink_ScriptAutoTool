clear;
    
filename = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Analysis_Model\AnalysisSample11.slx';
Depth = 1;
    
open_system(filename);
    
Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
Outport = find_system('SearchDepth',Depth,'BlockType','Outport');

    
Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];
    
    
close_system();
