

systemName="AnalysisSample11.slx";

open_system(systemName);
systemDepth=2;
% Find all the line handles for this model
allLines = find_system('SearchDepth', systemDepth,'FindAll', 'On', 'type', 'line');
if (isempty(allLines))   
       return;
end
% Intialize Line Information Class
%allLineProperties = LineInformation;

% Parse through lines and Assign the object properties. 
for i = 1 : length(allLines)
       allLineProperties(i).Identifier =  allLines(i);  
       sourceData = get_param(allLineProperties(i).Identifier,'SrcBlockHandle');
       destinationData = get_param(allLineProperties(i).Identifier,'DstBlockHandle');
       sourcePortData = get_param(allLineProperties(i).Identifier,'SrcportHandle');
       destinationPortData = get_param(allLineProperties(i).Identifier,'DstportHandle');
       allLineProperties(i).SourceBlock =  get_param(sourceData, 'Name');
       allLineProperties(i).DestinationBlock =  get_param(destinationData, 'Name');
       allLineProperties(i).SourcePort =  get_param(sourcePortData, 'Name');
       allLineProperties(i).DestinationPort =  get_param(destinationPortData, 'Name');
end

Tester_Index=1;

for j=1:length(allLines)
    
    T(Tester_Index).SrcBlock=get_param(allLines(j),'SrcBlock');
    T(Tester_Index).SrcPort=get_param(allLines(j),'SrcPort');
    T(Tester_Index).SrcParent=get_param(allLines(j),'Parent');
    T(Tester_Index).SrcPath=[T(Tester_Index).SrcParent,'/',T(Tester_Index).SrcBlock];
    T(Tester_Index).DstBlock=get_param(allLines(j),'DstBlock');
    T(Tester_Index).DstPort=get_param(allLines(j),'DstPort');
    Tester_Index=Tester_Index+1;
end
s=slroot;
a=s.find('-isa','Stateflow.Chart');
aab=s.find('-isa','Stateflow.Data','Path',T(1).SrcPath);
T(1).SrcBlock