local MOD_NAME = "whizchameleon"

-- Store active HUD IDs for players so we can update or remove them cleanly
local player_hud_ids = {}

-- GLOBAL STEP: Checks every tick what players are holding and looking at
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		local wielded_item = player:get_wielded_item()
		local item_name = wielded_item:get_name()
		
		local show_hud = false
		local hud_text = ""

		-- Check if the player is holding the magnifying glass
		if item_name == MOD_NAME .. ":maginify" then
			-- Perform a server-side raycast from the player's eyes (feet pos + 1.62 eye height)
			local eye_pos = player:get_pos()
			eye_pos.y = eye_pos.y + 1.62
			
			local look_dir = player:get_look_dir()
			local reach_pos = vector.add(eye_pos, vector.multiply(look_dir, 5))
			
			local ray = minetest.raycast(eye_pos, reach_pos, false, true)
			for pointed in ray do
				if pointed.type == "node" then
					local node = minetest.get_node(pointed.under)
					
					-- Check if the node belongs to your chameleon mod
					if node.name:find(MOD_NAME) then
						local meta = minetest.get_meta(pointed.under)
						
						-- Automatically clear any old lingering infotext from previous versions
						if meta:get_string("infotext") ~= "" then
							meta:set_string("infotext", "")
						end

						local is_locked = meta:get_int("locked") == 1
						local status_text = is_locked and "Chameleon (Locked)" or "Chameleon (Unlocked)"
						
						hud_text = "Magnify: " .. status_text
						show_hud = true
					end
				end
				break -- Stop at the first thing hit
			end
		end

		-- Manage the HUD display
		if show_hud then
			if not player_hud_ids[player_name] then
				-- Create the HUD element if it doesn't exist yet
				player_hud_ids[player_name] = player:hud_add({
					hud_elem_type = "text",
					position = {x = 0.5, y = 0.55}, -- Slightly below center screen
					offset = {x = 0, y = 0},
					text = hud_text,
					alignment = {x = 0, y = 0},
					scale = {x = 100, y = 100},
					number = 0xFFFFFF, -- White text
				})
			else
				-- Update the text if they moved to a different chameleon block
				player:hud_change(player_hud_ids[player_name], "text", hud_text)
			end
		else
			-- Remove the HUD when they stop holding the magnifier or look away
			if player_hud_ids[player_name] then
				player:hud_remove(player_hud_ids[player_name])
				player_hud_ids[player_name] = nil
			end
		end
	end
end)

-- Clean up HUD tracker when players leave the game
minetest.register_on_leaveplayer(function(player)
	player_hud_ids[player:get_player_name()] = nil
end)


-- NODE RIGHT-CLICK INTERACTION HANDLER
return function(target_to_node_map)
	return function(pos, node, clicker, itemstack, pointed_thing)
		if not itemstack or not clicker then return itemstack end
		
		local meta = minetest.get_meta(pos)
		
		-- Ensure any old infotext is wiped out when interacting with the block
		if meta:get_string("infotext") ~= "" then
			meta:set_string("infotext", "")
		end

		local is_locked = meta:get_int("locked") == 1
		local target_name = itemstack:get_name()
		local player_name = clicker:get_player_name()

		-- 1. HANDLE PADLOCK KEY (Locks / Unlocks the chameleon block)
		if target_name == MOD_NAME .. ":padlockkey" then
			if is_locked then
				meta:set_int("locked", 0)
				minetest.chat_send_player(player_name, "Chameleon block unlocked.")
				minetest.sound_play("default_place_node", {pos = pos, gain = 0.6}, true)
			else
				meta:set_int("locked", 1)
				minetest.chat_send_player(player_name, "Chameleon block locked.")
				minetest.sound_play("default_place_node", {pos = pos, gain = 0.3}, true)
			end
			return itemstack
		end

		-- 2. LOCKED BEHAVIOR (Bypasses shape transformation if locked)
		if is_locked then
			if itemstack:is_empty() then return itemstack end

			local item_def = minetest.registered_items[target_name]
			if item_def and item_def.type == "node" and pointed_thing and pointed_thing.above then
				local place_pos = pointed_thing.above
				local node_below = minetest.get_node(place_pos)
					
				if node_below.name == "air" or minetest.registered_nodes[node_below.name].buildable_to then
					local success = minetest.set_node(place_pos, {name = target_name, param2 = 0})
					if success then
						minetest.sound_play(item_def.sounds and item_def.sounds.place or "default_place_node", {pos = place_pos, gain = 0.5}, true)
						if not minetest.is_creative_enabled(player_name) then
							itemstack:take_item()
						end
						return itemstack
					end
				end
			end
				
			return itemstack
		end

		-- 3. UNLOCKED BEHAVIOR (Transform chameleon shape using a valid block)
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
				new_meta:set_string("infotext", "") -- Ensure clean meta

				minetest.sound_play("default_place_node", {pos = pos, gain = 0.8}, true)

				return itemstack
			end
		end

		return itemstack
	end
end
