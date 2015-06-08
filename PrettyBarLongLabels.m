function [ output_args ] = PrettyBarLongLabels(indata,dlabels)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure;
x1 = 1:length(indata);
hbar = bar(x1,indata);

% Reduce the size of the axis so that all the labels fit in the figure.
pos = get(gca,'Position');
set(gca,'Position',[pos(1), .2, pos(3) .65])

%Set X-tick positions
Xt = x1;

% If you want to set x-axis limit, uncomment the following two lines of 
% code and remove the third
%Xl = [1 6]; 
%set(gca,'XTick',Xt,'XLim',Xl);
set(gca,'XTick',Xt);
% ensure that each string is of the same length, using leading spaces
algos = ['       CELF'; 'DegDiscount'; '    GroupPR';
    '     Linear'; '     OutDeg'; '   PageRank'; ' buildGraph'];

ax = axis; % Current axis limits
axis(axis); % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4); % Y-axis limits

% Remove the default labels
set(gca,'XTickLabel','')

% Place the text labels
t = text(Xt,Yl(1)*ones(1,length(Xt)),dlabels(1:length(indata)));
set(t,'HorizontalAlignment','right','VerticalAlignment','top', ...
'Rotation',45, 'Fontsize', 10,'Interpreter','none');
ylabel('Neurons Observed per session', 'Fontsize', 13)

end

