class recipe 
	var name = ""
	var mix = ""
	def create(name, mix)
		tmp = new(recipe)
		tmp.name = name
		tmp.mix = mix
		return tmp
	enddef
endclass