

%% QUENCHING PLOTS 
close all
figure
counter = 1;
relevant = 1:12;
% relevant = [2,3,4,5,6,7,11,12,13];
for i=relevant
	  subplot(3,4,counter)
		plotYelOverTimeCollated(resultsQuench(i))
		counter = counter +1;
end

figure
counter =1;
for i=relevant
		subplot(3,4,counter)
		plotYelOverTime(resultsQuench(i))
		counter = counter +1;
end

desktopDir = getDesktopDir();
saveQuenchingTimelineHere   = fullfile(desktopDir,'timelineQuench.csv');
outputQuenchTimelineToExcelTemp (plate, saveQuenchingTimelineHere)

saveModelTimelineHere   = fullfile(desktopDir,'modelTimeline.csv');
outputModelTimelineToExcel (resultsQuench, saveModelTimelineHere)

