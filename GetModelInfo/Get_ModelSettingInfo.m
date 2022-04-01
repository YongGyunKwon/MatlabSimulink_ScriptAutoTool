
filepath="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample.slx";

ModelName_split=split(filepath,'\');
ModelName_file=string(ModelName_split(end));
    
ModelName_file_split_a=split(ModelName_file,'.slx');
%ModelName_file_split_b=split(ModelName_file,'_v_');
ModelFileName=string(ModelName_file_split_a(1));


open_system(filepath);

s=slroot;

%modelpath=find_system(SearchDepth','1');

statechart_handle=s.find('-isa','Stateflow.Chart');
statechart_handle_size=size(statechart_handle,1);



% Extract StateChart Color
% Color 부분은 소수점으로 나와서 이 부분 해결할 것!!
for statechart_handle_index=1:statechart_handle_size
    ModelSetInfo.StateChartSet(statechart_handle_index).Path=statechart_handle(statechart_handle_index).Path;
    ModelSetInfo.StateChartSet(statechart_handle_index).ActionLanguage=statechart_handle(statechart_handle_index).ActionLanguage;
    ModelSetInfo.StateChartSet(statechart_handle_index).Decomposition=statechart_handle(statechart_handle_index).Decomposition;
    ModelSetInfo.StateChartSet(statechart_handle_index).TransitionColor=statechart_handle(statechart_handle_index).TransitionColor;
    ModelSetInfo.StateChartSet(statechart_handle_index).TransitionLabelColor=statechart_handle(statechart_handle_index).TransitionLabelColor;
    ModelSetInfo.StateChartSet(statechart_handle_index).JunctionColor=statechart_handle(statechart_handle_index).JunctionColor;

    %disp(statechart_handle(statechart_handle_index).Path);
    %disp(statechart_handle(statechart_handle_index).ActionLanguage);
    %disp(statechart_handle(statechart_handle_index).Decomposition);
    %disp(statechart_handle(statechart_handle_index).TransitionColor);
    %disp(statechart_handle(statechart_handle_index).TransitionLabelColor);
    %disp(statechart_handle(statechart_handle_index).JunctionColor);

end


% Extract Data Type Information
statechart_data_handle=s.find('-isa','Stateflow.Data');
statechart_data_handle_size=size(statechart_data_handle,1);

for statechart_data_handle_index=1:statechart_data_handle_size
    ModelSetInfo.DataInfo(statechart_data_handle_index).Name=statechart_data_handle(statechart_data_handle_index).Name;
    ModelSetInfo.DataInfo(statechart_data_handle_index).Port=statechart_data_handle(statechart_data_handle_index).Port;
    ModelSetInfo.DataInfo(statechart_data_handle_index).Scope=statechart_data_handle(statechart_data_handle_index).Scope;
    ModelSetInfo.DataInfo(statechart_data_handle_index).Path=statechart_data_handle(statechart_data_handle_index).Path;
    ModelSetInfo.DataInfo(statechart_data_handle_index).DataType=statechart_data_handle(statechart_data_handle_index).DataType;
    
    %disp(statechart_data_handle(statechart_data_handle_index).Name);
    %disp(statechart_data_handle(statechart_data_handle_index).Scope);
    %disp(statechart_data_handle(statechart_data_handle_index).Path);
    %disp(statechart_data_handle(statechart_data_handle_index).DataType);
    %disp(statechart_data_handle(statechart_data_handle_index).Size);
end


%Extract Solver Information
myConfigObj = getActiveConfigSet('Sample'); %매개변수에 모델명 넣기
slxConfigset =myConfigObj.find('Name','Solver');

% Solver Type
ModelSetInfo.SolverType=slxConfigset.SolverName;
% Fixed-Step
ModelSetInfo.FixedStep=slxConfigset.FixedStep;

%Get ScreenColor
ModelSetInfo.ModelScreenColor_FirstDepth=get_param(ModelFileName,'ScreenColor');
ModelSetInfo.ModelScreenColor_SecondDepth=get_param(append(ModelFileName,"/",ModelFileName),'ScreenColor');