tic;
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));


% declare global variables
global SITEN BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

runMode = 'acrossExperimentsLocal'; % 'test' OR 'full'


%% IMPORT DATA

if strcmp(runMode,'test')
	SITEN = 2;
	inputDataTest
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
		
elseif strcmp(runMode,'full')
	SITEN = 9;
	inputData
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
	
elseif strcmp(runMode,'acrossExperimentsQuench')
	SITEN = 9;
	inputDataExpQuench
	cond1 = createConditionStruct(exp1);
	cond1 = findImagePaths(exp1,cond1);
	cond2 = createConditionStruct(exp2);
	cond2 = findImagePaths(exp2,cond2);
	cond3 = createConditionStruct(exp3);
	cond3 = findImagePaths(exp3,cond3);
	cond4 = createConditionStruct(exp4);
	cond4 = findImagePaths(exp4,cond4);
	
	elseif strcmp(runMode,'acrossExperimentsLocal')
	SITEN = 9;
	inputDataExpLocal
	cond1 = createConditionStruct(exp1);
	cond1 = findImagePaths(exp1,cond1);
	cond2 = createConditionStruct(exp2);
	cond2 = findImagePaths(exp2,cond2);
	cond3 = createConditionStruct(exp3);
	cond3 = findImagePaths(exp3,cond3);
	cond4 = createConditionStruct(exp4);
	cond4 = findImagePaths(exp4,cond4);
	cond5 = createConditionStruct(exp5);
	cond5 = findImagePaths(exp5,cond5);
end

conditionN = 3;

cond1(2).mutation{1} = 'F508del/R1070W';
cond2(2).mutation{1} = 'F508del/R1070W';
cond3(2).mutation{1} = 'F508del/R1070W';
cond4(2).mutation{1} = 'F508del/R1070W';
cond5(2).mutation{1} = 'F508del/R1070W';

disp('Completed importing data')
time(1) = toc;

%% SEGMENTATION

close all

for j=1:conditionN
 	for i=1:cond(j).localImageN

		cond(j).imageLocal(i) = imgSegmentWatershed(cond(j).imageLocal(i));

	end
end

store = cond;

disp('Completed image segmentation')
time(2) = toc;
%% FILTERING

cond = store;

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i).cellN = cond(j).imageLocal(i).cellN(1);
		
		cond(j).imageLocal(i) = imgFilterEdges(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterUnmasked(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterCellDimensions(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterRedGrad(cond(j).imageLocal(i));
		
	end
end

disp('Completed cell filtering')
time(3) = toc;
%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i) = imgFindBackground(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = distanceMap(cond(j).imageLocal(i));

	end
end

disp('Completed localisation distance map')
time(4) = toc;
%% QUENCHING ANALYSIS

for j=1:conditionN
	
	quenchImageN = cond4(j).quenchImageTestN + cond4(j).quenchImageControlN;
	
	for i=1:quenchImageN
		
		cond(j).imageQuench(i) = findRedMaskChange(cond(j).imageQuench(i));
		
		cond4(j).imageQuench(i) = findYelInsideOverTime(cond4(j).imageQuench(i));
		
		cond4(j).imageQuench(i) = calculateConcIodine(cond4(j).imageQuench(i));
		
	end
end

disp('Completed quenching analysis')
time(5) = toc;
%%

disp('Full analysis completed')


