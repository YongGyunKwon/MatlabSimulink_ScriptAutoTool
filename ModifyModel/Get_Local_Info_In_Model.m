% Extract_Parameter
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';

%Local_Data = Extract_LocalInfo(filepath);

open_system(filepath);

Origin_LocalData="b_LocalData";
Modify_LocalData="b_ThisModify";

Local_Data=Extract_LocalInfo(filepath);
Modify_LocalDataName(Origin_LocalData,Modify_LocalData);



function Modify_LocalDataName(Origin_Data,Modify_Data)
    s=slroot;
    Local_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Local','-and','Name',Origin_Data);
    Local_handle_list_size=size(Local_handle_list,1);
    
    for Local_handle_list_index=1:Local_handle_list_size
        Local_handle_list(Local_handle_list_index).Name=Modify_Data;
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data);
end

%Extract LocalInfo
function Local_Data=Extract_LocalInfo(filepath)
    open_system(filepath);
    s=slroot;
    Local_handle = s.find('-isa','Stateflow.Data','-and','Scope','Local');

    for Local_index=1:size(Local_handle,1)
        
        Local_Data(Local_index).Name=string(Local_handle(Local_index).Name);
        Local_Data(Local_index).DataType=string(Local_handle(Local_index).DataType);
        
    end
    
end

% Modify StateChart's Contents
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

% Modify Transition's Contents
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