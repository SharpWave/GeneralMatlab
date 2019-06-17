function [outputArg1,outputArg2] = RUNCNMFE
% wrapper for a wrapper for a wrapper
% takes the work out of getting things set up

% parameters
patch_dims = [50, 50];
K = 20;         %  the maximum number of neurons per patch. 
gSiz = 10;      % the diameter of a neuron in pixels. If not initialized, it is initialized as roughly twice the gSig parameter. It’s used in initialization for constructing boxes around seed pixels.
gSig = 5;       % roughly equal to the half-diameter of a cell in pixels. It is used to high pass filter the movie before initialization
min_pnr = 40;%60;   % the minimum peak-to-noise ratio a pixel must have to be considered. Set higher if lots of false positives
min_corr = 0.9; %  the minimum correlation for a pixel to be considered as a seed during initialization
max_tau = 0.400;
merge_threshold = 0.4;%.65

% memory_size_to_use: total memory to use at a time in GB (defaults to 64GB).
% memory_size_per_patch: the amount of memory in GB to use for each patch (defaults to 8GB).
% hat the default value of merge_threshold is 0.80 for CaImAn, and 0.65 for MATLAB CNMF_E.
% first, grab the data directory
cd('C:\Users\Dave\Documents\Inscopix_Projects\');

[datafile,datapath] = uigetfile('*.isxd','Pick the movie file');
[filepath,name,ext] = fileparts([datapath,datafile]);
cd(datapath);

mov_file = fullfile([datapath,datafile]);
pp_mov_file = fullfile([datapath,name,'-PP',ext]);

[~,name,~] = fileparts(pp_mov_file);

cellset_file = fullfile([datapath,name,'-CNFE',ext]);
events_file = fullfile([datapath,name,'-CNFE-ED',ext]);


% Re-downsample the file by 2 (assumes file already downsampled by 2 during
% collection or in Inscopix data processing

isx.preprocess(datafile, pp_mov_file, 'spatial_downsample_factor', 2, 'temporal_downsample_factor', 1,'fix_defective_pixels', 0);

isx.cnmfe.run_cnmfe(pp_mov_file, cellset_file, events_file, 'patch_dims', patch_dims, 'K', K, 'gSiz', gSiz, 'gSig', gSig, 'min_pnr', min_pnr, 'min_corr', min_corr, 'max_tau', max_tau,'merge_threshold',merge_threshold,'event_threshold', 0.1);

end

