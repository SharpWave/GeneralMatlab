function [outputArg1,outputArg2] = CNMFE_outputviewer()
% C is the fluroescence traces
% S is is the event detection
% A is the ROIs

[datafile,datapath] = uigetfile('*.mat','Pick the CNMFE output file');
cd(datapath);
load(datafile);

[datafile,datapath] = uigetfile('*.tiff','Pick the .tiff movie file');
mov = importdata(datafile);

Xdim = size(mov,1);
Ydim = size(mov,2);

% plot all of the ROIs

NumNeurons = size(C,1);
NumSamples = size(C,2);


ROIcube = reshape(full(A),[Xdim Ydim NumNeurons]);
figure(1);
imagesc(sum(ROIcube,3));
hold on;

for i = 1:NumNeurons
    ROImat = squeeze(ROIcube(:,:,i));
    ROIpix_max = find(ROImat > 0);
    thresh = mean(ROImat(ROIpix_max));
    ROIpix = find(ROImat > thresh);
    temp = zeros(size(ROImat));
    temp(ROIpix) = 1;
    PlotRegionOutline(temp,rand(1,3));
    
end
keyboard;
end

