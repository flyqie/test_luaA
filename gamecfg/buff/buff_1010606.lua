return {
	init_effect = "",
	name = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "",
	stack = 1,
	id = 1010606,
	icon = 1010600,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffShiftBarrage",
			trigger = {
				"onAttach",
				"onRemove"
			},
			arg_list = {
				barrage_id = 81075,
				index = {
					2
				}
			}
		}
	}
}
