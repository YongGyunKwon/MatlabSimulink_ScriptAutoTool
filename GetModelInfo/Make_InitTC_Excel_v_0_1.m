

% 1 is for Template Path for Not Req TC
% 2 is for Template Path for Req TC
Select_Template=2;

%Model File Path
modelfilepath = 'D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1.slx';
%ModelName_file_path_split_a=split(modelfilepath,'.slx');
%TC_File_Path=[ModelName_file_path_split_a,];

%Template Path for Not Req TC
%Template_for_NotReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_NotReqTC.xlsx'; 
Template_for_NotReqTC_Path='D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_NotReqTC.xlsx'; 
%Template Path for Req TC
%Template_for_ReqTC_Path='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_ReqTC.xlsx';
Template_for_ReqTC_Path='D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\Template_for_ReqTC.xlsx';


%모델파일 경로에 맞춰서 path 수정하기
%pastepath='D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1_TestcaseReq111212.xlsx'; 
%TC_File_Path=['D:\1_Code\Suresoft\MatlabSimulink_ScriptAutoTool\GetModelInfo\',char(TCInit_Result.TC_File_Name)]; 

ModelName_file_path_split_a=split(modelfilepath,'.slx');
TC_File_Path=[char(ModelName_file_path_split_a(1)),'_TestCase.xlsx'];



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