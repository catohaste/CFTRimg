function outputQuenchTimelineToExcelTemp (...
	plateStructArray , saveLocationPath)

plateN = length(plateStructArray);

totalWellN = 0;
maxTimePointN = 0;
for j=1:plateN
	plateStruct = plateStructArray(j);
	wellN = length(plateStruct.well);
	for i=1:wellN
		totalWellN = totalWellN + 1;
		maxTimePointN = max(maxTimePointN,plateStruct.well(i).timeline(end));
	end
end

condition = cell(totalWellN,1);
test_control = cell(totalWellN,1);
yelInside = cell(totalWellN,maxTimePointN);

currentWell = 1;
for k=1:plateN
	plateStruct = plateStructArray(k);
	wellN = length(plateStruct.well);
	for j=1:wellN
		condition{currentWell} = plateStruct.well(j).conditionStr;
		test_control{currentWell} = plateStruct.well(j).test_control;
		for i=1:size(plateStruct.well(j).yelInsideOverT,1)
			yelInside{currentWell,i} = plateStruct.well(j).yelInsideOverT(i);
		end
		currentWell=currentWell +1;
	end
end

header{1} = 'condition';
header{2} = 'test or control';
for i=1:maxTimePointN
	header{i+2} = strcat('TimePoint_',num2str(i));
end

data = horzcat(condition,test_control,yelInside);

T = cell2table(vertcat(header,data));

	writetable(T,saveLocationPath)
	
end

