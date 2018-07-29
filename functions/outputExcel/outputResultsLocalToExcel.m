function [perPlateDisplay,plateNTable,compStatsTable] = ...
	outputResultsLocalToExcel( resultsStructArray , normPlateStructArray ...
	, saveLocationFolder )
%OUTPUT_RESULTS_LOCAL_TO_EXCEL
%   The 'xlswrite' function only works on Windows machines and the
%   'writetable' function only works on Mac machine. This function splits
%   in order to work on both PC an unix machines.
%
%		This function creates four xlsx/csv files. The first gives data for
%		every cell. The second file gives some summary statistics of the data
%		per plate. The third file gives summary statistics for each condition
%		using the number of plates as the N value. The final file gives
%		p-values for comparing conditions against each other.

%% RESULTS FOR ALL CELLS
% uses 'resultsStructArray' which is arranged by condition

conditionN = length(resultsStructArray);

totalCellN = 0;
for i=1:conditionN
	resultsStruct = resultsStructArray(i);
	totalCellN = totalCellN + resultsStruct.localCellN;
end

expStr							= cell(totalCellN,1);
plateIdx						= cell(totalCellN,1);
condition						= cell(totalCellN,1);
normCondition				= cell(totalCellN,1);
yelMembrane					= cell(totalCellN,1);
yelEntire						= cell(totalCellN,1);
redEntire						= cell(totalCellN,1);
yelMembraneAbsolute	= cell(totalCellN,1);
yelEntireAbsolute		= cell(totalCellN,1);
redEntireAbsolute		= cell(totalCellN,1);
memDens							= cell(totalCellN,1);
logMemDens					= cell(totalCellN,1);

cntr = 1;
for j=1:conditionN
	resultsStruct = resultsStructArray(j);
	localCellN = resultsStruct.localCellN;
	
	expStr(cntr:cntr+localCellN-1) = resultsStruct.cellLocation(:,1);
	plateIdx(cntr:cntr+localCellN-1) = resultsStruct.cellLocation(:,2);
	condition(cntr:cntr+localCellN-1) = {resultsStruct.condition};
	normCondition(cntr:cntr+localCellN-1) = {resultsStruct.normCondition};
	yelMembrane(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelMembrane(:));
	yelEntire(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelEntire(:));
	redEntire(cntr:cntr+localCellN-1) = num2cell(resultsStruct.redEntire(:));
	yelMembraneAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelMembraneAbsolute(:));
	yelEntireAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelEntireAbsolute(:));
	redEntireAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.redEntireAbsolute(:));
	memDens(cntr:cntr+localCellN-1) = num2cell(resultsStruct.memDens(:));
	logMemDens(cntr:cntr+localCellN-1) = num2cell(resultsStruct.logMemDens(:));
	
	cntr = cntr + localCellN;
end

allCellsHeader = {'expStr', 'plateIdx', 'condition', 'normCondition'...
	, 'yelMembrane', 'yelEntire', 'redEntire', 'yelMembraneAbsolute'...
	, 'yelEntireAbsolute', 'redEntireAbsolute', 'memDens', 'logMemDens'};
allCellsResults = horzcat(expStr,plateIdx,condition,normCondition,yelMembrane...
	,yelEntire,redEntire,yelMembraneAbsolute,yelEntireAbsolute...
	,redEntireAbsolute,memDens,logMemDens);

allCellsCellArray = vertcat(allCellsHeader,allCellsResults);
allCellsTable = cell2table(allCellsResults,'VariableNames',allCellsHeader);

%% STATISTICS PER PLATE
% uses 'normPlateStructArray' which is arranged by plate

tempPerPlateConditions = cell(totalCellN,1);
cellCounter = 1;
plateN = length(normPlateStructArray);

% calculate number of conditions
for j=1:plateN
	plateStruct = normPlateStructArray(j);
	plateCellN = length(plateStruct.condition);
	for i=1:plateCellN
		tempPerPlateConditions{cellCounter} = [plateStruct.plateStr,' '...
			,plateStruct.condition{i},' norm ',plateStruct.normCondition];
		cellCounter = cellCounter + 1;
	end
end

perPlateConditionN = length(unique(tempPerPlateConditions));

