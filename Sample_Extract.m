clear;
clc;

%Inport - Outport

%Inport;
%Outport;

%Open SimulinkModel File

filename="D:\2_CodeBase\6_SimulinkTool\Sample.slx";

%open_system(filename);

%s=slroot;


%chartArray = s.find('-isa','Stateflow.State');
%states = chartArray.find('-isa','Stateflow.State');
%get(chartArray.Path);


%close_system();


onState = find(sfroot,'-isa','Stateflow.State','Name','On');
chartArray = find(sfroot,'-isa','Stateflow.Chart');


states = find(chartArray,'-isa','Stateflow.State');
get(states,'Name');
