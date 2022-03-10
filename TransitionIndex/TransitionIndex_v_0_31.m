%Transition 
% (가 첫번째인 경우, 아닌경우 합친버전
%REQ-0002


%Sample Transition


Transition = '(AA || (BB && (CC || DD) || (EE && FF)) || (GG || HH))';
%Transition = 'AA||(BB&&CC||(DD))';

disp(Transition_Index(Transition));

% Transition
% 해당 함수를 사용하기 위해 아래에 선언된 함수들이 모두 존재해야함.
% 매개변수 Transition에는 Transition식을 넣어야 함
function result_print=Transition_Index(Transition)

    Transition_char=char(Transition);
    % '('로 시작될 경우
    if Transition_char(1)=='('
        result_print=Transition_Index_InStart(Transition);
    % '('로 시작되지 않을 경우
    else
        result_print=Transition_Index_InNotStart(Transition);
    end

end

%'('로 시작하는 Transition
function result_print_InStart=Transition_Index_InStart(Transition)

    Transition_size=size(Transition,2);

    Transition_char=char(Transition);

    %괄호갯수 count
    bracket_count=count(Transition,'(');

    %괄호갯수에 따라 '(' 와 ')' 인덱스
    bracket_count_index_in=1;
    bracket_count_index_out=bracket_count;

    result='';


    %Transition 시작부터 괄호가 있는 경우
    for i=1:Transition_size

        now_char=Transition_char(i);

        % ( 부분
        % Use bracket_count_index_in
        if now_char=='('
            %첫번째 괄호부터
            if bracket_count_index_in==1

                result=append(result,now_char);
                result=append(result,'\n');%
                %result=append(result,string(bracket_count_index_in)); %띄어쓰기 갯수 파악
                result=append(result,char(tab_counter(bracket_count_index_in))); %tab

                bracket_count_index_in=bracket_count_index_in+1;
            else
                result=append(result,'\n');
                %result=append(result,string(bracket_count_index_in)); %띄어쓰기 갯수 파악
                result=append(result,char(tab_counter(bracket_count_index_in))); %tab
                result=append(result,now_char);

                bracket_count_index_in=bracket_count_index_in+1;
            end

        % ) 부분
        % Use bracket_count_index_out
        elseif now_char==')'
            %첫번째 ) 일 경우
            if bracket_count_index_out==bracket_count
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;
            %괄호 끝일경우
            elseif bracket_count_index_out==1
                result=append(result,'\n');
                result=append(result,now_char);
            %그 외의 )
            else
                result=append(result,'\n');
                result=append(result,char(tab_counter(bracket_count_index_out))); %tab
                %result=append(result,string(bracket_count_index_out)); %띄어쓰기 갯수 파악
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;
            end


        else 
            result=append(result,now_char);
        end

    end

    result_print_InStart=sprintf(result);
    %disp(result_print_InStart);

end
%'('로 시작하지 않은 Transition
function result_print_InNotStart=Transition_Index_InNotStart(Transition)
    Transition_size=size(Transition,2);

    Transition_char=char(Transition);

    %괄호갯수 count
    bracket_count=count(Transition,'(');

    %괄호갯수에 따라 '(' 와 ')' 인덱스
    bracket_count_index_in=1;
    bracket_count_index_out=bracket_count;

    result='';


    %Transition 시작부터 괄호가 없는경우
    for j=1:Transition_size

        now_char=Transition_char(j);

        % ( 부분
        % Use bracket_count_index_in
        if now_char=='('

            result=append(result,'\n');
            %result=append(result,string(bracket_count_index_in)); %띄어쓰기 갯수 파악
            result=append(result,char(tab_counter(bracket_count_index_in))); %tab
            result=append(result,now_char);

            bracket_count_index_in=bracket_count_index_in+1;


        % ) 부분
        % Use bracket_count_index_out
        elseif now_char==')'
            %첫번째 ) 일 경우
            if bracket_count_index_out==bracket_count
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;

            %그 외의 )
            else
                result=append(result,'\n');
                result=append(result,char(tab_counter(bracket_count_index_out))); %tab
                %result=append(result,string(bracket_count_index_out)); %띄어쓰기 갯수 파악
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;
            end

        else
            result=append(result,now_char);
        end

    end

    result_print_InNotStart=sprintf(result);
    %disp(result_print);
end

function taab=tab_counter(tab_number)
    taab='';
    for tab_i=1:(tab_number)
        taab=append(taab,'\t');
        
    end
end