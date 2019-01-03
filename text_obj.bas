import "object.bas"

class TextObj(Object)
	var content = ""
	
	def draw() 
		text me.x, me.y, me.content, rgba(255,255,255)
	enddef
endclass