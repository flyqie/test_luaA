﻿return {
	init_effect = "",
	name = "点燃",
	time = 15.1,
	picture = "",
	desc = "时乃空",
	stack = 1,
	id = 322,
	icon = 322,
	last_effect = "zhuoshao",
	effect_list = {
		{
			type = "BattleBuffDOT",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				attr = "airPower",
				exposeGroup = 1,
				time = 3,
				cloakExpose = 36,
				number = 5,
				dotType = 1,
				k = 0.1
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				skill_id = 60,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onRemove"
			},
			arg_list = {
				skill_id = 61,
				target = "TargetSelf"
			}
		}
	}
}
