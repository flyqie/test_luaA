﻿return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onSubmarineRaid"
			},
			arg_list = {
				skill_id = 1011380,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onSubmarineRetreat"
			},
			arg_list = {
				quota = 1,
				target = "TargetSelf",
				skill_id = 1011381
			}
		}
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	desc_get = "",
	name = "谢幕演出 +",
	init_effect = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "",
	stack = 1,
	id = 1011380,
	icon = 11380,
	last_effect = ""
}
