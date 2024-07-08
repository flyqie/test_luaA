﻿return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				skill_id = 4081
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				buff_id = 4082,
				time = 15,
				target = "TargetSelf"
			}
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有15.0%的概率使用烟雾弹，处于烟幕中的角色回避率提高20.0%，持续5秒，同技能效果不叠加",
		addition = {
			"15.0%(+1.6%)",
			"20.0%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有16.6%的概率使用烟雾弹，处于烟幕中的角色回避率提高22.2%，持续5秒，同技能效果不叠加",
		addition = {
			"16.6%(+1.6%)",
			"22.2%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有18.2%的概率使用烟雾弹，处于烟幕中的角色回避率提高24.4%，持续5秒，同技能效果不叠加",
		addition = {
			"18.2%(+1.6%)",
			"24.4%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有19.8%的概率使用烟雾弹，处于烟幕中的角色回避率提高26.6%，持续5秒，同技能效果不叠加",
		addition = {
			"19.8%(+1.6%)",
			"26.6%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有21.4%的概率使用烟雾弹，处于烟幕中的角色回避率提高28.8%，持续5秒，同技能效果不叠加",
		addition = {
			"21.4%(+1.6%)",
			"28.8%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有23.0%的概率使用烟雾弹，处于烟幕中的角色回避率提高31.0%，持续5秒，同技能效果不叠加",
		addition = {
			"23.0%(+1.6%)",
			"31.0%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有24.6%的概率使用烟雾弹，处于烟幕中的角色回避率提高33.2%，持续5秒，同技能效果不叠加",
		addition = {
			"24.6%(+1.8%)",
			"33.2%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有26.4%的概率使用烟雾弹，处于烟幕中的角色回避率提高35.4%，持续5秒，同技能效果不叠加",
		addition = {
			"26.4%(+1.8%)",
			"35.4%(+2.2%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有28.2%的概率使用烟雾弹，处于烟幕中的角色回避率提高37.6%，持续5秒，同技能效果不叠加",
		addition = {
			"28.2%(+1.8%)",
			"37.6%(+2.4%)"
		}
	},
	{
		desc = "战斗开始时使用烟雾弹，随后每15秒有30.0%的概率使用烟雾弹，处于烟幕中的角色回避率提高40.0%，持续5秒，同技能效果不叠加",
		addition = {
			"30.0%",
			"40.0%"
		}
	},
	desc_get = "战斗开始时使用烟雾弹，随后每15秒有15.0%(满级30.0%)的概率使用烟雾弹，处于烟幕中的角色回避率提高20.0%(满级40.0%)，持续5秒，同技能效果不叠加",
	name = "烟雾弹",
	init_effect = "",
	time = 0,
	color = "blue",
	picture = "",
	desc = "战斗开始时使用烟雾弹，随后每15秒有$1的概率使用烟雾弹，处于烟幕中的角色回避率提高$2，持续5秒，同技能效果不叠加",
	stack = 1,
	id = 14024,
	icon = 14024,
	last_effect = ""
}
