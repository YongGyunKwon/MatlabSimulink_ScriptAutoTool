% MATLAB Automation client example 
%
% Open Excel, add workbook, change active worksheet, 
% get/put array, save.

% First, open an Excel Server.
e = actxserver('excel.application');

% Insert a new workbook.
eWorkbook = e.Workbooks.Add;
e.Visible = 1;

% Make the first sheet active.
eSheets = e.ActiveWorkbook.Sheets;

eSheet1 = eSheets.get('Item', 1);
eSheet1.Activate;

% Put a MATLAB array into Excel.
A = [1 2; 3 4];
eActivesheetRange = e.Activesheet.get('Range', 'A1:B2');
eActivesheetRange.Value = A;

% Get back a range.  It will be a cell array, since the cell range 
% can contain different types of data.
eRange = e.Activesheet.get('Range', 'A1:B2');
B = eRange.Value;

% Convert to a double matrix.  The cell array must contain only
% scalars.
B = reshape([B{:}], size(B));

% Now, save the workbook.
eWorkbook.SaveAs('myfile.xls');

% To avoid saving the workbook and being prompted to do so,
% uncomment the following code.
% eWorkbook.Saved = 1;
% eWorkbook.Close;

% Quit Excel and delete the server.
% e.Quit;
% e.delete;