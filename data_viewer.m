function data_viewer(data,axis,axis_range)

%example:
% data=[linspace(1,1000,1000);linspace(500,1500,1000);linspace(1000,2000,1000);];
% axis=[linspace(1,1000,1000);];
% axis_range=100;
% data_viewer(data,axis,axis_range)

nRow=size(data,1);
figure;
for i=1:nRow
ax(i)=subplot(nRow,1,i);plot(axis,data(i,:));
end
addScrollbar( ax, axis_range )