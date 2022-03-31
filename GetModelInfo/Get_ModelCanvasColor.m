
open_system("Sample.slx");

s=slroot;

myConfigObj = getActiveConfigSet(s);
slxConfigset =myConfigObj.find('Name','Solver');

modelguideinfo.Solver=slxConfigset.FixedStep;



settings=s.find('-isa','Simulink.Diagram');

%settings_aaa=s.find('-isa','Simulink.SolverCC');

%sett=myConfigObj.find('Name','Solver');

%settings_size=size(settings,1);




%backgroundcolor=Simulink.Annotation('Sample','BackgroundColor');
%backgroundcolor=s.find('-isa','Simulink.Subsystem');
%backgroundcolor=s.find('-isa','Simulink.Format');
%aa=find_system('Sample','Format');

%block_settings=s.find('-isa','Simulink.FindOptions');

%find_system('Sample','Option');


%aa=Simulink.FindOptions;

