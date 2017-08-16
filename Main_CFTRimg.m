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
	experimentStr = {'exp1'};
	exp = createExperimentStruct(experimentStr);

	exp(1).local_quench = {'60x'};
	exp(1).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',};
	
	exp(1).condWells(1,:) = {'B02'};
	exp(1).condWells(2,:) = {'B03'};
	exp(1).condWells(3,:) = {'B04'};

	
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

elseif strcmp(runMode,'Stella')
	SITEN = 9;
	inputDataStellaICL4
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
end

conditionN = 3;

disp('Completed importing data')
time(1) = toc;

%% SEGMENTATION

close all

for j=1:conditionN
 	for i=1:cond1(j).localImageN
		cond1(j).imageLocal(i) = imgSegmentWatershed(cond1(j).imageLocal(i));
	end
	for i=1:cond2(j).localImageN
		cond2(j).imageLocal(i) = imgSegmentWatershed(cond2(j).imageLocal(i));
	end
	for i=1:cond3(j).localImageN
		cond3(j).imageLocal(i) = imgSegmentWatershed(cond3(j).imageLocal(i));
	end
	for i=1:cond4(j).localImageN
		cond4(j).imageLocal(i) = imgSegmentWatershed(cond4(j).imageLocal(i));
	end
	for i=1:cond5(j).localImageN
		cond5(j).imageLocal(i) = imgSegmentWatershed(cond5(j).imageLocal(i));
	end
end

store1 = cond1;
store2 = cond2;
store3 = cond3;
store4 = cond4;
store5 = cond5;

disp('Completed image segmentation')
time(2) = toc;
%% FILTERING

cond1 = store1;
cond2 = store2;
cond3 = store3;
cond4 = store4;
cond5 = store5;

for j=1:conditionN
	for i=1:cond1(j).localImageN
		cond1(j).imageLocal(i).cellN = cond1(j).imageLocal(i).cellN(1);
		cond1(j).imageLocal(i) = imgFilterEdges(cond1(j).imageLocal(i));
		cond1(j).imageLocal(i) = imgFilterUnmasked(cond1(j).imageLocal(i));
		cond1(j).imageLocal(i) = imgFilterCellDimensions(cond1(j).imageLocal(i));
		cond1(j).imageLocal(i) = imgFilterRedGrad(cond1(j).imageLocal(i));
	end
	for i=1:cond2(j).localImageN
		cond2(j).imageLocal(i).cellN = cond2(j).imageLocal(i).cellN(1);
		cond2(j).imageLocal(i) = imgFilterEdges(cond2(j).imageLocal(i));
		cond2(j).imageLocal(i) = imgFilterUnmasked(cond2(j).imageLocal(i));
		cond2(j).imageLocal(i) = imgFilterCellDimensions(cond2(j).imageLocal(i));
		cond2(j).imageLocal(i) = imgFilterRedGrad(cond2(j).imageLocal(i));
	end
	for i=1:cond3(j).localImageN
		cond3(j).imageLocal(i).cellN = cond3(j).imageLocal(i).cellN(1);
		cond3(j).imageLocal(i) = imgFilterEdges(cond3(j).imageLocal(i));
		cond3(j).imageLocal(i) = imgFilterUnmasked(cond3(j).imageLocal(i));
		cond3(j).imageLocal(i) = imgFilterCellDimensions(cond3(j).imageLocal(i));
		cond3(j).imageLocal(i) = imgFilterRedGrad(cond3(j).imageLocal(i));
	end
	for i=1:cond4(j).localImageN
		cond4(j).imageLocal(i).cellN = cond4(j).imageLocal(i).cellN(1);
		cond4(j).imageLocal(i) = imgFilterEdges(cond4(j).imageLocal(i));
		cond4(j).imageLocal(i) = imgFilterUnmasked(cond4(j).imageLocal(i));
		cond4(j).imageLocal(i) = imgFilterCellDimensions(cond4(j).imageLocal(i));
		cond4(j).imageLocal(i) = imgFilterRedGrad(cond4(j).imageLocal(i));
	end
	for i=1:cond5(j).localImageN
		cond5(j).imageLocal(i).cellN = cond5(j).imageLocal(i).cellN(1);
		cond5(j).imageLocal(i) = imgFilterEdges(cond5(j).imageLocal(i));
		cond5(j).imageLocal(i) = imgFilterUnmasked(cond5(j).imageLocal(i));
		cond5(j).imageLocal(i) = imgFilterCellDimensions(cond5(j).imageLocal(i));
		cond5(j).imageLocal(i) = imgFilterRedGrad(cond5(j).imageLocal(i));
	end
end

disp('Completed cell filtering')
time(3) = toc;
%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond1(j).localImageN
		cond1(j).imageLocal(i) = imgFindBackground(cond1(j).imageLocal(i));
		cond1(j).imageLocal(i) = distanceMap(cond1(j).imageLocal(i));
	end
	for i=1:cond2(j).localImageN
		cond2(j).imageLocal(i) = imgFindBackground(cond2(j).imageLocal(i));
		cond2(j).imageLocal(i) = distanceMap(cond2(j).imageLocal(i));
	end
	for i=1:cond3(j).localImageN
		cond3(j).imageLocal(i) = imgFindBackground(cond3(j).imageLocal(i));
		cond3(j).imageLocal(i) = distanceMap(cond3(j).imageLocal(i));
	end
	for i=1:cond4(j).localImageN
		cond4(j).imageLocal(i) = imgFindBackground(cond4(j).imageLocal(i));
		cond4(j).imageLocal(i) = distanceMap(cond4(j).imageLocal(i));
	end
	for i=1:cond5(j).localImageN
		cond5(j).imageLocal(i) = imgFindBackground(cond5(j).imageLocal(i));
		cond5(j).imageLocal(i) = distanceMap(cond5(j).imageLocal(i));
	end
end

disp('Completed localisation distance map')
time(4) = toc;
%% QUENCHING ANALYSIS
% 
% for j=1:conditionN
% 	
% 	quenchImageN = cond(j).quenchImageTestN + cond(j).quenchImageControlN;
% 	
% 	for i=1:quenchImageN
% 		
% 		cond(j).imageQuench(i) = findRedMaskChange(cond(j).imageQuench(i));
% 		
% 		cond(j).imageQuench(i) = findYelInsideOverTime(cond(j).imageQuench(i));
% 		
% 		cond(j).imageQuench(i) = calculateConcIodine(cond(j).imageQuench(i));
% 		
% 	end
% end
% 
% disp('Completed quenching analysis')
% time(5) = toc;
%%

disp('Full analysis completed')


