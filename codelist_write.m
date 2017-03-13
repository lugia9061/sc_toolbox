function codelist_write(Codelist,fid)
%This function gives a text list about structures in Codelist

%Codelist_view(Codelist,filepath);

% document_path=filepath;

nCode=length(Codelist);

for iCode=1:nCode
    fprintf(fid, '\t\t %s \r\n',Codelist(iCode).name);
end
