class small_ingr(floaty)
	var name = "";
	
	def create(name, sprite, x, y, color)
		tmp = new(small_ingr)
		tmp.name = name
		tmp.sprite = sprite
		tmp.x = x
		tmp.y = y
		return tmp
	enddef

endclass