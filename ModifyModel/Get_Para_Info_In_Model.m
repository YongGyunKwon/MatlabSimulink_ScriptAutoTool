% Extract_Parameter
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';



Parameter_Data=Extract_ParameterInfo(filepath);

function Parameter_Data=Extract_ParameterInfo(filepath)
    open_system(filepath);
    s=slroot;
    Parameter_handle = s.find('-isa','Stateflow.Data','-and','Scope','Parameter');
    
    %Parameter_data()
    
    Parameter_Data_Index=1;

    for paramter_index=1:size(Parameter_handle,1)
        
        Parameter_Data(paramter_index).Name=char(Parameter_handle(paramter_index).Name);
        
    end
    
end
