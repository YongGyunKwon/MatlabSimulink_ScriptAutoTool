
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting
%Origin_Data='Input_AAA'; %
%Modify_Data='Input_ThisisModify';


Modify_IO_Name(filename);
%Inport_sysport_Modify(Origin_Data,Modify_Data);

%Origin_Data, Modify_Data 구조체 형식으로 받아오는 방법 생각하기
function Modify_IO_Name(filename)
    open_system(filename);
    
    %for문 써서 구조체 들어가기
    
    % Origin_Data, Modify_Data도 for문에서 참고
    Origin_Input_Data="Input_AAA"; %
    Modify_Input_Data="Input_ThisisModify";
    
    Origin_Output_Data="Output_AAA"; %
    Modify_Output_Data="Output_Hello";

    %if문 써서 수정,추가,삭제 하기
    
    %1. Modify Inport
    Modify_InportName(Origin_Input_Data,Modify_Input_Data);
    %add StateChart, Transition
    
    %2. Modify Outport
    Modify_OutportName(Origin_Output_Data,Modify_Output_Data);
    
    %3. Modify Local Data

    %4. Modify Parameter

    %5. Add Input

    %6. Add Output


    %7. Add Parameter

    %8. Add Local

    %9. Delete Input

    %10. Delete Output

    %11. Delete Parameter

    %12. Delete Local

    
    
    %save_system();
end

%Modify Inport Name
function Modify_InportName(Origin_Data,Modify_Data)

    %Search Origin Inport for handle
    s=slroot;
    %Extract Inport handle
    Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
    Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);
    
    %Modify Inport Name from Origin_Data to Modify_Data
    for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name=Modify_Data;
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).PortName=Modify_Data;
    end
    
    % Extract StateChart's Input Name
    Inport_Data_handle_list=s.find('-isa','Stateflow.Data','-and','Name',Origin_Data);
    Inport_Data_handle_list_size=size(Inport_Data_handle_list,1);
    
    % Modify StateChart's InputName from Origin_Data to Modify_Data
    for Inport_Data_handle_list_Index=1:Inport_Data_handle_list_size
        Inport_Data_handle_list(Inport_Data_handle_list_Index).Name=Modify_Data;
        
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data)
end


function Modify_OutportName(Origin_Data,Modify_Data)
    
    %Search Origin Inport for handle
    s=slroot;
    Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
    Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);
    
    for Outport_sysport_handle_list_index=1:Outport_sysport_handle_list_size
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).Name=Modify_Data;
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).PortName=Modify_Data;
    end

    % Extract StateChart's Input Name
    Outport_Data_handle_list=s.find('-isa','Stateflow.Data','-and','Name',Origin_Data);
    Outport_Data_handle_list_size=size(Outport_Data_handle_list,1);
    
    % Modify StateChart's InputName from Origin_Data to Modify_Data
    for Outport_Data_handle_list_Index=1:Outport_Data_handle_list_size
        Outport_Data_handle_list(Outport_Data_handle_list_Index).Name=Modify_Data;
        
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data)
    Modify_Transition_Contents(Origin_Data,Modify_Data)
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
