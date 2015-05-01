function[FiltSig] = NP_QuickFilt(sig,low,high,sr)
% [FiltSig] = NP_QuickFilt(sig,low,high,sr)

forder = 4000;  % filter order has to be even; .. the longer the more
               % selective, but the operation will be linearly slower
    	       % to the filter order
% Check to make sure sig is 3x or more the size of forder and adjust.
% otherwise you will get an error using filtfilt.
if length(sig)/3 < forder
    forder = floor(length(sig)/3)-3;
    disp('Filter order in NP_QuickFilt is lower than 4000.  Check outputs to make sure they look correct')
end

forder = ceil(forder/2)*2;           %make sure filter order is even

firfiltb = fir1(forder,[low/sr*2,high/sr*2]);
FiltSig = filtfilt(firfiltb,1,sig);