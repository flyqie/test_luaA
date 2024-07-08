local var_0_0 = class("ActivityMediator", import("..base.ContextMediator"))

var_0_0.EVENT_GO_SCENE = "event go scene"
var_0_0.EVENT_OPERATION = "event operation"
var_0_0.GO_SHOPS_LAYER = "event go shop layer"
var_0_0.GO_SHOPS_LAYER_STEEET = "event go shop layer in shopstreet"
var_0_0.BATTLE_OPERA = "event difficult sel"
var_0_0.GO_BACKYARD = "event go backyard"
var_0_0.GO_LOTTERY = "event go lottery"
var_0_0.EVENT_COLORING_ACHIEVE = "event coloring achieve"
var_0_0.ON_TASK_SUBMIT = "event on task submit"
var_0_0.ON_TASK_GO = "event on task go"
var_0_0.OPEN_LAYER = "event OPEN_LAYER"
var_0_0.CLOSE_LAYER = "event CLOSE_LAYER"
var_0_0.EVENT_PT_OPERATION = "event pt op"
var_0_0.BLACKWHITEGRID = "black white grid"
var_0_0.MEMORYBOOK = "memory book"
var_0_0.RETURN_AWARD_OP = "event return award op"
var_0_0.SHOW_AWARD_WINDOW = "event show award window"
var_0_0.GO_DODGEM = "event go dodgem"
var_0_0.GO_SUBMARINE_RUN = "event go sumbarine run"
var_0_0.ON_SIMULATION_COMBAT = "event simulation combat"
var_0_0.ON_AIRFIGHT_COMBAT = "event perform airfight combat"
var_0_0.SPECIAL_BATTLE_OPERA = "special battle opera"
var_0_0.NEXT_DISPLAY_AWARD = "next display awards"
var_0_0.GO_PRAY_POOL = "go pray pool"
var_0_0.SELECT_ACTIVITY = "event select activity"
var_0_0.FETCH_INSTARGRAM = "fetch instagram"
var_0_0.MUSIC_GAME_OPERATOR = "get music game final prize"
var_0_0.SHOW_NEXT_ACTIVITY = "show next activity"
var_0_0.OPEN_RED_PACKET_LAYER = "ActivityMediator:OPEN_RED_PACKET_LAYER"
var_0_0.GO_MINI_GAME = "ActivityMediator.GO_MINI_GAME"
var_0_0.GO_DECODE_MINI_GAME = "ActivityMediator:GO_DECODE_MINI_GAME"
var_0_0.ON_BOBING_RESULT = "on bobing result"
var_0_0.ACTIVITY_PERMANENT = "ActivityMediator.ACTIVITY_PERMANENT"
var_0_0.FINISH_ACTIVITY_PERMANENT = "ActivityMediator.FINISH_ACTIVITY_PERMANENT"
var_0_0.ON_SHAKE_BEADS_RESULT = "on shake beads result"
var_0_0.GO_PERFORM_COMBAT = "ActivityMediator.GO_PERFORM_COMBAT"
var_0_0.ON_AWARD_WINDOW = "ActivityMediator:ON_AWARD_WINDOW"
var_0_0.GO_CARDPUZZLE_COMBAT = "ActivityMediator.GO_CARDPUZZLE_COMBAT"
var_0_0.CHARGE = "ActivityMediator.CHARGE"
var_0_0.BUY_ITEM = "ActivityMediator.BUY_ITEM"
var_0_0.OPEN_CHARGE_ITEM_PANEL = "ActivityMediator.OPEN_CHARGE_ITEM_PANEL"
var_0_0.OPEN_CHARGE_BIRTHDAY = "ActivityMediator.OPEN_CHARGE_BIRTHDAY"

