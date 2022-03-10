%Transition 
% (가 첫번째인 경우, 아닌경우 합친버전
%REQ-0002


%Sample Transition
%Transition = '(AA||(BB&&CC))';
Transition = 'AA||(BB&&CC||(DD))';

Transition_size=size(Transition,2);

Transition_char=char(Transition);

%괄호갯수 count
bracket_count=count(Transition,'(');

%괄호갯수에 따라 '(' 와 ')' 인덱스
bracket_count_index_in=1;
bracket_count_index_out=bracket_count;

result='';




if Transition_char(1)=='('
    
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
                result=append(result,string(bracket_count_index_in)); %띄어쓰기 갯수 파악
                result=append(result,char(tab_counter(bracket_count_index_in))); %tab

                bracket_count_index_in=bracket_count_index_in+1;
            else
                result=append(result,'\n');
                result=append(result,string(bracket_count_index_in));
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
                result=append(result,string(bracket_count_index_out));
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;
            end


        else 
            result=append(result,now_char);
        end

    end
    
    
else
    %Transition 시작부터 괄호가 없는경우
    for i=1:Transition_size

        now_char=Transition_char(i);

        % ( 부분
        % Use bracket_count_index_in
        if now_char=='('
            %첫번째 괄호부터
            result=append(result,'\n');
            result=append(result,string(bracket_count_index_in));
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
            %괄호 끝일경우
            elseif bracket_count_index_out==1
                result=append(result,'\n');
                result=append(result,now_char);
            %그 외의 )
            else
                result=append(result,'\n');
                result=append(result,char(tab_counter(bracket_count_index_out))); %tab
                result=append(result,string(bracket_count_index_out));
                result=append(result,now_char);

                bracket_count_index_out=bracket_count_index_out-1;
            end


        else 
            result=append(result,now_char);
        end

    end
end


result_print=sprintf(result);
disp(result_print);


function taab=tab_counter(tab_number)
    taab='';
    for tab_i=1:(tab_number)
        taab=append(taab,'\t');
    end
end