pg = pg or {}
pg.dorm3d_resource = {
	[202201] = {
		ship_group = 20220,
		name = "天狼星",
		model_id = "pre_char_tianlangxing_noshoes_mod",
		type = 1,
		id = 202201,
		picture = "regular",
		unlock_text = "",
		unlock = {
			1,
			1
		}
	},
	[202202] = {
		ship_group = 20220,
		name = "天狼星·浴衣",
		model_id = "pre_char_tianlangxing_db_cehuatest",
		type = 1,
		id = 202202,
		picture = "yuyi",
		unlock_text = "默契值达到10级后解锁",
		unlock = {
			1,
			10
		}
	},
	get_id_list_by_ship_group = {
		[20220] = {
			202201,
			202202
		}
	},
	all = {
		202201,
		202202
	}
}
