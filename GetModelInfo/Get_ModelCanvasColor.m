
open_system("Sample.slx");

s=slroot;

Sovler_Check_SolverType="FixedStepDiscrete"; %고정스텝 이산
Sovler_Check_SolveerFixedStep="dT";

%config_a=s.find('-isa','Simulink.Configurations');
%con=s.find('=isa','Simulink.ConfigSet');

%파라미터에 모델명 넣기
myConfigObj = getActiveConfigSet('Sample');
slxConfigset =myConfigObj.find('Name','Solver');

%SolverName 종류
% VariableStepAuto 유형-가변스텝, 솔버-자동
% VariableStepDiscrete 유형-가변스텝, 솔버-이산
% ode45 유형-가변스텝, 솔버-ode45
% ode23 유형-가변스텝, 솔버-ode23
% ode113 유형-가변스텝, 솔버-ode113
% ode15s 유형-가변스텝, 솔버-ode15s
% ode23s 유형-가변스텝, 솔버-ode23s
% ode23t 유형-가변스텝, 솔버-ode23t
% ode23tb 유형-가변스텝, 솔버-ode23tb
% odeN 유형-가변스텝, 솔버-odeN
% FixedStepAuto 유형-고정스텝, 솔버-자동
% FixedStepDiscrete 유형 고정스텝, 솔버-이산 --> 이거 기준!
% ode8 유형 고정스텝, 솔버-ode8
% ode5 유형 고정스텝, 솔버-ode5
% ode4 유형 고정스텝, 솔버-ode4
% ode3 유형 고정스텝, 솔버-ode3
% ode2 유형 고정스텝, 솔버-ode2
% ode14x 유형 고정스텝, 솔버-ode14x
% ode1be 유형 고정스텝, 솔버-ode1be
modelguideinfo.SolverType=slxConfigset.SolverName;
% 고정스텝 크기
modelguideinfo.FixedStep=slxConfigset.FixedStep;

disp(modelguideinfo);

if modelguideinfo.SolverType==Sovler_Check_SolverType && modelguideinfo.FixedStep==Sovler_Check_SolveerFixedStep
    disp("Yes");
else
    disp("Solver Setting Error");
end


a=get_param('Sample','ScreenColor');

disp(a);

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