function var_0_0.register(arg_1_0)
	arg_1_0.UIAvalibleCallbacks = {}

	arg_1_0:bind(var_0_0.ON_AWARD_WINDOW, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.viewComponent:ShowAwardWindow(arg_2_1, arg_2_2, arg_2_3)
	end)
	arg_1_0:bind(var_0_0.GO_DECODE_MINI_GAME, function(arg_3_0)
		pg.m02:sendNotification(GAME.REQUEST_MINI_GAME, {
			type = MiniGameRequestCommand.REQUEST_HUB_DATA,
			callback = function()
				pg.m02:sendNotification(GAME.GO_MINI_GAME, 11)
			end
		})
	end)
	arg_1_0:bind(var_0_0.GO_MINI_GAME, function(arg_5_0, arg_5_1)
		pg.m02:sendNotification(GAME.GO_MINI_GAME, arg_5_1)
	end)
	arg_1_0:bind(var_0_0.GO_SUBMARINE_RUN, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SUBMARINE_RUN,
			stageId = arg_6_1
		})
	end)
	arg_1_0:bind(var_0_0.GO_DODGEM, function(arg_7_0)
		local var_7_0 = ys.Battle.BattleConfig.BATTLE_DODGEM_STAGES[math.random(#ys.Battle.BattleConfig.BATTLE_DODGEM_STAGES)]

		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_DODGEM,
			stageId = var_7_0
		})
	end)
	arg_1_0:bind(var_0_0.ON_SIMULATION_COMBAT, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_8_1.stageId,
			warnMsg = arg_8_1.warnMsg,
			exitCallback = arg_8_2
		})
	end)
	arg_1_0:bind(var_0_0.ON_AIRFIGHT_COMBAT, function(arg_9_0, arg_9_1, arg_9_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_AIRFIGHT,
			stageId = arg_9_1.stageId,
			exitCallback = arg_9_2
		})
	end)
	arg_1_0:bind(var_0_0.RETURN_AWARD_OP, function(arg_10_0, arg_10_1)
		if arg_10_1.cmd == ActivityConst.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW then
			arg_1_0.viewComponent:ShowWindow(ReturnerAwardWindow, arg_10_1.arg1)
		elseif arg_10_1.cmd == ActivityConst.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW then
			arg_1_0.viewComponent:ShowWindow(TaskAwardWindow, arg_10_1.arg1)
		else
			arg_1_0:sendNotification(GAME.RETURN_AWARD_OP, arg_10_1)
		end
	end)
	arg_1_0:bind(var_0_0.SHOW_AWARD_WINDOW, function(arg_11_0, arg_11_1, arg_11_2)
		arg_1_0.viewComponent:ShowWindow(arg_11_1, arg_11_2)
	end)
	arg_1_0:bind(var_0_0.EVENT_PT_OPERATION, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.ACT_NEW_PT, arg_12_1)
	end)
	arg_1_0:bind(var_0_0.OPEN_LAYER, function(arg_13_0, arg_13_1)
		arg_1_0:addSubLayers(arg_13_1)
	end)
	arg_1_0:bind(var_0_0.OPEN_RED_PACKET_LAYER, function(arg_14_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))
	end)
	arg_1_0:bind(var_0_0.CLOSE_LAYER, function(arg_15_0, arg_15_1)
		local var_15_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_15_1)

		if var_15_0 then
			arg_1_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_15_0
			})
		end
	end)
	arg_1_0:bind(var_0_0.EVENT_OPERATION, function(arg_16_0, arg_16_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_16_1)
	end)
	arg_1_0:bind(var_0_0.EVENT_GO_SCENE, function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_1 == SCENE.SUMMER_FEAST then
			pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI1", function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SUMMER_FEAST)
			end)
		else
			arg_1_0:sendNotification(GAME.GO_SCENE, arg_17_1, arg_17_2)
		end
	end)
	arg_1_0:bind(var_0_0.BLACKWHITEGRID, function()
		if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACKWHITE) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = BlackWhiteGridLayer,
			mediator = BlackWhiteGridMediator
		}))
	end)
	arg_1_0:bind(var_0_0.MEMORYBOOK, function()
		if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = MemoryBookLayer,
			mediator = MemoryBookMediator
		}))
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER, function(arg_21_0, arg_21_1)
		if not getProxy(ActivityProxy):getActivityById(arg_21_1.actId) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_21_1 or {
			warp = NewShopsScene.TYPE_ACTIVITY
		})
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER_STEEET, function(arg_22_0, arg_22_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_22_1 or {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})
	end)
	arg_1_0:bind(var_0_0.BATTLE_OPERA, function()
		local var_23_0 = getProxy(ChapterProxy)
		local var_23_1, var_23_2 = var_23_0:getLastMapForActivity()

		if not var_23_1 or not var_23_0:getMapById(var_23_1):isUnlock() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		else
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
				chapterId = var_23_2,
				mapIdx = var_23_1
			})
		end
	end)
	arg_1_0:bind(var_0_0.SPECIAL_BATTLE_OPERA, function()
		local var_24_0 = getProxy(ChapterProxy)
		local var_24_1, var_24_2 = var_24_0:getLastMapForActivity()

		if not var_24_1 or not var_24_0:getMapById(var_24_1):isUnlock() then
			local var_24_3 = getProxy(ChapterProxy)
			local var_24_4 = var_24_3:getActiveChapter()

			var_24_1 = var_24_4 and var_24_4:getConfig("map")

			if not var_24_4 then
				local var_24_5 = Map.lastMap and var_24_3:getMapById(Map.lastMap)

				if var_24_5 and var_24_5:isUnlock() then
					var_24_1 = Map.lastMap
				else
					var_24_1 = var_24_3:getLastUnlockMap().id
				end
			end

			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
				chapterId = var_24_4 and var_24_4.id,
				mapIdx = var_24_1
			})
		else
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
				chapterId = var_24_2,
				mapIdx = var_24_1
			})
		end
	end)
	arg_1_0:bind(var_0_0.GO_LOTTERY, function(arg_25_0)
		local var_25_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

		arg_1_0:addSubLayers(Context.New({
			mediator = LotteryMediator,
			viewComponent = LotteryLayer,
			data = {
				activityId = var_25_0.id
			}
		}))
	end)
	arg_1_0:bind(var_0_0.GO_BACKYARD, function(arg_26_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)
	end)
	arg_1_0:bind(var_0_0.EVENT_COLORING_ACHIEVE, function(arg_27_0, arg_27_1)
		arg_1_0:sendNotification(GAME.COLORING_ACHIEVE, arg_27_1)
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_28_0, arg_28_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_28_1.id)
	end)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_29_0, arg_29_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_29_1
		})
	end)
	arg_1_0:bind(var_0_0.GO_PRAY_POOL, function(arg_30_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT, {
			goToPray = true
		})
	end)
	arg_1_0:bind(var_0_0.FETCH_INSTARGRAM, function(arg_31_0, ...)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_FETCH, ...)
	end)
	arg_1_0:bind(var_0_0.MUSIC_GAME_OPERATOR, function(arg_32_0, ...)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, ...)
	end)
	arg_1_0:bind(var_0_0.SELECT_ACTIVITY, function(arg_33_0, arg_33_1)
		arg_1_0.viewComponent:verifyTabs(arg_33_1)
	end)
	arg_1_0:bind(var_0_0.SHOW_NEXT_ACTIVITY, function(arg_34_0)
		arg_1_0:showNextActivity()
	end)
	arg_1_0:bind(var_0_0.ACTIVITY_PERMANENT, function(arg_35_0, arg_35_1)
		if PlayerPrefs.GetString("permanent_time", "") ~= pg.gameset.permanent_mark.description then
			PlayerPrefs.SetString("permanent_time", pg.gameset.permanent_mark.description)
			arg_1_0.viewComponent:updateEntrances()
		end

		local var_35_0 = getProxy(ActivityPermanentProxy):getDoingActivity()

		if var_35_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_permanent_tips3"))
			arg_1_0.viewComponent:verifyTabs(var_35_0.id)
		else
			arg_1_0:addSubLayers(Context.New({
				mediator = ActivityPermanentMediator,
				viewComponent = ActivityPermanentLayer,
				data = {
					finishId = arg_35_1
				}
			}))
		end
	end)
	arg_1_0:bind(var_0_0.FINISH_ACTIVITY_PERMANENT, function(arg_36_0)
		local var_36_0 = getProxy(ActivityPermanentProxy):getDoingActivity()

		assert(var_36_0:canPermanentFinish(), "error permanent activity finish")
		arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_FINISH, {
			activity_id = var_36_0.id
		})
	end)
	arg_1_0:bind(var_0_0.GO_PERFORM_COMBAT, function(arg_37_0, arg_37_1, arg_37_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_37_1.stageId,
			memory = arg_37_1.memory
		})
	end)
	arg_1_0:bind(var_0_0.NEXT_DISPLAY_AWARD, function(arg_38_0, arg_38_1, arg_38_2)
		arg_1_0.nextDisplayAwards = arg_38_1
	end)
	arg_1_0:bind(var_0_0.GO_CARDPUZZLE_COMBAT, function(arg_39_0, arg_39_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_CARDPUZZLE,
			combatID = arg_39_1
		})
	end)
	arg_1_0:bind(var_0_0.CHARGE, function(arg_40_0, arg_40_1)
		arg_1_0:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_40_1
		})
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_41_0, arg_41_1, arg_41_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_41_1,
			count = arg_41_2
		})
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_PANEL, function(arg_42_0, arg_42_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_42_1
			}
		}))
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_43_0, arg_43_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))
	end)

	local var_1_0 = getProxy(ActivityProxy)

	arg_1_0.viewComponent:setActivities(var_1_0:getPanelActivities())

	local var_1_1 = getProxy(PlayerProxy):getRawData()

	arg_1_0.viewComponent:setPlayer(var_1_1)

	local var_1_2 = getProxy(BayProxy):getShipById(var_1_1.character)

	arg_1_0.viewComponent:setFlagShip(var_1_2)
