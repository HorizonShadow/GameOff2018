class Object
	var x = 0
	var y = 0
	var w = 0
	var h = 0
	var click_listeners = list()
	
	def draw()
		print "An object is missing it's draw method";
	enddef
	
	def clicked()
		touch 0, tx, ty, tb0
		print tx, " ", ty, " ", x, " ", y;
		if ty >= x and tx >= y and tx <= (x + w) and ty <= (y + h) then
			return true
		endif
		return false
	enddef
	
	def process_events()
		if clicked() then
			process_click_event()
		endif
	enddef
	
	def process_click_event()
		for fn in click_listeners
			fn()
		next
	enddef
	
	def add_event_listeners(event, fn)
		if event == "click"
			push(click_listeners, fn)
		endif
	enddef
	
endclass