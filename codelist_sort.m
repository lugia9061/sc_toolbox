function codelist=codelist_sort(codelist)

for iCode=1:length(codelist)
    name_cell{iCode,1}=codelist(iCode).name;
end
[name_cell_sorted,indx_order]=sort(name_cell);   %List for names of data objects
codelist=codelist(indx_order);