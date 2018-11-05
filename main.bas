REM Hello BASIC8!
REM Entry program.
REM License: CC-BY.
REM Press Ctrl+R to run.

import "small_ingr.bas"
import "recipe.bas"

spr_ingr_a = load_resource("ingr_a.sprite")
spr_ingr_b = load_resource("ingr_b.sprite")
spr_ingr_c = load_resource("ingr_c.sprite")
spr_ingr_d = load_resource("ingr_d.sprite")
spr_ingr_a_small = load_resource("ingr_a_small.sprite")
spr_ingr_b_small = load_resource("ingr_b_small.sprite")
spr_ingr_c_small = load_resource("ingr_c_small.sprite")
spr_ingr_d_small = load_resource("ingr_d_small.sprite")

map_bar_mode = load_resource("bar_mode.map")


persist ingredient_amounts
if ingredient_amounts = 0 then
	ingredient_amounts = list(10, 10, 10, 10)
endif
ingredient_sprites = list(spr_ingr_a, spr_ingr_b, spr_ingr_c, spr_ingr_d)

small_ingrs = list()
mouse_down = false
mix = ""

recipes = list(
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
request = rnd(9)

drv = driver()
set_orderby(drv, "map")

buttons = list("L", "R", "U", "D", "A", "B")

t = 0

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

def draw_requested_recipe()
	r = get(recipes, request)
	text 2, 4, r.name, rgba(255,255,255)
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

new_small_ingr = nil

def update(delta)
	map map_bar_mode, 0, 0
	draw_fill()
	draw_bar_mode()
	draw_requested_recipe()
	
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
		else
			ingr.draw()
			ingr.move()
		endif
	next
	
	for ind in items_to_remove
		remove(small_ingrs, ind)
	next
	
	if len(mix) = 4 then
		print mix;

	endif

enddef

update_with(drv, call(update))