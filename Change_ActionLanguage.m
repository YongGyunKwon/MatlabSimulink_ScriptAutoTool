% How to Change MATLAB to C
% 속성에서 MATLAB -> C 로 바꾸는 방법 Source

clear;
clc;

% Open ModelFile(.slx)
filename="D:\2_CodeBase\6_SimulinkTool\Sample.slx"; %Change Filename by your PC Setting
open_system(filename);

%Change ActionLanguage
chartArray = find(sfroot,'-isa','Stateflow.Chart'); % Find Attribute
chartArray.ActionLanguage = 'C'; %MATLAB C 


save_system(); %Must SAVE!!!! 
close_system(); %Clsoe ModelFile