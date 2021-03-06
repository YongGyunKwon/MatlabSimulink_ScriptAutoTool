filename="AnalysisSample11.slx"; %Change Filename by your PC Setting
FirstDepthIO=Get_IOFirstDepth(filename);


s=slroot;
ChartInfo=s.find('-isa','Stateflow.Chart');

for i=1:length(a)
    Charts(i).ChartName=ChartInfo(i).Name;
    Charts(i).ChartPath=ChartInfo(i).Path;

    
end

aa=s.find('-isa','Stateflow.Data','Path',Charts(1).ChartPath);





function FirstDepthIO=Get_IOFirstDepth(filename)

    %open_system(filename);

    Depth = 1;
    Inport = find_system('SearchDepth',Depth,'BlockType','Inport');
    Outport = find_system('SearchDepth',Depth,'BlockType','Outport');
    
    
    Inport_Size=size(Inport,1);
    Outport_Size=size(Outport,1);
    
    FirstDepthIO_Index=1;


    for Inport_Index=1:Inport_Size
        FirstDepthIO(FirstDepthIO_Index).IO="Inport";
        FirstDepthIO(FirstDepthIO_Index).Name=string(get_param(Inport(Inport_Index),'Name'));
        FirstDepthIO(FirstDepthIO_Index).Port=string(get_param(Inport(Inport_Index),'Port'));
        
        FirstDepthIO_Index=FirstDepthIO_Index+1;
    end

    for Outport_Index=1:Outport_Size
        FirstDepthIO(FirstDepthIO_Index).IO="Outport";
        FirstDepthIO(FirstDepthIO_Index).Name=string(get_param(Outport(Outport_Index),'Name'));
        FirstDepthIO(FirstDepthIO_Index).Port=string(get_param(Outport(Outport_Index),'Port'));

        FirstDepthIO_Index=FirstDepthIO_Index+1;
    end

    %close_system();
end