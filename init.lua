-- ========================================================
-- WHIZCHAMELEON MOD (Dynamic & Deduplicated Pre-Registration)
-- ========================================================

local MOD_NAME = "whizchameleon"

-- Shape Definitions
local SHAPES = {
	cube = {
		desc = "Cube",
		drawtype = "normal",
		selection_box = {
			type = "regular",
		},
		collision_box = {
			type = "regular",
		},
	},
	slab = {
		desc = "Slab",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		},
	},
	slope = {
		desc = "Slope",
		drawtype = "mesh",
		mesh = "whizchameleon_slope.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.3, -0.3},
				{-0.5, -0.5, -0.3, 0.5, -0.1, -0.1},
				{-0.5, -0.5, -0.1, 0.5,  0.1,  0.1},
				{-0.5, -0.5,  0.1, 0.5,  0.3,  0.3},
				{-0.5, -0.5,  0.3, 0.5,  0.5,  0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.3, -0.3},
				{-0.5, -0.5, -0.3, 0.5, -0.1, -0.1},
				{-0.5, -0.5, -0.1, 0.5,  0.1,  0.1},
				{-0.5, -0.5,  0.1, 0.5,  0.3,  0.3},
				{-0.5, -0.5,  0.3, 0.5,  0.5,  0.5},
			},
		},
	},
	stairs = {
		desc = "Stairs",
		drawtype = "mesh",
		mesh = "whizchameleon_stairs.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
	},
	longslope_bottom = {
		desc = "Long Slope (Bottom)",
		drawtype = "mesh",
		mesh = "whizchameleon_longslopebottom.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.4, -0.3},
				{-0.5, -0.5, -0.3, 0.5, -0.3, -0.1},
				{-0.5, -0.5, -0.1, 0.5, -0.2,  0.1},
				{-0.5, -0.5,  0.1, 0.5, -0.1,  0.3},
				{-0.5, -0.5,  0.3, 0.5,  0.0,  0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.4, -0.3},
				{-0.5, -0.5, -0.3, 0.5, -0.3, -0.1},
				{-0.5, -0.5, -0.1, 0.5, -0.2,  0.1},
				{-0.5, -0.5,  0.1, 0.5, -0.1,  0.3},
				{-0.5, -0.5,  0.3, 0.5,  0.0,  0.5},
			},
		},		
	},
	longslope_top = {
		desc = "Long Slope (Top)",
		drawtype = "mesh",
		mesh = "whizchameleon_longslopetop.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.1, -0.3},
				{-0.5, -0.5, -0.3, 0.5, 0.2, -0.1},
				{-0.5, -0.5, -0.1, 0.5, 0.3,  0.1},
				{-0.5, -0.5,  0.1, 0.5, 0.4,  0.3},
				{-0.5, -0.5,  0.3, 0.5, 0.5,  0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.1, -0.3},
				{-0.5, -0.5, -0.3, 0.5, 0.2, -0.1},
				{-0.5, -0.5, -0.1, 0.5, 0.3,  0.1},
				{-0.5, -0.5,  0.1, 0.5, 0.4,  0.3},
				{-0.5, -0.5,  0.3, 0.5, 0.5,  0.5},
			},
		},
	},
	wall_thick = {
		desc = "Thick Wall",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
			connect_front = {-0.3, -0.5, -0.5, 0.3, 0.5, -0.3},
			connect_back = {-0.3, -0.5, 0.3, 0.3, 0.5, 0.5},
			connect_left = {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
			connect_right = {0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
		},
		connects_to = {"group:solid", "group:whizchameleon_thick"},
	},
	flat = {
		desc = "Flat",
		drawtype = "mesh",
		mesh = "whizchameleon_flat.obj",
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.275, 0.5},
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.175, 0.5},
		},
	}
}

-- Registry mappings for deduplication redirect
local target_to_node_map = {}

-- Serializes tiles table to create a unique hash key
local function hash_tiles(tiles)
	if not tiles then return nil end
	local key = {}
	for i, t in ipairs(tiles) do
		if type(t) == "table" then
			table.insert(key, t.name or "")
		else
			table.insert(key, tostring(t))
		end
	end
	return table.concat(key, "|")
end

