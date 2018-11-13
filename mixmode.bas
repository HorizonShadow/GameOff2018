spr_ingr_a = load_resource("ingr_a.sprite")
spr_ingr_b = load_resource("ingr_b.sprite")
spr_ingr_c = load_resource("ingr_c.sprite")
spr_ingr_d = load_resource("ingr_d.sprite")
spr_ingr_a_small = load_resource("ingr_a_small.sprite")
spr_ingr_b_small = load_resource("ingr_b_small.sprite")
spr_ingr_c_small = load_resource("ingr_c_small.sprite")
spr_ingr_d_small = load_resource("ingr_d_small.sprite")
map_bar_mode = load_resource("bar_mode.map")
recipe_sprite = load_resource("recipe_button.sprite")

class MixMode
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
	var mix = ""
	var request = rnd(9)
	var mouse_down = false
	var small_ingrs = list()
	var coins = list()
	var ingredient_sprites = list(spr_ingr_a, spr_ingr_b, spr_ingr_c, spr_ingr_d)
	var ingredient_amounts = list(10,10,10,10)
	var new_small_ingr = nil
	var speech = nil
	var speech_timer = 0

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

	def draw_recipes_button() 
		spr recipe_sprite, 0, 82
	enddef
	
	def add_coins(n)
		for i in list(1 to n)
			c = coin.create(80, 72))
			c.x_speed = 2 * ((rnd * 2) - 1)
			c.y_speed = 10 * (rnd + 0.5)
			push(coins, c)
		next
	enddef
	
	def draw_top_text() 
		text 2, 4, speech, rgba(255,255,255)
	enddef
	
	def update_game()
		if speech_timer = 0 then
			r = get(recipes, request)
			speech = "I want " + r.name
		else
			speech_timer = speech_timer - 1	
		endif
		map map_bar_mode, 0, 0
		draw_fill()
		draw_bar_mode()
		draw_top_text()
		draw_recipes_button()
			
		touch 0, tx, ty, tb0
		if tb0 then
			if ty >= 82 and tx >= 0 and tx <= 6 and ty <= 114 then
				mix_list_open = true
				print "clicked recipe";
			endif
			
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
			else
				ingr.draw()
				ingr.move()
			endif
		next

		for c in coins
			c.draw()
			c.move()
		next
		
		for ind in items_to_remove
			remove(small_ingrs, ind)
		next
		
		if len(mix) = 4 then
			selected_recipe = get(recipes, request)
			if mix = selected_recipe.mix then
				add_coins(25)
			else
				speech = "What's this!?"
				speech_timer = 100
			endif
			mix = ""
			request = rnd(9)
		endif
	enddef
	
	def update_recipes()
		map recipe_map, 0, 0
		y = 10
		x = 20
		for r in recipes
			text x, y, r.name  + "  " + r.mix
			y = y + 10 
		next
	enddef
	
	def update()
		if mix_list_open then
			update_recipes()
		else
			update_game()
		endif
	enddef
endclass