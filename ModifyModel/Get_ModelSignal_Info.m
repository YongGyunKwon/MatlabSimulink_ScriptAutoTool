%REQ-0004
%Get ModelSignal
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting

%open_system(filename);
Model_Signal=Get_ModelSig_Info(filename);

%s=slroot;
%Local_handle = s.find('-isa','Stateflow.Data','-and','Scope','Local');


function Model_Signal=Get_ModelSig_Info(filename)
    open_system(filename);
    Model_Signal.Input=Extract_InputInfo(filename);
    Model_signal.Output=Extract_OutputInfo(filename);
    Model_Signal.Parameter=Extract_ParameterInfo(filename);
    Model_Signal.Local=Extract_LocalInfo(filename);
end

function Input_Data=Extract_InputInfo(filename)
    
    %open_system(filename);

    s=slroot;
    Input_handle = s.find('-isa','Simulink.Inport');
    
    for Input_Index=1:size(Input_handle,1)
        Input_Data(Input_Index).Name=string(Input_handle(Input_Index).Name);
        Input_Data(Input_Index).Port=string(Input_handle(Input_Index).Port);
        Input_Data(Input_Index).Path=string(Input_handle(Input_Index).Path);
    end
    
end

function Output_Data=Extract_OutputInfo(filename)
    
    %open_system(filename);

    s=slroot;
    Output_handle = s.find('-isa','Simulink.Outport');
    
    for Output_Index=1:size(Output_handle,1)
        Output_Data(Output_Index).Name=string(Output_handle(Output_Index).Name);
        Output_Data(Output_Index).Port=string(Output_handle(Output_Index).Port);
        Output_Data(Output_Index).Path=string(Output_handle(Output_Index).Path);
    end

end


function Paremeter_Data=Extract_ParameterInfo(filename)
    
    %open_system(filename);

    s=slroot;
    Parameter_handle = s.find('-isa','Stateflow.Data','-and','Scope','Parameter');

    for Parameter_index=1:size(Parameter_handle,1)
        Paremeter_Data(Parameter_index).Name=string(Parameter_handle(Parameter_index).Name);
        Paremeter_Data(Parameter_index).DataType=string(Parameter_handle(Parameter_index).DataType);
        Paremeter_Data(Parameter_index).Path=string(Parameter_handle(Parameter_index).Path);
    end
    
end

function Local_Data=Extract_LocalInfo(filename)
    
    %open_system(filename);

    s=slroot;
    Local_handle = s.find('-isa','Stateflow.Data','-and','Scope','Local');

    for Local_index=1:size(Local_handle,1)
        Local_Data(Local_index).Name=string(Local_handle(Local_index).Name);
        Local_Data(Local_index).DataType=string(Local_handle(Local_index).DataType);
        Local_Data(Local_index).Path=string(Local_handle(Local_index).Path);
    end
    
end
