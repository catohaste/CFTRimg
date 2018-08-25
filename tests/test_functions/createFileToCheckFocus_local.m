function createFileToCheckFocus_local(plateStructArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

desktopDir = getDesktopDir();
folderName = fullfile(desktopDir,'test_output','checkFocusLocal');
if exist(folderName,'dir') ~= 7
	mkdir(folderName)
end

disp('Running "createFileToCheckFocus_local"...')

plateN = length(plateStructArray);
for indexA = 1:plateN
	imageN = length(plateStructArray(indexA).image);
	filename = ['checkFocusLocal_',plateStructArray(indexA).plateStr,'.tif'];
	for indexB = 1:imageN
		image = imadjust(im2double(imread(plateStructArray(indexA).image(indexB).redPath)));
		if indexB == 1
			imwrite(image,fullfile(folderName,filename),'Resolution',512,'Compression','jpeg','RowsPerStrip',8);
		else
			imwrite(image,fullfile(folderName,filename),'WriteMode','append','Resolution',512,'Compression','jpeg','RowsPerStrip',8);
		end
	end
end
	
disp('Completed')

end
