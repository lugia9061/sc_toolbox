function datalist=datalist_sort(datalist)

for iData=1:length(datalist)
    name_cell{iData,1}=datalist(iData).name;
end
[name_cell_sorted,indx_order]=sort(name_cell);   %List for names of data objects
datalist=datalist(indx_order);