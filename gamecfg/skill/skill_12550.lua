return {
	uiEffect = "",
	name = "长弓",
	cd = 0,
	painting = 1,
	id = 12550,
	picture = "0",
	castCV = "skill",
	desc = "长弓",
	aniEffect = {
		effect = "jineng",
		offset = {
			0,
			-2,
			0
		}
	},
	effect_list = {
		{
			type = "BattleSkillAddBuff",
			casterAniEffect = "",
			target_choise = "TargetSelf",
			targetAniEffect = "",
			arg_list = {
				buff_id = 12551
			}
		}
	}
}
