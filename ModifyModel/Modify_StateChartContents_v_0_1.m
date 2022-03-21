clc;
clear;

filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting

Origin_Data='Four_aa';
Modify_Data='Four_bb';


%Open Model File(.slx)
open_system(filename);

%handle
s=slroot;

%Get StateChart's Input list for handle
input_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Input');
input_handle_list_size=size(input_handle_list,1);

%Get StateChart's Output list for handle
output_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Output');
output_handle_list_size=size(output_handle_list,1);

%Get StateChart's Parameter list for handle
parameter_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Parameter');
parameter_handle_list_size=size(parameter_handle_list,1);

%Get StateChart Contents list for handle
stateschartcontents_handle_list = find(sfroot,'-isa','Stateflow.State');
stateschartcontents_handle_list_size = size(stateschartcontents_handle_list,1);

%Get Transition Contents list for handle
transitions_handle_list = find(sfroot,'-isa','Stateflow.Transition');
transitions_handle_list_size = size(transitions_handle_list,1);


%Modify Parameter list's Name
for parameter_handle_list_index=1:size(parameter_handle_list,1)

    parameter_index_name=parameter_handle_list(parameter_handle_list_index).Name;

    if strcmp(parameter_index_name,Origin_Data)
        parameter_handle_list(parameter_handle_list_index).Name=Modify_Data;
    end

end

%StateChart 내용 교체
for stateschartcontents_handle_list_index=1:stateschartcontents_handle_list_size
    
    modify_statechart_contents=strrep(stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString,Origin_Data,Modify_Data);
    stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString=modify_statechart_contents;

end

%Transition 내용 교체
for transitions_handle_list_index=1:transitions_handle_list_size
    modify_transition_contents = strrep(transitions_handle_list(transitions_handle_list_index).LabelString,Origin_Data,Modify_Data);
    transitions_handle_list(transitions_handle_list_index).LabelString = modify_transition_contents;
end

%ParameterFile(.m) 내용 교체


%Inport for SubSystem 내용 교체


%Outport for SubSystem 내용 교체



%StaeChart_Table;

%for i=1:StateChart_Count
    
    %disp(get(states(i),'Path'));
    %disp(states(i).Path);

    %StateChart_Table(i).Path = states_handle_list(i).Path;
    %StateChart_Table(i).Name = states_handle_list(i).Name;
    %StateChart_Table(i).Contents = states_handle_list(i).LabelString;
%end


%States(1);


save_system(filename);
%close_system();