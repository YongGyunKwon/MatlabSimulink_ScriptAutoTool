%Transition 
%REQ-0002

% 줄바꾸기 그리고 띄어쓰기 다시 하기

%Sample Transition
Transition = '(AA||(BB&&CC))';

Transition_size=size(Transition,2);

Transition_char=char(Transition);

%괄호갯수 count
bracket_count=count(Transition,'(');

%괄호갯수에 따라 '(' 와 ')' 인덱스
bracket_count_index_in=1;
bracket_count_index_out=bracket_count;

result='';

for i=1:Transition_size
    
    now_char=Transition_char(i);
    
    if now_char=='('
        if bracket_count_index_in==1
            result=append(result,now_char);
            bracket_count_index_in=bracket_count_index_in+1;
        else
            result=append(result,'\n(');
        end
    
    elseif now_char==')'
        % ) 부분 다시 고려하기
        result=append(result,')\n');
        
    else 
        result=append(result,now_char);
    end

end

disp(result);
