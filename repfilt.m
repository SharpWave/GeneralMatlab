function [outmat] = repfilt(inmat,h,reps)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:reps
    temp = imfilter(inmat,h);
    inmat = temp;
end
outmat = inmat;