end

function var_0_0.onUIAvalible(arg_44_0)
	arg_44_0.UIAvalible = true

	_.each(arg_44_0.UIAvalibleCallbacks, function(arg_45_0)
		arg_45_0()
	end)
end

function var_0_0.initNotificationHandleDic(arg_46_0)
	arg_46_0.handleDic = {
		[ActivityProxy.ACTIVITY_ADDED] = function(arg_47_0, arg_47_1)
			local var_47_0 = arg_47_1:getBody()

			if var_47_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LOTTERY then
				return
			end

			arg_47_0.viewComponent:updateActivity(var_47_0)

			if ActivityConst.AOERLIANG_TASK_ID == var_47_0.id then
				arg_47_0.viewComponent:update_task_list_auto_aoerliang(var_47_0)
			end
		end,
		[ActivityProxy.ACTIVITY_UPDATED] = function(...)
			arg_46_0.handleDic[ActivityProxy.ACTIVITY_ADDED](...)
		end,
		[ActivityProxy.ACTIVITY_DELETED] = function(arg_49_0, arg_49_1)
			local var_49_0 = arg_49_1:getBody()

			arg_49_0.viewComponent:removeActivity(var_49_0)
		end,
		[ActivityProxy.ACTIVITY_OPERATION_DONE] = function(arg_50_0, arg_50_1)
			local var_50_0 = arg_50_1:getBody()

			if ActivityConst.AOERLIANG_TASK_ID == var_50_0 then
				return
			end

			if ActivityConst.HOLOLIVE_MORNING_ID == var_50_0 then
				local var_50_1 = arg_50_0.viewComponent.pageDic[ActivityConst.HOLOLIVE_MORNING_ID]
			end

			arg_50_0:showNextActivity()
		end,
		[ActivityProxy.ACTIVITY_SHOW_AWARDS] = function(arg_51_0, arg_51_1)
			local var_51_0 = arg_51_1:getBody()
			local var_51_1 = var_51_0.awards

			if arg_51_0.nextDisplayAwards and #arg_51_0.nextDisplayAwards > 0 then
				for iter_51_0 = 1, #arg_51_0.nextDisplayAwards do
					table.insert(var_51_1, arg_51_0.nextDisplayAwards[iter_51_0])
				end
			end

			arg_51_0.nextDisplayAwards = {}

			arg_51_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_51_1, var_51_0.callback)
		end,
		[ActivityProxy.ACTIVITY_SHOW_BB_RESULT] = function(arg_52_0, arg_52_1)
			local var_52_0 = arg_52_1:getBody()

			arg_52_0.viewComponent:emit(ActivityMediator.ON_BOBING_RESULT, var_52_0)
		end,
		[ActivityProxy.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT] = function(arg_53_0, arg_53_1)
			local var_53_0 = arg_53_1:getBody()
			local var_53_1 = var_53_0.activityID

			arg_53_0.viewComponent.pageDic[var_53_1]:showLotteryAwardResult(var_53_0.awards, var_53_0.number, var_53_0.callback)
		end,
		[ActivityProxy.ACTIVITY_SHOW_SHAKE_BEADS_RESULT] = function(arg_54_0, arg_54_1)
			local var_54_0 = arg_54_1:getBody()

			arg_54_0.viewComponent:emit(ActivityMediator.ON_SHAKE_BEADS_RESULT, var_54_0)
		end,
		[GAME.COLORING_ACHIEVE_DONE] = function(arg_55_0, arg_55_1)
			arg_55_0.viewComponent:playBonusAnim(function()
				local var_56_0 = arg_55_1:getBody()

				arg_55_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_56_0.drops, function()
					arg_55_0.viewComponent:flush_coloring()
				end)
			end)
		end,
		[GAME.SUBMIT_TASK_DONE] = function(arg_58_0, arg_58_1)
			local var_58_0 = arg_58_1:getBody()

			arg_58_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_58_0, function()
				arg_58_0.viewComponent:updateTaskLayers()
			end)
		end,
		[GAME.ACT_NEW_PT_DONE] = function(arg_60_0, arg_60_1)
			local var_60_0 = arg_60_1:getBody()

			arg_60_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_60_0.awards, var_60_0.callback)
		end,
		[GAME.BEGIN_STAGE_DONE] = function(arg_61_0, arg_61_1)
			local var_61_0 = arg_61_1:getBody()

			arg_61_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_61_0)
		end,
		[GAME.RETURN_AWARD_OP_DONE] = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1:getBody()

			arg_62_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_62_0.awards)
		end,
		[VoteProxy.VOTE_ORDER_BOOK_DELETE] = function(arg_63_0, arg_63_1)
			return
		end,
		[VoteProxy.VOTE_ORDER_BOOK_UPDATE] = function(...)
			arg_46_0.handleDic[VoteProxy.VOTE_ORDER_BOOK_DELETE](...)
		end,
		[GAME.REMOVE_LAYERS] = function(arg_65_0, arg_65_1)
			if arg_65_1:getBody().context.mediator == VoteFameHallMediator then
				arg_65_0.viewComponent:updateEntrances()
			end

			arg_65_0.viewComponent:removeLayers()
		end,
		[GAME.MONOPOLY_AWARD_DONE] = function(arg_66_0, arg_66_1)
			local var_66_0 = arg_66_1:getBody()
			local var_66_1 = arg_66_0.viewComponent.pageDic[arg_66_0.viewComponent.activity.id]

			if var_66_1 and var_66_1.activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY and var_66_1.onAward then
				var_66_1:onAward(var_66_0.awards, var_66_0.callback)
			else
				arg_66_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_66_0.awards, var_66_0.callback)
			end
		end,
		[GAME.SEND_MINI_GAME_OP_DONE] = function(arg_67_0, arg_67_1)
			local var_67_0 = arg_67_1:getBody()
			local var_67_1 = {
				function(arg_68_0)
					local var_68_0 = var_67_0.awards

					if #var_68_0 > 0 then
						if arg_67_0.viewComponent then
							arg_67_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_68_0, arg_68_0)
						else
							arg_67_0:emit(BaseUI.ON_ACHIEVE, var_68_0, arg_68_0)
						end
					else
						arg_68_0()
					end
				end
			}

			seriesAsync(var_67_1, function()
				return
			end)
		end,
		[GAME.ACTIVITY_PERMANENT_START_DONE] = function(arg_70_0, arg_70_1)
			local var_70_0 = arg_70_1:getBody()

			arg_70_0.viewComponent:verifyTabs(var_70_0.id)
		end,
		[GAME.ACTIVITY_PERMANENT_FINISH_DONE] = function(arg_71_0, arg_71_1)
			local var_71_0 = arg_71_1:getBody()

			arg_71_0.viewComponent:emit(ActivityMediator.ACTIVITY_PERMANENT, var_71_0.activity_id)
		end,
		[GAME.MEMORYBOOK_UNLOCK_AWARD_DONE] = function(arg_72_0, arg_72_1)
			local var_72_0 = arg_72_1:getBody()

			arg_72_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_72_0.awards)
		end,
		[GAME.LOAD_LAYERS] = function(arg_73_0, arg_73_1)
			local var_73_0 = arg_73_1:getBody()

			arg_73_0.viewComponent:loadLayers()
		end,
		[GAME.CHARGE_SUCCESS] = function(arg_74_0, arg_74_1)
			local var_74_0 = arg_74_1:getBody()

			arg_74_0.viewComponent:updateTaskLayers()

			local var_74_1 = Goods.Create({
				shop_id = var_74_0.shopId
			}, Goods.TYPE_CHARGE)

			arg_74_0.viewComponent:OnChargeSuccess(var_74_1)
		end,
		[GAME.SHOPPING_DONE] = function(arg_75_0, arg_75_1)
			local var_75_0 = arg_75_1:getBody()

			arg_75_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_75_0.awards, function()
				arg_75_0.viewComponent:updateTaskLayers()
			end)
		end,
		[GAME.ACT_MANUAL_SIGN_DONE] = function(arg_77_0, arg_77_1)
			local var_77_0 = arg_77_1:getBody()

			arg_77_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_77_0.awards)
		end
	}
