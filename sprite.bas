import "object.bas"
class Sprite(Object)
	var spri = nil
	
	def draw()
		spr me.spri, me.x, me.y
	enddef
endclass