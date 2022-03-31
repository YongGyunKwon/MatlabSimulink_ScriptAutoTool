% Extract_Parameter
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';



Parameter_Data=Extract_ParameterInfo(filepath);
Origin_Data="SystemOn";
Modify_Data="SystemOffOn";



open_system(filepath);
Modify_ParameterName(Origin_Data,Modify_Data);


function Modify_ParameterName(Origin_Data,Modify_Data)
    s=slroot;
    Parameter_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Parameter','-and','Name',Origin_Data);
    Parameter_handle_list_size=size(Parameter_handle_list,1);

    for Parameter_handle_list_index=1:Parameter_handle_list_size
        
        Parameter_handle_list(Parameter_handle_list_index).Name=Modify_Data;
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data);
end



function Parameter_Data=Extract_ParameterInfo(filepath)
    open_system(filepath);
    s=slroot;
    Parameter_handle = s.find('-isa','Stateflow.Data','-and','Scope','Parameter');
    
    %Parameter_data()
    
    Parameter_Data_Index=1;

    for paramter_index=1:size(Parameter_handle,1)
        
        Parameter_Data(paramter_index).Name=string(Parameter_handle(paramter_index).Name);
        
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
