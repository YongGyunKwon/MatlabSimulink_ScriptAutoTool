%Transition 
% (가 첫번째인 경우만 파악
%REQ-0002


%Sample Transition
Transition = 'AA||(DD&&(BB&&CC))';


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




result_print=sprintf(result);
disp(result_print);


function taab=tab_counter(tab_number)
    taab='';
    for tab_i=1:(tab_number)
        taab=append(taab,'\t');
    end
end