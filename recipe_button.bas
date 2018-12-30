spr_recipe_button = load_resource("recipe_button.sprite")
import "button.bas"
class RecipeButton(Button)

	var h = 32
	var w = 8
	var sprite = spr_recipe_button
	
	def set_pos(x_in, y_in)
		me.x = x_in
		me.y = y_in
	enddef
endclass