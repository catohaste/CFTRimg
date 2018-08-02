

%% QUENCHING PLOTS 
close all
figure
counter = 1;

% subplotRows = 2;
% subplotCols = 4;
% conditionIdx = 1:7;
% subplotIdx = [1,2,3,5,6,7,8];

% conditionIdx = 1:12;
% subplotIdx = 1:12;
% subplotRows = 3;
% subplotCols = 4;

% conditionIdx = 1:9;
% subplotIdx = 1:9;
% subplotRows = 3;
% subplotCols = 3;

conditionIdx = 1:4;
subplotIdx = [1,2,3,4];
subplotRows = 2;
subplotCols = 3;

for i=conditionIdx
	  subplot(subplotRows,subplotCols,subplotIdx(i))
		plotYelOverTimeCollated(resultsQuench(i))
		counter = counter +1;
end

figure
counter =1;
for i=conditionIdx
		subplot(subplotRows,subplotCols,subplotIdx(i))
		plotYelOverTime(resultsQuench(i))
		counter = counter +1;
end

desktopDir = getDesktopDir();
saveQuenchResultsFolder			= fullfile(desktopDir,'resultsQuench');
outputQuenchTimelineToExcel(plate,saveQuenchResultsFolder);

desiredTimePoints = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
desiredTimePoints = logical(desiredTimePoints);

outputModelTimelineToExcel (plate,saveQuenchResultsFolder,desiredTimePoints);

