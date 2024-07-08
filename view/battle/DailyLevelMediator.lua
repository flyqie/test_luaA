﻿local var_0_0 = class("DailyLevelMediator", import("..base.ContextMediator"))

var_0_0.ON_STAGE = "DailyLevelMediator:ON_STAGE"
var_0_0.ON_CHALLENGE = "DailyLevelMediator:ON_CHALLENGE"
var_0_0.ON_RESET_CHALLENGE = "DailyLevelMediator:ON_RESET_CHALLENGE"
var_0_0.ON_CONTINUE_CHALLENGE = "DailyLevelMediator:ON_CONTINUE_CHALLENGE"
var_0_0.ON_CHALLENGE_EDIT_FLEET = "DailyLevelMediator:ON_CHALLENGE_EDIT_FLEET"
var_0_0.ON_REQUEST_CHALLENGE = "DailyLevelMediator:ON_REQUEST_CHALLENGE"
var_0_0.ON_CHALLENGE_FLEET_CLEAR = "DailyLevelMediator.ON_CHALLENGE_FLEET_CLEAR"
var_0_0.ON_CHALLENGE_FLEET_RECOMMEND = "DailyLevelMediator.ON_CHALLENGE_FLEET_RECOMMEND"
var_0_0.ON_CHALLENGE_OPEN_DOCK = "DailyLevelMediator:ON_CHALLENGE_OPEN_DOCK"
var_0_0.ON_CHALLENGE_OPEN_RANK = "DailyLevelMediator:ON_CHALLENGE_OPEN_RANK"
var_0_0.ON_QUICK_BATTLE = "DailyLevelMediator:ON_QUICK_BATTLE"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(DailyLevelProxy)

	arg_1_0.viewComponent:setDailyCounts(var_1_0:getRawData())

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:setShips(arg_1_0.ships)

	local var_1_1 = getProxy(PlayerProxy):getData()

	arg_1_0.viewComponent:updateRes(var_1_1)
	arg_1_0:bind(var_0_0.ON_QUICK_BATTLE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:CheckShipExpItemOverflow(arg_2_2, function()
			arg_1_0:sendNotification(GAME.DAILY_LEVEL_QUICK_BATTLE, {
				dailyLevelId = arg_2_1,
				stageId = arg_2_2,
				cnt = arg_2_3
			})
		end)
	end)
	arg_1_0:bind(var_0_0.ON_STAGE, function(arg_4_0, arg_4_1)
		var_1_0.dailyLevelId = arg_1_0.contextData.dailyLevelId

		local var_4_0 = PreCombatLayer
		local var_4_1 = SYSTEM_ROUTINE

		if pg.expedition_data_template[arg_4_1.id].type == Stage.SubmarinStage then
			var_4_0 = PreCombatLayerSubmarine
			var_4_1 = SYSTEM_SUB_ROUTINE
		end

		arg_1_0:addSubLayers(Context.New({
			mediator = PreCombatMediator,
			viewComponent = var_4_0,
			data = {
				stageId = arg_4_1.id,
				system = var_4_1,
				OnConfirm = function(arg_5_0)
					arg_1_0:CheckShipExpItemOverflow(arg_4_1.id, arg_5_0)
				end
			}
		}))
	end)
end

function var_0_0.CheckShipExpItemOverflow(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = pg.expedition_data_template[arg_6_1].award_display

	if _.any(var_6_0, function(arg_7_0)
		local var_7_0 = getProxy(BagProxy):getItemCountById(arg_7_0[2])
		local var_7_1 = Item.getConfigData(arg_7_0[2])

		return arg_7_0[1] == DROP_TYPE_ITEM and var_7_1.type == Item.EXP_BOOK_TYPE and var_7_0 >= var_7_1.max_num
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("player_expResource_mail_fullBag"),
			onYes = arg_6_2,
			weight = LayerWeightConst.THIRD_LAYER
		})
	else
		arg_6_2()
	end
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		PlayerProxy.UPDATED,
		GAME.DAILY_LEVEL_QUICK_BATTLE_DONE,
		GAME.REMOVE_LAYERS
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:updateRes(var_9_1)
	elseif var_9_0 == GAME.DAILY_LEVEL_QUICK_BATTLE_DONE then
		local var_9_2 = var_9_1.awards

		if #var_9_2 > 0 then
			arg_9_0:DisplayAwards(var_9_2)
		end

		local var_9_3 = getProxy(DailyLevelProxy)

		arg_9_0.viewComponent:setDailyCounts(var_9_3:getRawData())
		arg_9_0.viewComponent:UpdateBattleBtn({
			id = var_9_1.stageId
		})
		arg_9_0.viewComponent:UpdateDailyLevelCnt(var_9_1.dailyLevelId)
		arg_9_0.viewComponent:UpdateDailyLevelCntForDescPanel(var_9_1.dailyLevelId)
	elseif var_9_0 == GAME.REMOVE_LAYERS and var_9_1.context.mediator.__cname == "PreCombatMediator" then
		setActive(arg_9_0.viewComponent.blurPanel, true)
	end
end

function var_0_0.DisplayAwards(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			table.insert(var_10_0, iter_10_3)
		end
	end

	arg_10_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_10_0)
end

return var_0_0
