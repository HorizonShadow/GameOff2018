REM Hello BASIC8!
REM Entry program.
REM License: CC-BY.
REM Press Ctrl+R to run.
DB = database()
DB.open("data")

import "ingredient.bas"
import "bar_mode.bas"

init = false
persist init
if not init then
	import "seed.bas"
	init = true
endif



bar_mode = new(BarMode)


drv = driver()
print drv, ", detail type is: ", typeof(drv);

buttons = list("L", "R", "U", "D", "A", "B")

t = 0

def update(delta)


	ipt = false

	t = t + delta
	if t > 1 then
		t = t - 1
		col rgba(rnd(255), rnd(255), rnd(255), 127)
	endif
	rectfill 0, 0, 159, 127
	text 56, 60, "BASIC8", rgba(255, 255, 255)
	bar_mode.draw()
	touch 0, tx, ty, tb0
	if tb0 then
		ipt = true
		text 0, 0, "MOUSE " + str(tx) + ", " + str(ty), rgba(255, 255, 255)
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