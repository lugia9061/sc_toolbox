function show_spec(powspec,timeaxis,freqaxis,clims)
%show_spec(powspec,timeaxis,freqaxis,clims)
%This function shows the spectrogram 'powspec' (power spectrum) with axis
%and zlim
%Auto-generated Code by MATLAB Figure
 
% Create figure                    
figure1 = figure('PaperSize',[60 20],...
    'PaperOrientation','landscape');
% set(figure1,'position',[200 400 869 477]) %on big screen 
set(figure1,'position',[100 300 469 277])

% Create axes
axes1 = axes('Parent',figure1,'Layer','top','Fontsize',14);
xlim(axes1,[min(timeaxis),max(timeaxis)]);
ylim(axes1,[min(freqaxis),max(freqaxis)]);
% zlim(axes1,[-80,0]);
box(axes1,'on');
hold(axes1,'all');
% clims=[-80,0];
% clims=[min(powspec(:)),max(powspec(:))];
imagesc(timeaxis,freqaxis,powspec,clims)
colorbar

% Create title
title('Power Spectrum','FontSize',14);
