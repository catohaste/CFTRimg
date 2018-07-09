function outputModelTimelineToExcel (...
	resultsStructArray , saveLocationPath)

conditionN = length(resultsStructArray);
rowN  = conditionN * 2;

timepointN = size(resultsStructArray(1).yelInsideOverTTest,2);

desiredPoints = zeros(1,timepointN);
desiredPoints(12) = 1;
desiredPoints(15:end) = 1;
desiredPoints = logical(desiredPoints);
desiredPointsN = sum(desiredPoints);

condition = cell(rowN,1);
test_control = cell(rowN,1);
yelInside = zeros(rowN,desiredPointsN);

counter = 1;
for i=1:conditionN
	
	resultsStruct = resultsStructArray(i);

	yelTest					= resultsStruct.yelInsideOverTTest;
	yelControl			= resultsStruct.yelInsideOverTControl;

	meanYelTest         = mean(yelTest,1);
	meanYelControl      = mean(yelControl,1);
	
	meanYelTest = meanYelTest(desiredPoints);
	meanYelControl = meanYelControl(desiredPoints);
	
	yelInside(counter,:) = meanYelTest;
	yelInside(counter+1,:) = meanYelControl;
	
	condition{counter} = resultsStruct.condition;
	condition{counter+1} = resultsStruct.condition;
	
	test_control{counter} = 'test';
	test_control{counter+1} = 'control';
	
	counter = counter + 2;

end

header{1} = 'condition';
header{2} = 'test or control';
header{3} = 'TimePoint_12';
for i=1:timepointN-14
	header{i+3} = strcat('TimePoint_',num2str(i+14));
end

data = horzcat(condition,test_control,num2cell(yelInside));

T = cell2table(vertcat(header,data));

	writetable(T,saveLocationPath,'WriteVariableNames',false)
	
end

