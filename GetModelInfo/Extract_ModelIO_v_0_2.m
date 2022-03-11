
modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1.slx';

[Inport_Info,Outport_Info]=Get_Model_IO_Info(modelfilepath);

disp(Inport_Info);
disp(Outport_Info);




% Get Model I/O Information
%Model에서 Inport, Outport 정보 추출
% in 1 Depth
function [Inport_Info,Outport_Info] = Get_Model_IO_Info(filename)
    Depth = 1; %Modify Value what you want(Depth)

    open_system(filename);
    
    Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
    Outport = find_system('SearchDepth',Depth,'BlockType','Outport');

    Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
    Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];

    close_system();
end