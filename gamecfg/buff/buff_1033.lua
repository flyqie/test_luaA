return {
	{
		desc = "提高舰队中所有战列舰5.0%装填属性，同类指挥技能无法同时生效",
		addition = {
			"5.0%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰6.1%装填属性，同类指挥技能无法同时生效",
		addition = {
			"6.1%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰7.2%装填属性，同类指挥技能无法同时生效",
		addition = {
			"7.2%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰8.3%装填属性，同类指挥技能无法同时生效",
		addition = {
			"8.3%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰9.4%装填属性，同类指挥技能无法同时生效",
		addition = {
			"9.4%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰10.5%装填属性，同类指挥技能无法同时生效",
		addition = {
			"10.5%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰11.6%装填属性，同类指挥技能无法同时生效",
		addition = {
			"11.6%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰12.7%装填属性，同类指挥技能无法同时生效",
		addition = {
			"12.7%(+1.1%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰13.8%装填属性，同类指挥技能无法同时生效",
		addition = {
			"13.8%(+1.2%)"
		}
	},
	{
		desc = "提高舰队中所有战列舰15.0%装填属性，同类指挥技能无法同时生效",
		addition = {
			"15.0%"
		}
	},
	desc_get = "提高舰队中所有战列舰5.0%(满级15.0%)装填属性，同类指挥技能无法同时生效",
	name = "装填指挥·战列舰",
	init_effect = "",
	time = 0,
	color = "yellow",
	picture = "",
	desc = "提高舰队中所有战列舰$1装填属性，同类指挥技能无法同时生效",
	stack = 1,
	id = 1033,
	icon = 1030,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 1033
			}
		}
	}
}
