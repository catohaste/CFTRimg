
experimentN = 1;
exp1 = createExperimentStruct(experimentN);
exp2 = createExperimentStruct(experimentN);
exp3 = createExperimentStruct(experimentN);
exp4 = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp1(1).expStr = 'Stella YFP mCh 2017-07-05 Plate_15435';

	exp1(1).baseFolder		= '~/Desktop/data';
	exp1(1).local_quench = 'quench';
	exp1(1).filePrefix = 'Stella mCherry YFP 05-07-2017 Katie_';
	
	exp1(1).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp1(1).condWells(1,:) = {'B02','C02','D02'};
		exp1(1).condWells(2,:) = {'B03','C03','D03'};
		exp1(1).condWells(3,:) = {'B04','C04','D04'};
		
		exp1(1).condWellsControl(1,:) = {'E02','F02','G02'};
		exp1(1).condWellsControl(2,:) = {'E03','F03','G03'};
		exp1(1).condWellsControl(3,:) = {'E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp2(1).expStr = 'Stella YFP mCh 2017-07-12 Plate_15452';

	exp2(1).baseFolder		= '~/Desktop/data';
	exp2(1).local_quench = 'quench';
	exp2(1).filePrefix = 'Stella mCherry YFP 2017-07-12_';
	
	exp2(1).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp2(1).condWells(1,:) = {'B02','C02','D02'};
		exp2(1).condWells(2,:) = {'B03','C03','D03'};
		exp2(1).condWells(3,:) = {'B04','C04','D04'};
		
		exp2(1).condWellsControl(1,:) = {'E02','F02','G02'};
		exp2(1).condWellsControl(2,:) = {'E03','F03','G03'};
		exp2(1).condWellsControl(3,:) = {'E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp3(1).expStr = 'Stella YFP mCh 2017-07-14 Plate_15465';

	exp3(1).baseFolder		= '~/Desktop/data';
	exp3(1).local_quench = 'quench';
	exp3(1).filePrefix = 'Stella mCherry YFP 14-07-2017_';
	
	exp3(1).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp3(1).condWells(1,:) = {'B02','C02','D02'};
		exp3(1).condWells(2,:) = {'B03','C03','D03'};
		exp3(1).condWells(3,:) = {'B04','C04','D04'};
		
		exp3(1).condWellsControl(1,:) = {'E02','F02','G02'};
		exp3(1).condWellsControl(2,:) = {'E03','F03','G03'};
		exp3(1).condWellsControl(3,:) = {'E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp4(1).expStr = 'Stella YFP mCh 2017-07-21 Plate_15486';

	exp4(1).baseFolder		= '~/Desktop/data';
	exp4(1).local_quench = 'quench';
	exp4(1).filePrefix = 'Stella mCherry YFP 2017-07-21_';
	
	exp4(1).conditionStr = {'WT','F508del/R1070W','F508del'};
		exp4(1).condWells(1,:) = {'E02','F02','G02'};
		exp4(1).condWells(2,:) = {'E03','F03','G03'};
		exp4(1).condWells(3,:) = {'E04','F04','G04'};
		
		exp4(1).condWellsControl(1,:) = {'B02','C02','D02'};
		exp4(1).condWellsControl(2,:) = {'B03','C03','D03'};
		exp4(1).condWellsControl(3,:) = {'B04','C04','D04'};
		


