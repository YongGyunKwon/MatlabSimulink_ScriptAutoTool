%REQ-0006
%Analysis Signal
filename="AnalysisSample11.slx"; %Change Filename by your PC Setting
parafilepath = 'AnalysisSample_Parameter.m';
AnalysisFilepath = "1.xlsx";

%Model_Signal=Get_ModelSig_Info(filename);
Analysis_Result=AnalySis_ModelSig_Info(filename,parafilepath);
Analysis_To_Excel(Analysis_Result,AnalysisFilepath);

function Analysis_Signal=AnalySis_ModelSig_Info(filename,parafilepath)
    
    %Extract Model I/O, Local, Parameter
    Model_Signal=Get_ModelSig_Info(filename);

    %Analysis Internal, Outernal
    Model_Signal_forCheck=Model_Signal;
    
    Analysis_Output_Size=size(Model_Signal.Output,2);
    
    inputtable=struct2table(Model_Signal.Input);
    
    Internal_Index=1;
    

    for Analysis_Output_Index=1:Analysis_Output_Size
        disp(Model_Signal.Output(Analysis_Output_Index).Name);

        
        find_Internalsignal=strcmp(Model_Signal.Output(Analysis_Output_Index).Name,inputtable.Name);
        ToSignalIndex=find(find_Internalsignal);
        
        %Find Internal Signal
        if find(find_Internalsignal,1)
            %disp("Internal");
            
            Analysis_Signal.Internal(Internal_Index).FromName=Model_Signal.Output(Analysis_Output_Index).Name;
            Analysis_Signal.Internal(Internal_Index).FromIO="Output";
            Analysis_Signal.Internal(Internal_Index).Port=Model_Signal.Output(Analysis_Output_Index).Port;
            Analysis_Signal.Internal(Internal_Index).FromPath=Model_Signal.Output(Analysis_Output_Index).Path;

            Model_Signal_forCheck.Output(Analysis_Output_Index).Check=1;
            
            
            Analysis_Signal.Internal(Internal_Index).ToName=Model_Signal.Input(ToSignalIndex).Name;
            Analysis_Signal.Internal(Internal_Index).ToIO="Input";
            Analysis_Signal.Internal(Internal_Index).ToPort=Model_Signal.Input(ToSignalIndex).Port;
            Analysis_Signal.Internal(Internal_Index).ToPath=Model_Signal.Input(ToSignalIndex).Path;
            Model_Signal_forCheck.Input(ToSignalIndex).Check=1;

            Internal_Index=Internal_Index+1;
        
        end
    end
    
    %Extract Outernal Signal
    Analysis_Signal.Outernal=Model_Signal.FirstDepth;
    
    
    
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
    Model_Signal.FirstDepth=Get_IOFirstDepth(filename);

    close_system(filename);
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


function FirstDepthIO=Get_IOFirstDepth(filename)

    %open_system(filename);

    Depth = 1;
    Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
    Outport = find_system('SearchDepth',Depth,'BlockType','Outport');
    
    
    Inport_Size=size(Inport,1);
    Outport_Size=size(Outport,1);
    
    FirstDepthIO_Index=1;


    for Inport_Index=1:Inport_Size
        FirstDepthIO(FirstDepthIO_Index).Name=string(get_param(Inport(Inport_Index),'Name'));
        FirstDepthIO(FirstDepthIO_Index).IO="Inport";
        FirstDepthIO(FirstDepthIO_Index).Port=string(get_param(Inport(Inport_Index),'Port'));
        
        FirstDepthIO_Index=FirstDepthIO_Index+1;
    end

    for Outport_Index=1:Outport_Size
        FirstDepthIO(FirstDepthIO_Index).Name=string(get_param(Outport(Outport_Index),'Name'));
        FirstDepthIO(FirstDepthIO_Index).IO="Outport";
        FirstDepthIO(FirstDepthIO_Index).Port=string(get_param(Outport(Outport_Index),'Port'));

        FirstDepthIO_Index=FirstDepthIO_Index+1;
    end

    %close_system();
end


function Analysis_To_Excel(Analysis_Result,AnalysisFilepath)
    
    ExcelInternal=struct2table(Analysis_Result.Internal);
    ExcelOutnernal=struct2table(Analysis_Result.Outernal);
    ExcelParameter=struct2table(Analysis_Result.Parameter);
    
    if isstring(Analysis_Result.Local)==0
        ExcelLocal=struct2table(Analysis_Result.Local);
    end
    
    Internal_Table_Size=size(ExcelInternal,1);
    Outernal_Table_Size=size(ExcelOutnernal,1);
    Parameter_Table_Size=size(ExcelParameter,1);
    
    Internal_Index=1;
    Internal_Table_Start=2;
    Outernal_Index=Internal_Table_Start+Internal_Table_Size+2;
    Outernal_Table_Start=Outernal_Index+1;
    Parameter_Index=Outernal_Table_Start+Outernal_Table_Size+2;
    Parameter_Table_Start=Parameter_Index+1;
    
    InternalIndexcell=sprintf("B%d",Internal_Index);
    InternalTablecell=sprintf("B%d",Internal_Table_Start);
    OuternalIndexcell=sprintf("B%d",Outernal_Index);
    OuternalTablecell=sprintf("B%d",Outernal_Table_Start);
    ParameterIndexcell=sprintf("B%d",Parameter_Index);
    ParameterTablecell=sprintf("B%d",Parameter_Table_Start);
    
    
    if isstring(Analysis_Result.Local)==0
        Local_Index=Parameter_Index+Parameter_Table_Size+1;
        Local_Table_Start=Local_Index+1;
        
        LocalIndexcell=sprintf("B%d",Local_Index);
        LocalTablecell=sprintf("B%d",Local_Table_Start);
    end
    
    
    writematrix("Internal",AnalysisFilepath,'Sheet','AnalysisResult','Range',InternalIndexcell);
    writetable(ExcelInternal,AnalysisFilepath,'Sheet','AnalysisResult','Range',InternalTablecell);
    writematrix("Outernal",AnalysisFilepath,'Sheet','AnalysisResult','Range',OuternalIndexcell);
    writetable(ExcelOutnernal,AnalysisFilepath,'Sheet','AnalysisResult','Range',OuternalTablecell);
    
    writematrix("Parameter",AnalysisFilepath,'Sheet','AnalysisResult','Range',ParameterIndexcell);
    writetable(ExcelParameter,AnalysisFilepath,'Sheet','AnalysisResult','Range',ParameterTablecell);
    
    if isstring(Analysis_Result.Local)==0
        writematrix("Local",AnalysisFilepath,'Sheet','AnalysisResult','Range',LocalIndexcell);
        writetable(ExcelLocal,AnalysisFilepath,'Sheet','AnalysisResult','Range',LocalTablecell);
    end
    
end