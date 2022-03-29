% Add Inport

%매개변수
New_Inport_Name="Input_ADDDDD123123";
filename = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_2.slx';

Add_New_InportName(filename,New_Inport_Name);

function Add_New_InportName(filename,New_Inport_Name)
    %Open System
    s=slroot;
    open_system(filename);


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