perPlateCondition					= cell(perPlateConditionN,4);
perPlateLogMemDens_N			= zeros(perPlateConditionN,1);
perPlateLogMemDens_mean		= zeros(perPlateConditionN,1);
perPlateLogMemDens_STDev	= zeros(perPlateConditionN,1);
perPlateLogMemDens_SEM		= zeros(perPlateConditionN,1);
perPlateLogMemDens_CI_LL	= zeros(perPlateConditionN,1);
perPlateLogMemDens_CI_UL	= zeros(perPlateConditionN,1);
perPlateLogMemDens_median	= zeros(perPlateConditionN,1);

condCounter = 1;
for j = 1:plateN
	plateStruct = normPlateStructArray(j);
	
	plateCondition = unique(plateStruct.condition);
	plateConditionN = length(plateCondition);
	for i = 1:plateConditionN
		
		perPlateCondition{condCounter,1} = plateStruct.experimentStr;
		perPlateCondition{condCounter,2} = plateStruct.plateStr;
		perPlateCondition{condCounter,4} = plateStruct.normCondition;
		
		testCondition = plateCondition{i};
		perPlateCondition{condCounter,3} = testCondition;
		
		locationCondition = strcmp(testCondition,plateStruct.condition);
		perPlateLogMemDens_values = plateStruct.logMemDens(locationCondition);
		
		perPlateLogMemDens_N(condCounter)				= length(perPlateLogMemDens_values);
		perPlateLogMemDens_mean(condCounter)		= mean(perPlateLogMemDens_values);
		perPlateLogMemDens_STDev(condCounter)		= std(perPlateLogMemDens_values);
		perPlateLogMemDens_SEM(condCounter)			= ...
			perPlateLogMemDens_STDev(condCounter) / sqrt(perPlateLogMemDens_N(condCounter));
		confIntTStats														= tinv([0.025  0.975]...
			,perPlateLogMemDens_N(condCounter) - 1);
		perPlateLogMemDens_CI_LL(condCounter)		= mean(perPlateLogMemDens_values) - (confIntTStats(1)*perPlateLogMemDens_SEM(condCounter));
		perPlateLogMemDens_CI_UL(condCounter)		= mean(perPlateLogMemDens_values) + (confIntTStats(2)*perPlateLogMemDens_SEM(condCounter));
		perPlateLogMemDens_median(condCounter)	= median(perPlateLogMemDens_values);
		
		condCounter = condCounter + 1;
		
	end

end

perPlateHeader = {'experiment','plate','condition','normCondition','cellN','mean_rho','STDEV_rho','SEM_rho'...
	,'lower_CI','upper_CI', 'median_rho'};
perPlateResults	=	horzcat(perPlateCondition,num2cell(perPlateLogMemDens_N),...
	num2cell(perPlateLogMemDens_mean),num2cell(perPlateLogMemDens_STDev),...
	num2cell(perPlateLogMemDens_SEM),num2cell(perPlateLogMemDens_CI_LL),...
	num2cell(perPlateLogMemDens_CI_UL),num2cell(perPlateLogMemDens_median));
						
perPlateCellArray = vertcat(perPlateHeader,perPlateResults);
perPlateTable = cell2table(perPlateResults,'VariableNames',perPlateHeader);

[condG,conditionNames] = findgroups(perPlateCondition(:,3));
[plateG,plateNames] = findgroups(perPlateCondition(:,2));
conditionN = length(unique(conditionNames));

perPlateDisplay = NaN(plateN,conditionN);
for i=1:perPlateConditionN
	perPlateDisplay(plateG(i),condG(i)) = perPlateLogMemDens_mean(i);
end

