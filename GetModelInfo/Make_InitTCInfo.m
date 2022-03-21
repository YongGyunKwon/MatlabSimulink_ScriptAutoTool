% REQ-0003
% Extract TC Init Info

% Issue: Depth2 이상일 경우 필요없는 값들이 불러와서 해결필요


clear;

filename = 'D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample_v_0_1.slx';
Depth = 1; %Modify Value what you want(Depth)

%Model에서 Inport, Outport 정보 추출
open_system(filename);

Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
Outport = find_system('SearchDepth',Depth,'BlockType','Outport');

Inport_Info = [Inport,get_param(Inport,'Name'),get_param(Inport,'Port')];
Outport_Info = [Outport,get_param(Outport,'Name'),get_param(Outport,'Port')];

close_system();


ModelName_split=split(filename,'\');
ModelName_file=string(ModelName_split(end));

ModelName_file_split_a=split(ModelName_file,'.slx');
ModelName_file_split_b=split(ModelName_file,'_v_');


ModelName_ver=string(ModelName_file_split_a(1));
ModelName=string(ModelName_file_split_b(1));

TC_File_Name= ModelName_ver+"_TestCase.xlsx";
TC_Init_Name= "TC_"+ModelName+"_Init_0001";

TC_event='';
TC_event_append='';

TC_expect='';
TC_expect_append='';

for in_info_index=1:size(Inport_Info,1)
    %disp(Inport_Info(in_info_index,2));
    TC_event_append=append(TC_event_append,char(Inport_Info(in_info_index,2)));
    TC_event_append=append(TC_event_append,' = ');
    
    if in_info_index < size(Inport_Info,1)
        TC_event_append=append(TC_event_append,'\n');
    end
end

TC_event=sprintf(TC_event_append);


for out_info_index=1:size(Outport_Info,1)
    %disp(Outport_Info(out_info_index,2));
    TC_expect_append=append(TC_expect_append,char(Outport_Info(out_info_index,2)));
    TC_expect_append=append(TC_expect_append,' = ');
    
    if out_info_index < size(Outport_Info,1)
        TC_expect_append=append(TC_expect_append,'\n');
    end
end

TC_expect=sprintf(TC_expect_append);

disp(TC_File_Name);
disp(TC_Init_Name);
disp(TC_event);
disp(TC_expect);

TCInit_Result.TC_File_Name = TC_File_Name;
TCInit_Result.TC_Init_Name = TC_Init_Name;
TCInit_Result.TC_event = TC_event;
TCInit_Result.TC_expect = TC_expect;