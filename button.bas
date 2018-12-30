import "object.bas"
class Button(Object)
	var sprite = nil
	
	def draw()
		spr me.sprite, me.x, me.y
	enddef
endclass