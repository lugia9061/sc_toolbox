%This script find all used (called using 'load' command) data in codes.

%ver.1 20140611
%Chen Song

clear;clc;

filepath='D:\MATLAB\R2011a\work\Chinese Phoneme Space\Analysis\';
codelist=dir([filepath,'*.m']);

%Remove all test codes as 'test_xxx' from search list
iFile=0;
iCount=0; 
while iFile<length(codelist)  
    iFile=iFile+1;
    if strcmp(codelist(iFile).name(1:4),'test')
        iCount=iCount+1;
        codelist_excluded(iCount,1)=codelist(iFile);
        codelist(iFile)=[];
        iFile=iFile-1;
    end
end
nFile=length(codelist);

datalist=[];    %contain data objects found in codes
dataCount = 0;
Flag_load=zeros(nFile,1);  %indicate whether a file uses 'load'

for iFile=1:length(codelist)
    filename=[filepath,codelist(iFile).name];
    fid = fopen(filename, 'rt');
    if fid<0
        error(['Can''t open file for reading (' filename ')'])
    end

    LineCount=0;
    while(~feof(fid))
        tline=fgetl(fid);
        LineCount=LineCount+1;
        if ~isempty(tline)&&~strcmp(tline(1),'%')  %not a comment line
            istart=strfind(tline,'load'); %find 'load' in line
            if ~isempty(istart)
                
                Flag_load(iFile)=1;
                
                comment_loc=strfind(tline,'%'); %delete following comments
                if ~isempty(comment_loc)
                tline=tline(1:comment_loc-1);
                end
                
                %if there exist fullfile
                search_range_rev=strfind(tline,'fullfile');
                if ~isempty(search_range_rev)
                tline=tline((search_range_rev+8):end);
                end
                                
                %if there exist [] like "load([A,B]),'C'"
                search_range1=strfind(tline,'[');
                search_range2=strfind(tline,']'); 
                if ~isempty(search_range1)&&~isempty(search_range2)
                    if ((length(search_range1)~=1)||(length(search_range2)~=1))  
                        search_range1 = search_range1(1);   %multiple []s : first '[' to last ']'
                        search_range2 = search_range2(end);
%                         error(['Line ',num2str(LineCount),' in ',codelist(iFile).name,' has multiple []s !']);
                    end
                end
                
                if ~isempty(search_range1)    %[ must co-exist with ]
                    istart=strfind(tline(search_range1:search_range2),''''); 
                    istart=search_range1-1+istart;
                else
                    istart=strfind(tline,''''); %find all 's in line, if [] exist, restrict range in []
                end
                
                if ~isempty(istart)
                    tmp=[];
                    for i=1:2:length(istart)	%find all fixed strings in the text file, use their linkage as one data object
                        tmp=strcat(tmp,tline(istart(i):istart(i+1))); 
                    end
                    
                    remove_chara_set={'"';'/';'\';'''';};
                    tmp2 = remove_chara(tmp,remove_chara_set);   %remove some meaningless characters from data object name
                    
                    flag_exist_data=0;
                    for i=1:length(datalist)
                         if strcmp(tmp2,datalist(i).name)   %exist data object
                             datalist(i,1).memfunc{datalist(i,1).num_memfunc+1} = codelist(iFile).name;
                             datalist(i,1).num_memfunc=datalist(i,1).num_memfunc+1;
                             flag_exist_data=1;
                         end
                    end
                    
                    if ~flag_exist_data
                    %new data object
                     dataCount=dataCount+1;
                     datalist(dataCount,1).name = tmp2; 
                     datalist(dataCount,1).memfunc{1}= codelist(iFile).name;
                     datalist(dataCount,1).num_memfunc = 1;
                    end
                end
            end
        end
    end
    fclose(fid);
end

fid=fopen([filepath,'Document.txt'],'w+');   %generate .txt document
datalist=datalist_sort(datalist);
datalist_write(datalist,fid); 

%Put the file without 'load' into codelist_excluded
iCount_start=length(codelist_excluded);
for iFile=1:nFile
    if Flag_load(iFile)==0
        iCount_start=iCount_start+1;
        codelist_excluded(iCount_start,1)=codelist(iFile);
    end
end

fprintf(fid, 'Code without loading data : \r\n');
codelist_excluded=codelist_sort(codelist_excluded);
codelist_write(codelist_excluded,fid);

fclose(fid);