﻿return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onSubmarineRaid",
				"onSubmarineFreeSpecial"
			},
			arg_list = {
				quota = 1,
				target = "TargetSelf",
				skill_id = 29722
			}
		}
	},
	{},
	init_effect = "",
	name = "专属弹幕",
	time = 0,
	color = "red",
	picture = "",
	desc = "进入战斗后，触发专属弹幕-大青花鱼II",
	stack = 1,
	id = 29722,
	icon = 29720,
	last_effect = ""
}
