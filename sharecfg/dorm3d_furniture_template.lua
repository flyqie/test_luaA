pg = pg or {}
pg.dorm3d_furniture_template = {
	{
		rarity = 3,
		name = "卧室初始花瓶",
		lazy_action = "",
		type = 3,
		desc = "装饰",
		char_id = 20220,
		model = "",
		id = 1,
		icon = "",
		target_slots = {},
		acesses = {
			{
				"勋章商店兑换",
				{
					"SHOP",
					{
						warp = "medal"
					}
				},
				0
			},
			{
				"军需商店兑换",
				{
					"SHOP",
					{
						warp = "supplies"
					}
				},
				0
			},
			{
				"每周任务",
				{
					""
				},
				0
			}
		}
	},
	{
		rarity = 3,
		name = "卧室初始书桌灯",
		lazy_action = "",
		type = 3,
		desc = "装饰",
		char_id = 20220,
		model = "",
		id = 2,
		icon = "",
		target_slots = {},
		acesses = {
			{
				"勋章商店兑换",
				{
					"SHOP",
					{
						warp = "medal"
					}
				},
				0
			},
			{
				"军需商店兑换",
				{
					"SHOP",
					{
						warp = "supplies"
					}
				},
				0
			},
			{
				"每周任务",
				{
					""
				},
				0
			}
		}
	},
	{
		rarity = 3,
		name = "卧室初始床头灯",
		lazy_action = "",
		type = 3,
		desc = "装饰",
		char_id = 20220,
		model = "",
		id = 3,
		icon = "",
		target_slots = {},
		acesses = {
			{
				"勋章支援（概率产出）",
				{
					"GETBOAT",
					{
						page = 3
					}
				},
				0
			},
			{
				"推荐探索关卡1-3",
				{
					"LEVEL",
					{
						chapterid = 103
					}
				},
				0
			},
			{
				"进行轻型舰建造",
				{
					"GETBOAT",
					{
						projectName = "light",
						page = 1
					}
				},
				0
			}
		}
	},
	{
		rarity = 3,
		name = "卧室初始床",
		model = "",
		type = 4,
		id = 4,
		icon = "",
		char_id = 20220,
		desc = "默认床",
		target_slots = {},
		acesses = {
			{
				"勋章支援（概率产出）",
				{
					"GETBOAT",
					{
						page = 3
					}
				},
				0
			},
			{
				"推荐探索关卡1-3",
				{
					"LEVEL",
					{
						chapterid = 103
					}
				},
				0
			},
			{
				"进行轻型舰建造",
				{
					"GETBOAT",
					{
						projectName = "light",
						page = 1
					}
				},
				0
			}
		},
		lazy_action = {
			"GoToBedLStart",
			"GoToBedLEnd"
		}
	},
	{
		rarity = 3,
		name = "餐桌初始红茶",
		lazy_action = "",
		type = 3,
		desc = "初始",
		char_id = 20220,
		model = "",
		id = 5,
		icon = "",
		target_slots = {},
		acesses = {
			{
				"勋章支援（概率产出）",
				{
					"GETBOAT",
					{
						page = 3
					}
				},
				0
			},
			{
				"推荐探索关卡1-3",
				{
					"LEVEL",
					{
						chapterid = 103
					}
				},
				0
			},
			{
				"进行轻型舰建造",
				{
					"GETBOAT",
					{
						projectName = "light",
						page = 1
					}
				},
				0
			}
		}
	},
	{
		rarity = 3,
		name = "客厅初始沙发",
		model = "",
		type = 5,
		id = 6,
		icon = "",
		char_id = 20220,
		desc = "沙发",
		target_slots = {},
		acesses = {
			{
				"勋章支援（概率产出）",
				{
					"GETBOAT",
					{
						page = 3
					}
				},
				0
			},
			{
				"推荐探索关卡1-3",
				{
					"LEVEL",
					{
						chapterid = 103
					}
				},
				0
			},
			{
				"进行轻型舰建造",
				{
					"GETBOAT",
					{
						projectName = "light",
						page = 1
					}
				},
				0
			}
		},
		lazy_action = {
			"SitStart",
			"SitEnd"
		}
	},
	[100] = {
		rarity = 4,
		name = "付费沙发",
		lazy_action = "",
		type = 5,
		char_id = 20220,
		desc = "沙发",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_chair02",
		id = 100,
		icon = "",
		target_slots = {}
	},
	[101] = {
		rarity = 4,
		name = "付费镜子",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "换衣室",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_mirror01",
		id = 101,
		icon = "",
		target_slots = {}
	},
	[102] = {
		rarity = 4,
		name = "小冰箱",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "厨房",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_electrical01",
		id = 102,
		icon = "",
		target_slots = {}
	},
	[103] = {
		rarity = 4,
		name = "工具箱",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "换衣室",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_plasticbox01",
		id = 103,
		icon = "",
		target_slots = {}
	},
	[104] = {
		rarity = 4,
		name = "小熊玩偶",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "床上、床头柜",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_toy01",
		id = 104,
		icon = "",
		target_slots = {}
	},
	[105] = {
		rarity = 4,
		name = "书",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "任意装饰处",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_book01",
		id = 105,
		icon = "",
		target_slots = {}
	},
	[106] = {
		rarity = 4,
		name = "空花瓶",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "任意装饰处",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_flowerpot01",
		id = 106,
		icon = "",
		target_slots = {}
	},
	[107] = {
		rarity = 4,
		name = "看不懂的食物",
		lazy_action = "",
		type = 3,
		char_id = 20220,
		desc = "餐桌上",
		acesses = "",
		model = "Pay_Siriushostel/pre_db_sh_food01",
		id = 107,
		icon = "",
		target_slots = {}
	},
	get_id_list_by_char_id = {
		[20220] = {
			1,
			2,
			3,
			4,
			5,
			6,
			100,
			101,
			102,
			103,
			104,
			105,
			106,
			107
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		100,
		101,
		102,
		103,
		104,
		105,
		106,
		107
	}
}
