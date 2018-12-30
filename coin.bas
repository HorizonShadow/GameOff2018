import "floaty.bas"
spr_coin = load_resource("coin.sprite")

class coin(floaty)
	var sprite = spr_coin
	def create(x, y)
		tmp = new(coin)
		tmp.x = x
		tmp.y = y
		return tmp
	enddef
endclass