local kpse_find_file = kpse.find_file

return function(name)
	return kpse_find_file(name, "afm"), kpse_find_file(name, "type1 fonts")
end
