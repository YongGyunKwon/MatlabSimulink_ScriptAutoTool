
Input_Tranisition = "(AA||BB||CC)";
MOperator=['||','&&','(',')'];

transition_char=char(Input_Tranisition);

tap_number=1;

strsize=strlength(Input_Tranisition);

find_a=strfind(Input_Tranisition,'||');

for i=1:strsize
   disp(transition_char(i));
end