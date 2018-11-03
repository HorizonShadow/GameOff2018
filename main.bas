REM Hello BASIC8!
REM Entry program.
REM License: CC-BY.
REM Press Ctrl+R to run.

spr_ingr_a = load_resource("ingr_a.sprite")
spr_ingr_b = load_resource("ingr_b.sprite")
spr_ingr_c = load_resource("ingr_c.sprite")
spr_ingr_d = load_resource("ingr_d.sprite")
spr_ingr_a_small = load_resource("ingr_a_small.sprite")

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

def update(delta)
	

	ipt = false

	t = t + delta
	if t > 1 then
		t = t - 1
		col rgba(rnd(255), rnd(255), rnd(255), 127)
	endif
	rectfill 0, 0, 159, 127
	text 56, 60, "BASIC8", rgba(255, 255, 255)
	map map_bar_mode, 0, 0
	draw_bar_mode()
	
	touch 0, tx, ty, tb0
	if tb0 then
		ipt = true
		if tx > 24 and tx < 36 then
			if not mouse_down then
				print "adding to list", ;
				push(small_ingrs, dict("sprite", spr_ingr_a_small, "x", tx - 2, "y", ty - 2))
			endif
		endif
		mouse_down = true
		text 0, 0, "MOUSE " + str(tx) + ", " + str(ty), rgba(255, 255, 255)
	else
		mouse_down = false
	endif
	
	if mouse_down then
	
		i = iterator(small_ingrs)
		move_next(i)
		spr get(i, "sprite"), tx - 2, ty - 2
		while move_next(i)
			spr get(i, "sprite"), get(i, "x"), get(i, "y")
			set(i, "y", get(i, "y") - 1)
		wend
	endif

	btns0 = nil
	btns1 = nil
	for i = 0 to 5
		if btn(i) then
			if btns0 = nil then
				ipt = true
				btns0 = ""
			endif
			btns0 = btns0 + buttons(i)
		endif

		if btn(i, 1) then
			if btns1 = nil then
				ipt = true
				btns1 = ""
			endif
			btns1 = btns1 + buttons(i)
		endif
	next
	if btns0 <> nil then
		text 0, 8, "GAMEPAD[0] " + btns0, rgba(255, 255, 255)
	endif
	if btns1 <> nil then
		text 0, 16, "GAMEPAD[1] " + btns1, rgba(255, 255, 255)
	endif

	if not ipt then
		text 0, 0, "NO INPUT", rgba(255, 255, 255)
	endif
enddef

update_with(drv, call(update))
DB.close()