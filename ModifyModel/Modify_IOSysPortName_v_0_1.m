% REQ-004
% 

filename="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx"; %Change Filename by your PC Setting
filename2="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx"; %Change Filename by your PC Setting"

Modify_IO_Name(filename);
%Inport_sysport_Modify(Origin_Data,Modify_Data);

%Origin_Data, Modify_Data 구조체 형식으로 받아오는 방법 생각하기
function Modify_IO_Name(filename)
    open_system(filename);
    
    %for문 써서 구조체 들어가기
    
    % Origin_Data, Modify_Data도 for문에서 참고
    
    %SampleData
    Origin_Input_Data="Input_AAA"; 
    Modify_Input_Data="Input_ThisisModify";
    
    Origin_Output_Data="Output_AAA"; 
    Modify_Output_Data="Output_Hello";
    
    Origin_LocalData="b_LocalData";
    Modify_LocalData="b_HelloLocal";
    
    Origin_ParameterData="SystemOn";
    Modify_ParameterData="SystemOffOn";
    
    New_Inport_Name="Input_ThisisAdd";
    
    New_Outport_Name="Output_ThisisAdd";
    
    Delete_Inport_Name="Input_BBB";

    Delete_Outport_Name="Output_BBB";

    Delete_Parameter_Name="Four_bb";
    
    Delete_Local_Data_Name="b_Running";

    %if문 써서 수정,추가,삭제 하기
    
    %1. Modify Inport
    Modify_InportName(Origin_Input_Data,Modify_Input_Data);
    %add StateChart, Transition
    
    %2. Modify Outport
    Modify_OutportName(Origin_Output_Data,Modify_Output_Data);
    
    %3. Modify Local Data
    Modify_LocalDataName(Origin_LocalData,Modify_LocalData);
    
    %4. Modify Parameter
    Modify_ParameterName(Origin_ParameterData,Modify_ParameterData);
    
    %5. Add Input Name
    Add_New_InportName(filename,New_Inport_Name);
    %6. Add Output
    Add_New_OutportName(filename,New_Outport_Name);

    %7. Delete Input
    Delete_InportName(Delete_Inport_Name);
    %8. Delete Output
    Delete_OutportName(Delete_Outport_Name);
    %9. Delete Parameter
    Delete_ParameterName(Delete_Parameter_Name);
    %10. Delete Local Data
    Delete_LocalDataName(Delete_Local_Data_Name);
    
    
    
    %save_system();
end

%Modify Inport Name
function Modify_InportName(Origin_Data,Modify_Data)

    %Search Origin Inport for handle
    s=slroot;
    %Extract Inport handle
    Inport_sysport_handle_list=s.find('-isa','Simulink.Inport','-and','Name',Origin_Data);
    Inport_sysport_handle_list_size=size(Inport_sysport_handle_list,1);
    
    %Modify Inport Name from Origin_Data to Modify_Data
    for Inport_sysport_handle_list_index=1:Inport_sysport_handle_list_size
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).Name=Modify_Data;
        Inport_sysport_handle_list(Inport_sysport_handle_list_index).PortName=Modify_Data;
    end
    
    % Extract StateChart's Input Name
    Inport_Data_handle_list=s.find('-isa','Stateflow.Data','-and','Name',Origin_Data);
    Inport_Data_handle_list_size=size(Inport_Data_handle_list,1);
    
    % Modify StateChart's InputName from Origin_Data to Modify_Data
    for Inport_Data_handle_list_Index=1:Inport_Data_handle_list_size
        Inport_Data_handle_list(Inport_Data_handle_list_Index).Name=Modify_Data;
        
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data)
end

