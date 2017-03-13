% Example of using CaptureFigVid
% Cheers, Dr. Alan Jennings, Research assistant professor, 
% Department of Aeronautics and Astronautics, Air Force Institute of Technology

%% Set up 3D plot to record
figure(171);clf;
surf(peaks,'EdgeColor','none','FaceColor','interp','FaceLighting','phong')
daspect([1,1,.3]);axis tight;
axis off;

%% Set up recording parameters (optional), and record
OptionZ.FrameRate=25;OptionZ.Periodic=true;
% CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'WellMadeVid',OptionZ)
step=1;
tmp=[-360:step:360].';
OptionZ.Duration=length(tmp)/OptionZ.FrameRate;
ViewZ=[tmp,10*ones(size(tmp))];
CaptureFigVid(ViewZ,'MyRotation',OptionZ)
