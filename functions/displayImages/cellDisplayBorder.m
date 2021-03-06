function cellDisplayBorder(imageStruct, colorStr , boundingBox_idx )
%CELLDISPLAYBORDER Summary of this function goes here
%   Detailed explanation goes here

redBW = im2double(imread(imageStruct.redPath));

boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
 
cellMask    = boundingBoxToCellMask(redBW,boundingBox);

switch colorStr
	case 'yelBorder'
		yelImage = imadjust(im2double(imread(imageStruct.yelPath)));
		
		[imX,map] = gray2ind(yelImage,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)];
		yelImage = ind2rgb(imX,yelMap);
		
		cropped = boundingBoxToCroppedColor(yelImage,boundingBox);
		
		edgeCellMask = edge(cellMask);
		fused = imoverlay(cropped,edgeCellMask,'w');
		imshow(fused,'InitialMagnification','fit')
		set(gca,'position',[0 0 1 1])
% 		title('Cell component')
case 'redBorder'
	
	redImage = imadjust(redBW);
	[imX,map]   = gray2ind(redImage,256);
	redMap      = [map(:,1),zeros(256,1),zeros(256,1)];
	redImage       = ind2rgb(imX,redMap);
	cropped     = boundingBoxToCroppedColor(redImage,boundingBox);
	
	edgeCellMask = edge(cellMask);
	fused = imoverlay(cropped,edgeCellMask,'w');
	imshow(fused,'InitialMagnification','fit')
	
		set(gca,'position',[0 0 1 1])
% 		title('Cell component')
	otherwise
		disp('Please enter "redBorder" or "yelBorder".')
		return
end

set(gca,'fontsize',14)

end

