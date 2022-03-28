% Extract_Parameter
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';

Local_Data = Extract_LocalInfo(filepath);

function Local_Data=Extract_LocalInfo(filepath)
    open_system(filepath);
    s=slroot;
    Local_handle = s.find('-isa','Stateflow.Data','-and','Scope','Local');

    for Local_index=1:size(Local_handle,1)
        
        Local_Data(Local_index).Name=char(Local_handle(Local_index).Name);
        
    end
    
end
