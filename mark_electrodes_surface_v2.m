function h=mark_electrodes_surface_v2(subject_name,dataroute,channel_list,colorset,montage)
%mark_electrodes(subject_name,dataroute,channel_list)
%Mark the significant channels on a surface map(generated by freesurfer)

% Revised from ZhengXiao's mapping_system by Chen Song, 2013-7-9

%INPUT
%subject_name : subject's name
%dataroute : location of subject's picture, required as 'subject's name_mapping.png'
%channel_list : channels to be marked, such as 'Amp1-1';  support groups, 1*nGroup -> nChannels *1
%colorset : n*3 matrix, each row stand for RGB color for one group
%montage:
%1 : 64 channel, Amp1~4
%2 : 92 channel, Amp1~6

%OUTPUT
%The figure of marking electrodes on the head

%PARAMETERS
%the locfile's order should be
%"Amp1-1~16";"Amp2-1~16";..."Amp5-1~16";"Amp6-5~16"; use label_92
%Probably "Amp1-1~16" ... "Amp4-1~16";   use label_norm
%The electrode can also be less than montage's channel number.


%exp.
% clear;clc;
% subjInfoFunc='subjInfo_S05_YuanZhiyang';
% eval(['subjInfo = ' subjInfoFunc ';']);
% subject_name=subjInfo.name;
% dataroute=[subjInfo.matdir,'\'];
% channel_list{1}=subjInfo.channels(1);
% colorset=[1,0,0]*255;
% montage=1;

%Ver.2 20141018
%support multiple color for different groups of electrodes


locfile=[dataroute,subject_name,'_surface_loc_new01.mat'];
mapfile=[dataroute,subject_name,'_surface_new02.png'];
load(locfile);   %name 'loc' and saved in acquire_loc.m
skull=imread(mapfile);

switch montage
    case 1
        load('label_norm.mat');    %named label_norm, a constant list
        %usually locfile has the same order as 'label_norm' in sc_toolbox
        label_list=label_norm;
    case 2
        load('label_92.mat');  
        label_list=label_92;
    otherwise
        error('Montage not found!');
end

% colorset=[1,0,0;1,1,0;0,1,1]*255; %'r','y','c'
nGroup=length(channel_list);
for iGroup=1:nGroup
    if ~isempty(channel_list{iGroup})
    signif_chan=[];
    for i=1:size(channel_list{iGroup},1);
        indx=find(strcmp(channel_list{iGroup}{i},label_list));
        signif_chan=[signif_chan,indx];
    end
%     for ii=1:length(signif_chan)
%         fff=signif_chan(ii);
%         skull(loc(fff,2)-9:loc(fff,2)+9,loc(fff,1)-9:loc(fff,1)+9,1)=colorset(iGroup,1);
%         skull(loc(fff,2)-9:loc(fff,2)+9,loc(fff,1)-9:loc(fff,1)+9,2)=colorset(iGroup,2);
%         skull(loc(fff,2)-9:loc(fff,2)+9,loc(fff,1)-9:loc(fff,1)+9,3)=colorset(iGroup,3);
%     end
    
    diameter=40;width_edge=4;
    for ii=1:length(signif_chan)
        fff=signif_chan(ii);
        center_raw=[loc(fff,2),loc(fff,1)];
        [circle_model,rel_indx,true_indx,edge_indx] = circle_generate_v2(center_raw,diameter,width_edge);
        for j=1:size(rel_indx,1)
            if true_indx(j,1)<=size(skull,1)&&true_indx(j,2)<=size(skull,2)   %may be out of range due to large diameter
                 skull(true_indx(j,1),true_indx(j,2),1)=colorset(iGroup,1);
                 skull(true_indx(j,1),true_indx(j,2),2)=colorset(iGroup,2);
                 skull(true_indx(j,1),true_indx(j,2),3)=colorset(iGroup,3);
            end
        end
        
        %draw edge of each circle
        for j=1:size(edge_indx,1)
             skull(edge_indx(j,1),edge_indx(j,2),1)=0;   %black edge
             skull(edge_indx(j,1),edge_indx(j,2),2)=0;
             skull(edge_indx(j,1),edge_indx(j,2),3)=0;
        end

    end
    end
end

image_size=size(skull);image_size=fliplr(image_size(1:2));  %for adjustment of figure's gray outside edge
figure_size=image_size/10;
h=figure;
set(h,'PaperSize',figure_size);
set(h,'PaperPosition',[10,10,figure_size]);
set(h,'Position',[50,100,image_size]);
h1=imagesc(skull,'Clipping','off');
set(gca,'Position',[0,0,1,1]);
axis equal;axis off;
% saveas(h,['test_pic.png'],'png');