-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")


-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")


-- WHEAT

farming.register_plant("farming:wheat", {
	description = "Wheat Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	minlight = 12,
	fertility = {"grassland"},
	place_param2 = 3,
	groups = {food_wheat = 1, flammable = 4}
})

minetest.register_craftitem("farming:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1, farming = 1}
})

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2, food = 1}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

-- String

minetest.register_craftitem("farming:string",{
	description = "String",
	inventory_image = "farming_string.png",
	groups = {materials = 1}
})

minetest.register_craft({
	output = "farming:string",
	recipe = {{"default:paper", "default:paper"}}
})

-- Straw

minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"}
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {{"farming:straw"}}
})


-- Aliases
minetest.register_alias("default:string", "farming:string")
minetest.register_alias("default:haybale", "farming:straw")

-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "farming:straw",
	burntime = 3
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:cotton",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:string",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:hoe_wood",
	burntime = 5
})
