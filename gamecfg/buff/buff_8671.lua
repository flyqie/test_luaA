﻿return {
	init_effect = "",
	name = "潜伏者II型水面减伤护盾",
	time = 15,
	color = "blue",
	picture = "",
	desc = "",
	stack = 1,
	id = 8671,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				buff_id = 8672,
				target = "TargetSelf",
				time = 11,
				quota = 1
			}
		}
	}
}
