return {
	{
		desc = "每隔20秒，有25%的概率发动，提高全队5.0%装填，持续8秒，同技能效果不叠加",
		addition = {
			"5.0%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队7.2%装填，持续8秒，同技能效果不叠加",
		addition = {
			"7.2%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队9.4%装填，持续8秒，同技能效果不叠加",
		addition = {
			"9.4%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队11.6%装填，持续8秒，同技能效果不叠加",
		addition = {
			"11.6%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队13.8%装填，持续8秒，同技能效果不叠加",
		addition = {
			"13.8%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队16.0%装填，持续8秒，同技能效果不叠加",
		addition = {
			"16.0%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队18.2%装填，持续8秒，同技能效果不叠加",
		addition = {
			"18.2%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队20.4%装填，持续8秒，同技能效果不叠加",
		addition = {
			"20.4%(+2.2%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队22.6%装填，持续8秒，同技能效果不叠加",
		addition = {
			"22.6%(+2.4%)"
		}
	},
	{
		desc = "每隔20秒，有25%的概率发动，提高全队25.0%装填，持续8秒，同技能效果不叠加",
		addition = {
			"25.0%"
		}
	},
	desc_get = "每隔20秒，有25%的概率发动，提高全队5.0%(满级25.0%)装填，持续8秒，同技能效果不叠加",
	name = "装填号令",
	init_effect = "",
	time = 0,
	color = "yellow",
	picture = "",
	desc = "每隔20秒，有25%的概率发动，提高全队$1装填，持续8秒，同技能效果不叠加",
	stack = 1,
	id = 2021,
	icon = 2020,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				buff_id = 2022,
				time = 20,
				target = "TargetSelf"
			}
		}
	}
}
