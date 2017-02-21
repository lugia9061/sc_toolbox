function time_matrix=correct_hms(time_matrix)
%time_matrix : nRow * [hour,minute,seconds]

for iRow=1:size(time_matrix,1)
    if time_matrix(iRow,3)>=60
        time_matrix(iRow,3)=rem(time_matrix(iRow,3),60);
        time_matrix(iRow,2)=time_matrix(iRow,2)+1;
    end
    if time_matrix(iRow,2)>=60   
        time_matrix(iRow,2)=rem(time_matrix(iRow,2),60);
        time_matrix(iRow,1)=time_matrix(iRow,1)+1;
    end
    if time_matrix(iRow,1)>=24   
        time_matrix(iRow,1)=rem(time_matrix(iRow,1),24);
    end
end