%REQ-0004
%Get ModelSignal
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Analysis_Model\AnalysisSample11.slx"; %Change Filename by your PC Setting

open_system(filename);

s=slroot;


line = s.find('-isa','Simulink.Signal');




%Find all the line handles for this model
%h = find_system(bdroot,'FindAll','On','type', 'line');

%hblkSrc = get_param(h(1),'SrcBlockHandle');
%hblkDst = get_param(h(1),'DstBlockHandle');


%aa = get_param(h(1),'LineHandles');