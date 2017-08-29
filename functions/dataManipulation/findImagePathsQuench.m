function [ redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl] = findImagePathsQuench( ...
	conditionLocation,experimentStruct...
	,redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl)
%FINDIMAGEPATHSQUENCH Constructs file names for quenching data
%   Also performs tests on existance of files.

redTimePoints = {'1','70'};

wellsTest = {experimentStruct.condWells{conditionLocation,:}};
wellsControl = {experimentStruct.condWellsControl{conditionLocation,:}};

wellsTestN = sum(~cellfun(@isempty,experimentStruct.condWells(conditionLocation,:)));
wellsControlN = sum(~cellfun(@isempty,experimentStruct.condWellsControl(conditionLocation,:)));

tmpRedPathArrayTest = cell(wellsTestN,2);
tmpYelPathArrayTest = cell(wellsTestN,70);
tmpRedPathArrayControl = cell(wellsControlN,2);
tmpYelPathArrayControl = cell(wellsControlN,70);

testRed = zeros(2,1);
testYel = zeros(70,1);

for j=1:wellsTestN

	[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
		constructPathNameQuench(experimentStruct,wellsTest,j,redTimePoints...
		,tmpRedPathArrayTest,tmpYelPathArrayTest);
	
	% check that all files are there
	for i=1:2
		testRed(i) = exist(tmpRedPathArrayTest{j,1},'file') == 2 ;
	end
	for i=1:70
		testYel(i) = exist(tmpYelPathArrayTest{j,1},'file') == 2 ;
	end
	if vertcat(testRed,testYel)
		% do nothing
	else
		fprintf('File missing for experiment %s, well %s'...
			,experimentStruct.expStr,wellsTest{j})
	end

end

for j=1:wellsControlN

	[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
		constructPathNameQuench(experimentStruct,wellsControl,j,redTimePoints...
		,tmpRedPathArrayControl,tmpYelPathArrayControl);
	
	% check that all files are there
	for i=1:2
		testRed(i) = exist(tmpRedPathArrayTest{j,1},'file') == 2 ;
	end
	for i=1:70
		testYel(i) = exist(tmpYelPathArrayTest{j,1},'file') == 2 ;
	end
	if vertcat(testRed,testYel)
		% do nothing
	else
		fprintf('File missing for experiment %s, well %s'...
			,experimentStruct.expStr,wellsTest{j})
	end

end

clear tmpRed1 tmpRed2 tmpYel

redPathArrayTest = [redPathArrayTest; tmpRedPathArrayTest];
yelPathArrayTest = [yelPathArrayTest; tmpYelPathArrayTest];

redPathArrayControl = [redPathArrayControl; tmpRedPathArrayControl];
yelPathArrayControl = [yelPathArrayControl; tmpYelPathArrayControl];

end


