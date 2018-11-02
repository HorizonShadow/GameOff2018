DB.exec("drop table ingredients;")
DB.exec("create table ingredients(id integer primary key, name, quantity default 0);");
Ingredient.create("Ingredient 1")
Ingredient.create("Ingredient 2")
Ingredient.create("Ingredient 3")