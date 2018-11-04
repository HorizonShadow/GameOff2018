REM Hello BASIC8!
REM Entry program.
REM License: CC-BY.
REM Press Ctrl+R to run.

import "small_ingr.bas"

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
	ingredient_amounts = list(0, 0, 0, 0)
endif
ingredient_sprites = list(spr_ingr_a, spr_ingr_b, spr_ingr_c, spr_ingr_d)

small_ingrs = list()
mouse_down = false

drv = driver()
print drv, ", detail type is: ", typeof(drv);

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
	
	x = 28
	for i in ingredient_amounts
		text x, 115, i, rgba(255,255,255)
		x = x + x_offset
	next
enddef

new_small_ingr = nil

def update(delta)
	map map_bar_mode, 0, 0
	draw_bar_mode()
	
	touch 0, tx, ty, tb0
	if tb0 then
		if not mouse_down then
			if ty > 95 and ty < 112 then
				if tx >= 24 and tx <= 40 then
					new_small_ingr = small_ingr.create(spr_ingr_a_small, tx - 2, ty - 2)
				elseif tx >= 56 and tx <= 72 then
					new_small_ingr = small_ingr.create(spr_ingr_b_small, tx - 2, ty - 2)
				elseif tx >= 88 and tx <= 104 then
					new_small_ingr = small_ingr.create(spr_ingr_c_small, tx - 2, ty - 2)
				elseif tx >= 120 and tx <= 136 then
					new_small_ingr = small_ingr.create(spr_ingr_d_small, tx - 2, ty - 2)
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
	
	for ingr in small_ingrs
		ingr.draw()
		ingr.move()
	next
enddef

update_with(drv, call(update))
DB.close()