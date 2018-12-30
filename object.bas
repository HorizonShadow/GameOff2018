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
		return tx >= x and ty >= y and tx <= (me.x + me.w) and ty <= (me.y + me.h)
	enddef
	
	def process_events()
		if me.clicked() then
			me.process_click_event()
		endif
	enddef
	
	def process_click_event()
		print len(me.click_listeners);
		for fn in me.click_listeners
			fn()
		next
	enddef
	
	def add_event_listener(event, fn)
		print event;
		if event = "click" then
			print "pushing";
			push(me.click_listeners, fn)
		endif
	enddef
	
endclass