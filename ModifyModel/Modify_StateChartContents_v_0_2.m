clc;
clear;

filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting

Origin_Data="Input_AAA";
Modify_Data="Input_Hello";


%Open Model File(.slx)
open_system(filename);



%Get StateChart's Input list for handle
input_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Input');
input_handle_list_size=size(input_handle_list,1);

%Get StateChart's Output list for handle
output_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Output');
output_handle_list_size=size(output_handle_list,1);

%Get StateChart's Parameter list for handle
parameter_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Parameter');
parameter_handle_list_size=size(parameter_handle_list,1);





%Modify StateChart Parameter's Name
for parameter_handle_list_index=1:size(parameter_handle_list,1)

    parameter_index_name=parameter_handle_list(parameter_handle_list_index).Name;

    if strcmp(parameter_index_name,Origin_Data)
        parameter_handle_list(parameter_handle_list_index).Name=Modify_Data;
    end

end



%Transition 내용 교체
for transitions_handle_list_index=1:transitions_handle_list_size
    modify_transition_contents = strrep(transitions_handle_list(transitions_handle_list_index).LabelString,Origin_Data,Modify_Data);
    transitions_handle_list(transitions_handle_list_index).LabelString = modify_transition_contents;
end

%ParameterFile(.m) 내용 교체


%Input for StateChart 내용 교체
for input_handle_list_index=1:input_handle_list_size
    now=input_handle_list(input_handle_list_index).Name;

    if strcmp(now,Origin_Data)
        input_handle_list(input_handle_list_index).Name=Modify_Data;
        
    end
end

function Modify_StateChart_Contents(Origin_Data,Modify_Data)

    %handle
    s=slroot;

    %Get StateChart Contents list for handle
    stateschartcontents_handle_list = find(sfroot,'-isa','Stateflow.State');
    stateschartcontents_handle_list_size = size(stateschartcontents_handle_list,1);

    %StateChart 내용 교체
    for stateschartcontents_handle_list_index=1:stateschartcontents_handle_list_size
        
        modify_statechart_contents=strrep(stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString,Origin_Data,Modify_Data);
        stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString=modify_statechart_contents;
    
    end

end

function Modify_Transition_Contents(Origin_Data,Modify_Data)
    
    %handle
    s=slroot;

    %Get Transition Contents list for handle
    transitions_handle_list = find(sfroot,'-isa','Stateflow.Transition');
    transitions_handle_list_size = size(transitions_handle_list,1);
    
    for transitions_handle_list_index=1:transitions_handle_list_size
        modify_transition_contents = strrep(transitions_handle_list(transitions_handle_list_index).LabelString,Origin_Data,Modify_Data);
        transitions_handle_list(transitions_handle_list_index).LabelString = modify_transition_contents;
    end

end



%save_system(filename);
%close_system();