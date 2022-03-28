% Add Inport

%매개변수
New_Inport_Name="Input_ADDDDD123123";
filepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\ModifyModel\Sample_v_0_1.slx';

% PathMaker
filepath_split=strsplit(filepath,'.slx');
filepath_split=strsplit(string(filepath_split(1)),'\');

Model_SubSystemName=string(filepath_split(end));

%First Depth 변수명 만들기
New_Inport_First_Depth_Path=strcat(Model_SubSystemName,"/",New_Inport_Name);
First_Depth_Path=Model_SubSystemName;

%Second Depth 변수명 만들기
New_Inport_Second_Depth=strcat(Model_SubSystemName,"/",Model_SubSystemName,"/",New_Inport_Name);
Second_Depth_Path=strcat(Model_SubSystemName,"/",Model_SubSystemName);

s=slroot;

open_system(filepath);

%For First Path

%First Depth의 Inport Handle 추출
Inport_FirstDepth_handle = s.find('-isa','Simulink.Inport','Path',First_Depth_Path);
%First Depth의 Inport Handle 의 size 파악
Inport_FirstHandle_size=size(Inport_FirstDepth_handle,1);

%Inport_FirstHandle_handle에서 마지막 PortNumber에 대한 정보 추출
Inport_FirstHandle_lastPort_Name=Inport_FirstDepth_handle(Inport_FirstHandle_size).Name; %for First Depth Copy
Inport_FirstHandle_lastPort_Position=Inport_FirstDepth_handle(Inport_FirstHandle_size).Position; %for First Depth Copy


%Set New Inport Position in First Depth
disp(Inport_FirstHandle_lastPort_Position);

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
Inport_SecondHandle_lastPort_Name=Inport_SecondDepth_handle(Inport_Secondhandle_size).Name; %for Second Depth Copy
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

