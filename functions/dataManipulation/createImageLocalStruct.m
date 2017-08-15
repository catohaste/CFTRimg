function  imageStruct = createImageLocalStruct( redPathArray , yelPathArray )
%CREATEIMAGELOCALSTRUCT create empty structs for each localisation image

pathN = length(redPathArray);
imageTemplate = struct(...
			'redPath',''...
			,'yelPath',''...
			,'boundingBox',[] ...
			,'redEntire',[]...
			,'redOutside',[]...
			,'yelEntire',[]...
			,'yelOutside',[]...
			,'yelMembrane',[]...
			,'yelInterior',[]...
			,'redBackground',[]...
			,'yelBackground',[]...
			,'cellN',[] ...
			);

imageStruct(1:pathN,1) = imageTemplate;

for i=1:pathN
	imageStruct(i).redPath = redPathArray{i};
	imageStruct(i).yelPath = yelPathArray{i};
end

end

