function normStructArray = createNormalizeStruct( expStructArray )
%CREATE_NORMALIZE_STRUCT initializes empty structs for data in preparation
%for the normalization to WT process
%   The structs are dummy, temporary structures to store the data while it
%   is being normalized.

expN = length(expStructArray);

normalizeTemplate = struct(...
			'condition',{{}}...
			,'normCondition',''...
			,'cellLocation',{{}}...
			,'yelMembrane',[]...
			,'yelEntire',[]...
			,'redEntire',[]...
			,'yelMembraneAbsolute',[]...
			,'yelEntireAbsolute',[]...
			,'redEntireAbsolute',[]...
			,'memDens',[]...
			,'logMemDens',[]);
		

for j=1:expN

	expStruct = expStructArray(j);

	normStruct = normalizeTemplate;
	normStruct.normCondition = expStruct.normConditionStr;

	for i=1:length(expStruct.imageLocal)

		cellN = expStruct.imageLocal(i).cellN(end);
		tmpCondition(1:cellN,1) = {expStruct.imageLocal(i).condition};
		normStruct.condition = ...
			vertcat(normStruct.condition,tmpCondition);

		clear tmpCondition

		normStruct.cellLocation = vertcat(normStruct.cellLocation...
			,expStruct.imageLocal(i).cellLocation);
		normStruct.yelMembrane = vertcat(normStruct.yelMembrane...
			,expStruct.imageLocal(i).yelMembrane);
		normStruct.yelEntire = vertcat(normStruct.yelEntire...
			,expStruct.imageLocal(i).yelEntire);
		normStruct.redEntire = vertcat(normStruct.redEntire...
			,expStruct.imageLocal(i).redEntire);
		normStruct.yelMembraneAbsolute = ...
			vertcat(normStruct.yelMembraneAbsolute...
			,expStruct.imageLocal(i).yelMembraneAbsolute);	
		normStruct.yelEntireAbsolute = ...
			vertcat(normStruct.yelEntireAbsolute...
			,expStruct.imageLocal(i).yelEntireAbsolute);
		normStruct.redEntireAbsolute = ...
			vertcat(normStruct.redEntireAbsolute...
			,expStruct.imageLocal(i).redEntireAbsolute);


	end

	normStructArray(j) = normStruct;

end

end
