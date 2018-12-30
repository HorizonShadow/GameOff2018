class Scene 
	var objects = list()
	
	def add_object(obj)
		push(objects, obj)
	enddef
	
	def update()
		for obj in objects
			obj.draw()
			obj.process_events()
		next
	enddef
endclass