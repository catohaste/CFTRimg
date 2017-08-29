function test_runMode( runMode )
%TEST_RUNMODE Tests for valid values of 'runMode'.
%   Nothing is done if the value of runMode is valid. Otherwise, a list of
%   possible valid values is printed.


	switch runMode
		case 'StellaICL4'
			return
		case 'StellaTestICL4'
			return
		case 'StellaTestLocal'
			return
		case 'StellaTestQuench'
			return
		case 'Katie'
			return
		case 'KatieTest'
			return
		case 'Emily'
			return
		otherwise
			fprintf(strcat('Invalid value of "runMode".\n'...
				,'Please enter one of:\n'...
				,'"StellaICL4"\n'...
				,'"StellaTestICL4"\n'...
				,'"StellaTestLocal"\n'...
				,'"StellaTestQuench"\n'...
				,'"Katie"\n'...
				,'"KatieTest"\n'...
				,'"Emily"\n'))
	end
	

end

