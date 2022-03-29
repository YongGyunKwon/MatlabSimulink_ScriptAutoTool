
New_Inport_Name="Input_ADDDDD123123";
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx';

open_system(filepath);

s=slroot;

stateflow_handle_list = s.find('-isa','Stateflow.Chart');
stateflow_handle_list_size=size(stateflow_handle_list,1);

if stateflow_handle_list_size==1
    add_data_in_statechart=Stateflow.Data(stateflow_handle_list(1));
    add_data_in_statechart.Name=New_Inport_Name;
    add_data_in_statechart.Scope="Input";
    add_data_in_statechart.Props.Type.Method = "Built-in";
    add_data_in_statechart.DataType = "uint8";
    
end
