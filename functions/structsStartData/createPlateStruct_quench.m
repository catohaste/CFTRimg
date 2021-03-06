function  plateStructArray = createPlateStruct_quench( inputStructArray )
%CREATE_PLATE_STRUCT_QUENCH create empty structs for each plate as listed
%in 'inputStruct.plateStr'

inputN = length(inputStructArray);

plateNames = unique(horzcat(inputStructArray.plateStr));
plateN = length(plateNames);
plateTemplate = struct(...
			'plateStr',[]...
			,'experimentStr',[]...
			,'well',{{}});

for i=1:plateN
	plateStructArray(i) = plateTemplate;
	plateStructArray(i).plateStr = plateNames{i};
end

for j=1:plateN
	for i=1:inputN
		if strcmp(inputStructArray(i).plateStr{1},plateStructArray(j).plateStr)
			plateStructArray(j).experimentStr = inputStructArray(i).experimentStr{1};
		end
	end
end

end

