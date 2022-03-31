% Add Inport

%매개변수
New_Outport_Name="Output_ADDDDD123123";
modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';

Add_New_Outport(modelfilepath,New_Outport_Name);

function Add_New_Outport(modelfilepath,New_Outport_Name)
    %Open System
    s=slroot;
    open_system(modelfilepath);


    % PathMaker
    filepath_split=strsplit(modelfilepath,'.slx');
    filepath_split=strsplit(string(filepath_split(1)),'\');
    
    Model_SubSystemName=string(filepath_split(end));
    
    %First Depth 변수명 만들기
    New_Outport_First_Depth_Path=strcat(Model_SubSystemName,"/",New_Outport_Name);
    First_Depth_Path=Model_SubSystemName;
    
    %Second Depth 변수명 만들기
    New_Inport_Second_Depth=strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",New_Outport_Name);
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
    add_block(Outport_FirstHandle_lastPortPath_ForCopy,New_Outport_First_Depth_Path,'Position',Outport_FirstHandle_NewInport_Position);
    
    
    %For Second Path
    
    %Second Depth의 Inport 정보 추출
    Outport_SecondDepth_handle = s.find('-isa','Simulink.Outport','Path',Second_Depth_Path);
    Outport_Secondhandle_size=size(Outport_SecondDepth_handle,1);
    Outport_SecondHandle_lastPort_Name=Outport_SecondDepth_handle(Outport_Secondhandle_size).Name; %for Second Depth Copy
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
    add_block(Outport_SecondHandle_lastPortPath_ForCopy,New_Inport_Second_Depth,'Position',Outport_SecondHandle_NewInport_Position);

end
