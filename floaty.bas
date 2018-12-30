import "object.bas"
class Floaty(Object)
	var x_speed = 0;
	var y_speed = 0;
	var sprite = nil;
	
	def set_pos(x_in, y_in)
		me.x_speed = me.x - x_in
		me.y_speed = me.y - y_in
		
		me.x = x_in
		me.y = y_in	
	enddef
	
	def move()
		me.y = me.y - me.y_speed / 1.8
		me.x = me.x - me.x_speed / 1.1
		me.y_speed = me.y_speed - 0.7
	enddef

	def draw()
		spr me.sprite, me.x, me.y
	enddef
endclass