function [] = DWS_WidebandPlx2dat(inname,outname,NumChannels)
% [] = DWS_WidebandPlx2dat(inname,channels)
% this function takes a .plx file containing wideband data, extracts the
% wideband data, and compiles it into the datamax .dat binary format that
% is compatible with the Neuroscope/Klusters/NdManager suite


CurrChan = 1;
[ns,s] = plx_adchan_samplecounts(inname);
NumSamples = s(1);
fout = fopen([outname,'.dat'],'w');
ChunkSize = 5000000;
NumFullChunks = floor(NumSamples/ChunkSize);
CurrStart = 1;
CurrStart = ChunkSize*10;
ad = zeros(NumChannels,ChunkSize);

for i = 1:NumChannels
  i
  [~,~,~,~,v] = plx_ad(inname,i-1);
  fouts{i} = fopen(['tmpchan.',int2str(i-1)],'w');
  fwrite(fouts{i},ad,'int16');
end
  
% for j = 1:NumFullChunks
%     tic
%     j/NumFullChunks
%     for i = 1:NumChannels
%         
%         % read the wideband signal for channel i
%         [~,~,ad(i,1:ChunkSize)] = plx_ad_span(inname,i-1,CurrStart,CurrStart+ChunkSize-1);
%         %ad(i,:) = temp;
%         
%     end
%     CurrStart = CurrStart + ChunkSize;
%     fwrite(fout,ad,'int16');
%     toc
% end
% fclose(fout);



