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

-- Right-click handler with persistent locking mechanism
local function handle_rightclick(pos, node, clicker, itemstack)
	if not itemstack or itemstack:is_empty() then return end
	
	local target_name = itemstack:get_name()
	local meta = minetest.get_meta(pos)
	local is_locked = meta:get_int("locked") == 1

	-- If player is using the Padlock and Key, toggle lock state
	if target_name == MOD_NAME .. ":padlockkey" then
		if is_locked then
			meta:set_int("locked", 0)
			meta:set_string("infotext", "Chameleon (Unlocked)")
			minetest.chat_send_player(clicker:get_player_name(), "Chameleon block unlocked.")
			minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
		else
			meta:set_int("locked", 1)
			meta:set_string("infotext", "Chameleon (Locked)")
			minetest.chat_send_player(clicker:get_player_name(), "Chameleon block locked.")
			minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
		end
		return
	end

	-- If the block is locked, completely prevent shape changing
	if is_locked then
		minetest.chat_send_player(clicker:get_player_name(), "This Chameleon block is locked!")
		return
	end
	
	local current_shape = node.name:match("^" .. MOD_NAME .. ":([%w_]+)_c_") or node.name:match("^" .. MOD_NAME .. ":([%w_]+)$")
	if not current_shape then return end

	local target_variant = target_to_node_map[current_shape] and target_to_node_map[current_shape][target_name]
	
	if target_variant and minetest.registered_nodes[target_variant] then
		minetest.swap_node(pos, {name = target_variant, param2 = node.param2})
		
		-- Re-apply metadata to the new swapped node instance so lock persists across transformations
		local new_meta = minetest.get_meta(pos)
		new_meta:set_int("locked", 0)
		new_meta:set_string("infotext", "Chameleon: " .. target_name)
		
		minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
	end
end

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

-- Deduplicated Pre-Registration

minetest.register_on_mods_loaded(function()
	for shape_id, _ in pairs(SHAPES) do
		target_to_node_map[shape_id] = {}
	end

	local registered_hashes = {}

	for node_name, node_def in pairs(minetest.registered_nodes) do
		if node_name ~= "" and node_name ~= "ignore" 
		   and not node_name:find(MOD_NAME .. ":")
			and not node_name:find ("mimic")
			and not node_name:find ("whizchameleon")
			and not node_name:find ("chameleon") then
		   
			if node_def.tiles and #node_def.tiles > 0 then
				local tile_hash = hash_tiles(node_def.tiles)

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
							on_place = shape_def.on_place,
						})

						registered_hashes[lookup_key] = registered_id
						target_to_node_map[shape_id][node_name] = registered_id
					end
				end
			end
		end
	end
end)
