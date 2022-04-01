% REQ-0003
% InitTC생성
% !Notice
% Excel로 정보 집어넣는 것은 구현중
% Excel파일 생성기능 함수 추가 예정


%modelfilepath = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1.slx';
modelfilepath = 'D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1.slx';

% 1 is for Template Path for Not Req TC
% 2 is for Template Path for Req TC
Select_Template=2;

%함수호출
% Get_Model_IO_Info 함수를 통하여 모델정보를 불러옴
% Get_Model_IO_Info 함수에서 불러온 정보를 GetMake_InitTCInfo의 매개변수에 넣어서 
% TC파일에 넣을 정보 가져옴
% Make_InitTC_To_Excel 함수를 통하여 Excel파일 생성
[Inport_Info,Outport_Info]=Get_Model_IO_Info(modelfilepath);
TCInit_Result=Make_InitTCInfo(modelfilepath,Inport_Info,Outport_Info);
Make_InitTC_To_Excel(Select_Template,modelfilepath,TCInit_Result);


% Get Model I/O Information
%Model에서 Inport, Outport 정보 추출
% in 1 Depth
function [Inport_Info,Outport_Info] = Get_Model_IO_Info(modelfilepath)
    Depth = 1; %Modify Value what you want(Depth)

    open_system(modelfilepath);
    
    Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
    Outport = find_system('SearchDepth',Depth,'BlockType','Outport');

    Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
    Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];

    close_system();
end

% TC Init 파일에 들어갈 정보 생성
% 해당 함수를 실행하기 위해 Get_Model_IO_Info를 넣어야 함
% 매개변수 filename: 모델파일경로
% 매개변수 Inport_Info: 모델파일의 입력신호 정보(Get_Model_IO_Info를 실행해야 받아올 수 있음)
% 매개변수 Outport_Info: 모델파일의 출력신호 정보(Get_Model_IO_Info를 실행해야 받아올 수 있음)
% TCInit_Result 라는 구조체로 return
% 구조체정보
% TCInit_Result.TC_File_Name: 테스트케이스 파일명
% TCInit_Result.TC_Init_Name: 테스트케이스의 Init TC번호
% TCInit_Result.TC_event: 테스트케이스의 event1에 넣을 Inport 변수명들(1번포트부터 순서대로 출력됨)
% TCInit_Result.TC_expect: 테스트케이스의 exp1에 넣을 Outport 변수명들(1번포트부터 순서대로 출력됨)
function TCInit_Result=Make_InitTCInfo(modelfilepath,Inport_Info,Outport_Info)
    
    %filepath를 통하여 모델명, 파일이름 추출
    ModelName_split=split(modelfilepath,'\');
    ModelName_file=string(ModelName_split(end));
    
    ModelName_file_split_a=split(ModelName_file,'.slx');
    ModelName_file_split_b=split(ModelName_file,'_v_');


    ModelName_ver=string(ModelName_file_split_a(1));
    ModelName=string(ModelName_file_split_b(1));
    
    %추출한 파일이름을 가지고 테스트케이스 파일명, TC번호 제작
    TC_File_Name= ModelName_ver+"_TestCase.xlsx";
    TC_Init_Name= "TC_"+ModelName+"_Init_0001";
    
    TC_event='';
    TC_event_append='';

    TC_expect='';
    TC_expect_append='';
    
    %Get_Model_IO_Info를 통하여 얻은 Inport 정보를 Text로 출력하기 위해 가공
    for in_info_index=1:size(Inport_Info,1)
        %disp(Inport_Info(in_info_index,2));
        TC_event_append=append(TC_event_append,char(Inport_Info(in_info_index,2)));
        TC_event_append=append(TC_event_append,' = ');

        if in_info_index < size(Inport_Info,1)
            TC_event_append=append(TC_event_append,'\n');
        end
    end

    TC_event=sprintf(TC_event_append);

    %Get_Model_IO_Info를 통하여 얻은 Outport 정보를 Text로 출력하기 위해 가공
    for out_info_index=1:size(Outport_Info,1)
        %disp(Outport_Info(out_info_index,2));
        TC_expect_append=append(TC_expect_append,char(Outport_Info(out_info_index,2)));
        TC_expect_append=append(TC_expect_append,' = ');

        if out_info_index < size(Outport_Info,1)
            TC_expect_append=append(TC_expect_append,'\n');
        end
    end

    TC_expect=sprintf(TC_expect_append);
    
    disp('TC_File_Name: '+TC_File_Name);
    disp('TC_Init_Name: '+TC_Init_Name);
    disp('TC_event:');
    disp(TC_event);
    disp('TC_expect:');
    disp(TC_expect);
    
    %TCInit_Result라는 구조체로 저장하고 return
    TCInit_Result.TC_File_Name = TC_File_Name;
    TCInit_Result.TC_Init_Name = TC_Init_Name;
    TCInit_Result.TC_event = TC_event;
    TCInit_Result.TC_expect = TC_expect;
end


% Make InitTC To Excel File
% 매개변수
% Select_Template은 Not_Req, Req 버전에 따라 탬플릿을 구분하기 위한 것임
% 1 is for Template Path for Not Req TC
% 2 is for Template Path for Req TC
% modelfilepath 모델파일 경로, 모델파일 경로에 Init TC 파일을 생성하기 위해 필요
% TCInit_Result는 Make_InitTCInfo 를 먼저 실행시켜야 얻어올 수 있음
function Make_InitTC_To_Excel(Select_Template,modelfilepath,TCInit_Result)
    
    %템플릿을 받아오기 위해서
    
    %Template Path for Not Req TC
    %Template_for_NotReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_NotReqTC.xlsx'; 
    Template_for_NotReqTC_Path='D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_NotReqTC.xlsx'; 
    %Template Path for Req TC
    %Template_for_ReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_ReqTC.xlsx';
    Template_for_ReqTC_Path='D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_ReqTC.xlsx';
    
    
    %모델파일 경로에 맞춰서 path 수정하기
    ModelName_file_path_split_a=split(modelfilepath,'.slx');
    TC_File_Path=[char(ModelName_file_path_split_a(1)),'_TestCase.xlsx'];
    %TC_File_Path=['D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\',char(TCInit_Result.TC_File_Name)]; 
    
    
    %Make_InitTCInfo_v_0_2.m 파일 먼저 실행할 것
    Import_Data_for_Excel={TCInit_Result.TC_Init_Name,'','','O','',TCInit_Result.TC_event,TCInit_Result.TC_expect};
    
    %copy Excel file From 'Template_for_NotReqTC'
    if Select_Template==1
        copyfile(Template_for_NotReqTC_Path,TC_File_Path);
    %copy Excel file From 'Template_for_ReqTC'
    elseif Select_Template==2
        copyfile(Template_for_ReqTC_Path,TC_File_Path);
    end
    
    %writecell for NotReq Temlate
    writecell(Import_Data_for_Excel,TC_File_Path,'Sheet','v0.1','Range','B5');

end