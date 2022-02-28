
%Data
ModelName='Hello';
% Chart를 SubSystem으로 커버하는거 필요
% Position 조절필요

SCName=[ModelName '_State_Chart'];

% 구조체로 받을 경우 로직 일부 수정 필요
Inport_list=["Input_AAA","Input_BBB","Input_CCC","Input_DDD"];
Outport_list=["Output_AAA","Output_BBB","Output_CCC","Output_DDD"];


rt=sfroot;
prev_models=rt.find('-isa','Simulink.BlockDiagram');

sfnew;

curr_models=rt.find('-isa','Simulink.BlockDiagram');


m=setdiff(curr_models,prev_models);


ch=m.find('-isa','Stateflow.Chart');

ch.Name=SCName;
sA=Stateflow.State(ch);

sA.Name=SCName;
sA.Position = [200 200 3000 1500];


%Inport
for in=1:size(Inport_list,2)
    
    data = Stateflow.Data(ch);
    data.Name=Inport_list(in);
    data.Scope='Input';
    data.Props.Type.Method = 'Built-in';
    data.DataType = 'uint8';
end

%Outport
for out=1:size(Inport_list,2)
    
    data = Stateflow.Data(ch);
    data.Name=Outport_list(out);
    data.Scope='Output';
    data.Props.Type.Method = 'Built-in';
    data.DataType = 'uint8';
end




