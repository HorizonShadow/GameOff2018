class small_ingr
	var sprite = nil;
	var x = 0;
	var y = 0;
	var x_speed = 0;
	var y_speed = 0;
	var name = "";
	
	def create(name, sprite, x, y, color)
		tmp = new(small_ingr)
		tmp.name = name
		tmp.sprite = sprite
		tmp.x = x
		tmp.y = y
		return tmp
	enddef
	
	def set_position(x_in, y_in)
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