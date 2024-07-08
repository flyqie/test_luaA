﻿local var_0_0 = class("MainActRefluxBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.InShowTime(arg_1_0)
	return getProxy(RefluxProxy):isActive()
end

function var_0_0.GetUIName(arg_2_0)
	return "MainUIReturnBtn"
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0.event:emit(NewMainMediator.GO_SCENE, SCENE.REFLUX)
end

function var_0_0.OnRegister(arg_4_0)
	arg_4_0.redDot = EffectRedDotNode.New(arg_4_0._tf, {
		pg.RedDotMgr.TYPES.ACT_RETURN
	})

	pg.redDotHelper:AddNode(arg_4_0.redDot)
end

function var_0_0.OnClear(arg_5_0)
	if arg_5_0.redDot then
		pg.redDotHelper:RemoveNode(arg_5_0.redDot)
	end
end

return var_0_0
