function[Epochs] = NP_FindSupraThresholdEpochs(x,InThresh,omitends)
% NP_FindSupraThresholdEpochs(x,InThresh,minsamples)

if (nargin < 3)
    omitends = 1;
end

DatLen = length(x);

OverInThresh = find(x > InThresh);
OverLen = length(OverInThresh);

Epochs = [];

if(isempty(OverInThresh))
    return;
end

curr = 1;
NumEpochs = 0;

while(curr <= OverLen)
  CurrStart = OverInThresh(curr);
  CurrEnd = OverInThresh(curr);
  while ((curr < OverLen) && (OverInThresh(curr+1) == OverInThresh(curr)+1))
      curr = curr+1;
      CurrEnd = OverInThresh(curr);
  end
  NumEpochs = NumEpochs+1;
  Epochs(NumEpochs,1) = CurrStart;
  Epochs(NumEpochs,2) = CurrEnd;
  curr = curr+1; 
end

if (omitends)
    % kill a bad first
    if (Epochs(1,1) == 1)
        if (NumEpochs > 1)
          Epochs = Epochs(2:end,:);
        else
          Epochs = [];
          return;
        end
        
    end
        
    if (Epochs(end,2) == DatLen)
        if (NumEpochs > 1)
          Epochs = Epochs(1:end-1,:);
        else
           Epochs = [];
        end
    end
end

        
      










    


    
    
    