return {
	init_effect = "",
	name = "2022莱莎联动 战斗BUFF 防御核心LV1",
	time = 0,
	color = "red",
	picture = "",
	desc = "",
	stack = 1,
	id = 200153,
	icon = 200153,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddAttr",
			trigger = {
				"onAttach",
				"onRemove"
			},
			arg_list = {
				attr = "injureRatio",
				number = -0.03
			}
		}
	}
}
