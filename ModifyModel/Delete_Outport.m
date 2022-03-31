filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx"; %Change Filename by your PC Setting

open_system(filename);
Origin_Data="Output_BBB";

Delete_OutportName(Origin_Data);

function Delete_OutportName(Origin_Data)
    s=slroot;
    %Stateflow의 Output Data 제거
    stateflow_outputdata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Output','-and','Name',Origin_Data);
    stateflow_outputdata_handle_list_size=size(stateflow_outputdata_handle_list,1);
    
    for stateflow_outputdata_handle_list_index=1:stateflow_outputdata_handle_list_size
        delete(stateflow_outputdata_handle_list(stateflow_outputdata_handle_list_index));
    end
    
    %Model의 Outport 제거
    Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
    Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);
    
    for Outport_sysport_handle_list_index=1:Outport_sysport_handle_list_size
        nowhandle_Outport_path=string(Outport_sysport_handle_list(Outport_sysport_handle_list_index).Path);
        nowhandle_Outport_name=string(Outport_sysport_handle_list(Outport_sysport_handle_list_index).Name);
        now_Outport_controlpath=append(nowhandle_Outport_path,"/",nowhandle_Outport_name);
            
        delete_block(now_Outport_controlpath);
    end
end