﻿return {
	uiEffect = "",
	name = "第二阶段",
	cd = 0,
	painting = 1,
	id = 100003,
	picture = "0",
	desc = "第二阶段",
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
				buff_id = 100003
			}
		}
	}
}
