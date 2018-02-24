function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMG_SEGMENT_WATERSHED Segment localization images to locate cells
%   The watershed method is used to perform this segmentation.

mode = 'full'; % 'full' OR 'test';

global BINNING

I = im2double(imread(imageStruct.redPath));
% imshow(I,[])
 
Ieq = adapthisteq(I,'NumTiles',[20 20]);
% figure, imshow(Ieq,[])

Ibw = imbinarize(Ieq,'adaptive');
% figure, imshow(Ibw)

closeSE = strel('disk',4*BINNING);
Iclosed = imclose(Ibw,closeSE);
% figure, imshow(Iclosed)

Icleared = bwareaopen(Iclosed,ceil(4800*BINNING));
% figure, imshow(Icleared)

Ifilled = imfill(Icleared,'holes');
% figure, imshow(Ifilled)

dilateSE = strel('disk',ceil(4*BINNING));
Idilated = imopen(Ifilled,dilateSE);
% figure, imshow(Idilated)

smallEM = imextendedmax(I, 0.9*median(I(:)));
smallEM = imclose(smallEM, closeSE);
smallEM = bwareaopen(smallEM, 120);
smallEM = imerode(smallEM, ones(6*BINNING));
% figure, imshow(smallEM)

largeEM = imextendedmax(I, median(I(:)));
largeEM = imclose(largeEM, closeSE);
largeEM = imfill(largeEM, 'holes');
largeEM = bwareaopen(largeEM, 1200);
% figure, imshow(largeEM)

BGmarkers = largeEM | Idilated;
% figure, imshow(BGmarkers)

if strcmp(mode,'test')
	IbwPerim = bwperim(BGmarkers);
	overlay = imoverlay(Ieq, IbwPerim|smallEM, [.3 1 .3]);
% 	figure, imshow(overlay)
end

complement = imcomplement(I);

Imod = imimposemin(complement, ~BGmarkers | smallEM);

L = watershed(Imod);
% figure, imshow(label2rgb(L))

if strcmp(mode,'test')
 	showWatershedProcess(imageStruct,Ibw,BGmarkers,smallEM,overlay,label2rgb(L))
end

properties = regionprops(L,'BoundingBox','Area');

counter = 1;
for i=1:length(properties)
	
	if properties(i).Area > 100
		imageStruct.boundingBox(counter,:) = properties(i).BoundingBox;
		counter = counter + 1;
	end
	
end

imageStruct.cellN(1,1) = counter - 1;

end

