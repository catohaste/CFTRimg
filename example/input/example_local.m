
desktopDir = getDesktopDir();
saveWorkspaceHere = fullfile(desktopDir,'example_local');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolderN	= 3;																		% number of input folders
inputFolder		= createInputStruct_local(inputFolderN);	% create empty structs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolder(1).plateStr						= {'plate1'};			% string labelling the plate
inputFolder(1).experimentStr			= {'exp1'};				% string for grouping plates

	inputFolder(1).folderName				= 'plate1_local'; % name of the data folder
	inputFolder(1).baseFolder				= fullfile('example','data'); % path of data folder
	inputFolder(1).filePrefix				= 'plate1_local_'; % filename of each image before B02_etc
	
	inputFolder(1).conditionStr			= {'WT','F508del'};
		inputFolder(1).condWells(1,1:2) = {'B02','E02'}; % the wells for cond 1, 'WT'
		inputFolder(1).condWells(2,1:2) = {'B03','E03'}; % the wells for cond 2, 'F508del'
		
	inputFolder(1).normConditionStr	= {'WT'};				% condition to normalize to
	inputFolder(1).pixelBinning			= 1/2;					% 1/2 for 2*2 pixel binning
	inputFolder(1).siteN						= 1;						% number of image sites per well

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

inputFolder(2).plateStr						= {'plate2'};
inputFolder(2).experimentStr			= {'exp2'};

	inputFolder(2).folderName				= 'plate2a_local';
	inputFolder(2).baseFolder				= fullfile('example','data');
	inputFolder(2).filePrefix				= 'plate2_local_';

	inputFolder(2).conditionStr			= {'WT','F508del'};
		inputFolder(2).condWells(1,1)		= {'B02'};
		inputFolder(2).condWells(2,1)		= {'B03'};
		
	inputFolder(2).normConditionStr	= {'WT'};
	inputFolder(2).pixelBinning			= 1/2;
	inputFolder(2).siteN						= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolder(3).plateStr						= {'plate2'};
inputFolder(3).experimentStr			= {'exp2'};

	inputFolder(3).folderName				= 'plate2b_local';
	inputFolder(3).baseFolder				= fullfile('example','data');
	inputFolder(3).filePrefix				= 'plate2_local_';

	inputFolder(3).conditionStr			= {'WT'};
		inputFolder(3).condWells(1,1)		= {'E02'};
		
	inputFolder(3).normConditionStr	= {'WT'};
	inputFolder(3).pixelBinning			= 1/2;
	inputFolder(3).siteN						= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
