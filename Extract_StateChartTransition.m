%Extract StateName in StateChart

clc;
clear;

filename="D:\2_CodeBase\6_SimulinkTool\Sample.slx"; %Change Filename by your PC Setting

%Transitions_Table 변수는 전역변수로 선언해놓기!!
global Transitions_Table;

%Open Model File(.slx)
open_system(filename);


%Get Transition Information
transitions = find(sfroot,'-isa','Stateflow.Transition');
%get(transitions) => To find transition's value in cmd 

transitions_count=size(transitions,1);

%disp(transitions(2,1).LabelString);

for i=1:transitions_count

    % Path: Transition 존재하는 StateChart
    % From: Transition 시작되는 State
    % Destination: Transition 도착하는 State
    % Contents: Transition 안의 내용들
    % ExcutionOrder: Transition의 우선순위
    % If you wanna Structure's Contents, 
    % Write down "disp(transition(i,1).XXX(Value)"
    % ex. disp(transitions(i,1).Source.Name);
    
    
    Transitions_Table(i).Path = transitions(i).Chart.Name;
    
    % Check if From is null
    % To prevent Error
    if isempty(transitions(i,1).Source) == 0
        disp(i);
        Transitions_Table(i).From = transitions(i,1).Source.Name;
        disp(transitions(11,1).Source.Name);
    end

    %Transitions_Table(i).Destination = transitions(i).Destination.Name;

    Transitions_Table(i).Contents=transitions(i,1).LabelString;
    Transitions_Table(i).ExecutionOrder=transitions(i,1).ExecutionOrder;
    
end

close_system();