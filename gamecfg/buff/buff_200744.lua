return {
	init_effect = "",
	name = "2023关岛活动EX 二阶段召唤物1",
	time = 3,
	color = "blue",
	picture = "",
	desc = "",
	stack = 1,
	id = 200744,
	icon = 200744,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				skill_id = 200744,
				target = "TargetSelf"
			}
		}
	}
}
