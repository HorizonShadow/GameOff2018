spr_ingr_a = load_resource("ingr_a.sprite")
spr_ingr_b = load_resource("ingr_b.sprite")
spr_ingr_c = load_resource("ingr_c.sprite")
spr_ingr_d = load_resource("ingr_d.sprite")
spr_ingr_a_small = load_resource("ingr_a_small.sprite")
spr_ingr_b_small = load_resource("ingr_b_small.sprite")
spr_ingr_c_small = load_resource("ingr_c_small.sprite")
spr_ingr_d_small = load_resource("ingr_d_small.sprite")
map_bar_mode = load_resource("bar_mode.map")
import "recipe_button.bas"
import "scene.bas"

class MixMode(Scene)
	var mix_list_open = false
	var recipes = list(
		recipe.create("Recipe A", "CCDD"),
		recipe.create("Recipe B", "ABCC"),
		recipe.create("Recipe C", "AAAD"),
		recipe.create("Recipe D", "BBDD"),
		recipe.create("Recipe E", "BCCC"),
		recipe.create("Recipe F", "DDDD"),
		recipe.create("Recipe G", "ACCC"),
		recipe.create("Recipe H", "ABBD"),
		recipe.create("Recipe I", "AABD"),
		recipe.create("Recipe J", "BBCD")
	)
	
	var objects = list(
		RecipeButton.create(0, 82)
	)
	var mix = ""
	var request = rnd(9)
	var mouse_down = false
	var small_ingrs = list()
	var coins = list()
	var ingredient_sprites = list(spr_ingr_a, spr_ingr_b, spr_ingr_c, spr_ingr_d)
	var new_small_ingr = nil
	var speech = nil
	var speech_timer = 0
	var gold = 0
	
	def create()
		tmp = new(MixMode)
		
		recipe_button = RecipeButton.create(0, 82)
		recipe_button.add_event_listener("click", ~(
			mix_list_open = true
		)) 
		tmp.add_object(recipe_button)
	enddef

	def draw_bar_mode()
		x = 28
		y = 100
		x_offset = 32
		y_offset = 16
			
		for i in ingredient_sprites
			spr i.sprite, x, y
			x = x + x_offset
		next
		
		x = 24
		for i in ingredient_amounts
			text x, 115, i, rgba(255,255,255)
			x = x + x_offset
		next
	enddef
	
	def set_ingredient_amounts(ingr_amts)
		ingredient_amounts = ingr_amts
	enddef

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

	def get_mix_recipe()
		for r in recipes
			if r.mix = mix then
				return mix
			endif
		next
		return nil
	enddef

	def draw_fill()
		if len(mix) > 0 then
			draw_first_fill(mid(mix, 0, 1))
		endif
		if len(mix) > 1 then
			draw_second_fill(mid(mix, 1, 1))
		endif
		if len(mix) > 2 then
			draw_third_fill(mid(mix, 2, 1))
		endif
		if len(mix) > 3 then
			draw_fourth_fill(mid(mix, 3, 1))
		endif
	enddef
	
	def add_coins(n)
		for i in list(1 to n)
			c = coin.create(80, 72))
			c.x_speed = 2 * ((rnd * 2) - 1)
			c.y_speed = 10 * (rnd + 0.5)
			push(coins, c)
		next
		gold = gold + n
	enddef
	
	def draw_top_text() 
		text 2, 4, speech, rgba(255,255,255)
		if speech_timer = 0 then
			r = get(recipes, request)
			speech = "I want " + r.name
		else
			speech_timer = speech_timer - 1	
		endif
	enddef
	
	def process_coins() 
		items_to_remove = list()
		for c in coins
			c.draw()
			c.move()
			if c.y > 128 then
				push(items_to_remove, index_of(coins, c))
			endif
		next
		
		for i in items_to_remove
			remove(coins, i)
		next
	enddef
	
	def new_mix()
		mix = ""
		request = rnd(9)
	enddef
	
	def draw_gold_counter()
		spr spr_coin, 2, 20
		text 8, 20, gold
	enddef
	
	def update_game()
		map map_bar_mode, 0, 0
		draw_fill()
		draw_bar_mode()
		draw_top_text()
		
		draw_gold_counter()
			
		touch 0, tx, ty, tb0
		

		
		if tb0 then
			if not mouse_down then
				if ty > 95 and ty < 112 then
					if tx >= 24 and tx <= 40 and get(ingredient_amounts, 0) > 0 then
						new_small_ingr = small_ingr.create("A", spr_ingr_a_small, tx - 2, ty - 2, 2)
						set(ingredient_amounts, 0, get(ingredient_amounts, 0) - 1)
					elseif tx >= 56 and tx <= 72 and get(ingredient_amounts, 1) > 0 then
						new_small_ingr = small_ingr.create("B", spr_ingr_b_small, tx - 2, ty - 2, 14)
						set(ingredient_amounts, 1, get(ingredient_amounts, 1) - 1)
					elseif tx >= 88 and tx <= 104 and get(ingredient_amounts, 2) > 0 then
						new_small_ingr = small_ingr.create("C", spr_ingr_c_small, tx - 2, ty - 2, 10)
						set(ingredient_amounts, 2, get(ingredient_amounts, 2) - 1)
					elseif tx >= 120 and tx <= 136 and get(ingredient_amounts, 3) > 0 then
						new_small_ingr = small_ingr.create("D", spr_ingr_d_small, tx - 2, ty - 2, 3)
						set(ingredient_amounts, 3, get(ingredient_amounts, 3) - 1)
					endif
				endif
			endif
			mouse_down = true
		else
			mouse_down = false
		endif
		
		
		if new_small_ingr then
			if mouse_down then
				new_small_ingr.set_position(tx - 2, ty - 2)
				new_small_ingr.draw()
			else
				push(small_ingrs, new_small_ingr)
				new_small_ingr = nil
			endif
		endif
		
		items_to_remove = list()
		for ingr in small_ingrs
			if ingr.x >= 71 and ingr.x <= 85 and ingr.y > 65 and ingr.y < 80 then
				push(items_to_remove, index_of(small_ingrs, ingr))
				mix = mix + ingr.name
			elseif ingr.y > 128 then
				push(items_to_remove, index_of(small_ingrs, ingr))
			else
				ingr.draw()
				ingr.move()
			endif
		next
		
		for ind in items_to_remove
			remove(small_ingrs, ind)
		next
		
		process_coins()
		
		selected_recipe = get(recipes, request)
		mix_length = len(mix)
		if mix_length > 0 then
			if mix <> left(selected_recipe.mix, mix_length) then
				speech = "That's not right!"
				speech_timer = 100
				new_mix()
			elseif mix = selected_recipe.mix then
				add_coins(25)
				new_mix()
			endif
		endif
	enddef
	
	def update_recipes()
		map recipe_map, 0, 0
		y = 10
		x = 20
		touch 0, tx, ty, tb0
		for r in recipes
			text x, y, r.name  + "  " + r.mix
			y = y + 10 
		next
		text 150, 1, "X"
		if tb0 and tx >= 150 and tx <= 158 and ty <= 9 and ty >= 1 then
			mix_list_open = false
		endif
	enddef
	
	' def update()
		'if mix_list_open then
		'	update_recipes()
		'else
		'	update_game()
		'endif
	' enddef
endclass