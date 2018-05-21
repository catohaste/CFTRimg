function [redCellImage,yelCellImage,sizeParams] = ...
	cellWithBorderSizeParams(imageStruct , boundingBox_idx )
%CELL_WITH_BORDER_SIZE_PARAMS output red and yellow cell image with border
%and cell size params

redBW = im2double(imread(imageStruct.redPath));
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
cellMask    = boundingBoxToCellMask(redBW,boundingBox);

redImage = imadjust(redBW);
yelImage = imadjust(im2double(imread(imageStruct.yelPath)));

[redImX,map]   = gray2ind(redImage,256);
redMap      = [map(:,1),zeros(256,1),zeros(256,1)];
redImage       = ind2rgb(redImX,redMap);
redCropped     = boundingBoxToCroppedColor(redImage,boundingBox);

[yelImX,tmpYelMap] = gray2ind(yelImage,256);
yelMap = [tmpYelMap(:,1),tmpYelMap(:,1),zeros(256,1)];
yelImage = ind2rgb(yelImX,yelMap);
yelCropped = boundingBoxToCroppedColor(yelImage,boundingBox);

edgeCellMask = edge(cellMask);
redCellImage = imoverlay(redCropped,edgeCellMask,'w');
yelCellImage = imoverlay(yelCropped,edgeCellMask,'w');

[labelled, ~] = bwlabel(cellMask,8);
properties = regionprops(labelled ...
	,'MinorAxisLength','MajorAxisLength','Area','Perimeter');

sizeParams = zeros(4,1);
sizeParams(1) = properties.Area;
sizeParams(2) = properties.Perimeter;
sizeParams(3) = properties.MajorAxisLength;
sizeParams(4) = properties.MinorAxisLength;


end