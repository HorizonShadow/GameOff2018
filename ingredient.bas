class Ingredient
	var id = nil
	var name = nil
	var amt = 0
	
	def create(name)
		DB.exec("insert into ingredients(name) values ('" + name + "');") 
	enddef
	
	def list_to_ingredient(l)
		new_instance = new(Ingredient)
		new_instance.amt = pop(l)
		new_instance.name = pop(l)
		new_instance.id = pop(l)
		return new_instance
	enddef
	
	def all()
		objs = list()
		query_result = DB.query("select * from ingredients;")
		for ingr in query_result
			push(objs, list_to_ingredient(ingr))
		next
		return objs
	enddef
	
	def save()
		print me.id, me.name, me.amt, ;
		res = DB.exec("update ingredients set name='" + me.name + "', quantity="+ str(me.amt) + " where id=" + str(me.id) + ";")
	enddef
	
	def get(ind)
		query_result = DB.query("select * from ingredients where id=" + str(ind) + ";")
		ingr = pop(query_result)
		return list_to_ingredient(ingr)
	enddef
	
endclass