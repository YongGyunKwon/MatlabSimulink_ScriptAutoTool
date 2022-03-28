

% 1 is for Template Path for Not Req TC
% 2 is for Template Path for Req TC
Select_Template=2;

%Template Path for Not Req TC
Template_for_NotReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_NotReqTC.xlsx';
%Template Path for Req TC
Template_for_ReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_ReqTC.xlsx';

%모델파일 경로에 맞춰서 path 수정하기
pastepath='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1_TestcaseReq111212.xlsx'; 

%Make_InitTCInfo_v_0_2.m 파일 먼저 실행할 것
Import_Data_for_Excel={TCInit_Result.TC_Init_Name,'','','O','',TCInit_Result.TC_event,TCInit_Result.TC_expect};

%copy Excel file From 'Template_for_NotReqTC'
if Select_Template==1
    copyfile(Template_for_NotReqTC_Path,pastepath);
%copy Excel file From 'Template_for_ReqTC'
elseif Select_Template==2
    copyfile(Template_for_ReqTC_Path,pastepath);
end

%writecell for NotReq Temlate
writecell(Import_Data_for_Excel,pastepath,'Sheet','v0.1','Range','B5');


%xlswrite(pastepath,Import_Data_NotReq,'v_0_1','B5');