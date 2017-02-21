function [string_out] = remove_chara(string_in, remove_chara_set)
%This function removes characters contained in "remove_chara_set" from string_in.

for i=1:size(remove_chara_set,1)
    remove_len=length(remove_chara_set{i});
    istart=strfind(string_in,remove_chara_set{i});
    for k=1:length(istart)
        string_in(istart(k):(istart(k)+remove_len-1))=[];
        if k~=length(istart)
        istart(k+1)=istart(k+1)-remove_len*k;
        end
    end
end

string_out=string_in;