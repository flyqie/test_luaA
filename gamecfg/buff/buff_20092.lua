﻿return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countType = 20090,
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
				skill_id = 20092,
				countType = 20090
			}
		}
	},
	{
		desc = "主炮每进行10次攻击，触发全弹发射-埃德索尔级II"
	},
	init_effect = "",
	name = "全弹发射",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行10次攻击，触发全弹发射-埃德索尔级II",
	stack = 1,
	id = 20092,
	icon = 20000,
	last_effect = ""
}
