﻿return {
	uiEffect = "",
	name = "2023海盗活动 传奇旗舰Lv1",
	cd = 0,
	painting = "huangjiacaifu",
	id = 200619,
	picture = "0",
	aniEffect = "",
	desc = "",
	effect_list = {
		{
			type = "BattleSkillSummon",
			casterAniEffect = "",
			target_choise = "TargetNil",
			targetAniEffect = "",
			arg_list = {
				delay = 0,
				spawnData = {
					monsterTemplateID = 16568001,
					buffList = {
						8001,
						8007
					},
					corrdinate = {
						-88,
						0,
						55
					},
					phase = {
						{
							switchParam = 1.5,
							switchTo = 1,
							index = 0,
							switchType = 1,
							setAI = 20006
						},
						{
							switchParam = 4,
							switchTo = 2,
							index = 1,
							switchType = 1,
							setAI = 70227
						},
						{
							index = 2,
							switchType = 1,
							switchTo = 0,
							switchParam = 300,
							addWeapon = {
								3099050,
								3099030,
								3099060,
								3099065
							}
						}
					}
				}
			}
		}
	}
}
