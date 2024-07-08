﻿return {
	uiEffect = "",
	name = "2023俾斯麦Z活动B3 BOSS浮游炮召唤",
	cd = 0,
	painting = 0,
	id = 200450,
	picture = "0",
	aniEffect = "",
	desc = "",
	effect_list = {
		{
			target_choise = "TargetNil",
			type = "BattleSkillSummon",
			arg_list = {
				delay = 0,
				spawnData = {
					monsterTemplateID = 16521305,
					corrdinate = {
						10,
						0,
						30
					},
					phase = {
						{
							switchParam = 3,
							switchTo = 1,
							index = 0,
							switchType = 1,
							setAI = 75021
						},
						{
							index = 1,
							switchParam = 400,
							switchTo = 2,
							switchType = 1,
							addWeapon = {
								3061431
							},
							removeWeapon = {}
						}
					}
				}
			}
		},
		{
			target_choise = "TargetNil",
			type = "BattleSkillSummon",
			arg_list = {
				delay = 0,
				spawnData = {
					monsterTemplateID = 16521306,
					corrdinate = {
						10,
						0,
						70
					},
					phase = {
						{
							switchParam = 3,
							switchTo = 1,
							index = 0,
							switchType = 1,
							setAI = 75022
						},
						{
							index = 1,
							switchParam = 400,
							switchTo = 1,
							switchType = 1,
							addWeapon = {
								3061432
							},
							removeWeapon = {}
						}
					}
				}
			}
		}
	}
}
