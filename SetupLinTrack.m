function [] = SetupLinTrack(xpos,ypos)

close all;
% sets up automatic parsing of the linear track task

% first, use PCA to linearize the maze
SR = 10;
t = (1:length(xpos))/SR;

figure(1);
subplot(2,1,1);plot(t,xpos);axis tight;
subplot(2,1,2);plot(t,ypos);axis tight;xlabel('time (sec)');

StartSec = input('enter the timepoint in sec where the position starts making sense --> ');
StartSamp = StartSec*SR;

% ok so now chop out the shit at the beginning

xpos = xpos(StartSamp:end);
ypos = ypos(StartSamp:end);

figure(2);
histogram2(xpos,ypos,[4 100],'DisplayStyle','tile');

DownEnd = input('enter the limit y coordinate for the bottom end ->');
UpEnd = input('enter the limit y coordinate for the top end ->');

NumSamples = length(ypos);
ts = 1:NumSamples;

% area coding: 1 - Up, 2 - Down, 3 - Track

for i = 1:NumSamples
    if (ypos(i) > UpEnd)
        areacode(i) = 1;
    else
        if (ypos(i) < DownEnd)
            areacode(i) = 2;
        else
            areacode(i) = 3;
        end
    end
end


IsInEnd = (areacode ~= 3);

%
IsValidRun = ones(1,NumSamples);
IsValidRun(find(IsInEnd)) = 0;

% find the first time the mouse is at one of the ends
FirstEndSample = min(find(IsInEnd));

% none of the time the mouse is on the track counts until he visits an end
IsValidRun(1:FirstEndSample-1) = 0;

LastValidEnd = areacode(FirstEndSample);

timepointer = FirstEndSample;

if (LastValidEnd == 1)
    OppositeEnds = (areacode == 2);
else
    OppositeEnds = (areacode == 1);
end

NumRunsToUp = 0;
NumRunsToDown = 0;

% check if the mouse visits the opposite side again
if(LastValidEnd == 1)
    MoreValidRunsLeft = sum(areacode(timepointer:end) == 2) > 0;
else
    MoreValidRunsLeft = sum(areacode(timepointer:end) == 1) > 0;
end

while(MoreValidRunsLeft)
    FoundIt = 0;
    while(~FoundIt)
        % set timepointer to next time he leaves
        while(areacode(timepointer) ~= 3)
            timepointer = timepointer + 1;
        end
        
        % set searchpointer to the next time he reaches an end
        searchpointer = timepointer;
        while(areacode(searchpointer) == 3)
            searchpointer = searchpointer + 1;
        end
        
        if (areacode(searchpointer) ~= areacode(timepointer - 1))
            % he made it to the opposite side and this is a good run
            FoundIt = 1;
            if (LastValidEnd == 2)
                NumRunsToUp = NumRunsToUp + 1;
                RunsToUp(NumRunsToUp).start_ts = timepointer;
                RunsToUp(NumRunsToUp).end_ts = searchpointer -1;
                LastValidEnd = 1;
            else
                NumRunsToDown = NumRunsToDown + 1;
                RunsToDown(NumRunsToDown).start_ts = timepointer;
                RunsToDown(NumRunsToDown).end_ts = searchpointer -1;
                LastValidEnd = 2;
            end
            
            
        else
            IsValidRun(timepointer:searchpointer-1) = 0;
            
        end
        timepointer = searchpointer;
    end
    
    if(LastValidEnd == 1)
        MoreValidRunsLeft = sum(areacode(timepointer:end) == 2) > 0;
    else
        MoreValidRunsLeft = sum(areacode(timepointer:end) == 1) > 0;
    end
end







% advance to the next time the mouse is in area 3

% then, from that point, ask if the next time he's NOT in area 3 is via
% going to the same or opposite end
% if it's the opposite, all of the points in between are a valid run
%
%






% USEFUL SOMEWHERE BUT UNNCESSARY HERE
% figure(3);
% plot(ypos,'k');axis tight;hold on;
% line([1 length(ypos)] ,[DownEnd DownEnd],'Color','r');
% line([1 length(ypos)], [UpEnd UpEnd],'Color','r');
% display('ok, now click once per every time the mouse returns to an end');
% display('even turnarounds, so long as he crossed the threshold');
%
%
%
% w = 'normal';
% NumGoodPoints = 0;
% mousetype = [];
% while(~strcmp(mousetype,'alt'))
%     display('click the position');
%     [tinput,~] = ginput(1);
%     o = plot(tinput,ypos(round(tinput)),'r*');
%     display('now left click to do another or click right when yo done ');
%     display('or hit backspace to delete the last point');
%     w = waitforbuttonpress;
%     if (w == 1)
%         if (get(gcf,'CurrentCharacter') == '')
%             delete(o);
%         end
%     end
%     if (w == 0)
%         mousetype = get(gcf,'SelectionType');
%
%         NumGoodPoints = NumGoodPoints + 1;
%         tpoints(NumGoodPoints) = round(tinput);
%
%     end
% end

% now divvy up the time into 5 categories
% DownEnd, UpEnd, RunToDown,RunToUp, and BadTrial, and nil

% Start with first end
% iterate, looking for a border crossing.
% everything up to the border crossing is nil

% past the border crossing, iterate until next border crossing
% if next border crossed was opposite, mark points between appropriate run

%
figure(3);

for i = 1:length(RunsToUp)
    plot(RunsToUp(i).start_ts:RunsToUp(i).end_ts,ypos(RunsToUp(i).start_ts:RunsToUp(i).end_ts),'-m','LineWidth',3);hold on;
end

for i = 1:length(RunsToDown)
    plot(RunsToDown(i).start_ts:RunsToDown(i).end_ts,ypos(RunsToDown(i).start_ts:RunsToDown(i).end_ts),'-g','LineWidth',3);hold on;
end
plot(ypos,'-r');
save LinTrackInfo.mat UpEnd DownEnd StartSamp RunsToUp RunsToDown ypos xpos;

end




% draw a rectangle around valid maze points

% only do stats on these

% plot 2-d




