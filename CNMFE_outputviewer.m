function [outputArg1,outputArg2] = CNMFE_outputviewer()
% C is the fluroescence traces
% S is is the event detection
% A is the ROIs

[datafile,datapath] = uigetfile('*.mat','Pick the CNMFE output file');
cd(datapath);
load(datafile);

[datafile,datapath] = uigetfile('*.tiff','Pick the .tiff movie file');
mov = importdata(datafile);

movinfo = imfinfo(datafile);
NumFrames = length(movinfo);
Ydim = movinfo(1).Width;
Xdim = movinfo(1).Height;

% calculate maximum projection
maxproj = inf(Xdim,Ydim)*-1;
for i = 1:10:NumFrames
    i/NumFrames,
    temp = double(imread(datafile,i));
    maxproj = max(maxproj,temp);
end

figure(1);
imagesc(maxproj);colormap gray;hold on;

%keyboard;

% plot all of the ROIs

NumNeurons = size(C,1);
NumSamples = size(C,2);


ROIcube = reshape(full(A),[Xdim Ydim NumNeurons]);

%imagesc(sum(ROIcube,3));
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

