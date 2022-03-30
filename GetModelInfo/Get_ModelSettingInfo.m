
open_system("Sample.slx");

s=slroot;

aa=find_system('Sample');

statechart_handle=s.find('-isa','Stateflow.Chart');
statechart_handle_size=size(statechart_handle,1);



%backgroundcolor=Simulink.Annotation('Sample','BackgroundColor');


%backgroundcolor=s.find('-isa','Simulink.Annotation.BackgroundColor');

for statechart_handle_index=1:statechart_handle_size
    disp(statechart_handle(statechart_handle_index).Path);
    disp(statechart_handle(statechart_handle_index).ActionLanguage);
    disp(statechart_handle(statechart_handle_index).Decomposition);
    disp(statechart_handle(statechart_handle_index).TransitionColor);
    a=statechart_handle(statechart_handle_index).TransitionColor;
    disp(statechart_handle(statechart_handle_index).TransitionLabelColor);
    disp(statechart_handle(statechart_handle_index).JunctionColor);
end

%statechart_handle.ActionLanguage = 'C'; %MATLAB C

statechart_data_handle=s.find('-isa','Stateflow.Data');
statechart_data_handle_size=size(statechart_data_handle,1);

for statechart_data_handle_index=1:statechart_data_handle_size
    disp(statechart_data_handle(statechart_data_handle_index).Name);
    disp(statechart_data_handle(statechart_data_handle_index).Scope);
    disp(statechart_data_handle(statechart_data_handle_index).Path);
    disp(statechart_data_handle(statechart_data_handle_index).DataType);
    %disp(statechart_data_handle(statechart_data_handle_index).Size);
end

