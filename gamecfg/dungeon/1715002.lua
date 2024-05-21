return {
	id = 1715002,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 600,
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
			mainUnitPosition = {
				{
					Vector3(-105, 0, 58),
					Vector3(-105, 0, 78),
					Vector3(-105, 0, 38)
				},
				[-1] = {
					Vector3(15, 0, 58),
					Vector3(15, 0, 78),
					Vector3(15, 0, 38)
				}
			},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 300,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 3,
					waveIndex = 200,
					preWaves = {
						300
					},
					triggerParams = {
						id = "YANJINCHENXU23-1"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						200
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16506101,
							moveCast = true,
							delay = 0,
							corrdinate = {
								10,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506103,
							moveCast = true,
							delay = 0,
							corrdinate = {
								0,
								0,
								55
							}
						},
						{
							monsterTemplateID = 16506101,
							moveCast = true,
							delay = 0,
							corrdinate = {
								10,
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
					key = true,
					waveIndex = 102,
					conditionType = 1,
					preWaves = {
						101
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16506102,
							moveCast = true,
							delay = 0,
							corrdinate = {
								0,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506101,
							moveCast = true,
							delay = 0,
							corrdinate = {
								10,
								0,
								65
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506101,
							moveCast = true,
							delay = 0,
							corrdinate = {
								10,
								0,
								45
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506102,
							moveCast = true,
							delay = 0,
							corrdinate = {
								0,
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
					key = true,
					waveIndex = 103,
					conditionType = 1,
					preWaves = {
						102
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16506102,
							moveCast = true,
							delay = 0,
							score = 0,
							corrdinate = {
								0,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506103,
							moveCast = true,
							delay = 0,
							score = 0,
							corrdinate = {
								0,
								0,
								65
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506102,
							moveCast = true,
							delay = 0,
							score = 0,
							corrdinate = {
								0,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16506103,
							moveCast = true,
							delay = 0,
							score = 0,
							corrdinate = {
								0,
								0,
								45
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 3,
					waveIndex = 201,
					preWaves = {
						103
					},
					triggerParams = {
						id = "YANJINCHENXU23-2"
					}
				},
				{
					triggerType = 1,
					waveIndex = 301,
					preWaves = {
						201
					},
					triggerParams = {
						timeout = 20
					}
				},
				{
					triggerType = 3,
					waveIndex = 202,
					preWaves = {
						301
					},
					triggerParams = {
						id = "YANJINCHENXU23-3"
					}
				},
				{
					triggerType = 5,
					waveIndex = 400,
					preWaves = {
						201
					},
					triggerParams = {
						bgm = "battle-whaling-normal"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 104,
					conditionType = 0,
					preWaves = {
						201
					},
					triggerParam = {},
					spawn = {
						{
							score = 0,
							moveCast = true,
							delay = 0,
							monsterTemplateID = 16506150,
							corrdinate = {
								-5,
								0,
								50
							},
							buffList = {
								200348
							},
							bossData = {
								hpBarNum = 100,
								icon = "sairen"
							},
							phase = {
								{
									index = 0,
									switchParam = 0.1,
									switchTo = 1,
									switchType = 1,
									addWeapon = {
										3054101
									},
									removeWeapon = {}
								},
								{
									switchType = 1,
									switchTo = 2,
									index = 1,
									switchParam = 6.5,
									setAI = 20006,
									addWeapon = {
										3054102
									},
									removeWeapon = {}
								},
								{
									index = 2,
									switchParam = 6,
									switchTo = 3,
									switchType = 1,
									addWeapon = {
										3054103
									},
									removeWeapon = {
										3054102
									}
								},
								{
									switchType = 1,
									switchTo = 4,
									index = 3,
									switchParam = 10,
									setAI = 75027,
									addWeapon = {
										3054104,
										3054105,
										3054106,
										3054107
									},
									removeWeapon = {
										3054102,
										3054103,
										3054101
									}
								},
								{
									switchType = 1,
									switchTo = 5,
									index = 4,
									switchParam = 1,
									setAI = 70093,
									addWeapon = {
										3054101
									},
									removeWeapon = {
										3054104,
										3054105,
										3054106
									}
								},
								{
									index = 5,
									switchParam = 0.1,
									switchTo = 6,
									switchType = 1,
									addWeapon = {
										3054108
									},
									removeWeapon = {}
								},
								{
									switchType = 1,
									switchTo = 7,
									index = 6,
									switchParam = 10,
									setAI = 10001,
									addWeapon = {
										3054109,
										3054110
									},
									removeWeapon = {
										3054107
									}
								},
								{
									switchType = 1,
									switchTo = 1,
									index = 7,
									switchParam = 1,
									setAI = 70093,
									addWeapon = {},
									removeWeapon = {
										3054108,
										3054109,
										3054110
									}
								}
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 901,
					preWaves = {
						104
					},
					triggerParams = {}
				},
				{
					triggerType = 3,
					key = true,
					waveIndex = 203,
					preWaves = {
						901
					},
					triggerParams = {
						id = "YANJINCHENXU23-4"
					}
				}
			}
		}
	},
	fleet_prefab = {
		vanguard_unitList = {
			{
				exp = 10,
				configId = 900364,
				tmpID = 900364,
				skinId = 805010,
				oil_at_end = 55,
				id = 1,
				level = 104,
				energy = 10,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 350,
					air = 0,
					antiaircraft = 310,
					torpedo = 500,
					durability = 9000,
					reload = 250,
					armor = 98,
					dodge = 70,
					speed = 31.5,
					luck = 40,
					hit = 140
				},
				skills = {
					{
						id = 200347,
						level = 10
					}
				}
			},
			{
				exp = 10,
				configId = 900363,
				tmpID = 900363,
				skinId = 201360,
				oil_at_end = 55,
				id = 2,
				level = 98,
				energy = 10,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 300,
					air = 0,
					antiaircraft = 310,
					torpedo = 500,
					durability = 5000,
					reload = 250,
					armor = 98,
					dodge = 70,
					speed = 31.5,
					luck = 40,
					hit = 140
				},
				skills = {
					{
						id = 29982,
						level = 10
					}
				}
			},
			{
				exp = 10,
				configId = 900362,
				tmpID = 900362,
				skinId = 202330,
				oil_at_end = 55,
				id = 3,
				level = 102,
				energy = 10,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 300,
					air = 0,
					antiaircraft = 310,
					torpedo = 500,
					durability = 6000,
					reload = 250,
					armor = 98,
					dodge = 70,
					speed = 31.5,
					luck = 40,
					hit = 140
				},
				skills = {
					{
						id = 21062,
						level = 10
					}
				}
			}
		},
		main_unitList = {
			{
				tmpID = 900365,
				configId = 900365,
				skinId = 207070,
				id = 1,
				level = 101,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 500,
					air = 500,
					antiaircraft = 300,
					torpedo = 0,
					durability = 25000,
					reload = 250,
					armor = 0,
					dodge = 30,
					speed = 28.3,
					luck = 20,
					hit = 140
				},
				skills = {
					{
						id = 16450,
						level = 10
					},
					{
						id = 16460,
						level = 10
					},
					{
						id = 16470,
						level = 10
					}
				}
			},
			{
				tmpID = 900366,
				configId = 900366,
				skinId = 205140,
				id = 2,
				level = 109,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 400,
					air = 0,
					antiaircraft = 300,
					torpedo = 0,
					durability = 20000,
					reload = 250,
					armor = 0,
					dodge = 30,
					speed = 28.3,
					luck = 20,
					hit = 140
				},
				skills = {
					{
						id = 16490,
						level = 10
					},
					{
						id = 16500,
						level = 10
					}
				}
			},
			{
				tmpID = 900367,
				configId = 900367,
				skinId = 206020,
				id = 3,
				level = 105,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 0,
					air = 350,
					antiaircraft = 300,
					torpedo = 0,
					durability = 15000,
					reload = 250,
					armor = 0,
					dodge = 30,
					speed = 28.3,
					luck = 20,
					hit = 140
				},
				skills = {
					{
						id = 16510,
						level = 10
					},
					{
						id = 16520,
						level = 10
					}
				}
			}
		}
	}
}