-- Right-click handler
local function handle_rightclick(pos, node, clicker, itemstack)
	if not itemstack or itemstack:is_empty() then return end
	
	local target_name = itemstack:get_name()
	
	-- Robust pattern extraction of current shape base ID
	local current_shape = node.name:match("^" .. MOD_NAME .. ":([%w_]+)_c_") or node.name:match("^" .. MOD_NAME .. ":([%w_]+)$")
	if not current_shape then return end

	-- Fetch mapped deduplicated target block ID
	local target_variant = target_to_node_map[current_shape] and target_to_node_map[current_shape][target_name]
	
	if target_variant and minetest.registered_nodes[target_variant] then
		minetest.swap_node(pos, {name = target_variant, param2 = node.param2})
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Chameleon: " .. target_name)
		minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
	end
end

-- --------------------------------------------------------
-- 1. Register Base Inventory Nodes
-- --------------------------------------------------------
for shape_id, shape_def in pairs(SHAPES) do
	local groups = {cracky = 3, choppy = 3, oddly_breakable_by_hand = 2}
	if shape_id == "wall_thick" then
		groups.whizchameleon_thick = 1
	end

	minetest.register_node(MOD_NAME .. ":" .. shape_id, {
		description = "Whizchameleon " .. shape_def.desc,
		drawtype = shape_def.drawtype,
		mesh = shape_def.mesh,
		node_box = shape_def.node_box,
		selection_box = shape_def.selection_box,
		collision_box = shape_def.collision_box,
		connects_to = shape_def.connects_to,
		paramtype = "light",
		sunlight_propagates = (shape_def.drawtype ~= "normal"),
		paramtype2 = (shape_def.drawtype == "normal") and "none" or "facedir",
		tiles = {"default_wood.png"},
		groups = groups,
		on_rightclick = handle_rightclick,
	})
end

-- --------------------------------------------------------
-- 2. Deduplicated Pre-Registration
-- --------------------------------------------------------
minetest.register_on_mods_loaded(function()
	for shape_id, _ in pairs(SHAPES) do
		target_to_node_map[shape_id] = {}
	end

	-- Key: shape_id .. "::" .. tile_hash -> registered_id
	local registered_hashes = {}

	for node_name, node_def in pairs(minetest.registered_nodes) do
		-- Skip empty/special nodes and chameleon/stair/slab variations
		if node_name ~= "" and node_name ~= "ignore" 
		   and not node_name:find(MOD_NAME .. ":") 
		   and not node_name:find("stairs") 
		   and not node_name:find("slab") then
		   
			if node_def.tiles and #node_def.tiles > 0 then
				local tile_hash = hash_tiles(node_def.tiles)

				for shape_id, shape_def in pairs(SHAPES) do
					local lookup_key = shape_id .. "::" .. tile_hash
					
					-- Check if this shape+texture combination is already registered
					if registered_hashes[lookup_key] then
						-- Deduplicate: Map this item directly to the already registered node
						target_to_node_map[shape_id][node_name] = registered_hashes[lookup_key]
					else
						local clean_name = node_name:gsub(":", "_")
						local registered_id = MOD_NAME .. ":" .. shape_id .. "_c_" .. clean_name
						local raw_id_override = ":" .. registered_id

						local groups = {cracky = 3, choppy = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1}
						if shape_id == "wall_thick" then
							groups.whizchameleon_thick = 1
						end

						minetest.register_node(raw_id_override, {
							description = "Whizchameleon " .. shape_def.desc .. " (" .. node_name .. ")",
							drawtype = shape_def.drawtype,
							mesh = shape_def.mesh,
							node_box = shape_def.node_box,
							selection_box = shape_def.selection_box,
							collision_box = shape_def.collision_box,
							connects_to = shape_def.connects_to,
							paramtype = "light",
							paramtype2 = (shape_def.drawtype == "normal") and "none" or "facedir",
							tiles = node_def.tiles,
							use_texture_alpha = node_def.use_texture_alpha or "clip",
							sunlight_propagates = (shape_def.drawtype == "normal") and false or (node_def.sunlight_propagates or false),
							is_ground_content = false, 
							groups = groups,
							drop = MOD_NAME .. ":" .. shape_id,
							on_rightclick = handle_rightclick,
						})

						-- Record hash and mapping
						registered_hashes[lookup_key] = registered_id
						target_to_node_map[shape_id][node_name] = registered_id
					end
				end

			end
		end
	end
end)
