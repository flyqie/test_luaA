﻿local var_0_0 = {
	"潜艇战斗相关的内容可以点击帮助按钮查看更详细的内容"
}

return {
	id = "NG003",
	events = {
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 0,
				text = var_0_0[1]
			}
		},
		{
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/top/LevelStageView(Clone)/bottom_stage/normal/help_button"
			}
		}
	}
}
