function createFileToCheckFocus_quench(plateStructArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

desktopDir = getDesktopDir();
folderName = fullfile(desktopDir,'test_output','checkFocusQuench');
if exist(folderName,'dir') ~= 7
	mkdir(folderName)
end

disp('Running "createFileToCheckFocus_quench"...')

plateN = length(plateStructArray);
for indexA = 1:plateN
	wellN = length(plateStructArray(indexA).well);
	for indexB = 1:wellN
		filename = ['checkFocusQuench_',plateStructArray(indexA).plateStr,'_well',num2str(indexB),'.tif'];
		timePointN = plateStructArray(indexA).well(indexB).timeline(end);
		redStartBW = im2double(imread(plateStructArray(indexA).well(indexB).redPath{1}));
		minRed = min(redStartBW(:));
		maxRed = max(redStartBW(:));
		% write first red image
		redStartBW = imadjust(redStartBW,[minRed maxRed]);
		[redImX,tmpRedMap] 	= gray2ind(redStartBW,256);
		redMap      				= [tmpRedMap(:,1),zeros(256,1),zeros(256,1)];
		redImage 						= ind2rgb(redImX,redMap);
		imwrite(redImage,fullfile(folderName,filename),'Resolution',216,'Compression','jpeg','RowsPerStrip',8);
		% write second red image
		redEndBW = imadjust(im2double(imread(plateStructArray(indexA).well(indexB).redPath{2})),[minRed maxRed]);
		[redImX,tmpRedMap] 	= gray2ind(redEndBW,256);
		redMap      				= [tmpRedMap(:,1),zeros(256,1),zeros(256,1)];
		redImage 						= ind2rgb(redImX,redMap);
		imwrite(redImage,fullfile(folderName,filename),'WriteMode','append','Resolution',216,'Compression','jpeg','RowsPerStrip',8);
		yelBW = im2double(imread(plateStructArray(indexA).well(indexB).yelPath{1}));
		minYel = min(yelBW(:));
		maxYel = max(yelBW(:));
		for indexC = 1:timePointN
			yelBW = imadjust(im2double(imread(plateStructArray(indexA).well(indexB).yelPath{indexC})),[minYel maxYel]);
			[yelImX,tmpYelMap] 	= gray2ind(yelBW,256);
			yelMap      				= [tmpYelMap(:,1),tmpYelMap(:,1),zeros(256,1)];
			yelImage 						= ind2rgb(yelImX,yelMap);
			imwrite(yelImage,fullfile(folderName,filename),'WriteMode','append','Resolution',216,'Compression','jpeg','RowsPerStrip',8);
		end
	end
end

disp('Completed')

end



