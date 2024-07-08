pg = pg or {}
pg.dorm3d_camera_zone_template = {
	[1001] = {
		char_id = 20220,
		name = "卧室",
		move_range_vertical = "",
		record_time = 60,
		id = 1001,
		move_range_horizonal = "",
		watch_camera = "Bed",
		regular_anim = {
			1001,
			1002,
			1003,
			1005
		},
		special_furniture = {},
		anim_speeds = {
			0.2,
			0.5,
			1,
			1.5,
			2
		},
		focus_distance = {
			0.1,
			5
		},
		blur_strength = {
			-1,
			1
		},
		exposure = {
			-10,
			10
		},
		contrast = {
			-100,
			100
		},
		saturation = {
			-100,
			100
		}
	},
	[1002] = {
		char_id = 20220,
		name = "客厅",
		move_range_vertical = "",
		record_time = 60,
		id = 1002,
		move_range_horizonal = "",
		watch_camera = "Chair",
		regular_anim = {
			1001,
			1002,
			1003,
			1004
		},
		special_furniture = {
			{
				100,
				100301
			}
		},
		anim_speeds = {
			0.2,
			0.5,
			1,
			1.5,
			2
		},
		focus_distance = {
			0.1,
			5
		},
		blur_strength = {
			-1,
			1
		},
		exposure = {
			-10,
			10
		},
		contrast = {
			-100,
			100
		},
		saturation = {
			-100,
			100
		}
	},
	[1003] = {
		char_id = 20220,
		name = "门口",
		move_range_vertical = "",
		record_time = 60,
		id = 1003,
		move_range_horizonal = "",
		watch_camera = "Default",
		regular_anim = {
			1001,
			1002,
			1003
		},
		special_furniture = {},
		anim_speeds = {
			0.2,
			0.5,
			1,
			1.5,
			2
		},
		focus_distance = {
			0.1,
			5
		},
		blur_strength = {
			-1,
			1
		},
		exposure = {
			-10,
			10
		},
		contrast = {
			-100,
			100
		},
		saturation = {
			-100,
			100
		}
	},
	[1004] = {
		char_id = 20220,
		name = "餐厅",
		move_range_vertical = "",
		record_time = 60,
		id = 1004,
		move_range_horizonal = "",
		watch_camera = "Table",
		regular_anim = {
			1001,
			1002,
			1003
		},
		special_furniture = {},
		anim_speeds = {
			0.2,
			0.5,
			1,
			1.5,
			2
		},
		focus_distance = {
			0.1,
			5
		},
		blur_strength = {
			-1,
			1
		},
		exposure = {
			-10,
			10
		},
		contrast = {
			-100,
			100
		},
		saturation = {
			-100,
			100
		}
	},
	[1005] = {
		char_id = 20220,
		name = "浴室",
		move_range_vertical = "",
		record_time = 60,
		id = 1005,
		move_range_horizonal = "",
		watch_camera = "Bath",
		regular_anim = {
			1001,
			1002,
			1003
		},
		special_furniture = {},
		anim_speeds = {
			0.2,
			0.5,
			1,
			1.5,
			2
		},
		focus_distance = {
			0.1,
			5
		},
		blur_strength = {
			-1,
			1
		},
		exposure = {
			-10,
			10
		},
		contrast = {
			-100,
			100
		},
		saturation = {
			-100,
			100
		}
	},
	get_id_list_by_char_id = {
		[20220] = {
			1001,
			1002,
			1003,
			1004,
			1005
		}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005
	}
}