end

function var_0_0.showNextActivity(arg_78_0)
	local var_78_0 = getProxy(ActivityProxy)

	if not var_78_0 then
		return
	end

	local var_78_1 = var_78_0:findNextAutoActivity()

	if var_78_1 then
		if var_78_1.id == ActivityConst.BLACK_FRIDAY_SIGNIN_ACT_ID then
			arg_78_0.contextData.showByNextAct = true

			arg_78_0.viewComponent:verifyTabs(ActivityConst.BLACK_FRIDAY_ACT_ID)
		else
			arg_78_0.viewComponent:verifyTabs(var_78_1.id)
		end

		local var_78_2 = var_78_1:getConfig("type")

		if var_78_2 == ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN then
			arg_78_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = var_78_1.id
			})
		elseif var_78_2 == ActivityConst.ACTIVITY_TYPE_MONTHSIGN then
			local var_78_3 = var_78_1:getSpecialData("reMonthSignDay") ~= nil and 3 or 1

			arg_78_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_78_1.id,
				cmd = var_78_3,
				arg1 = var_78_1:getSpecialData("reMonthSignDay")
			})
		elseif var_78_2 == ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN then
			arg_78_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_78_1.id,
				cmd = var_78_1.data1 < 7 and 1 or 2
			})
		elseif var_78_1.id == ActivityConst.SHADOW_PLAY_ID then
			var_78_1.clientData1 = 1

			arg_78_0:showNextActivity()
		end
	elseif not arg_78_0.viewComponent.activity then
		local var_78_4 = var_78_0:getPanelActivities()
		local var_78_5 = arg_78_0.contextData.id or arg_78_0.contextData.type and checkExist(_.detect(var_78_4, function(arg_79_0)
			return arg_79_0:getConfig("type") == arg_78_0.contextData.type
		end), {
			"id"
		}) or 0

		arg_78_0.viewComponent:verifyTabs(var_78_5)
	end
end

return var_0_0