%Modify Outport Name
function Modify_OutportName(Origin_Data,Modify_Data)
    
    %Search Origin Inport for handle
    s=slroot;
    Outport_sysport_handle_list=s.find('-isa','Simulink.Outport','-and','Name',Origin_Data);
    Outport_sysport_handle_list_size=size(Outport_sysport_handle_list,1);
    
    for Outport_sysport_handle_list_index=1:Outport_sysport_handle_list_size
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).Name=Modify_Data;
        Outport_sysport_handle_list(Outport_sysport_handle_list_index).PortName=Modify_Data;
    end

    % Extract StateChart's Input Name
    Outport_Data_handle_list=s.find('-isa','Stateflow.Data','-and','Name',Origin_Data);
    Outport_Data_handle_list_size=size(Outport_Data_handle_list,1);
    
    % Modify StateChart's InputName from Origin_Data to Modify_Data
    for Outport_Data_handle_list_Index=1:Outport_Data_handle_list_size
        Outport_Data_handle_list(Outport_Data_handle_list_Index).Name=Modify_Data;
        
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data)
    Modify_Transition_Contents(Origin_Data,Modify_Data)
end

%Modify LocalDataName
function Modify_LocalDataName(Origin_Data,Modify_Data)
    s=slroot;
    Local_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Local','-and','Name',Origin_Data);
    Local_handle_list_size=size(Local_handle_list,1);
    
    for Local_handle_list_index=1:Local_handle_list_size
        Local_handle_list(Local_handle_list_index).Name=Modify_Data;
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data);
end

%Modify Parameter Name
function Modify_ParameterName(Origin_Data,Modify_Data)
    s=slroot;
    Parameter_handle_list=s.find('-isa','Stateflow.Data','-and','Scope','Parameter','-and','Name',Origin_Data);
    Parameter_handle_list_size=size(Parameter_handle_list,1);

    for Parameter_handle_list_index=1:Parameter_handle_list_size
        
        Parameter_handle_list(Parameter_handle_list_index).Name=Modify_Data;
    end
    
    Modify_StateChart_Contents(Origin_Data,Modify_Data);
    Modify_Transition_Contents(Origin_Data,Modify_Data);
end


% Modify StateChart's Contents
function Modify_StateChart_Contents(Origin_Data,Modify_Data)

    %handle
    s=slroot;
    
    %Get StateChart Contents list for handle
    stateschartcontents_handle_list = find(sfroot,'-isa','Stateflow.State');
    stateschartcontents_handle_list_size = size(stateschartcontents_handle_list,1);

    %StateChart 내용 교체
    for stateschartcontents_handle_list_index=1:stateschartcontents_handle_list_size
        
        modify_statechart_contents=strrep(stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString,Origin_Data,Modify_Data);
        stateschartcontents_handle_list(stateschartcontents_handle_list_index).LabelString=modify_statechart_contents;
    
    end

end

% Modify Transition's Contents
function Modify_Transition_Contents(Origin_Data,Modify_Data)
    
    %handle
    s=slroot;

    %Get Transition Contents list for handle
    transitions_handle_list = find(sfroot,'-isa','Stateflow.Transition');
    transitions_handle_list_size = size(transitions_handle_list,1);
    
    for transitions_handle_list_index=1:transitions_handle_list_size
        modify_transition_contents = strrep(transitions_handle_list(transitions_handle_list_index).LabelString,Origin_Data,Modify_Data);
        transitions_handle_list(transitions_handle_list_index).LabelString = modify_transition_contents;
    end

end

