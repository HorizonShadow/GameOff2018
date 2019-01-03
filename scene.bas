class Scene 
	var objects = list()
	
	def add_object(obj)
		push(me.objects, obj)
	enddef
	
	def update()
		for obj in me.objects
			print "draw";
			obj.draw()
			obj.process_events()
		next
	enddef
endclass