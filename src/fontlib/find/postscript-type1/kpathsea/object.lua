return function(name, kpse)
	local afm_path = kpse:find_file(name, "afm")
	local pfx_path = kpse:find_file(name, "type1 fonts")
	
	return afm_path, pfx_path
end