%5 Add_InportName
function Add_New_InportName(filename,New_Inport_Name)
    %Open System
    s=slroot;
    %open_system(filename);


    % PathMaker
    filepath_split=strsplit(filename,'.slx');
    filepath_split=strsplit(string(filepath_split(1)),'\');
    
    Model_SubSystemName=string(filepath_split(end));
    
    %First Depth 변수명 만들기
    New_Inport_First_Depth_Path=strcat(Model_SubSystemName,"/",New_Inport_Name);
    First_Depth_Path=Model_SubSystemName;
    
    %Second Depth 변수명 만들기
    New_Inport_Second_Depth=strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",New_Inport_Name);
    Second_Depth_Path=strcat(Model_SubSystemName,"/",Model_SubSystemName);
    
    %For First Path
    
    %First Depth의 Inport Handle 추출
    Inport_FirstDepth_handle = s.find('-isa','Simulink.Inport','Path',First_Depth_Path);
    %First Depth의 Inport Handle 의 size 파악
    Inport_FirstHandle_size=size(Inport_FirstDepth_handle,1);
    
    %Inport_FirstHandle_handle에서 마지막 PortNumber에 대한 정보 추출
    Inport_FirstHandle_lastPort_Name=Inport_FirstDepth_handle(Inport_FirstHandle_size).Name; %for First Depth Copy
    Inport_FirstHandle_lastPort_Position=Inport_FirstDepth_handle(Inport_FirstHandle_size).Position; %for First Depth Copy
    
    
    
    %FirstDepth Depth에서 Position 계산
    diff_firstdepth_y=Inport_FirstDepth_handle(Inport_FirstHandle_size).Position(2)-Inport_FirstDepth_handle(Inport_FirstHandle_size-1).Position(2);
    diff_firstdepth_w=Inport_FirstDepth_handle(Inport_FirstHandle_size).Position(4)-Inport_FirstDepth_handle(Inport_FirstHandle_size-1).Position(4);
    
    Inport_FirstHandle_NewInport_Position=Inport_FirstHandle_lastPort_Position;
    Inport_FirstHandle_NewInport_Position(2)=Inport_FirstHandle_NewInport_Position(2)+diff_firstdepth_y;
    Inport_FirstHandle_NewInport_Position(4)=Inport_FirstHandle_NewInport_Position(4)+diff_firstdepth_w;
    
    %FirstDepth의 마지막 Portnumber Path 만들기
    Inport_FirstHandle_lastPortPath_ForCopy = strcat(Model_SubSystemName,"/",Inport_FirstHandle_lastPort_Name);
    
    %FiststDepth의 마지막 Portnumber를 복사하여 새로운 Inport 생성
    add_block(Inport_FirstHandle_lastPortPath_ForCopy,New_Inport_First_Depth_Path,'Position',Inport_FirstHandle_NewInport_Position);
    

    %For Second Path
    
    %Second Depth의 Inport 정보 추출
    Inport_SecondDepth_handle = s.find('-isa','Simulink.Inport','Path',Second_Depth_Path);
    Inport_Secondhandle_size=size(Inport_SecondDepth_handle,1);
    Inport_SecondHandle_lastPort_Name=string(Inport_SecondDepth_handle(Inport_Secondhandle_size).Name); %for Second Depth Copy
    Inport_SecondHandle_lastPort_Position=Inport_SecondDepth_handle(Inport_Secondhandle_size).Position; %for Second Depth Copy
    
    
    %Set New Inport Position in Second Depth
    Inport_SecondHandle_NewInport_Position=Inport_SecondHandle_lastPort_Position;
    
    %Second Depth에서 Position 계산
    diff_seconddepth_y=Inport_SecondDepth_handle(Inport_Secondhandle_size).Position(2)-Inport_SecondDepth_handle(Inport_Secondhandle_size-1).Position(2);
    diff_seconddepth_w=Inport_SecondDepth_handle(Inport_Secondhandle_size).Position(4)-Inport_SecondDepth_handle(Inport_Secondhandle_size-1).Position(4);
    
    Inport_SecondHandle_NewInport_Position(2)=Inport_SecondHandle_NewInport_Position(2)+diff_seconddepth_y;
    Inport_SecondHandle_NewInport_Position(4)=Inport_SecondHandle_NewInport_Position(4)+diff_seconddepth_w;
    
    
    Inport_SecondHandle_lastPortPath_ForCopy = strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",Inport_SecondHandle_lastPort_Name);
    
    %SecondDepth의 마지막 Portnumber를 복사하여 새로운 Inport 생성
    add_block(Inport_SecondHandle_lastPortPath_ForCopy,New_Inport_Second_Depth,'Position',Inport_SecondHandle_NewInport_Position);
    
    %First Depth에 Line 생성
    %Line 생성은 입출력 신호수 계산으로 인하여 버그가 있을 것으로 예상
    %삭제 후 추가 했을 때 어떻게 되는지 볼 것
    Inport_Name_out_refer=append(New_Inport_Name,"/1");
    SubSystem_Port_refer=append(Model_SubSystemName,"/",num2str(Inport_FirstHandle_size+1));
    add_line(Model_SubSystemName,Inport_Name_out_refer, SubSystem_Port_refer);
    
    %Add Input in StateChart
    % StateChart가 1개일 경우만 추가
    % StateChart가 두개 이상인 경우 어디에 넣어줘야 할지 모르는 상황이기에...
    stateflow_handle_list = s.find('-isa','Stateflow.Chart');
    stateflow_handle_list_size=size(stateflow_handle_list,1);
    
    if stateflow_handle_list_size==1
        add_data_in_statechart=Stateflow.Data(stateflow_handle_list(1));
        add_data_in_statechart.Name=New_Inport_Name;
        add_data_in_statechart.Scope="Input";
        add_data_in_statechart.Props.Type.Method = "Built-in";
        add_data_in_statechart.DataType = "uint8";
    end
    
end

%6. Add New Outport Name
function Add_New_OutportName(filename,New_Outport_Name)
    %Open System
    s=slroot;
    
    % PathMaker
    filepath_split=strsplit(filename,'.slx');
    filepath_split=strsplit(string(filepath_split(1)),'\');
    
    Model_SubSystemName=string(filepath_split(end));
    
    %First Depth 변수명 만들기
    New_Inport_First_Depth_Path=strcat(Model_SubSystemName,"/",New_Outport_Name);
    First_Depth_Path=Model_SubSystemName;
    
    %Second Depth 변수명 만들기
    New_Outport_Second_Depth=strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",New_Outport_Name);
    Second_Depth_Path=strcat(Model_SubSystemName,"/",Model_SubSystemName);
    
    %For First Path
    
    %First Depth의 Inport Handle 추출
    Outport_FirstDepth_handle = s.find('-isa','Simulink.Outport','Path',First_Depth_Path);
    %First Depth의 Inport Handle 의 size 파악
    Outport_FirstHandle_size=size(Outport_FirstDepth_handle,1);
    
    %Inport_FirstHandle_handle에서 마지막 PortNumber에 대한 정보 추출
    Outport_FirstHandle_lastPort_Name=Outport_FirstDepth_handle(Outport_FirstHandle_size).Name; %for First Depth Copy
    Outport_FirstHandle_lastPort_Position=Outport_FirstDepth_handle(Outport_FirstHandle_size).Position; %for First Depth Copy
    
    
    
    %FirstDepth Depth에서 Position 계산
    diff_firstdepth_y=Outport_FirstDepth_handle(Outport_FirstHandle_size).Position(2)-Outport_FirstDepth_handle(Outport_FirstHandle_size-1).Position(2);
    diff_firstdepth_w=Outport_FirstDepth_handle(Outport_FirstHandle_size).Position(4)-Outport_FirstDepth_handle(Outport_FirstHandle_size-1).Position(4);
    
    Outport_FirstHandle_NewInport_Position=Outport_FirstHandle_lastPort_Position;
    Outport_FirstHandle_NewInport_Position(2)=Outport_FirstHandle_NewInport_Position(2)+diff_firstdepth_y;
    Outport_FirstHandle_NewInport_Position(4)=Outport_FirstHandle_NewInport_Position(4)+diff_firstdepth_w;
    
    %FirstDepth의 마지막 Portnumber Path 만들기
    Outport_FirstHandle_lastPortPath_ForCopy = strcat(Model_SubSystemName,"/",Outport_FirstHandle_lastPort_Name);
    
    %FiststDepth의 마지막 Portnumber를 복사하여 새로운 Inport 생성
    add_block(Outport_FirstHandle_lastPortPath_ForCopy,New_Inport_First_Depth_Path,'Position',Outport_FirstHandle_NewInport_Position);
    

    %For Second Path
    
    %Second Depth의 Inport 정보 추출
    Outport_SecondDepth_handle = s.find('-isa','Simulink.Outport','Path',Second_Depth_Path);
    Outport_Secondhandle_size=size(Outport_SecondDepth_handle,1);
    Outport_SecondHandle_lastPort_Name=string(Outport_SecondDepth_handle(Outport_Secondhandle_size).Name); %for Second Depth Copy
    Outport_SecondHandle_lastPort_Position=Outport_SecondDepth_handle(Outport_Secondhandle_size).Position; %for Second Depth Copy
    
    
    %Set New Inport Position in Second Depth
    Outport_SecondHandle_NewInport_Position=Outport_SecondHandle_lastPort_Position;
    
    %Second Depth에서 Position 계산
    diff_seconddepth_y=Outport_SecondDepth_handle(Outport_Secondhandle_size).Position(2)-Outport_SecondDepth_handle(Outport_Secondhandle_size-1).Position(2);
    diff_seconddepth_w=Outport_SecondDepth_handle(Outport_Secondhandle_size).Position(4)-Outport_SecondDepth_handle(Outport_Secondhandle_size-1).Position(4);
    
    Outport_SecondHandle_NewInport_Position(2)=Outport_SecondHandle_NewInport_Position(2)+diff_seconddepth_y;
    Outport_SecondHandle_NewInport_Position(4)=Outport_SecondHandle_NewInport_Position(4)+diff_seconddepth_w;
    
    
    Outport_SecondHandle_lastPortPath_ForCopy = strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",Outport_SecondHandle_lastPort_Name);
    
    %SecondDepth의 마지막 Portnumber를 복사하여 새로운 Inport 생성
    add_block(Outport_SecondHandle_lastPortPath_ForCopy,New_Outport_Second_Depth,'Position',Outport_SecondHandle_NewInport_Position);
    
    %First Depth에 Line 생성
    %Line 생성은 입출력 신호수 계산으로 인하여 버그가 있을 것으로 예상
    %삭제 후 추가 했을 때 어떻게 되는지 볼 것
    Outport_Name_out_refer=append(New_Outport_Name,"/1");
    SubSystem_Port_refer=append(Model_SubSystemName,"/",num2str(Outport_FirstHandle_size+1));
    add_line(Model_SubSystemName,SubSystem_Port_refer,Outport_Name_out_refer);
    
    %Add Input in StateChart
    % StateChart가 1개일 경우만 추가
    % StateChart가 두개 이상인 경우 어디에 넣어줘야 할지 모르는 상황이기에...
    stateflow_handle_list = s.find('-isa','Stateflow.Chart');
    stateflow_handle_list_size=size(stateflow_handle_list,1);
    
    if stateflow_handle_list_size==1
        add_data_in_statechart=Stateflow.Data(stateflow_handle_list(1));
        add_data_in_statechart.Name=New_Outport_Name;
        add_data_in_statechart.Scope="Output";
        add_data_in_statechart.Props.Type.Method = "Built-in";
        add_data_in_statechart.DataType = "uint8";
    end
    
end
%7. Delete Input
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

%8. Delete Outport
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

%9. Delete Parameter
function Delete_ParameterName(Origin_Data)
    s=slroot;
    %Stateflow의 Parameter Data 제거
    stateflow_paradata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Parameter','-and','Name',Origin_Data);
    stateflow_paradata_handle_list_size=size(stateflow_paradata_handle_list,1);
    
    for stateflow_paradata_handle_list_index=1:stateflow_paradata_handle_list_size
        delete(stateflow_paradata_handle_list(stateflow_paradata_handle_list_index));
    end
    
end

%10. Delete Local Data
function Delete_LocalDataName(Origin_Data)
    s=slroot;
    %Stateflow의 Local Data 제거
    stateflow_localdata_handle_list = s.find('-isa','Stateflow.Data','-and','Scope','Local','-and','Name',Origin_Data);
    stateflow_localdata_handle_list_size=size(stateflow_localdata_handle_list,1);
    
    for stateflow_localdata_handle_list_index=1:stateflow_localdata_handle_list_size
        delete(stateflow_localdata_handle_list(stateflow_localdata_handle_list_index));
    end
    
end