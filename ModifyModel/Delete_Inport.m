filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx"; %Change Filename by your PC Setting

open_system(filename);
Origin_Data="Input_DDD";

Delete_InportName(Origin_Data);

function Delete_InportName(Origin_Data)
    s=slroot;
    %Stateflow의 Input Data 제거
    stateflow_inputdata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Input','-and','Name',Origin_Data);
    stateflow_inputdata_handle_list_size=size(stateflow_inputdata_handle_list,1);
    
    for stateflow_inputdata_handle_list_index=1:stateflow_inputdata_handle_list_size
        delete(stateflow_inputdata_handle_list(stateflow_inputdata_handle_list_index));
    end
    
    %Model의 Inport 제거
    Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
    Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);
    
    for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
        nowhandle_Inport_path=string(Inport_sysport_handle_list(Inport_sysport_handle_list_index).Path);
        nowhandle_Inport_name=string(Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name);
        now_Inport_controlpath=append(nowhandle_Inport_path,"/",nowhandle_Inport_name);
            
        delete_block(now_Inport_controlpath);
    end
end