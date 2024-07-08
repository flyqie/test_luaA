pg = pg or {}
pg.dorm3d_camera_anim_template = {
	[1001] = {
		anim_time = 0,
		unlock = "",
		furniture_id = 0,
		state = "Idle",
		id = 1001,
		finish_anim = 1001,
		desc = "站立",
		pre_anim = 0
	},
	[1002] = {
		anim_time = 4,
		unlock = "",
		furniture_id = 0,
		state = "SitStart",
		id = 1002,
		finish_anim = 1002,
		desc = "坐下",
		pre_anim = 1001
	},
	[1003] = {
		anim_time = 8.333,
		unlock = "",
		furniture_id = 0,
		state = "GoToBedLStart",
		id = 1003,
		finish_anim = 1003,
		desc = "躺下",
		pre_anim = 1001
	},
	[1004] = {
		anim_time = 3.167,
		unlock = "",
		furniture_id = 0,
		state = "surprise1",
		id = 1004,
		finish_anim = 1001,
		desc = "惊喜",
		pre_anim = 1001
	},
	[1005] = {
		anim_time = 3.333,
		unlock = "",
		furniture_id = 0,
		state = "Bow",
		id = 1005,
		finish_anim = 1001,
		desc = "鞠躬",
		pre_anim = 1001
	},
	[1006] = {
		anim_time = 7.5,
		unlock = "",
		furniture_id = 100,
		state = "PayGoToSofaStart",
		id = 1006,
		finish_anim = 1006,
		desc = "付费躺下",
		pre_anim = 1001
	},
	[1007] = {
		anim_time = 11.517,
		unlock = "",
		furniture_id = 100,
		state = "PayGoToSofaXiong",
		id = 1007,
		finish_anim = 1006,
		desc = "躺下-摸胸",
		pre_anim = 1006
	},
	[1008] = {
		anim_time = 7.083,
		unlock = "",
		furniture_id = 100,
		state = "PayGoToSofaYao",
		id = 1008,
		finish_anim = 1006,
		desc = "躺下-摸腰",
		pre_anim = 1006
	},
	[1009] = {
		anim_time = 11.35,
		unlock = "",
		furniture_id = 100,
		state = "PayGoToSofaTui",
		id = 1009,
		finish_anim = 1006,
		desc = "躺下-摸腿",
		pre_anim = 1006
	},
	[1010] = {
		anim_time = 10,
		unlock = "",
		furniture_id = 100,
		state = "PayGoToSofaJiao",
		id = 1010,
		finish_anim = 1006,
		desc = "躺下-摸脚",
		pre_anim = 1006
	},
	get_id_list_by_furniture_id = {
		[0] = {
			1001,
			1002,
			1003,
			1004,
			1005
		},
		[100] = {
			1006,
			1007,
			1008,
			1009,
			1010
		}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		1008,
		1009,
		1010
	}
}
