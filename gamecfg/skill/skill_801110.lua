﻿return {
	uiEffect = "",
	name = "水星纪念M",
	cd = 0,
	painting = 1,
	id = 801110,
	picture = "0",
	castCV = "skill",
	desc = "水星纪念M",
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
				buff_id = 801112
			}
		}
	}
}
