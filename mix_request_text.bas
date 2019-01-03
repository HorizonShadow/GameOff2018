import "object.bas"

class MixRequestText(Object)
	var content = ""
	var request_timer = 100
	
	def set_content(string)
		me.content = string
	enddef
	
	def draw()
		text me.x, me.y, me.content, rgba(255,255,255)
	enddef
endclass