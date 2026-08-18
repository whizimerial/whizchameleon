-- init.lua

-- ========================================================
-- WHIZCHAMELEON MOD (Dynamic & Deduplicated Pre-Registration)
-- ========================================================

		local MOD_NAME = "whizchameleon"

-- Initialize global SHAPES table
		SHAPES = {}

		local function load_shapes(filename)
		local path = minetest.get_modpath(MOD_NAME) .. "/" .. filename
		local chunk, err = loadfile(path)
		if chunk then
		local shapes = chunk()
		if type(shapes) == "table" then
		for k, v in pairs(shapes) do
		SHAPES[k] = v
		end
		end
		else
		minetest.log("error", "[whizchameleon] Failed to load " .. filename .. ": " .. tostring(err))
		end
		end

-- Specific loader for item.lua
		local function load_items(filename)
		local path = minetest.get_modpath(MOD_NAME) .. "/" .. filename
		local chunk, err = loadfile(path)
		if chunk then
		local items = chunk()
		if type(items) == "table" then
		for item_id, item_def in pairs(items) do
		minetest.register_craftitem(MOD_NAME .. ":" .. item_id, item_def)
		end
		end
		else
		minetest.log("error", "[whizchameleon] Failed to load " .. filename .. ": " .. tostring(err))
		end
		end

-- Load separate shape definition files and items
		load_shapes("node.lua")   
		load_shapes("slopes.lua") 
		load_shapes("extras.lua") 
		load_shapes("extrashapes.lua") 
		load_items("item.lua")    

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

-- Load Right-Click Handler and pass the mapping reference
		local rightclick_path = minetest.get_modpath(MOD_NAME) .. "/placement.lua"
		local handle_rightclick = dofile(rightclick_path)(target_to_node_map)

-- Register Base Inventory Nodes
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
		tiles = {"whizchameleon_default.png"},
		groups = groups,
		on_rightclick = handle_rightclick,
		})
		end

-- Deduplicated Pre-Registration (Chameleon dynamic node generation)
		minetest.register_on_mods_loaded(function()
		for shape_id, _ in pairs(SHAPES) do
		target_to_node_map[shape_id] = {}
		end

		local registered_hashes = {}

		-- OPTIMIZATION & DEDUPLICATION: Loop through nodes first, then shapes inside
		for node_name, node_def in pairs(minetest.registered_nodes) do
		if node_name ~= "" and node_name ~= "ignore" 
		and not node_name:find(MOD_NAME .. ":")
		and not node_name:find("mimic")
		and not node_name:find("whizchameleon")
		and not node_name:find("chameleon")
		and not node_name:find("chair")
		and not node_name:find("table")
		and not node_name:find("cushion")
		and not node_name:find("bed")
		and not node_name:find("slab")
		and not node_name:find("stair")
		and not node_name:find("items")
		and not node_name:find("fence")
		and not node_name:find("slope")
		and not node_name:find("air") 
		and node_def.drawtype ~= "mesh"
		and not node_def.mesh then
   
		if node_def.tiles and #node_def.tiles > 0 then
		local tile_hash = hash_tiles(node_def.tiles)

-- Loop through shapes second so each unique texture style registers nodes efficiently
		for shape_id, shape_def in pairs(SHAPES) do
		local lookup_key = shape_id .. "::" .. tile_hash

		if registered_hashes[lookup_key] then
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

		registered_hashes[lookup_key] = registered_id
		target_to_node_map[shape_id][node_name] = registered_id
		end
		end
		end
		end
		end
		end)
