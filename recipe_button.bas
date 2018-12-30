spr_recipe_button = load_resource("recipe_button.sprite")
import "button.bas"
class RecipeButton(Button)
	def create(x, y)
		tmp = new(RecipeButton)
		tmp.x = x
		tmp.y = y
		tmp.h = 32
		tmp.w = 8
		tmp.sprite = spr_recipe_button
	
		return tmp
	enddef
endclass