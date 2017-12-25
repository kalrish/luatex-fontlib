local database = assert(loadfile(config.luaotfload.paths.index_path_luc, "b", {}))()

return function(name)
	return database[name]
end
