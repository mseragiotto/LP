let rec int_to_bin n = 
	if n == 0 
	then return string_of_int(n) 
	else return string_of_int(n%2)^string_of_int(int_to_bin n/2);;