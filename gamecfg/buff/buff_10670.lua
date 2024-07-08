﻿return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onFriendlyShipDying",
				"onStartGame"
			},
			arg_list = {
				check_target = "TargetShipTypeFriendly",
				quota = 1,
				skill_id = 10670,
				maxTargetNumber = 1,
				ship_type_list = {
					4,
					5
				}
			}
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升10.0%",
		addition = {
			"10.0%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升12.2%",
		addition = {
			"12.2%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升14.4%",
		addition = {
			"14.4%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升16.6%",
		addition = {
			"16.6%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升18.8%",
		addition = {
			"18.8%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升21.0%",
		addition = {
			"21.0%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升23.2%",
		addition = {
			"23.2%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升25.4%",
		addition = {
			"25.4%(+2.2%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升27.6%",
		addition = {
			"27.6%(+2.4%)"
		}
	},
	{
		desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升30.0%",
		addition = {
			"30.0%"
		}
	},
	desc_get = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升10.0%(满级30.0%)",
	name = "北方的孤独女王",
	init_effect = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "主力舰队中战列、战巡只存在自己一艘时（可以有其他类型舰船）伤害提升$1",
	stack = 1,
	id = 10670,
	icon = 10670,
	last_effect = ""
}
