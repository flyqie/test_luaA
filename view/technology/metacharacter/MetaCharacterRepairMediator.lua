﻿local var_0_0 = class("MetaCharacterRepairMediator", import("...base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.REPAIR_META_CHARACTER_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.REPAIR_META_CHARACTER_DONE then
		arg_3_0.viewComponent:checkSpecialEffect()
		arg_3_0.viewComponent:updateData()
		arg_3_0.viewComponent:doRepairProgressPanelAni()
		arg_3_0.viewComponent:updateAttrItem(arg_3_0.viewComponent.attrTFList[arg_3_0.viewComponent.curAttrName], arg_3_0.viewComponent.curAttrName)
		arg_3_0.viewComponent:updateRepairBtn()
		arg_3_0.viewComponent:updateDetailPanel()
	end
end

return var_0_0
