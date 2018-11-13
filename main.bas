REM Hello BASIC8!
REM Entry program.
REM License: CC-BY.
REM Press Ctrl+R to run.


import "floaty.bas"
import "coin.bas"
import "small_ingr.bas"
import "recipe.bas"
import "mixmode.bas"




persist ingredient_amounts
if ingredient_amounts = 0 then
	ingredient_amounts = list(10, 10, 10, 10)
endif
	

mode = "bar"

drv = driver()
set_orderby(drv, "map")

buttons = list("L", "R", "U", "D", "A", "B")

t = 0
new_small_ingr = nil

mix_mode = new(mixmode)
mix_mode.set_ingredient_amounts(ingredient_amounts)
def update(delta)
	if mode = "bar" then
		mix_mode.update()
	endif
enddef

update_with(drv, call(update))
