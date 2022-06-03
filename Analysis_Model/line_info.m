open_system('AnalysisSample11.slx')
%Find all the line handles for this model
h = find_system('SearchDepth',2,'FindAll','On','type', 'line');
k = 1; % line 15
%You can use get_param(h(k),'objectparameters') to find all 
%the properties for the kth line
%Get the block handles
hblkSrc = get_param(h(k),'SrcBlockHandle');
hblkSrc_Port = get_param(h(k),'SrcPortHandle');
hblkDst = get_param(h(k),'DstBlockHandle');
hblkDst_Port = get_param(h(k),'DstBlockHandle');


%display the line name, source block and destination
%using the SPRINTF command
sprintf('LineName: %s Source Block : %s Destination Block: %s', ...
     get_param(h(k),'name'),get_param(hblkDst,'Name'), ...
     get_param(hblkSrc,'Name'));
