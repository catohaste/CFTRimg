function sizeRecord = testCellSize( resultsStructArray ,plateStructArray ...
	,saveLocation )
%TEST_CELL_SIZE output results after testing filtering on cell size   
%   Output cell images and cell size parameters (like cell area, length,
%   width and perimeter). Combine these with rho, so that the effects of
%   changing the filtering on cell size function

conditionN = length(resultsStructArray);

metricN = 7;
sizeRecord = cell(length(resultsStructArray),metricN + 1);

for j=1:conditionN
	
	resultsStruct = resultsStructArray(j);
	cellN = length(resultsStruct.cellLocation);
	cellLoc = resultsStruct.cellLocation;
	
	mkdir(fullfile(saveLocation,'cells',resultsStruct.mutation))
	
	% output each cell to file with size parameters labelled
	for i=1:cellN
		
		plateIdx = cellLoc(i,1);
		imageIdx = cellLoc(i,2);
		bBoxIdx = cellLoc(i,3);
		
		[redCellImage, yelCellImage, sizeParams] = ...
			cellWithBorderSizeParams(plateStructArray(plateIdx).imageLocal(imageIdx),bBoxIdx);

		textStr = sprintf('%.0f %0.f\n%.0fx%.0f\n%0.3f %0.3f',...
			sizeParams(1),sizeParams(2),sizeParams(3),sizeParams(4),sizeParams(5),sizeParams(6));
		
		redTextImage = insertText(redCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		yelTextImage = insertText(yelCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		
		redFilename = sprintf('red-%d_%d_%d.jpg',plateIdx,imageIdx,bBoxIdx);
		yelFilename = sprintf('yel-%d-%d-%d.jpg',plateIdx,imageIdx,bBoxIdx);
		
		imwrite( redTextImage, fullfile(saveLocation,'cells',resultsStruct.mutation,redFilename) , 'jpg' )
		imwrite( yelTextImage, fullfile(saveLocation,'cells',resultsStruct.mutation,yelFilename) , 'jpg' )
		
	end
	
	% save results in a cell array
	sizeRecord{j,1} = resultsStruct.mutation;
	sizeRecord{j,2} = cellN;
	sizeRecord{j,3} = sizeParams(1);
	sizeRecord{j,4} = sizeParams(2);
	sizeRecord{j,5} = sizeParams(3);
	sizeRecord{j,6} = sizeParams(4);
	sizeRecord{j,7} = sizeParams(5);
	sizeRecord{j,8} = sizeParams(6);
	
	
	mkdir(fullfile(saveLocation,'boxedImages',resultsStruct.mutation))
	
	folderName = fullfile(saveLocation,'boxedImages',resultsStruct.mutation);
	
	% find unique plate and image numbers
	uniquePlateImage = unique(resultsStruct.cellLocation(:,1:2),'rows');
	
	% save full images to file with bounding boxes
	for i=1:length(uniquePlateImage)
		
		plateIdx = uniquePlateImage(i,1);
		imageIdx = uniquePlateImage(i,2);
		
		BB = plateStructArray(plateIdx).imageLocal(imageIdx).boundingBox(:,:);
		
		redAxes				= localDisplayImage(plateStructArray(plateIdx).imageLocal(imageIdx),'red');
		redAxes				= localAddRectangleToImage(redAxes,BB);
		redFrame			= getframe(redAxes);
		imageFilename	= sprintf('plate%d_image%d.jpg',plateIdx,imageIdx);
		imwrite(redFrame.cdata,fullfile(folderName,imageFilename));
		close all
		
	end
	
end


end