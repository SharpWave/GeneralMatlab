function [] = DWS_WidebandPlx2dat(inname,outname,NumChannels)
% [] = DWS_WidebandPlx2dat(inname,channels)
% this function takes a .plx file containing wideband data, extracts the
% wideband data, and compiles it into the datamax .dat binary format that
% is compatible with the Neuroscope/Klusters/NdManager suite

display('setting things up');
CurrChan = 1;
[ns,s] = plx_adchan_samplecounts(inname);
NumSamples = s(1);
fout = fopen([outname,'.dat'],'w+');
ChunkSize = 5000000;
NumFullChunks = floor(NumSamples/ChunkSize);
CurrStart = 1;
CurrStart = ChunkSize*10;
ad = zeros(NumChannels,ChunkSize);

display('writing channels to files');
for i = 1:NumChannels
  display(['writing channel ',int2str(i-1)]);
  [~,~,~,~,v] = plx_ad(inname,i-1);
  fouts{i} = fopen(['tmpchan.',int2str(i-1)],'w+');
  fwrite(fouts{i},v,'int16');
end
  
display('opening files');

for i = 1:NumChannels
    fins{i} = fopen(['tmpchan.',int2str(i-1)],'r');
end

for j = 1:NumFullChunks
    tic
    j/NumFullChunks
    for i = 1:NumChannels
      % read a chunk's worth of data
        ad(i,:) = fread(fins{i},ChunkSize,'int16');
    end
    
    CurrStart = CurrStart + ChunkSize;
    fwrite(fout,ad,'int16');
    toc
end
fclose(fout);



