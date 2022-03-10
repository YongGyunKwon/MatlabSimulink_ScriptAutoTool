%Transition 
%REQ-0002


Transition = '(AA||(BB&&CC))';
Formula={'(',')','||','&&'};
Transition_1=strsplit(Transition);
[Transition_Vriable,Transition_formula]=split(Transition,Formula);

original=join(Transition_Vriable,Transition_formula);
%Transition_Match=match(Transition,["||","&&","(",")"]);


Transizion_Variable_Size=size(Transition_Vriable,1);
Transition_formula_Size=size(Transition_formula,1);

Transition_formula_Index=1;

%for i=1:Transizion_Variable_Size
%    if Transition_Vriable(i)==""
       %disp("zero");
       %disp(Transition_Vriable(i));
       %Transition_Vriable(i)=Transition_formula(Transition_formula_Index);
       %Transition_formula_Index=Transition_formula_Index+1;
    %end
%end