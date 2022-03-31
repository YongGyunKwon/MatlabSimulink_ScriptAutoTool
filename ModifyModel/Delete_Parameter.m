filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx"; %Change Filename by your PC Setting

open_system(filename);
Origin_Data="Four_bb";

Delete_ParameterName(Origin_Data);

function Delete_ParameterName(Origin_Data)
    s=slroot;
    %Stateflow의 Parameter Data 제거
    stateflow_paradata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Parameter','-and','Name',Origin_Data);
    stateflow_paradata_handle_list_size=size(stateflow_paradata_handle_list,1);
    
    for stateflow_paradata_handle_list_index=1:stateflow_paradata_handle_list_size
        delete(stateflow_paradata_handle_list(stateflow_paradata_handle_list_index));
    end
    
end