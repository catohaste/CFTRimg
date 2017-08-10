
experimentN = 1;
exp1 = createExperimentStruct(experimentN);
exp2 = createExperimentStruct(experimentN);
exp3 = createExperimentStruct(experimentN);
exp5 = createExperimentStruct(experimentN);
experimentN = 2;
exp4 = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp1(1).expStr = 'Stella YFP mCh 2017-06-29 Plate_15419 localisation';

	exp1(1).baseFolder		= '~/Desktop/data';
	exp1(1).local_quench = 'local';
	exp1(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp1(1).conditionStr = {'WT','F508del','R1070W'};
		exp1(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp1(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp1(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp2(1).expStr = 'Stella YFP mCh 2017-07-05 Plate_15433 localisation';

	exp2(1).baseFolder		= '~/Desktop/data';
	exp2(1).local_quench = 'local';
	exp2(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp2(1).conditionStr = {'WT','F508del','R1070W'};
		exp2(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp2(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp2(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp3(1).expStr = 'Stella YFP mCh 2017-07-12 Plate_15451 localisation';

	exp3(1).baseFolder		= '~/Desktop/data';
	exp3(1).local_quench = 'local';
	exp3(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp3(1).conditionStr = {'WT','F508del','R1070W'};
		exp3(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp3(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp3(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
				
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp4(1).expStr = 'Stella YFP mCh 2017-07-14 Plate_15463 localisation';

	exp4(1).baseFolder		= '~/Desktop/data';
	exp4(1).local_quench = 'local';
	exp4(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp4(1).conditionStr = {'WT','F508del'};
		exp4(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp4(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp4(2).expStr = 'Stella YFP mCh 2017-07-14 Plate_15464 localisation';

	exp4(2).baseFolder		= '~/Desktop/data';
	exp4(2).local_quench = 'local';
	exp4(2).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp4(2).conditionStr = {'R1070W'};
		exp4(2).condWells(1,:) = {'B04','C04','D04','E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp5(1).expStr = 'Stella YFP mCh 2017-07-21 Plate_15485 localisation';

	exp5(1).baseFolder		= '~/Desktop/data';
	exp5(1).local_quench = 'local';
	exp5(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp5(1).conditionStr = {'WT','R1070W','F508del'};
		exp5(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp5(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp5(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
		
