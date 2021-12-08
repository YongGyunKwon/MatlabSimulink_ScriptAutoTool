% Get State Name in StateChart 
% 속성에서 MATLAB -> C 로 바꾸는 방법 Source

clear;
clc;

% Open ModelFile(.slx)
filename="D:\2_CodeBase\6_SimulinkTool\Sample.slx";
open_system(filename);


%onState = find(sfroot,'-isa','Stateflow.State','Name','On');
chartArray = find(sfroot,'-isa','Stateflow.Chart');
chartArray.ActionLanguage = 'MATLAB'; %MATLAB C 
% 'MATLAB' or 'C' is Attribute.


states = find(chartArray,'-isa','Stateflow.State');
get(states,'Name');

save_system(); %Must SAVE!!!! 
close_system(); %Clsoe ModelFile