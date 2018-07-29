
desktopDir = getDesktopDir();
saveWorkspaceHere = fullfile(desktopDir,'example_quench');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolderN	= 1;																			% number of input folders
inputFolder		= createInputStruct_quench(inputFolderN);	% create empty structs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolder(1).plateStr						= {'plate1'};			% string labelling the plate
inputFolder(1).experimentStr			= {'exp1'};				% string for grouping plates

	inputFolder(1).folderName				= 'plate1_quench'; % name of the data folder
	inputFolder(1).baseFolder				= fullfile('example','data'); % path of data folder
	inputFolder(1).filePrefix				= 'plate1_quench_'; % filename of each image before B02_etc
	
	inputFolder(1).conditionStr			= {'WT','F508del'};
		inputFolder(1).condWells(1,1) = {'B02'}; % the wells for cond 1, 'WT'
		inputFolder(1).condWells(2,1) = {'B03'}; % the wells for cond 2, 'F508del'
		inputFolder(1).condWellsControl(1,1) = {'E02'}; % the control wells for cond 1, 'WT'
		inputFolder(1).condWellsControl(2,1) = {'E03'}; % the control wells for cond 2, 'F508del'
		
	inputFolder(1).timeStep		= 2;					% time between image collection (seconds)
	inputFolder(1).timeline		= [5,26,70];	% [first addition , second addition, end] (timepoints)
																					% [normalize time, start of interest, end] (timepoints)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%