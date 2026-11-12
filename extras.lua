-- extra.lua

return {

-- walls (mimics Minecraft better)

 wall = {
		desc = "wall",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "connected",
			fixed = {-0.25, -0.5, -0.25,  0.25, 0.5,  0.25},
			connect_front = {-0.19, -0.44, -0.5, 0.19, 0.44, 0},
			connect_back  = {-0.19, -0.44,  0.19,   0.13, 0.44,  0.5},
			connect_left  = {-0.5,  -0.44, -0.19,  -0.13, 0.44,  0.13},
			connect_right = { 0.19, -0.44, -0.19,   0.5,  0.44,  0.13}
		},
		collision_box = {
			type = "connected",
			fixed = {-0.25, -0.54, -0.25,  0.25, 0.7,  0.25},
			connect_front = {-0.25, -0.54, -0.5,   0.13, 0.7, -0.13},
			connect_back  = {-0.25, -0.54,  0.25,   0.13, 0.7,  0.5},
			connect_left  = {-0.5,  -0.54, -0.25,  -0.13, 0.7,  0.13},
			connect_right = { 0.25, -0.54, -0.25,   0.5,  0.7,  0.13}
		},
		connects_to = {
			"group:stone",
			"group:wood",
			"group:solid",
			"whizchameleon:wall_slim",
			"group:choppy",
			"group:cracky",
			"group:whizchameleon"
		},
		groups = {choppy = 2, oddly_breakable_by_hand = 2, solid = 1},
	},


-- Fence

 fence = {
		desc = "fence",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "connected",
			fixed = {-0.19, -0.5, -0.19, 0.19, 0.5, 0.19},
			connect_front = {-0.13, -0.5, -0.5, 0.13, 0.5, 0},
			connect_back  = {-0.13, -0.5, 0, 0.13, 0.5, 0.5},
			connect_left  = {-0.5, -0.5, -0.13, 0, 0.5, 0.13},
			connect_right = {0, -0.5, -0.13, 0.5, 0.5, 0.13}
		},
		collision_box = {
			type = "connected",
			fixed = {-0.13, -0.54, -0.13, 0.13, 0.5, 0.13},
			connect_front = {-0.25, -0.54, -0.5,   0.25, 0.7, -0.13},
			connect_back  = {-0.25, -0.54,  0.25,   0.25, 0.7,  0.5},
			connect_left  = {-0.5,  -0.54, -0.25,  -0.25, 0.7,  0.25},
			connect_right = { 0.25, -0.54, -0.25,   0.5,  0.7,  0.25}
		},
		connects_to = {
			"group:stone",
			"group:wood",
			"group:solid",
			"whizchameleon:wall_slim",
			"group:cracky", 
			"group:whizchameleon"
		},
		groups = {choppy = 2, oddly_breakable_by_hand = 2, solid = 1, whizchameleon = 1},
	},

}