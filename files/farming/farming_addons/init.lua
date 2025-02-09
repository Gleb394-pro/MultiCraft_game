local path = minetest.get_modpath("farming_addons")
local farming = {
	"api", "seeds",
	"carrot", "cocoa", "corn",
	"melon", "potato", "pumpkin"
}

for _, name in pairs(farming) do
	dofile(path .. "/" .. name .. ".lua")
end

--
-- Crafting recipes & items
--

-- Soup Bowl
minetest.register_craftitem("farming_addons:bowl", {
	description = "Empty Bowl",
	inventory_image = "farming_addons_bowl.png",
	groups = {food = 1}
})

minetest.register_craft({
	output = "farming_addons:bowl 3",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})

-- Hog Stew
minetest.register_craftitem("farming_addons:bowl_hog_stew", {
	description = "Stewed Pork Bowl",
	inventory_image = "farming_addons_hog_stew.png",
	on_use = minetest.item_eat(8, "farming_addons:bowl"),
	groups = {food = 1}
})

minetest.register_craft({
	output = "farming_addons:bowl_hog_stew",
	recipe = {
		{"", "mobs:pork_raw", ""},
		{"farming_addons:carrot", "farming_addons:potato_baked", "flowers:mushroom_brown"},
		{"", "farming_addons:bowl", ""}
	}
})
