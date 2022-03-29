filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx"; %Change Filename by your PC Setting

open_system(filename);
Origin_Data="b_Running";

Delete_LocalDataName(Origin_Data);

function Delete_LocalDataName(Origin_Data)
    s=slroot;
    %Stateflow의 Local Data 제거
    stateflow_localdata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Local','-and','Name',Origin_Data);
    stateflow_localdata_handle_list_size=size(stateflow_localdata_handle_list,1);
    
    for stateflow_localdata_handle_list_index=1:stateflow_localdata_handle_list_size
        delete(stateflow_localdata_handle_list(stateflow_localdata_handle_list_index));
    end
    
end