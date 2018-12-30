import "sprite.bas"
cup_spr = load_resource("cup.sprite")
class Cup(Sprite)
	var spri = cup_spr
	var h = 16
	var w = 16
	
	var fill = ""
	
	def get_color(char)
		if char = "A" then
			return pget(2)
		elseif char = "B" then
			return pget(14)
		elseif char = "C" then
			return pget(10)
		else
			return pget(3)
		endif
	enddef
	
	def set_fill(fill_in)
		me.fill = fill_in
	enddef 
	
		def draw_first_fill(char)
		color = get_color(char)
		rect 78, 77, 82, 79, color
	enddef

	def draw_second_fill(char)
		color = get_color(char)
		rect 78, 75, 82, 77, color
	enddef

	def draw_third_fill(char)
		color = get_color(char)
		line 77, 74, 82, 74, 1, color
		line 76, 73, 83, 73, 1, color
	enddef

	def draw_fourth_fill(char)
		color = get_color(char)
		line 75, 72, 84, 72, 1, color
		line 75, 71, 84, 71, 1, color
	enddef
	
	def draw()
		spr me.spri, me.x, me.y
		l = len(me.fill)
		if l > 0 then
			me.draw_first_fill(mid(fill, 0, 1))
		endif
		if l > 1 then
			me.draw_second_fill(mid(fill, 1, 1))
		endif
		if l > 2 then
			me.draw_third_fill(mid(fill, 2, 1))
		endif
		if l > 3 then
			me.draw_fourth_fill(mid(fill, 3, 1))
		endif
	enddef
endclass