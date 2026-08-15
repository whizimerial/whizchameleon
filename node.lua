-- node.lua

return {

-- base cube, slab, flat

	cube = {
		desc = "Cube",
		drawtype = "normal",
		selection_box = { type = "regular" },
		collision_box = { type = "regular" },
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
	},
	
-- Pixel Heights (1px to 15px)

	height_1px = {
		desc = "1px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5} },
	},
	height_2px = {
		desc = "2px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5} },
	},
	height_3px = {
		desc = "3px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5} },
	},
	height_4px = {
		desc = "4px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5} },
	},
	height_5px = {
		desc = "5px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5} },
	},
	height_6px = {
		desc = "6px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.125, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.125, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.125, 0.5} },
	},
	height_7px = {
		desc = "7px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.0625, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.0625, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.0625, 0.5} },
	},
	height_8px = {
		desc = "8px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5} },
	},
	height_9px = {
		desc = "9px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5} },
	},
	height_10px = {
		desc = "10px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5} },
	},
	height_11px = {
		desc = "11px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.1875, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.1875, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.1875, 0.5} },
	},
	height_12px = {
		desc = "12px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5} },
	},
	height_13px = {
		desc = "13px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5} },
	},
	height_14px = {
		desc = "14px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5} },
	},
	height_15px = {
		desc = "15px Height",
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5} },
		selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5} },
		collision_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5} },
	},

-- stairs

	stairs = {
		desc = "Stairs",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
	},
	stairs_inner = {
		desc = "Inner Stairs",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{ 0.0, 0.0, -0.5, 0.5, 0.5, 0.0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{ 0.0, 0.0, -0.5, 0.5, 0.5, 0.0},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{ 0.0, 0.0, -0.5, 0.5, 0.5, 0.0},
			},
		},
	},
	stairs_outer = {
		desc = "Outer Stairs",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{ 0.0,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{ 0.0,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{ 0.0,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
	},
}
