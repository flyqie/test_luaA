﻿return {
	uiEffect = "",
	name = "全弹发射",
	cd = 0,
	painting = 1,
	id = 30132,
	picture = "0",
	desc = "全弹发射",
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
			type = "BattleSkillFire",
			casterAniEffect = "",
			target_choise = "TargetHarmRandom",
			targetAniEffect = "",
			arg_list = {
				weapon_id = 170212,
				emitter = "BattleBulletEmitter"
			}
		},
		{
			type = "BattleSkillFire",
			casterAniEffect = "",
			target_choise = "TargetHarmRandom",
			targetAniEffect = "",
			arg_list = {
				emitter = "BattleBulletEmitter",
				delay = 1,
				weapon_id = 170212
			}
		}
	}
}
