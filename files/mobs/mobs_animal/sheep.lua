local dyes = dye.dyes

for i = 1, #dyes do
	local name = unpack(dyes[i])

	mobs:register_mob("mobs_animal:sheep_" .. name, {
		stay_near = {"farming:straw", 10},
		type = "animal",
		passive = true,
		hp_min = 6,
		hp_max = 10,
		collisionbox = {-0.4, -1, -0.4, 0.4, 0.3, 0.4},
		visual = "mesh",
		mesh = "mobs_sheep.b3d",
		textures = {"mobs_sheep.png^mobs_sheep_" .. name .. ".png"},
		gotten_texture = {"mobs_sheep.png^mobs_sheep_shaved.png"},
		gotten_mesh = "mobs_sheep_shaved.b3d",
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
			damage = "mobs_sheep_angry"
		},
		runaway = true,
		jump_height = 3,
		drops = function(pos)
			if rawget(_G, "experience") then
				experience.add_orb(math.random(2, 4), pos)
			end
			return {
				{name = "mobs:meat_raw"},
				{name = "mobs:meat_raw", chance = 2},
				{name = "wool:" .. name}
			}
		end,
		animation = {
			speed_normal = 15,	speed_run = 15,
			stand_start = 0,	stand_end = 80,
			walk_start = 81,	walk_end = 100
		},
		fear_height = 3,
		follow = {"flora", "farming:wheat"},
		replace_rate = 10,
		replace_what = {
			{"group:flora", "air", -1},
			{"default:dirt_with_grass", "default:dirt", -2}
		},

		on_replace = function(self)
			self.food = (self.food or 0) + 1

			-- if the sheep replaces 8x grass, it will regrow wool
			if self.food >= 8 and self.gotten then
				self.food = 0
				self.gotten = false

				self.object:set_properties({
					textures = {"mobs_sheep.png^mobs_sheep_" .. name .. ".png"},
					mesh = "mobs_sheep.b3d"
				})
			end
		end,

		on_rightclick = function(self, clicker)
			-- feed or tame
			if mobs:feed_tame(self, clicker, 8, true, true) then
				-- if feed 7x, the sheep regrow wool
				if self.food and self.food > 6 then
					self.gotten = false
					self.object:set_properties({
						textures = {"mobs_sheep.png^mobs_sheep_" .. name .. ".png"},
						mesh = "mobs_sheep.b3d"
					})
				end
				return
			end

			local item = clicker:get_wielded_item()
			local itemname = item:get_name()
			local player = clicker:get_player_name()

			-- are we giving a haircut?
			if itemname == "mobs:shears" then
				if self.gotten or self.child
						or player ~= self.owner then
					return
				end
				self.gotten = true -- shaved
				local obj = minetest.add_item(self.object:get_pos(),
					ItemStack("wool:" .. name .. " " .. math.random(3)))
				if obj then
					obj:set_velocity({
						x = math.random(-1, 1),
						y = 5,
						z = math.random(-1, 1)
					})
				end
				item:add_wear(650) -- 100 uses
				clicker:set_wielded_item(item)
				self.object:set_properties({
					textures = {"mobs_sheep.png^mobs_sheep_shaved.png"},
					mesh = "mobs_sheep_shaved.b3d"
				})
				return
			end

			-- are we coloring?
			if itemname:find("dye:") then
				if not self.gotten
						and not self.child
						and self.tamed
						and player == self.owner then
					local color = itemname:split(":")[2]
					for i = 1, #dyes do
						local name = unpack(dyes[i])

						if name == color then
							local pos = self.object:get_pos()
							self.object:remove()
							local mob = minetest.add_entity(pos, "mobs_animal:sheep_" .. color)
							local ent = mob:get_luaentity()
							ent.owner = player
							ent.tamed = true

							-- take item
							if not mobs.is_creative(player) or
									not minetest.is_singleplayer() then
								item:take_item()
								clicker:set_wielded_item(item)
							end
							break
						end
					end
				end
				return
			end

		--	if mobs:capture_mob(self, clicker, 0, 5, 60, false, nil) then return end
		end
	})

	minetest.register_alias("mobs_animal:sheep_" .. name, "mobs_animal:sheep_white")
end

mobs:register_egg("mobs_animal:sheep_white", "Sheep Egg", "wool_white.png", true)

mobs:spawn({
	name = "mobs_animal:sheep_white",
	mobs_animal.spawn_nodes,
	min_light = 7,
	chance = 100000,
	min_height = 0,
	day_toggle = true
})

mobs:spawn({
	name = "mobs_animal:sheep_grey",
	mobs_animal.spawn_nodes,
	min_light = 7,
	chance = 100000,
	min_height = 0,
	day_toggle = true
})

mobs:spawn({
	name = "mobs_animal:sheep_dark_grey",
	mobs_animal.spawn_nodes,
	min_light = 7,
	chance = 100000,
	min_height = 0,
	day_toggle = true
})

mobs:spawn({
	name = "mobs_animal:sheep_black",
	nodes = {"default:dirt", "default:sand", "default:redsand", "default:dirt_with_dry_grass", "default:dirt_with_grass"},
	min_light = 7,
	chance = 100000,
	min_height = 0,
	day_toggle = true
})

mobs:spawn({
	name = "mobs_animal:sheep_brown",
	nodes = {"default:dirt", "default:sand", "default:redsand", "default:dirt_with_dry_grass", "default:dirt_with_grass"},
	min_light = 7,
	chance = 100000,
	min_height = 0,
	day_toggle = true
})
