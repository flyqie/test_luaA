return {
	time = 0,
	name = "2022武藏活动 天宇启户祭 敌我双方单位造到的伤害降低，且战斗中每隔一段时间恢复自身微量耐久或获得一层护盾",
	init_effect = "",
	stack = 1,
	id = 200087,
	picture = "",
	last_effect = "",
	desc = "",
	effect_list = {
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach",
				"onRemove"
			},
			arg_list = {
				tag = "MusashiLeader"
			}
		}
	}
}
