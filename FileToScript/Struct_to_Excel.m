% Matlab의 데이터를 Excel로 변환
% Struct 형식일 경우 Struct_To_Excel을 사용하고, 일반 Table 형식은 Table_To_Excel을 사용할 것


%StructIO: Excel로 변환할 Struct형식의 Table
%filename: Excel 파일명(full path 기입할 것)

function Struct_To_Excel(StructIO,filename)
    writetable(struct2table(StructIO),filename,'Sheet',1,'Range','B2');
    %'Sheet' 매개변수 바로 뒤 1자리에 원하는 Sheet 명 적을 것 -> 'MySheet'와 같이
    %'Range' 매개변수 바로 뒤 'B2'자리에 원하는 시작 Excel 범위 적을 것 -> 'B2'와 같이
    
end

%TableIO: Excel로 변환할 Table
%filename: Excel 파일명(full path 기입할 것)

function Table_To_Excel(TableIO,filename)
    writetable(TableIO,filename,'Sheet',1,'Range','B2');
    %'Sheet' 매개변수 바로 뒤 1자리에 원하는 Sheet 명 적을 것 -> 'MySheet'와 같이
    %'Range' 매개변수 바로 뒤 'B2'자리에 원하는 시작 Excel 범위 적을 것 -> 'B2'와 같이
    
end