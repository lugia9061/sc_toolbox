function [circle_model,rel_indx,true_indx,edge_indx] = circle_generate_v2(center_raw,diameter,width_edge)
%circle = circle_generate(center,diameter)
%This function produce a circle around the given center in a image

%INPUT:
%center_raw=[y,x], the true center in some picture
%diameter: the expected circle's diameter

%OUTPUT:
%circle_model: can be any image processing kernel
%rel_indx: relative indexes within the circle ('1's in the circle model)
%true_indx: indexes within the circle , adjusted to center_raw to return true indx
%edge_indx: true index on edges. for plotting circles

%ver.2
%with edge indx

% diameter=10;
%define the relative center
if mod(diameter,2)==0
    center=(diameter+1)/2;
else
    center=diameter/2;
end

circle=zeros(diameter,diameter);
i_mat=repmat([1:diameter].',1,diameter);
j_mat=repmat([1:diameter],diameter,1);
tmp=sqrt((i_mat-center).^2+(j_mat-center).^2);
[row_indx,col_indx]=find(tmp<diameter/2);   %(i-x)^2+(j-y)^2 < r^2
rel_indx=[row_indx,col_indx];
for i=1:size(row_indx,1)
    circle(row_indx(i),col_indx(i))=1;
end
if (diameter/2-width_edge)<1
    error('width_edge out of bound!');
end
[edge_row_indx,edge_col_indx]=find(tmp>diameter/2-width_edge&tmp<diameter/2);
rel_edge_indx=[edge_row_indx,edge_col_indx];


sigma=diameter/6;
kernel=fspecial('gaussian',[diameter,diameter],sigma);
kernel=kernel/max(max(kernel));
circle_model=circle.*kernel;
% imagesc(circle)

correction=center_raw-center;
row_indx=fix(row_indx+correction(1));
col_indx=fix(col_indx+correction(2));
true_indx=[row_indx,col_indx];

edge_row_indx=fix(edge_row_indx+correction(1));
edge_col_indx=fix(edge_col_indx+correction(2));
edge_indx=[edge_row_indx,edge_col_indx];

end