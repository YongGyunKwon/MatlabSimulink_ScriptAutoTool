% Make Empty Subsystem
% 1. Read Inport, Outport Name/Number (for Parameter)
% 2. Make Simulink Subsystem (.slx)
% 3. Parameter: filename, Inport_list, Outport_list
%    filename: 모델파일명
%    Inport_list: Input명 배열(현재는 string 배열을 받는 것으로 구현되어있으나 구조체 형식으로 될 경우 코드 수정할 것)
%    Outport_list: Outport명 배열(현재는 string 배열을 받는 것으로 구현되어있으나 구조체 형식으로 될 경우 코드 수정할 것)

% 사용 함수
% add_block() => 해당 함수의 용도와 사용법 추후 정리할 것!!!!
% Add Block에서 Position이 나타내는 값 [X Y Width Height]

%Parameter for function
filename='test12';
Inport_list=["Input_AAA","Input_BBB","Input_CCC","Input_DDD"];
Outport_list=["Output_AAA","Output_BBB","Output_CCC","Output_DDD"];


% Position 분석하여 다시 수정해놓기
% Position에 필요한 변수들
x = 30;
y = 30;
w = 30;
h = 30;
offset = 60;
pos = [x y+h/4 x+w y+h*.75];

NS = new_system(filename);
open_system(NS);


%set_param(NS,'Type','Inport','Name','Input_AAAA','Port',1);

Subsystem_Name=[filename '/' filename];
StateChart_Name=[filename '/' filename '/' filename '_State_Chart'];

add_block('built-in/Subsystem',Subsystem_Name);

for in=1:size(Inport_list,2)
    
    %InportName(참조용)
    Inport_Name=[Subsystem_Name '/' char(Inport_list(in))];
    Inport_Name_out=[filename '/' char(Inport_list(in))];
    
    Inport_Name_out_refer=[char(Inport_list(in)) '/1'];
    SubSystem_Port_refer=[filename '/' num2str(in)];
    
    Inport_Add=add_block('built-in/Inport',Inport_Name,'Position',pos);
    Inport_Add_out=add_block('built-in/Inport',Inport_Name_out,'Position',pos);
    
    
    
    %add_line 함수 사용하여 Subsystem과 Inport 사이 연결
    add_line(filename,Inport_Name_out_refer, SubSystem_Port_refer);
    
    
end


%위의 Inport 만들기 작업 끝나면 참고하여 Outport 내용도 채워넣기
for out=1:size(Outport_list,2)
    %InportName(참조용)
    Outport_Name=[Subsystem_Name '/' char(Outport_list(out))];
    Outport_Name_out=[filename '/' char(Outport_list(out))];
    
    Outport_Name_out_refer=[char(Outport_list(out)) '/1'];
    SubSystem_Port_refer=[filename '/' num2str(out)];
    
    Outport_Add=add_block('built-in/Outport',Outport_Name,'Position',pos);
    Outport_Add_out=add_block('built-in/Outport',Outport_Name_out,'Position',pos);
    
    OutportHandle=get_param(Outport_Name,'Handle');
    
    %add_line 함수 사용하여 Subsystem과 Outport 사이 연결
    add_line(filename,SubSystem_Port_refer,Outport_Name_out_refer);
     
end



save_system(NS);
close_system(NS);





function Make_New_SubSystem(filename,Inport_list,Outport_list)
    NS=new_system(filename);
    open_system(NS);
    
    %Set SubSystem, StateChart Name
    
    Subsystem_Name=[filename '/' filename];
    %StateChartName은 업무양식에 맞게 바꿀것
    StateChart_Name=[filename '/' filename '/' filename '_State_Chart'];
    
    %Make Subsystem
    add_block('built-in/Subsystem',Subsystem_Name);
    
    
    %Make Inport
    for in=1:size(Inport_list,2)
    
        %InportName(참조용)
        Inport_Name=[Subsystem_Name '/' char(Inport_list(in))];
        Inport_Name_out=[filename '/' char(Inport_list(in))];

        Inport_Name_out_refer=[char(Inport_list(in)) '/1'];
        SubSystem_Port_refer=[filename '/' num2str(in)];

        Inport_Add=add_block('built-in/Inport',Inport_Name,'Position',pos);
        Inport_Add_out=add_block('built-in/Inport',Inport_Name_out,'Position',pos);



        %add_line 함수 사용하여 Subsystem과 Inport 사이 연결
        add_line(filename,Inport_Name_out_refer, SubSystem_Port_refer);


    end

    %Make Outport
    for out=1:size(Outport_list,2)
        %InportName(참조용)
        Outport_Name=[Subsystem_Name '/' char(Outport_list(out))];
        Outport_Name_out=[filename '/' char(Outport_list(out))];

        Outport_Name_out_refer=[char(Outport_list(out)) '/1'];
        SubSystem_Port_refer=[filename '/' num2str(out)];

        Outport_Add=add_block('built-in/Outport',Outport_Name,'Position',pos);
        Outport_Add_out=add_block('built-in/Outport',Outport_Name_out,'Position',pos);

        OutportHandle=get_param(Outport_Name,'Handle');

        %add_line 함수 사용하여 Subsystem과 Outport 사이 연결
        add_line(filename,SubSystem_Port_refer,Outport_Name_out_refer);

    end
    
    
    
    save_system(NS);
    close_system(NS);
    
end




