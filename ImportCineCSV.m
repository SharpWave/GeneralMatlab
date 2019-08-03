function [CineData] = ImportCineCSV(filename)
%UNTITLED Summary of this function goes here

delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Create output variable
CineData = table(dataArray{1:end-1}, 'VariableNames', {'Frame','time','X','Y','MotionMeasure'});




end

