pg = pg or {}
pg.dorm3d_furniture_slot_template = {
	[100101] = {
		char_id = 20220,
		name = "卧室桌子上",
		id = 100101,
		type = 3,
		default_furniture = 1,
		furniture_name = "pre_db_ceram05b",
		zone_id = 1001
	},
	[100102] = {
		char_id = 20220,
		name = "卧室桌子上",
		id = 100102,
		type = 3,
		default_furniture = 2,
		furniture_name = "pre_db_chandelier07a",
		zone_id = 1001
	},
	[100103] = {
		char_id = 20220,
		name = "卧室床头柜",
		id = 100103,
		type = 3,
		default_furniture = 3,
		furniture_name = "pre_db_chandelier07b",
		zone_id = 1001
	},
	[100104] = {
		char_id = 20220,
		name = "卧室床上",
		id = 100104,
		type = 3,
		default_furniture = 0,
		furniture_name = "",
		zone_id = 1001
	},
	[100105] = {
		char_id = 20220,
		name = "卧室床",
		id = 100105,
		type = 4,
		default_furniture = 4,
		furniture_name = "pre_db_bed01",
		zone_id = 1001
	},
	[100201] = {
		char_id = 20220,
		name = "餐厅置物架",
		id = 100201,
		type = 3,
		default_furniture = 0,
		furniture_name = "",
		zone_id = 1002
	},
	[100202] = {
		char_id = 20220,
		name = "餐厅桌子上",
		id = 100202,
		type = 3,
		default_furniture = 5,
		furniture_name = "pre_db_ceram01a",
		zone_id = 1002
	},
	[100301] = {
		char_id = 20220,
		name = "客厅沙发",
		id = 100301,
		type = 5,
		default_furniture = 6,
		furniture_name = "pre_db_chair01",
		zone_id = 1003
	},
	[100401] = {
		char_id = 20220,
		name = "换衣间地板处",
		id = 100401,
		type = 3,
		default_furniture = 0,
		furniture_name = "",
		zone_id = 1004
	},
	[100402] = {
		char_id = 20220,
		name = "换衣间置物架",
		id = 100402,
		type = 3,
		default_furniture = 0,
		furniture_name = "",
		zone_id = 1004
	},
	get_id_list_by_char_id = {
		[20220] = {
			100101,
			100102,
			100103,
			100104,
			100105,
			100201,
			100202,
			100301,
			100401,
			100402
		}
	},
	get_id_list_by_zone_id = {
		[1001] = {
			100101,
			100102,
			100103,
			100104,
			100105
		},
		[1002] = {
			100201,
			100202
		},
		[1003] = {
			100301
		},
		[1004] = {
			100401,
			100402
		}
	},
	all = {
		100101,
		100102,
		100103,
		100104,
		100105,
		100201,
		100202,
		100301,
		100401,
		100402
	}
}
