return {
	id = 999978,
	name = "教程 高费平射",
	attr_quote = "",
	effect_list = {
		{
			{
				type = "BattleCardPuzzleSkillFire",
				caster = "Leader",
				target_choise = {
					"TargetHarmNearest"
				},
				arg_list = {
					weapon_id = 9999997
				}
			}
		},
		{
			{
				type = "BattleCardPuzzleSkillMoveCard",
				arg_list = {
					move_to = 1,
					shuffle = 1,
					move_op = "Add"
				}
			}
		}
	}
}
