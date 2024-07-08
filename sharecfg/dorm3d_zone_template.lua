pg = pg or {}
pg.dorm3d_zone_template = {
	[1000] = {
		special_action = "",
		name = "全局区域",
		lazy_action = "",
		special_talk = "",
		is_global = 1,
		char_id = 20220,
		type_prioritys = "",
		id = 1000,
		watch_camera = ""
	},
	[1001] = {
		is_global = 0,
		name = "入口",
		lazy_action = "",
		char_id = 20220,
		id = 1001,
		type_prioritys = "",
		watch_camera = "Default",
		special_action = {
			"jinzhang",
			"dianshouzhi"
		},
		special_talk = {
			137,
			138,
			139
		}
	},
	[1002] = {
		is_global = 0,
		name = "卧室",
		char_id = 20220,
		id = 1002,
		watch_camera = "Bed",
		type_prioritys = {
			4,
			3,
			2,
			1
		},
		special_action = {
			"jinzhang",
			"dianshouzhi"
		},
		special_talk = {
			137,
			138,
			139
		},
		lazy_action = {
			"GoToBedLStart",
			"GoToBedLEnd",
			"GoToBedL"
		}
	},
	[1003] = {
		is_global = 0,
		name = "餐厅",
		type_prioritys = "",
		char_id = 20220,
		id = 1003,
		watch_camera = "Table",
		special_action = {
			"jinzhang",
			"dianshouzhi"
		},
		special_talk = {
			137,
			138,
			139
		},
		lazy_action = {
			"SitHStart",
			"SitHEnd",
			"SitH"
		}
	},
	[1004] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		char_id = 20220,
		id = 1004,
		watch_camera = "Chair",
		special_action = {
			"jinzhang",
			"dianshouzhi"
		},
		special_talk = {
			137,
			138,
			139
		},
		lazy_action = {
			"SitStart",
			"SitEnd",
			"Sit"
		}
	},
	[1005] = {
		is_global = 0,
		name = "换衣间",
		lazy_action = "",
		char_id = 20220,
		id = 1005,
		type_prioritys = "",
		watch_camera = "Bath",
		special_action = {
			"jinzhang",
			"dianshouzhi"
		},
		special_talk = {
			137,
			138,
			139
		}
	},
	get_id_list_by_char_id = {
		[20220] = {
			1000,
			1001,
			1002,
			1003,
			1004,
			1005
		}
	},
	all = {
		1000,
		1001,
		1002,
		1003,
		1004,
		1005
	}
}
