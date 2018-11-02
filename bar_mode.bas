class BarMode

	def draw_item_quantities()
		x = 0
		y = 98
		for i in Ingredient.all()
			text x, y, i.name, rgba(255, 255, 255)
			text x + 120, y, i.amt, rgba(255, 255, 255)
			y = y + 10
		next
		
	enddef
	
	def draw()
		draw_item_quantities()
		
	enddef
endclass