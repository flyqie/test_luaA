return {
	uiEffect = "",
	name = "ICELF",
	cd = 0,
	painting = 1,
	id = 13830,
	picture = "0",
	castCV = "skill",
	desc = "ICELF",
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
				buff_id = 13831
			}
		}
	}
}
