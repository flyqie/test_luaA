﻿return {
	id = 1703307,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 180,
			passCondition = 1,
			backGroundStageID = 1,
			totalArea = {
				-70,
				20,
				90,
				70
			},
			playerArea = {
				-70,
				20,
				37,
				68
			},
			enemyArea = {},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 100,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 1,
					waveIndex = 202,
					preWaves = {},
					triggerParams = {
						timeout = 20
					}
				},
				{
					triggerType = 1,
					waveIndex = 203,
					preWaves = {},
					triggerParams = {
						timeout = 40
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16403207,
							reinforceDelay = 6,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								0,
								0,
								55
							},
							buffList = {},
							phase = {
								{
									index = 0,
									switchType = 1,
									switchTo = 1,
									switchParam = 0.1,
									addWeapon = {
										3043301,
										3043302
									}
								},
								{
									switchParam = 3,
									switchTo = 99,
									index = 1,
									switchType = 1,
									setAI = 10001,
									addBuff = {},
									addWeapon = {
										3043303
									},
									removeWeapon = {}
								},
								{
									index = 99,
									switchType = 1,
									switchTo = 3,
									switchParam = 4,
									removeBuff = {
										200262
									},
									addWeapon = {
										3043304
									},
									removeWeapon = {}
								},
								{
									index = 3,
									switchType = 1,
									switchTo = 98,
									switchParam = 3,
									addBuff = {
										200262
									},
									addWeapon = {},
									removeWeapon = {}
								},
								{
									index = 98,
									switchParam = 12,
									switchTo = 97,
									switchType = 1,
									addWeapon = {
										3043308,
										3043309
									},
									removeWeapon = {
										3043303,
										3043304
									}
								},
								{
									index = 97,
									switchType = 1,
									switchTo = 1,
									switchParam = 1,
									addWeapon = {},
									addBuff = {},
									removeWeapon = {
										3043308,
										3043309
									}
								}
							}
						}
					},
					reinforcement = {
						{
							monsterTemplateID = 16403052,
							moveCast = true,
							delay = 4,
							score = 0,
							corrdinate = {
								12,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16403052,
							moveCast = true,
							delay = 4,
							score = 0,
							corrdinate = {
								12,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 0,
					waveIndex = 2002,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {},
					reinforcement = {
						{
							monsterTemplateID = 16403057,
							moveCast = true,
							delay = 4,
							corrdinate = {
								5,
								0,
								58
							},
							buffList = {
								8001
							},
							phase = {
								{
									switchParam = 180,
									dive = "STATE_RAID",
									switchTo = 1,
									index = 0,
									switchType = 1,
									setAI = 20009
								}
							}
						},
						reinforceDuration = 180
					}
				},
				{
					triggerType = 0,
					waveIndex = 3001,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16403902,
							moveCast = true,
							delay = 0,
							deadFX = "none",
							corrdinate = {
								60,
								0,
								55
							},
							phase = {
								{
									switchParam = 12,
									switchTo = 1,
									index = 0,
									switchType = 1,
									setAI = 20006
								},
								{
									index = 1,
									switchType = 1,
									switchTo = 0,
									switchParam = 300,
									addBuff = {
										200249
									}
								}
							}
						}
					}
				},
				{
					triggerType = 0,
					waveIndex = 3002,
					conditionType = 1,
					preWaves = {
						100
					},
					blockFlags = {
						200242
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16404901,
							moveCast = true,
							delay = 0,
							deadFX = "none",
							corrdinate = {
								-10,
								0,
								55
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						101
					},
					triggerParams = {}
				}
			}
		}
	},
	fleet_prefab = {}
}
