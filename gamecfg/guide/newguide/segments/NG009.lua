﻿local var_0_0 = {
	"点击这里可以查看指挥喵的技能和天赋！",
	"点击这里可以查看指挥喵带来的属性加成！",
	"通过“陪玩”和“天赋”操作可以对指挥喵进行进一步培养，这部分就由指挥官自己去感受吧~"
}

return {
	id = "NG009",
	events = {
		{
			style = {
				dir = -1,
				mode = 1,
				posY = 100,
				posX = 200,
				text = var_0_0[1]
			},
			ui = {
				path = "/UICamera/Canvas/UIMain/CommanderCatUI(Clone)/blur_panel/pages/CommanderDetailUI(Clone)/info/skill_btn",
				triggerType = {
					2
				}
			}
		},
		{
			style = {
				dir = -1,
				mode = 1,
				posY = 100,
				posX = 100,
				text = var_0_0[2]
			},
			ui = {
				path = "/UICamera/Canvas/UIMain/CommanderCatUI(Clone)/blur_panel/pages/CommanderDetailUI(Clone)/info/addition_btn",
				triggerType = {
					2
				}
			}
		},
		{
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = -500,
				text = var_0_0[3]
			}
		}
	}
}
