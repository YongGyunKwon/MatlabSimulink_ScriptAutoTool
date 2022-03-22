
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting

Modify_IO_Name(filename);

%Origin_Data, Modify_Data 구조체 형식으로 받아오는 방법 생각하기
function Modify_IO_Name(filename)
    open_system(filename);
    Origin_Data='Input_AAA';
    Modify_Data='Input_ThisisModify';

    Inport_sysport_Modify(Origin_Data,Modify_Data);
    %Outport_sysport_Modify(Origin_Data,Modify_Data);

    %save_system();
end


function Inport_sysport_Modify(Origin_Data,Modify_Data)

    %Search Origin Inport for handle
    s=slroot;
    Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
    Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);
    
    %Modify Origin_Data to Modify_Data
    for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name=Modify_Data;
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).PortName=Modify_Data;
    end

end


function Outport_sysport_Modify(Origin_Data,Modify_Data)
    
    %Search Origin Inport for handle
    s=slroot;
    Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
    Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);
    
    for Outport_sysport_handle_list_index=1:Outport_sysport_handle_list_size
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).Name=Modify_Data;
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).PortName=Modify_Data;
    end

end