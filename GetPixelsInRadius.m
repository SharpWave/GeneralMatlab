function [goodpix,C] = GetPixelsInRadius(Xdim,Ydim,Xcent,Ycent,radius)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[rr,cc] = meshgrid(1:Ydim,1:Xdim);
C = sqrt((rr-Xcent).^2+(cc-Ycent).^2)<=radius;
goodpix = find(C);

end

