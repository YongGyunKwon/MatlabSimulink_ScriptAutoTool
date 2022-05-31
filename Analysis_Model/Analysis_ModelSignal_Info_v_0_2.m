%REQ-0006
%Analysis Signal
filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Analysis_Model\AnalysisSample11.slx"; %Change Filename by your PC Setting
parafilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\Analysis_Model\AnalysisSample_Parameter.m';

%Model_Signal=Get_ModelSig_Info(filename);
Analysis_Result=AnalySis_ModelSig_Info(filename,parafilepath);


function Analysis_Signal=AnalySis_ModelSig_Info(filename,parafilepath)
    
    %Extract Model I/O, Local, Parameter
    Model_Signal=Get_ModelSig_Info(filename);

    %Analysis Internal, Outernal
    Model_Signal_forCheck=Model_Signal;
    
    Analysis_Output_Size=size(Model_Signal.Output,2);
    
    inputtable=struct2table(Model_Signal.Input);
    
    Internal_Index=1;
    Outernal_Index=1;

    for Analysis_Output_Index=1:Analysis_Output_Size
        disp(Model_Signal.Output(Analysis_Output_Index).Name);

        
        find_Internalsignal=strcmp(Model_Signal.Output(Analysis_Output_Index).Name,inputtable.Name);
        ToSignalIndex=find(find_Internalsignal);
        
        %Find Internal Signal
        if find(find_Internalsignal,1)
            %disp("Internal");
            Analysis_Signal.Internal(Internal_Index).FromName=Model_Signal.Output(Analysis_Output_Index).Name;
            Analysis_Signal.Internal(Internal_Index).Port=Model_Signal.Output(Analysis_Output_Index).Port;
            Analysis_Signal.Internal(Internal_Index).FromPath=Model_Signal.Output(Analysis_Output_Index).Path;

            Model_Signal_forCheck.Output(Analysis_Output_Index).Check=1;

            Analysis_Signal.Internal(Internal_Index).ToName=Model_Signal.Input(ToSignalIndex).Name;
            Analysis_Signal.Internal(Internal_Index).ToPort=Model_Signal.Input(ToSignalIndex).Port;
            Analysis_Signal.Internal(Internal_Index).ToPath=Model_Signal.Input(ToSignalIndex).Path;
            Model_Signal_forCheck.Input(ToSignalIndex).Check=1;

            Internal_Index=Internal_Index+1;
        else
            
            %disp("외부");
            Analysis_Signal.Outernal(Outernal_Index).Name=Model_Signal.Output(Analysis_Output_Index).Name;
            Analysis_Signal.Outernal(Outernal_Index).Scope="Outport";
            Analysis_Signal.Outernal(Outernal_Index).Port=Model_Signal.Output(Analysis_Output_Index).Port;
            Analysis_Signal.Outernal(Outernal_Index).Path=Model_Signal.Output(Analysis_Output_Index).Path;
            
            Model_Signal_forCheck.Output(Analysis_Output_Index).Check=1;
            Outernal_Index=Outernal_Index+1;
        end
    end
    
    
    Analysis_Input_Size=size(Model_Signal_forCheck.Input,2);

    for Analysis_Input_Index=1:Analysis_Input_Size
        if Model_Signal_forCheck.Input(Analysis_Input_Index).Check==0
            Analysis_Signal.Outernal(Outernal_Index).Name=Model_Signal_forCheck.Input(Analysis_Input_Index).Name;
            Analysis_Signal.Outernal(Outernal_Index).Scope="Inport";
            Analysis_Signal.Outernal(Outernal_Index).Port=Model_Signal_forCheck.Input(Analysis_Input_Index).Port;
            Analysis_Signal.Outernal(Outernal_Index).Path=Model_Signal_forCheck.Input(Analysis_Input_Index).Path;

            Model_Signal_forCheck.Input(Analysis_Input_Index).Check=1;
            
            Outernal_Index=Outernal_Index+1;
        end
    end
    
    %Extract Parameter
    Analysis_Signal.Parameter=Extract_ParameterInfo(parafilepath);
    
    %Extract Local
    Analysis_Signal.Local=Model_Signal.Local;
end


function Model_Signal=Get_ModelSig_Info(filename)
    open_system(filename);
    Model_Signal.Input=Extract_InputInfo(filename);
    Model_Signal.Output=Extract_OutputInfo(filename);
    %Model_Signal.Parameter=Extract_ParameterInfo(filename);
    Model_Signal.Local=Extract_LocalInfo(filename);
    %close_system(filename);
end

function Input_Data=Extract_InputInfo(filename)
    
    s=slroot;
    Input_handle = s.find('-isa','Stateflow.Data','-and','Scope','Input');
    
    for Input_Index=1:size(Input_handle,1)
        Input_Data(Input_Index).Name=string(Input_handle(Input_Index).Name);
        Input_Data(Input_Index).Port=string(Input_handle(Input_Index).Port);
        Input_Data(Input_Index).Path=string(Input_handle(Input_Index).Path);
        Input_Data(Input_Index).Check=0;
    end
    
end

function Output_Data=Extract_OutputInfo(filename)
    

    s=slroot;
    Output_handle = s.find('-isa','Stateflow.Data','-and','Scope','Output');
    
    for Output_Index=1:size(Output_handle,1)
        Output_Data(Output_Index).Name=string(Output_handle(Output_Index).Name);
        Output_Data(Output_Index).Port=string(Output_handle(Output_Index).Port);
        Output_Data(Output_Index).Path=string(Output_handle(Output_Index).Path);
        Output_Data(Output_Index).Check=0;
    end
end

function Local_Data=Extract_LocalInfo(filename)
    
    s=slroot;
    Local_handle = s.find('-isa','Stateflow.Data','-and','Scope','Local');
    if size(Local_handle,1)==0
        Local_Data="Empty";
    end

    for Local_index=1:size(Local_handle,1)
        Local_Data(Local_index).Name=string(Local_handle(Local_index).Name);
        Local_Data(Local_index).DataType=string(Local_handle(Local_index).DataType);
        Local_Data(Local_index).Path=string(Local_handle(Local_index).Path);
    end
    
end

function Parameter_Info=Extract_ParameterInfo(parafilepath)
    Parameter_Import=importdata(parafilepath);
    Scan_Index=1;

    for PI_Index=1:size(Parameter_Import,1)
        Parameter_Format="%s = %s ;";
        Parameter_Scan_temp=textscan(string(Parameter_Import(PI_Index)),Parameter_Format);
        
        if contains(string(Parameter_Scan_temp(1)),'%')==0
            Parameter_Info(Scan_Index).ParameterName=string(Parameter_Scan_temp(1));
            Parameter_Scan_temper=split(string(Parameter_Scan_temp(2)),';');
            Parameter_Info(Scan_Index).Value=Parameter_Scan_temper(1);
            Scan_Index=Scan_Index+1;
        end
    end
   
end