return {
	time = 0,
	name = "2023俾斯麦Z活动 侵蚀等级4 有利效果",
	init_effect = "",
	stack = 1,
	id = 200414,
	picture = "",
	last_effect = "qinshibuff4",
	desc = "",
	effect_list = {
		{
			type = "BattleBuffAddAttr",
			trigger = {
				"onAttach"
			},
			arg_list = {
				attr = "damageRatioBullet",
				number = 0.025
			}
		}
	}
}
