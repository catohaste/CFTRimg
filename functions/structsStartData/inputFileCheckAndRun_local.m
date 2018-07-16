function [inputFolder,saveWorkspaceHere] = ...
	inputFileCheckAndRun_local(inputFileName)
%inputFileCheckAndRun_local check for common errors in the input file
%
%   Some mistakes in an input file result in MATLAB throwing an automated
%   error. Often the error messages are not very helpful. The first part of
%   this function tries to identify the exact source of an error in the
%   input file, and give a more helpful error message.
%
%		Other mistakes in an input file either result in errors being thrown
%		later during image analysis, or simply in the incorrect processing of
%		the data. The second half of this function aims to identify an input
%		errors before the image analysis begins.
%
%		Errors which are identified are:
%			* dimension mismatch in the condWells
%			* mismatch in inputFolder dimensions (warning only)
%			* incorrect folderName or baseFolder
%			* incorrect folder structure (no "TimePoint_" folders)
%			* consistent localization variables within a plate
%			* "normConditionStr" not present in "conditionStr"

try
	run(inputFileName)
catch matlabException
	if strcmp(matlabException.identifier,'MATLAB:subsassigndimmismatch')
		errorLine = matlabException.stack(1).line;
		msg = ['Dimension mismatch when defining "condWells". Check line '...
					,num2str(errorLine),' of the input file. '];
		causeException = MException('MATLAB:inputFile:dimmismatch',msg);
		matlabException = addCause(matlabException,causeException);
	end
	rethrow(matlabException)
end

% check value of inputFolderN
if inputFolderN ~= length(inputFolder)
	warning(['"inputFolderN" number differes from the final length of ',...
		'"inputFolder". Check the value of "inputFolderN" set, or the indices of '...
		'"inputFolder" used.']);
	inputFolderN = length(inputFolder);
end

% check that all input folders exist
for i=1:inputFolderN
	fileFolder = fullfile(inputFolder(i).baseFolder,inputFolder(i).folderName);
	if exist(fileFolder) == 7
		continue
	else
		msg = ['The file folder for "inputFolder(',num2str(i),')" does not exist.'...
			' Check "inputFolder(',num2str(i),').folderName" and "inputFolder('...
			,num2str(i),').baseFolder".'];
		error(msg)
	end
end

% check that input folders have the required structure (inc. "TimePoint_")
for i=1:inputFolderN
	fileFolder = fullfile(inputFolder(i).baseFolder,inputFolder(i).folderName,'TimePoint_1');
	if exist(fileFolder) == 7
		continue
	else
		msg = ['Your data is not organized in the correct way to be '...
			,'automatically uploaded. Please see the example data files for '...
			,'the correct structure. Alternatively, you can edit '...
			,'"functions/populatePlates_local.m".'];
		error(msg)
	end
end

% if plateStr is repeated, check that localization variables are consistent
allPlateStr = vertcat(inputFolder.plateStr);
uniquePlateStr = unique(allPlateStr);
if length(allPlateStr) ~= length(uniquePlateStr)
	for j=1:length(uniquePlateStr)
		currentPlateStr = uniquePlateStr{j,1};
		locationPlateStr = false(inputFolderN,1);
		for i=1:inputFolderN
			locationPlateStr(i) = strcmp(currentPlateStr,inputFolder(i).plateStr{1});
			locationIndices = (1:inputFolderN)' .* locationPlateStr;
			locationIndices(locationIndices == 0) = []; % remove zeros
		end
		if sum(locationPlateStr) > 1
			inputPlate = inputFolder(locationPlateStr);
			if length(unique(horzcat(inputPlate.normConditionStr))) > 1
				msg = ['The plateStr "', currentPlateStr, '" is repeated. '...
            ,'The value of "normConditionStr" must be consistent within'...
						,' a plate. Check inputFolders ', num2str(locationIndices')...
						,'. '];
				error(msg)
			elseif length(unique(horzcat(inputPlate.pixelBinning))) > 1
				msg = ['The plateStr "', currentPlateStr, '" is repeated. '...
            ,'The value of "pixelBinning" must be consistent within'...
						,' a plate. Check inputFolders ', num2str(locationIndices')...
						,'. '];
				error(msg)
			elseif length(unique(horzcat(inputPlate.siteN))) > 1
				msg = ['The plateStr "', currentPlateStr, '" is repeated. '...
            ,'The value of "siteN" must be consistent within'...
						,' a plate. Check inputFolders ', num2str(locationIndices')...
						,'. '];
				error(msg)
			end
		end
	end
end

% check that every plate contains its normConditionStr
for i=1:inputFolderN
	if ~ismember(inputFolder(i).normConditionStr,inputFolder(i).conditionStr)
		msg = ['The cell array "inputFolder.conditionStr" must contain '...
			,'the value of "normConditionStr". Check '...
			,'inputFolder ', num2str(i), '. '];
		error(msg)
	end
end
	
% check experiment grouping


end