plateDisplayHeader = horzcat(cell(1,1),conditionNames');
plateDisplayResults = horzcat(plateNames,num2cell(perPlateDisplay));

perPlateDisplay = vertcat(plateDisplayHeader,plateDisplayResults);


%% STATISTICS WITH EACH PLATE AS N

perPlateFullConditions = strcat(perPlateCondition(:,3),{' norm '},perPlateCondition(:,4));

plateNCondition = unique(perPlateFullConditions);
plateNConditionN = length(plateNCondition);

plateNLogMemDens_N			= zeros(plateNConditionN,1);
plateNLogMemDens_mean		= zeros(plateNConditionN,1);
plateNLogMemDens_STDev	= zeros(plateNConditionN,1);
plateNLogMemDens_SEM		= zeros(plateNConditionN,1);
plateNLogMemDens_CI_LL	= zeros(plateNConditionN,1);
plateNLogMemDens_CI_UL	= zeros(plateNConditionN,1);
plateNLogMemDens_median	= zeros(plateNConditionN,1);

for i = 1:plateNConditionN
	testCondition = plateNCondition{i};
	locationCondition = strcmp(testCondition,perPlateFullConditions);
	
	plateNLogMemDens_values = perPlateLogMemDens_mean(locationCondition);
	
	plateNLogMemDens_N(i)				= length(plateNLogMemDens_values);
	plateNLogMemDens_mean(i)		= mean(plateNLogMemDens_values);
	plateNLogMemDens_STDev(i)		= std(plateNLogMemDens_values);
	plateNLogMemDens_SEM(i)			= plateNLogMemDens_STDev(i) / sqrt(plateNLogMemDens_N(i));
	confIntTStats								= tinv([0.025  0.975]...
		,plateNLogMemDens_N(i) - 1);
	plateNLogMemDens_CI_LL(i)		= mean(plateNLogMemDens_values) - (confIntTStats(1)*plateNLogMemDens_SEM(i));
	plateNLogMemDens_CI_UL(i)		= mean(plateNLogMemDens_values) + (confIntTStats(2)*plateNLogMemDens_SEM(i));
	plateNLogMemDens_median(i)	= median(plateNLogMemDens_values);
	
end

plateNHeader	= {'fullCondition', 'plateN', 'mean_rho','STDEV_rho','SEM_rho'...
	,'lower_CI','upper_CI', 'median_rho'};
plateNResults	=	horzcat(plateNCondition,num2cell(plateNLogMemDens_N),...
	num2cell(plateNLogMemDens_mean),num2cell(plateNLogMemDens_STDev),...
	num2cell(plateNLogMemDens_SEM),num2cell(plateNLogMemDens_CI_LL),...
	num2cell(plateNLogMemDens_CI_UL),num2cell(plateNLogMemDens_median));

plateNCellArray = vertcat(plateNHeader,plateNResults);
plateNTable = cell2table(plateNResults,'VariableNames',plateNHeader);


%% COMPARATIVE STATISTICS

[~,~,stats]		= anova1(perPlateLogMemDens_mean, perPlateFullConditions);
[multComparison,~,~,gnames]  = multcompare(stats,'CType','dunn-sidak');


group1Name	= gnames(multComparison(:,1));
group2Name	= gnames(multComparison(:,2));
pvalues			= multComparison(:,6);

multComparisonHeader	= {'group1','group2','p_value'};
multComparisonResults = horzcat(group1Name,group2Name,pvalues);

compStatsCellArray = vertcat(multComparisonHeader,multComparisonResults);
compStatsTable = cell2table(multComparisonResults,'VariableNames',multComparisonHeader);

%% WRITE TO FILE

dateFormat = 'yyyy_mm_dd_HHMM';
dateStr = datestr(now,dateFormat); 

if exist(saveLocationFolder,'dir') ~= 7
	mkdir(saveLocationFolder)
end

if ispc == true
	fullFileName = strcat('fullLocalResults_',dateStr,'.xlsx');
	xlswrite(fullfile(saveLocationFolder,fullFileName),allCellsCellArray,'allCells')
	xlswrite(fullfile(saveLocationFolder,fullFileName),perPlateCellArray,'perPlate')
	xlswrite(fullfile(saveLocationFolder,fullFileName),plateNCellArray,'plateN')
	xlswrite(fullfile(saveLocationFolder,fullFileName),compStatsCellArray,'compStats')
elseif isunix == true
	datedFolder = ['fullLocalResults_',dateStr];
	mkdir(fullfile(saveLocationFolder,datedFolder))
	allCellsFileName	= ['allCells_',dateStr,'.csv'];
	perPlateFileName	= ['perPlate_',dateStr,'.csv'];
	plateNFileName		= ['plateN_',dateStr,'.csv'];
	compStatsFileName	= ['compStats_',dateStr,'.csv'];
	writetable(allCellsTable,fullfile(saveLocationFolder,datedFolder,allCellsFileName))
	writetable(perPlateTable,fullfile(saveLocationFolder,datedFolder,perPlateFileName))
	writetable(plateNTable,fullfile(saveLocationFolder,datedFolder,plateNFileName))
	writetable(compStatsTable,fullfile(saveLocationFolder,datedFolder,compStatsFileName))
end

disp('Finished writing to file')

end

