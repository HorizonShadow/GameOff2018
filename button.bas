import "object.bas"
class Button(Object)
	var sprite = nil
	
	def draw()
		spr sprite, x, y
	enddef
endclass