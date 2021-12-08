clc;
clear;

filename="D:\2_CodeBase\6_SimulinkTool\Sample.slx"; %Change Filename by your PC Setting

%Open Model File(.slx)
open_system(filename);

%Get StateChart Information
states = find(sfroot,'-isa','Stateflow.State');

StateChart_Count = size(states,1);

%StaeChart_Table;

for i=1:StateChart_Count
    
    %disp(get(states(i),'Path'));
    %disp(states(i).Path);
    
    

    StateChart_Table(i).Path = states(i).Path;
    StateChart_Table(i).Name = states(i).Name;
    StateChart_Table(i).Contents = states(i).LabelString;
end

%StartChartPath = get(states,'Path');
%StateChartName = get(states,'Name');
%StateChartContents = get(states,'LabelString');