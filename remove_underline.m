function string_out=remove_underline(string_in)

%change '_' to '-' for MATLAB figure plotting

indx=strfind(string_in,'_');
string_in(indx)='-';
string_out=string_in;