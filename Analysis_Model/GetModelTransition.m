filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Analysis_Model\AnalysisSample11.slx"; %Change Filename by your PC Setting
Depth = 1;



open_system(filename);


s=slroot;
Transition_Handle = s.find('-isa','Simulink.Signal');
