function outputQuenchTimelineToExcelTemp (...
	expStructArray , saveLocationPath)

expN = length(expStructArray);

totalWellN = 0;
maxTimePointN = 0;
for j=1:expN
	expStruct = expStructArray(j);
	wellN = length(expStruct.imageQuench);
	for i=1:wellN
		totalWellN = totalWellN + 1;
		maxTimePointN = max(maxTimePointN,expStruct.imageQuench(i).timeline(end));
	end
end

condition = cell(totalWellN,1);
test_control = cell(totalWellN,1);
yelInside = cell(totalWellN,maxTimePointN);

currentWell = 1;
for k=1:expN
	expStruct = expStructArray(k);
	wellN = length(expStruct.imageQuench);
	for j=1:wellN
		condition{currentWell} = expStruct.imageQuench(j).condition;
		test_control{currentWell} = expStruct.imageQuench(j).test_control;
		for i=1:size(expStruct.imageQuench(j).yelInsideOverT,1)
			yelInside{currentWell,i} = expStruct.imageQuench(j).yelInsideOverT(i);
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

