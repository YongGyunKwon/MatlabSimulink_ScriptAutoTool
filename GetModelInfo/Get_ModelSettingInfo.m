% Get ModelSetting Information

filepath="D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\GetModelInfo\Sample.slx";
filelist=["D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample.slx","D:\2_CodeBase\6_SimulinkTool\MatlabSimulink_ScriptAutoTool\SampleModel\Sample11.slx"];

%ModelSetInfo=Get_ModelSetInfo(filepath);
ModelSetInfo_Multi=ModelSetInfo_Mudlti(filelist);



%Get ModelSet Info for Multi
function ModelSetInfo_Multi=ModelSetInfo_Mudlti(filelist)
    filelist_size=size(filelist,2);
    
    for filelist_index=1:filelist_size
        ModelSetInfo_Multi(filelist_index).FileName=string(filelist(filelist_index));
        ModelSetInfo_Multi(filelist_index).ModelFileInfo=Get_ModelSetInfo(string(filelist(filelist_index)));
    end
end

%Get ModelSet Info
function ModelSetInfo=Get_ModelSetInfo(filepath)
    
    
    ModelName_split=split(filepath,'\');
    ModelName_file=string(ModelName_split(end));
        
    ModelName_file_split_a=split(ModelName_file,'.slx');
    ModelFileName=string(ModelName_file_split_a(1));
    

    open_system(filepath);
    %modelpath=find_system(SearchDepth','1');
    
    s=slroot;
    
    SubSystemPath=find_system('SearchDepth',1,'BlockType','SubSystem');
    ModelFilename_a=split(SubSystemPath,"/");
    FirstDepthName=string(ModelFilename_a(1));
    
    %ModelFileName
    ModelSetInfo.ModelName=FirstDepthName;

    statechart_handle=s.find('-isa','Stateflow.Chart');
    statechart_handle_size=size(statechart_handle,1);

    % Extract StateChart Color
    % Color 부분은 소수점으로 나와서 이 부분 해결할 것!!
    for statechart_handle_index=1:statechart_handle_size
        ModelSetInfo.StateChartSet(statechart_handle_index).Path=statechart_handle(statechart_handle_index).Path;
        ModelSetInfo.StateChartSet(statechart_handle_index).ActionLanguage=statechart_handle(statechart_handle_index).ActionLanguage;
        ModelSetInfo.StateChartSet(statechart_handle_index).Decomposition=statechart_handle(statechart_handle_index).Decomposition;
        ModelSetInfo.StateChartSet(statechart_handle_index).ChartColor=rgb2hex(statechart_handle(statechart_handle_index).ChartColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).TransitionColor=rgb2hex(statechart_handle(statechart_handle_index).TransitionColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).TransitionLabelColor=rgb2hex(statechart_handle(statechart_handle_index).TransitionLabelColor);
        ModelSetInfo.StateChartSet(statechart_handle_index).JunctionColor=rgb2hex(statechart_handle(statechart_handle_index).JunctionColor);
    
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
        
    end
    
    
    %Extract Solver Information
    myConfigObj = getActiveConfigSet(FirstDepthName); %매개변수에 모델명 넣기
    slxConfigset =myConfigObj.find('Name','Solver');
    
    % Solver Type
    ModelSetInfo.SolverType=slxConfigset.SolverName;
    % Fixed-Step
    ModelSetInfo.FixedStep=slxConfigset.FixedStep;
    
    %Get ScreenColor
    ModelSetInfo.ModelScreenColor=string(get_param(FirstDepthName,'ScreenColor')); 
    %ModelSetInfo.ModelScreenColor_SecondDepth=string(get_param(FirstDepthName,'ScreenColor')); 
    %ModelSetInfo.ModelScreenColor_SecondDepth=string(get_param(SubSystemPath,'ScreenColor'));
    
    close_system();

end

%Change Color rgb to Hex
function [ hex ] = rgb2hex(rgb)
    % rgb2hex converts rgb color values to hex color format. 
    % 
    % This function assumes rgb values are in [r g b] format on the 0 to 1
    % scale.  If, however, any value r, g, or b exceed 1, the function assumes
    % [r g b] are scaled between 0 and 255. 
    % 
    % * * * * * * * * * * * * * * * * * * * * 
    % SYNTAX:
    % hex = rgb2hex(rgb) returns the hexadecimal color value of the n x 3 rgb
    %                    values. rgb can be an array. 
    % 
    % * * * * * * * * * * * * * * * * * * * * 
    % EXAMPLES: 
    % 
    % myhexvalue = rgb2hex([0 1 0])
    %    = #00FF00
    % 
    % myhexvalue = rgb2hex([0 255 0])
    %    = #00FF00
    % 
    % myrgbvalues = [.2 .3 .4;
    %                .5 .6 .7; 
    %                .8 .6 .2;
    %                .2 .2 .9];
    % myhexvalues = rgb2hex(myrgbvalues) 
    %    = #334D66
    %      #8099B3
    %      #CC9933
    %      #3333E6
    % 
    % * * * * * * * * * * * * * * * * * * * * 
    % Chad A. Greene, April 2014
    % 
    % Updated August 2014: Functionality remains exactly the same, but it's a
    % little more efficient and more robust. Thanks to Stephen Cobeldick for
    % his suggestions. 
    % 
    % * * * * * * * * * * * * * * * * * * * * 
    % See also hex2rgb, dec2hex, hex2num, and ColorSpec. 
    % Check inputs: 
    assert(nargin==1,'This function requires an RGB input.') 
    assert(isnumeric(rgb)==1,'Function input must be numeric.') 
    sizergb = size(rgb); 
    assert(sizergb(2)==3,'rgb value must have three components in the form [r g b].')
    assert(max(rgb(:))<=255& min(rgb(:))>=0,'rgb values must be on a scale of 0 to 1 or 0 to 255')
    
    % If no value in RGB exceeds unity, scale from 0 to 255: 
    if max(rgb(:))<=1
        rgb = round(rgb*255); 
    else
        rgb = round(rgb); 
    end
    % Convert (Thanks to Stephen Cobeldick for this clever, efficient solution):
    hex(:,2:7) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
    hex(:,1) = '#';
end