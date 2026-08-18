local MOD_NAME = "whizchameleon"

return function(target_to_node_map)
	return function(pos, node, clicker, itemstack, pointed_thing)
		if not itemstack or not clicker then return itemstack end
		
		local meta = minetest.get_meta(pos)
		local is_locked = meta:get_int("locked") == 1
		local target_name = itemstack:get_name()

		if target_name == MOD_NAME .. ":padlockkey" then
		if is_locked then
		meta:set_int("locked", 0)
		meta:set_string("infotext", "Chameleon (Unlocked)")
		minetest.chat_send_player(clicker:get_player_name(), "Chameleon block unlocked.")
		minetest.sound_play("default_place_node", {pos = pos, gain = 0.6}, true)
		else
		meta:set_int("locked", 1)
		meta:set_string("infotext", "Chameleon (Locked)")
		minetest.chat_send_player(clicker:get_player_name(), "Chameleon block locked.")
		minetest.sound_play("default_place_node", {pos = pos, gain = 0.3}, true)
		end
		return itemstack
		end

-- clicked, bypassing engine recursion entirely.
		if is_locked then
		if itemstack:is_empty() then return itemstack end

		local item_def = minetest.registered_items[target_name]
-- Check if it's a placeable node
		if item_def and pointed_thing and pointed_thing.above then
		local place_pos = pointed_thing.above
		local node_below = minetest.get_node(place_pos)
				
-- Ensure space is air or replaceable
		if node_below.name == "air" or minetest.registered_nodes[node_below.name].buildable_to then
		local success = minetest.set_node(place_pos, {name = target_name, param2 = clicker:get_look_horizontal() and 0 or 0})
		if success then
		minetest.sound_play(item_def.sounds and item_def.sounds.place or "default_place_node", {pos = place_pos, gain = 0.5}, true)
		if not minetest.is_creative_enabled(clicker:get_player_name()) then
		itemstack:take_item()
		end
		return itemstack
		end
		end
		end
			
		return itemstack
		end

-- 3. If unlocked, check if holding a valid block to transform the chameleon
		if itemstack:is_empty() then 
		return itemstack 
		end

		local current_shape = node.name:match("^" .. MOD_NAME .. ":([%w_]+)_c_") or node.name:match("^" .. MOD_NAME .. ":([%w_]+)$")
		if not current_shape then return itemstack end

		local item_def = minetest.registered_items[target_name]
		if not item_def then
		return itemstack
		end

-- Look up and swap to the dynamically generated chameleon node variant
		if target_to_node_map[current_shape] then
		local new_node_name = target_to_node_map[current_shape][target_name]
		if new_node_name and minetest.registered_nodes[new_node_name] then
		local old_param2 = node.param2

		minetest.set_node(pos, {name = new_node_name, param2 = old_param2})

		local new_meta = minetest.get_meta(pos)
		new_meta:set_int("locked", 0)
		new_meta:set_string("infotext", "Chameleon (Unlocked)")

		minetest.sound_play("default_place_node", {pos = pos, gain = 0.8}, true)

		return itemstack
		end
		end

		return itemstack
		end
		end
