function datalist_write(datalist,fid)
%This function gives a text list about structures in datalist

%datalist_view(datalist,filepath);

% document_path=filepath;

nData=length(datalist);

for iData=1:nData
    fprintf(fid, '%s : \r\n',datalist(iData).name);
    for j=1:datalist(iData).num_memfunc
        fprintf(fid,'\t\t %s \r\n',datalist(iData).memfunc{j});
    end
    fprintf(fid,'\r\n');
end
