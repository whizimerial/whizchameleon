-- extra.lua

return {

-- walls (mimics Minecraft better)

	wall_slim = {
		desc = "Wall",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "connected",
			fixed         = {-0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			connect_front = {-0.25, -0.5, -0.5,   0.25, 0.5, -0.25},
			connect_back  = {-0.25, -0.5,  0.25,   0.25, 0.5,  0.5},
			connect_left  = {-0.5,  -0.5, -0.25,  -0.25, 0.5,  0.25},
			connect_right = { 0.25, -0.5, -0.25,   0.5,  0.5,  0.25},
		},
		collision_box = {
			type = "connected",
			fixed         = {-0.25, -0.5, -0.25,  0.25, 0.7,  0.25},
			connect_front = {-0.25, -0.5, -0.5,   0.25, 0.7, -0.25},
			connect_back  = {-0.25, -0.5,  0.25,   0.25, 0.7,  0.5},
			connect_left  = {-0.5,  -0.5, -0.25,  -0.25, 0.7,  0.25},
			connect_right = { 0.25, -0.5, -0.25,   0.5,  0.7,  0.25},
		},
		-- Fallback to connect to default nodes if custom groups are missing
		connects_to = {
			"group:stone",
			"group:wood",
			"group:solid",
			"default:stone",
			"default:cobble",
			"default:wood",
			"whizchameleon:wall_slim"
		},
		groups = {choppy = 2, oddly_breakable_by_hand = 2, solid = 1},
	},

-- stairs supposedly similar to Minecraft (WIP)

	stairs_auto = {
		desc = "Stairs Auto",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.5, 0.0,  0.5},
				{-0.5,  0.0,  0.0,  0.5, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.5, 0.0,  0.5},
				{-0.5,  0.0,  0.0,  0.5, 0.5,  0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.5, 0.0,  0.5},
				{-0.5,  0.0,  0.0,  0.5, 0.5,  0.5},
			},
		},
		groups = {choppy = 2, oddly_breakable_by_hand = 2, solid = 1, stairs = 1},
		
		on_place = function(itemstack, placer, pointed_thing)
			-- 1. Let Luanti place and face the node normally first
			local ret = minetest.rotate_node(itemstack, placer, pointed_thing)
			
			-- 2. Get the exact position where the node was just placed
			local pos = pointed_thing.above
			local node = minetest.get_node(pos)
			
			-- 3. Example of checking a neighbor (e.g., checking what is behind or to the side)
			-- node.param2 gives you the orientation (0 to 3)
			-- You can use minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}) to check neighbors!
			
			-- If you want it to morph, you would check neighbors here, 
			-- and call minetest.swap_node(pos, {name = "whizchameleon:stairs_inner_c_...", param2 = node.param2})
			
			return ret
		end,
	},
}
