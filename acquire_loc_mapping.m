function acquire_loc_mapping(subject_name,dataroute)
%acquire_loc(subject_name,dataroute)
%Get the positions of electrodes on a cortex surface map 
%Loc file should be in the sequence: Amp1-1~16, Amp2-1~16, Amp3-1~16, Amp4-1~16

% Extracted from ZhengXiao's mapping_system by Chen Song, 2013-7-9

%exp.
%dataroute='D:\mapping\ChenLonglong\';
%subjInfo.name='ChenLonglong';

mapfile=[dataroute,subject_name,'_mapping.png'];
skull=imread(mapfile);
oskull=skull;

fid=figure;
%change figure size and position
set(fid,'Position',[50 50 800 600]);
imagesc(skull),axis equal, axis off
key='n';
raw_elec=[];
elec_num=1;
moveon=1;
while moveon==1
    title(['Define electrode ' num2str(elec_num) ' position.  Press "y" to keep point.  Press "c" to cancel point.  Press "d" if done.'])
    km=waitforbuttonpress;
    temp=get(fid);
    temp2=get(gca);
    if km==0     %mouse
        m_pos=floor(temp2.CurrentPoint(1,1:2));
    elseif km==1 %key button
        key=temp.CurrentCharacter;
    end
    skulltemp=skull;
    skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,1)=255; %7 pixel square centered about clicked point
    skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,2)=0; %7 pixel square centered about clicked point
    skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,3)=0; %7 pixel square centered about clicked point
    imagesc(skulltemp),axis equal, axis off
    if key=='y'
        skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,1)=0; %7 pixel square centered about clicked point
        skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,2)=255; %7 pixel square centered about clicked point
        skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,3)=0; %7 pixel square centered about clicked point
        imagesc(skulltemp),axis equal, axis off
        raw_elec=[raw_elec; m_pos];
        elec_num=elec_num+1;
        skull=skulltemp;
        key='n';
    elseif key=='d'
        moveon=2;
    elseif key=='c'
        if elec_num>1
            elec_num=elec_num-1;
            tmppos=raw_elec(elec_num,:);
            skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,1)=oskull(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,1);
            skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,2)=oskull(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,2);
            skulltemp(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,3)=oskull(m_pos(2)-3:m_pos(2)+3,m_pos(1)-3:m_pos(1)+3,3);
            
            skulltemp(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,1)=oskull(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,1);
            skulltemp(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,2)=oskull(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,2);
            skulltemp(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,3)= oskull(tmppos(2)-3:tmppos(2)+3,tmppos(1)-3:tmppos(1)+3,3);
            imagesc(skulltemp),axis equal, axis off
            raw_elec(elec_num,:)=[];
            skull=skulltemp;
            key='n';
        end
    end
end
loc=raw_elec;
save([dataroute,subject_name,'_mapping_loc.mat'],'loc');
% locNum=length(loc(:,1));

