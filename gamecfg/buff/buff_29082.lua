﻿return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countType = 29080,
				countTarget = 10,
				gunnerBonus = true,
				index = {
					1
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id = 29082,
				countType = 29080
			}
		}
	},
	{
		desc = "主炮每进行10次攻击，触发专属弹幕-标枪II"
	},
	desc_get = "主炮每进行10次攻击，触发专属弹幕-标枪II",
	name = "专属弹幕-标枪II",
	init_effect = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行10次攻击，触发专属弹幕-标枪II",
	stack = 1,
	id = 29082,
	icon = 29080,
	last_effect = ""
}
