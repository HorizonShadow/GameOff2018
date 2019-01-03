import "object.bas"

class IngrAmounts(Object)	
	def draw()
		tmp_x = me.x
		x_offset = 32
		
		x = 24
		for i in ingredient_amounts
			text tmp_x, me.y, i, rgba(255,255,255)
			tmp_x = tmp_x + x_offset
		next
	enddef
endclass