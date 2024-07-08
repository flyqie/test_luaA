local var_0_0 = class("LevelMediator2", import("..base.ContextMediator"))

var_0_0.ON_TRACKING = "LevelMediator2:ON_TRACKING"
var_0_0.ON_ELITE_TRACKING = "LevelMediator2:ON_ELITE_TRACKING"
var_0_0.ON_RETRACKING = "LevelMediator2:ON_RETRACKING"
var_0_0.ON_UPDATE_CUSTOM_FLEET = "LevelMediator2:ON_UPDATE_CUSTOM_FLEET"
var_0_0.ON_OP = "LevelMediator2:ON_OP"
var_0_0.ON_STAGE = "LevelMediator2:ON_STAGE"
var_0_0.ON_GO_TO_TASK_SCENE = "LevelMediator2:ON_GO_TO_TASK_SCENE"
var_0_0.ON_OPEN_EVENT_SCENE = "LevelMediator2:ON_OPEN_EVENT_SCENE"
var_0_0.ON_DAILY_LEVEL = "LevelMediator2:ON_DAILY_LEVEL"
var_0_0.ON_OPEN_MILITARYEXERCISE = "LevelMediator2:ON_OPEN_MILLITARYEXERCISE"
var_0_0.ON_OVERRIDE_CHAPTER = "LevelMediator2:ON_OVERRIDE_CHAPTER"
var_0_0.ON_TIME_UP = "LevelMediator2:ON_TIME_UP"
var_0_0.UPDATE_EVENT_LIST = "LevelMediator2:UPDATE_EVENT_LIST"
var_0_0.ON_START = "ON_START"
var_0_0.ON_ENTER_MAINLEVEL = "LevelMediator2:ON_ENTER_MAINLEVEL"
var_0_0.ON_DIDENTER = "LevelMediator2:ON_DIDENTER"
var_0_0.ON_PERFORM_COMBAT = "LevelMediator2.ON_PERFORM_COMBAT"
var_0_0.ON_ELITE_OEPN_DECK = "LevelMediator2:ON_ELITE_OEPN_DECK"
var_0_0.ON_ELITE_CLEAR = "LevelMediator2:ON_ELITE_CLEAR"
var_0_0.ON_ELITE_RECOMMEND = "LevelMediator2:ON_ELITE_RECOMMEND"
var_0_0.ON_ELITE_ADJUSTMENT = "LevelMediator2:ON_ELITE_ADJUSTMENT"
var_0_0.ON_SUPPORT_OPEN_DECK = "LevelMediator2:ON_SUPPORT_OPEN_DECK"
var_0_0.ON_SUPPORT_CLEAR = "LevelMediator2:ON_SUPPORT_CLEAR"
var_0_0.ON_SUPPORT_RECOMMEND = "LevelMediator2:ON_SUPPORT_RECOMMEND"
var_0_0.ON_ACTIVITY_MAP = "LevelMediator2:ON_ACTIVITY_MAP"
var_0_0.GO_ACT_SHOP = "LevelMediator2:GO_ACT_SHOP"
var_0_0.ON_SWITCH_NORMAL_MAP = "LevelMediator2:ON_SWITCH_NORMAL_MAP"
var_0_0.NOTICE_AUTOBOT_ENABLED = "LevelMediator2:NOTICE_AUTOBOT_ENABLED"
var_0_0.ON_EXTRA_RANK = "LevelMediator2:ON_EXTRA_RANK"
var_0_0.ON_STRATEGYING_CHAPTER = "LevelMediator2:ON_STRATEGYING_CHAPTER"
var_0_0.ON_SELECT_COMMANDER = "LevelMediator2:ON_SELECT_COMMANDER"
var_0_0.ON_SELECT_ELITE_COMMANDER = "LevelMediator2:ON_SELECT_ELITE_COMMANDER"
var_0_0.ON_COMMANDER_SKILL = "LevelMediator2:ON_COMMANDER_SKILL"
var_0_0.ON_SHIP_DETAIL = "LevelMediator2:ON_SHIP_DETAIL"
var_0_0.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN = "LevelMediator2:ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN"
var_0_0.GET_REMASTER_TICKETS_DONE = "LevelMediator2:GET_REMASTER_TICKETS_DONE"
var_0_0.ON_FLEET_SHIPINFO = "LevelMediator2:ON_FLEET_SHIPINFO"
var_0_0.ON_STAGE_SHIPINFO = "LevelMediator2:ON_STAGE_SHIPINFO"
var_0_0.ON_SUPPORT_SHIPINFO = "LevelMediator2:ON_SUPPORT_SHIPINFO"
var_0_0.ON_COMMANDER_OP = "LevelMediator2:ON_COMMANDER_OP"
var_0_0.CLICK_CHALLENGE_BTN = "LevelMediator2:CLICK_CHALLENGE_BTN"
var_0_0.ON_SUBMIT_TASK = "LevelMediator2:ON_SUBMIT_TASK"
var_0_0.ON_VOTE_BOOK = "LevelMediator2:ON_VOTE_BOOK"
var_0_0.GET_CHAPTER_DROP_SHIP_LIST = "LevelMediator2:GET_CHAPTER_DROP_SHIP_LIST"
var_0_0.ON_CHAPTER_REMASTER_AWARD = "LevelMediator2:ON_CHAPTER_REMASTER_AWARD"
var_0_0.ENTER_WORLD = "LevelMediator2:ENTER_WORLD"
var_0_0.ON_OPEN_ACT_BOSS_BATTLE = "LevelMediator2:ON_OPEN_ACT_BOSS_BATTLE"
var_0_0.ON_BOSSRUSH_MAP = "LevelMediator2:ON_BOSSRUSH_MAP"
var_0_0.SHOW_ATELIER_BUFF = "LevelMediator2:SHOW_ATELIER_BUFF"
var_0_0.ON_SPITEM_CHANGED = "LevelMediator2:ON_SPITEM_CHANGED"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(PlayerProxy)

	arg_1_0:bind(var_0_0.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})
	end)
	arg_1_0:bind(var_0_0.ON_VOTE_BOOK, function(arg_3_0, arg_3_1)
		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMANDER_OP, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.contextData.commanderOPChapter = arg_4_2

		arg_1_0:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_4_1
		})
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		FormationMediator.onSelectCommander(arg_5_1, arg_5_2)

		arg_1_0.contextData.selectedChapterVO = arg_5_3
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_ELITE_COMMANDER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = getProxy(ChapterProxy)
		local var_6_1 = arg_6_3.id

		arg_1_0.contextData.editEliteChapter = var_6_1

		local var_6_2 = arg_6_3:getEliteFleetCommanders()[arg_6_1] or {}
		local var_6_3

		if var_6_2[arg_6_2] then
			var_6_3 = getProxy(CommanderProxy):getCommanderById(var_6_2[arg_6_2])
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_6_3,
			ignoredIds = {},
			fleetType = CommanderCatScene.FLEET_TYPE_HARD_CHAPTER,
			chapterId = var_6_1,
			onCommander = function(arg_7_0)
				return true
			end,
			onSelected = function(arg_8_0, arg_8_1)
				local var_8_0 = arg_8_0[1]

				arg_1_0:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
					chapterId = var_6_1,
					index = arg_6_1,
					pos = arg_6_2,
					commanderId = var_8_0,
					callback = function()
						arg_8_1()
					end
				})
			end,
			onQuit = function(arg_10_0)
				arg_1_0:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
					chapterId = var_6_1,
					index = arg_6_1,
					pos = arg_6_2,
					callback = function()
						arg_10_0()
					end
				})
			end
		})
	end)
	arg_1_0:RegisterTrackEvent()
	arg_1_0:bind(var_0_0.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.UPDATE_CUSTOM_FLEET, {
			chapterId = arg_12_1.id
		})
	end)
	arg_1_0:bind(var_0_0.ON_OP, function(arg_13_0, arg_13_1)
		arg_1_0:sendNotification(GAME.CHAPTER_OP, arg_13_1)
	end)
	arg_1_0:bind(var_0_0.ON_SWITCH_NORMAL_MAP, function(arg_14_0)
		local var_14_0 = getProxy(ChapterProxy)
		local var_14_1
		local var_14_2 = Map.lastMap and var_14_0:getMapById(Map.lastMap)

		if var_14_2 and var_14_2:isUnlock() and var_14_2:getMapType() == Map.SCENARIO then
			var_14_1 = Map.lastMap
		else
			var_14_1 = var_14_0:getLastUnlockMap().id
		end

		if var_14_1 then
			arg_1_0.viewComponent:setMap(var_14_1)
		end
	end)
	arg_1_0:bind(var_0_0.ON_STAGE, function(arg_15_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChapterPreCombatMediator,
			viewComponent = ChapterPreCombatLayer
		}), false)
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_MILITARYEXERCISE, function()
		if getProxy(ActivityProxy):getMilitaryExerciseActivity() then
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.MILITARYEXERCISE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))
		end
	end)
	arg_1_0:bind(var_0_0.CLICK_CHALLENGE_BTN, function(arg_17_0)
		if LOCK_LIMIT_CHALLENGE then
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CHALLENGE_MAIN_SCENE)
		else
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.LIMIT_CHALLENGE)
		end
	end)
	arg_1_0:bind(var_0_0.ON_DAILY_LEVEL, function(arg_18_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)
	end)
	arg_1_0:bind(var_0_0.ON_GO_TO_TASK_SCENE, function(arg_19_0, arg_19_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.TASK, arg_19_1)
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_EVENT_SCENE, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
	end)
	arg_1_0:bind(var_0_0.ON_OVERRIDE_CHAPTER, function()
		local var_21_0 = arg_1_0.contextData.chapterVO

		getProxy(ChapterProxy):updateChapter(var_21_0)
	end)
	arg_1_0:bind(var_0_0.ON_TIME_UP, function()
		arg_1_0:onTimeUp()
	end)
	arg_1_0:bind(var_0_0.UPDATE_EVENT_LIST, function()
		arg_1_0.viewComponent:addbubbleMsgBox(function(arg_24_0)
			arg_1_0:OnEventUpdate(arg_24_0)
		end)

		local var_23_0 = getProxy(ChapterProxy):getActiveChapter(true)

		if var_23_0 and var_23_0:IsAutoFight() then
			local var_23_1 = pg.GuildMsgBoxMgr.GetInstance()

			if var_23_1:GetShouldShowBattleTip() then
				local var_23_2 = getProxy(GuildProxy):getRawData()
				local var_23_3 = var_23_2 and var_23_2:getWeeklyTask()

				if var_23_3 and var_23_3.id ~= 0 then
					getProxy(ChapterProxy):AddExtendChapterDataTable(var_23_0.id, "ListGuildEventNotify", var_23_3:GetPresonTaskId(), var_23_3:GetPrivateTaskName())
					pg.GuildMsgBoxMgr.GetInstance():CancelShouldShowBattleTip()
				end

				var_23_1:SubmitTask(function(arg_25_0, arg_25_1, arg_25_2)
					if arg_25_0 then
						local var_25_0 = pg.task_data_template[arg_25_2].desc

						getProxy(ChapterProxy):AddExtendChapterDataTable(var_23_0.id, "ListGuildEventAutoReceiveNotify", arg_25_2, var_25_0)
					end
				end)
			end
		else
			arg_1_0.viewComponent:addbubbleMsgBox(function(arg_26_0)
				pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_26_0)
			end)
		end
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_CLEAR, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_1.index
		local var_27_1 = arg_27_1.chapterVO

		var_27_1:clearEliterFleetByIndex(var_27_0)

		local var_27_2 = getProxy(ChapterProxy)

		var_27_2:updateChapter(var_27_1)
		var_27_2:duplicateEliteFleet(var_27_1)
		arg_1_0.viewComponent:RefreshFleetSelectView(var_27_1)
	end)
	arg_1_0:bind(var_0_0.NOTICE_AUTOBOT_ENABLED, function(arg_28_0, arg_28_1)
		arg_1_0:sendNotification(GAME.COMMON_FLAG, {
			flagID = BATTLE_AUTO_ENABLED
		})
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_RECOMMEND, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_1.index
		local var_29_1 = arg_29_1.chapterVO
		local var_29_2 = getProxy(ChapterProxy)

		var_29_2:eliteFleetRecommend(var_29_1, var_29_0)
		var_29_2:updateChapter(var_29_1)
		var_29_2:duplicateEliteFleet(var_29_1)
		arg_1_0.viewComponent:RefreshFleetSelectView(var_29_1)
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_ADJUSTMENT, function(arg_30_0, arg_30_1)
		local var_30_0 = getProxy(ChapterProxy)

		var_30_0:updateChapter(arg_30_1)
		var_30_0:duplicateEliteFleet(arg_30_1)
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_OEPN_DECK, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_1.shipType
		local var_31_1 = arg_31_1.fleetIndex
		local var_31_2 = arg_31_1.shipVO
		local var_31_3 = arg_31_1.fleet
		local var_31_4 = arg_31_1.chapter
		local var_31_5 = arg_31_1.teamType
		local var_31_6 = getProxy(BayProxy):getRawData()
		local var_31_7 = {}

		for iter_31_0, iter_31_1 in pairs(var_31_6) do
			if not ShipType.ContainInLimitBundle(var_31_0, iter_31_1:getShipType()) then
				table.insert(var_31_7, iter_31_0)
			end
		end

		arg_1_0.contextData.editEliteChapter = var_31_4.id

		local var_31_8 = {}

		for iter_31_2, iter_31_3 in pairs(var_31_3) do
			table.insert(var_31_8, iter_31_2.id)
		end

		local var_31_9, var_31_10, var_31_11 = arg_1_0:getDockCallbackFuncs(var_31_3, var_31_2, var_31_4, var_31_1)

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMax = 1,
			useBlackBlock = true,
			selectedMin = 0,
			energyDisplay = true,
			ignoredIds = var_31_7,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_31_2 ~= nil,
			teamFilter = var_31_5,
			leftTopInfo = i18n("word_formation"),
			onShip = var_31_9,
			confirmSelect = var_31_10,
			onSelected = var_31_11,
			hideTagFlags = setmetatable({
				inElite = var_31_4:getConfig("formation")
			}, {
				__index = ShipStatus.TAG_HIDE_LEVEL
			}),
			otherSelectedIds = var_31_8
		})
	end)
	arg_1_0:bind(var_0_0.ON_SUPPORT_OPEN_DECK, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_1.shipType
		local var_32_1 = arg_32_1.shipVO
		local var_32_2 = arg_32_1.fleet
		local var_32_3 = arg_32_1.chapter
		local var_32_4 = arg_32_1.teamType
		local var_32_5 = getProxy(BayProxy):getRawData()
		local var_32_6 = {}

		for iter_32_0, iter_32_1 in pairs(var_32_5) do
			if not ShipType.ContainInLimitBundle(var_32_0, iter_32_1:getShipType()) then
				table.insert(var_32_6, iter_32_0)
			end
		end

		local var_32_7 = {}

		for iter_32_2, iter_32_3 in pairs(var_32_2) do
			table.insert(var_32_7, iter_32_2.id)
		end

		local var_32_8, var_32_9, var_32_10 = arg_1_0:getSupportDockCallbackFuncs(var_32_2, var_32_1, var_32_3)

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMax = 1,
			useBlackBlock = true,
			selectedMin = 0,
			energyDisplay = true,
			ignoredIds = var_32_6,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_32_1 ~= nil,
			teamFilter = var_32_4,
			leftTopInfo = i18n("word_formation"),
			onShip = var_32_8,
			confirmSelect = var_32_9,
			onSelected = var_32_10,
			hideTagFlags = setmetatable({
				inSupport = var_32_3:getConfig("formation")
			}, {
				__index = ShipStatus.TAG_HIDE_SUPPORT
			}),
			otherSelectedIds = var_32_7
		})

		arg_1_0.contextData.selectedChapterVO = var_32_3
	end)
	arg_1_0:bind(var_0_0.ON_SUPPORT_CLEAR, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_1.index
		local var_33_1 = arg_33_1.chapterVO

		var_33_1:ClearSupportFleetList(var_33_0)

		local var_33_2 = getProxy(ChapterProxy)

		var_33_2:updateChapter(var_33_1)
		var_33_2:duplicateSupportFleet(var_33_1)
		arg_1_0.viewComponent:RefreshFleetSelectView(var_33_1)
	end)
	arg_1_0:bind(var_0_0.ON_SUPPORT_RECOMMEND, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_1.index
		local var_34_1 = arg_34_1.chapterVO
		local var_34_2 = getProxy(ChapterProxy)

		var_34_2:SupportFleetRecommend(var_34_1, var_34_0)
		var_34_2:updateChapter(var_34_1)
		var_34_2:duplicateSupportFleet(var_34_1)
		arg_1_0.viewComponent:RefreshFleetSelectView(var_34_1)
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_MAP, function()
		local var_35_0 = getProxy(ChapterProxy)
		local var_35_1, var_35_2 = var_35_0:getLastMapForActivity()

		if not var_35_1 or not var_35_0:getMapById(var_35_1):isUnlock() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		arg_1_0.viewComponent:ShowSelectedMap(var_35_1, function()
			if var_35_2 then
				local var_36_0 = var_35_0:getChapterById(var_35_2)

				arg_1_0.viewComponent:switchToChapter(var_36_0)
			end
		end)
	end)
	arg_1_0:bind(var_0_0.ON_BOSSRUSH_MAP, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)
	end)
	arg_1_0:bind(var_0_0.GO_ACT_SHOP, function()
		local var_38_0 = pg.gameset.activity_res_id.key_value
		local var_38_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

		if var_38_1 and var_38_1:getConfig("config_client").resId == var_38_0 and not var_38_1:isEnd() then
			arg_1_0:addSubLayers(Context.New({
				mediator = LotteryMediator,
				viewComponent = LotteryLayer,
				data = {
					activityId = var_38_1.id
				}
			}), false)
		else
			local var_38_2 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_39_0)
				return arg_39_0:getConfig("config_client").pt_id == var_38_0
			end)
			local var_38_3 = var_38_2 and var_38_2.id

			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = var_38_3
			})
		end
	end)
	arg_1_0:bind(var_0_0.SHOW_ATELIER_BUFF, function(arg_40_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = AtelierBuffMediator,
			viewComponent = AtelierBuffLayer
		}))
	end)
	arg_1_0:bind(var_0_0.ON_SHIP_DETAIL, function(arg_41_0, arg_41_1)
		arg_1_0.contextData.selectedChapterVO = arg_41_1.chapter

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_41_1.id
		})
	end)
	arg_1_0:bind(var_0_0.ON_FLEET_SHIPINFO, function(arg_42_0, arg_42_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_42_1.shipId,
			shipVOs = arg_42_1.shipVOs
		})

		arg_1_0.contextData.editEliteChapter = arg_42_1.chapter.id
	end)
	arg_1_0:bind(var_0_0.ON_SUPPORT_SHIPINFO, function(arg_43_0, arg_43_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_43_1.shipId,
			shipVOs = arg_43_1.shipVOs
		})

		arg_1_0.contextData.selectedChapterVO = arg_43_1.chapter
	end)
	arg_1_0:bind(var_0_0.ON_STAGE_SHIPINFO, function(arg_44_0, arg_44_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_44_1.shipId,
			shipVOs = arg_44_1.shipVOs
		})
	end)
	arg_1_0:bind(var_0_0.ON_EXTRA_RANK, function(arg_45_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_EXTRA_CHAPTER
		})
	end)
	arg_1_0:bind(var_0_0.ON_STRATEGYING_CHAPTER, function(arg_46_0)
		local var_46_0 = getProxy(ChapterProxy)
		local var_46_1 = var_46_0:getActiveChapter()

		assert(var_46_1)

		local var_46_2 = var_46_0:getMapById(var_46_1:getConfig("map"))

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_forward",
			content = i18n("levelScene_chapter_is_activation", string.split(var_46_2:getConfig("name"), "|")[1] .. ":" .. var_46_1:getConfig("chapter_name")),
			onYes = function()
				arg_1_0.viewComponent:switchToChapter(var_46_1)
			end,
			onNo = function()
				arg_1_0.contextData.chapterVO = var_46_1

				arg_1_0.viewComponent:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpRetreat,
					exittype = ChapterConst.ExitFromMap
				})
			end,
			onClose = function()
				return
			end,
			noBtnType = pg.MsgboxMgr.BUTTON_RETREAT
		})
	end)
	arg_1_0:bind(var_0_0.ON_COMMANDER_SKILL, function(arg_50_0, arg_50_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_50_1
			}
		}))
	end)
	arg_1_0:bind(var_0_0.ON_PERFORM_COMBAT, function(arg_51_0, arg_51_1, arg_51_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_51_1,
			exitCallback = arg_51_2
		})
	end)
	arg_1_0:bind(var_0_0.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN, function(arg_52_0)
		arg_1_0:sendNotification(GAME.GET_REMASTER_TICKETS)
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_53_0, arg_53_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_53_1)
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_54_0)
		local var_54_0 = getProxy(ChapterProxy):getActiveChapter()

		assert(var_54_0)

		local var_54_1 = var_54_0.fleet
		local var_54_2 = var_54_0:getStageId(var_54_1.line.row, var_54_1.line.column)

		seriesAsync({
			function(arg_55_0)
				local var_55_0 = {}

				for iter_55_0, iter_55_1 in pairs(var_54_1.ships) do
					table.insert(var_55_0, iter_55_1)
				end

				Fleet.EnergyCheck(var_55_0, var_54_1.name, function(arg_56_0)
					if arg_56_0 then
						arg_55_0()
					end
				end, function(arg_57_0)
					if not arg_57_0 then
						getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.SHIP_ENERGY_LOW)
					end
				end)
			end,
			function(arg_58_0)
				if getProxy(PlayerProxy):getRawData():GoldMax(1) then
					local var_58_0 = i18n("gold_max_tip_title") .. i18n("resource_max_tip_battle")

					getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.GOLD_MAX)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = var_58_0,
						onYes = arg_58_0,
						weight = LayerWeightConst.SECOND_LAYER
					})
				else
					arg_58_0()
				end
			end,
			function(arg_59_0)
				arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_SCENARIO,
					stageId = var_54_2
				})
			end
		})
	end)
	arg_1_0:bind(arg_1_0.ON_ENTER_MAINLEVEL, function(arg_60_0, arg_60_1)
		arg_1_0:DidEnterLevelMainUI(arg_60_1)
	end)
	arg_1_0:bind(arg_1_0.ON_DIDENTER, function(arg_61_0)
		arg_1_0.viewComponent:emit(LevelMediator2.UPDATE_EVENT_LIST)
	end)
	arg_1_0:bind(var_0_0.ENTER_WORLD, function(arg_62_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.WORLD)
	end)
	arg_1_0:bind(var_0_0.ON_CHAPTER_REMASTER_AWARD, function(arg_63_0, arg_63_1, arg_63_2)
		arg_1_0:sendNotification(GAME.CHAPTER_REMASTER_AWARD_RECEIVE, {
			chapterId = arg_63_1,
			pos = arg_63_2
		})
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_ACT_BOSS_BATTLE, function(arg_64_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ACT_BOSS_BATTLE, {
			showAni = true
		})
	end)
	arg_1_0:bind(LevelUIConst.OPEN_NORMAL_CONTINUOUS_WINDOW, function(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
		local var_65_0 = _.map(arg_65_2, function(arg_66_0)
			local var_66_0 = getProxy(FleetProxy):getFleetById(arg_66_0)

			if not var_66_0 or var_66_0:getFleetType() == FleetType.Submarine then
				return
			end

			return var_66_0
		end)

		arg_1_0:DisplayContinuousWindow(arg_65_1, var_65_0, arg_65_3, arg_65_4)
	end)
	arg_1_0:bind(LevelUIConst.OPEN_ELITE_CONTINUOUS_WINDOW, function(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
		local var_67_0 = arg_67_1:getEliteFleetList()
		local var_67_1 = getProxy(BayProxy):getRawData()
		local var_67_2 = _.map(var_67_0, function(arg_68_0)
			if #arg_68_0 == 0 or _.any(arg_68_0, function(arg_69_0)
				local var_69_0 = var_67_1[arg_69_0]

				return var_69_0 and var_69_0:getTeamType() == TeamType.Submarine
			end) then
				return
			end

			return TypedFleet.New({
				fleetType = FleetType.Normal,
				ship_list = arg_68_0
			})
		end)

		arg_1_0:DisplayContinuousWindow(arg_67_1, var_67_2, arg_67_2, arg_67_3)
	end)

	arg_1_0.player = var_1_0:getData()

	arg_1_0.viewComponent:updateRes(arg_1_0.player)

	local var_1_1 = getProxy(EventProxy)

	arg_1_0.viewComponent:updateEvent(var_1_1)

	local var_1_2 = getProxy(FleetProxy):GetRegularFleets()

	arg_1_0.viewComponent:updateFleet(var_1_2)

	local var_1_3 = getProxy(BayProxy)

	arg_1_0.viewComponent:setShips(var_1_3:getRawData())

	local var_1_4 = getProxy(ActivityProxy)

	arg_1_0.viewComponent:updateVoteBookBtn()

	local var_1_5 = getProxy(CommanderProxy):getPrefabFleet()

	arg_1_0.viewComponent:setCommanderPrefabs(var_1_5)

	local var_1_6 = var_1_4:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK)

	for iter_1_0, iter_1_1 in ipairs(var_1_6) do
		if iter_1_1:getConfig("config_id") == pg.gameset.activity_res_id.key_value then
			arg_1_0.viewComponent:updatePtActivity(iter_1_1)

			break
		end
	end

	local var_1_7 = getProxy(DailyLevelProxy)

	arg_1_0.viewComponent:setEliteQuota(var_1_7.eliteCount, pg.gameset.elite_quota.key_value)
	getProxy(ChapterProxy):updateActiveChapterShips()

	local var_1_8 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)

	arg_1_0.viewComponent:setSpecialOperationTickets(var_1_8)
end

function var_0_0.DidEnterLevelMainUI(arg_70_0, arg_70_1)
	arg_70_0.viewComponent:setMap(arg_70_1)

	local var_70_0 = arg_70_0.contextData.chapterVO

	if var_70_0 and var_70_0.active then
		arg_70_0.viewComponent:switchToChapter(var_70_0)
	elseif arg_70_0.contextData.map:isSkirmish() then
		arg_70_0.viewComponent:ShowCurtains(true)
		arg_70_0.viewComponent:doPlayAnim("TV01", function(arg_71_0)
			go(arg_71_0):SetActive(false)
			arg_70_0.viewComponent:ShowCurtains(false)
		end)
	end

	if arg_70_0.contextData.preparedTaskList and #arg_70_0.contextData.preparedTaskList > 0 then
		for iter_70_0, iter_70_1 in ipairs(arg_70_0.contextData.preparedTaskList) do
			arg_70_0:sendNotification(GAME.SUBMIT_TASK, iter_70_1)
		end

		table.clean(arg_70_0.contextData.preparedTaskList)
	end

	if arg_70_0.contextData.StopAutoFightFlag then
		local var_70_1 = getProxy(ChapterProxy)
		local var_70_2 = var_70_1:getActiveChapter()

		if var_70_2 then
			var_70_1:SetChapterAutoFlag(var_70_2.id, false)

			local var_70_3 = bit.bor(ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

			arg_70_0.viewComponent:updateChapterVO(var_70_2, var_70_3)
		end

		arg_70_0.contextData.StopAutoFightFlag = nil
	end

	if arg_70_0.contextData.ToTrackingData then
		arg_70_0:sendNotification(arg_70_0.contextData.ToTrackingData[1], arg_70_0.contextData.ToTrackingData[2])

		arg_70_0.contextData.ToTrackingData = nil
	end
end

function var_0_0.RegisterTrackEvent(arg_72_0)
	arg_72_0:bind(var_0_0.ON_TRACKING, function(arg_73_0, arg_73_1, arg_73_2, arg_73_3, arg_73_4, arg_73_5)
		local var_73_0 = getProxy(ChapterProxy):getChapterById(arg_73_1, true)
		local var_73_1 = getProxy(ChapterProxy):GetLastFleetIndex()

		arg_72_0:sendNotification(GAME.TRACKING, {
			chapterId = arg_73_1,
			fleetIds = var_73_1,
			loopFlag = arg_73_2,
			operationItem = arg_73_3,
			duties = arg_73_4,
			autoFightFlag = arg_73_5
		})
	end)
	arg_72_0:bind(var_0_0.ON_ELITE_TRACKING, function(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
		arg_72_0:sendNotification(GAME.TRACKING, {
			chapterId = arg_74_1,
			loopFlag = arg_74_2,
			operationItem = arg_74_3,
			duties = arg_74_4,
			autoFightFlag = arg_74_5
		})
	end)
	arg_72_0:bind(var_0_0.ON_RETRACKING, function(arg_75_0, arg_75_1, arg_75_2)
		local var_75_0 = arg_75_1.duties
		local var_75_1 = arg_75_1:getConfig("type") == Chapter.CustomFleet
		local var_75_2 = arg_75_1:GetActiveSPItemID()

		if var_75_1 then
			arg_72_0.viewComponent:emit(LevelMediator2.ON_ELITE_TRACKING, arg_75_1.id, arg_75_1.loopFlag, var_75_2, var_75_0, arg_75_2)
		else
			arg_72_0.viewComponent:emit(LevelMediator2.ON_TRACKING, arg_75_1.id, arg_75_1.loopFlag, var_75_2, var_75_0, arg_75_2)
		end
	end)
end

function var_0_0.NoticeVoteBook(arg_76_0, arg_76_1)
	arg_76_1()
end

function var_0_0.TryPlaySubGuide(arg_77_0)
	arg_77_0.viewComponent:tryPlaySubGuide()
end

function var_0_0.listNotificationInterests(arg_78_0)
	return {
		ChapterProxy.CHAPTER_UPDATED,
		ChapterProxy.CHAPTER_TIMESUP,
		PlayerProxy.UPDATED,
		DailyLevelProxy.ELITE_QUOTA_UPDATE,
		var_0_0.ON_TRACKING,
		var_0_0.ON_ELITE_TRACKING,
		var_0_0.ON_RETRACKING,
		GAME.TRACKING_DONE,
		GAME.TRACKING_ERROR,
		GAME.CHAPTER_OP_DONE,
		GAME.EVENT_LIST_UPDATE,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUB_CHAPTER_REFRESH_DONE,
		GAME.SUB_CHAPTER_FETCH_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COOMMANDER_EQUIP_TO_FLEET_DONE,
		GAME.COMMANDER_ELIT_FORMATION_OP_DONE,
		GAME.SUBMIT_TASK_DONE,
		LevelUIConst.CONTINUOUS_OPERATION,
		var_0_0.ON_SPITEM_CHANGED,
		GAME.GET_REMASTER_TICKETS_DONE,
		VoteProxy.VOTE_ORDER_BOOK_DELETE,
		VoteProxy.VOTE_ORDER_BOOK_UPDATE,
		GAME.VOTE_BOOK_BE_UPDATED_DONE,
		BagProxy.ITEM_UPDATED,
		ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED,
		ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED,
		ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED,
		GAME.CHAPTER_REMASTER_INFO_REQUEST_DONE,
		GAME.CHAPTER_REMASTER_AWARD_RECEIVE_DONE,
		GAME.STORY_UPDATE_DONE,
		GAME.STORY_END
	}
end

function var_0_0.handleNotification(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_1:getName()
	local var_79_1 = arg_79_1:getBody()

	if var_79_0 == GAME.BEGIN_STAGE_DONE then
		arg_79_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_79_1)
	elseif var_79_0 == VoteProxy.VOTE_ORDER_BOOK_DELETE or VoteProxy.VOTE_ORDER_BOOK_UPDATE == var_79_0 then
		arg_79_0.viewComponent:updateVoteBookBtn()
	elseif var_79_0 == PlayerProxy.UPDATED then
		arg_79_0.viewComponent:updateRes(var_79_1)
	elseif var_79_0 == var_0_0.ON_TRACKING or var_79_0 == var_0_0.ON_ELITE_TRACKING or var_79_0 == var_0_0.ON_RETRACKING then
		arg_79_0.viewComponent:emit(var_79_0, unpackEx(var_79_1))
	elseif var_79_0 == GAME.TRACKING_DONE then
		arg_79_0.waitingTracking = nil

		arg_79_0.viewComponent:resetLevelGrid()

		arg_79_0.viewComponent.FirstEnterChapter = var_79_1.id

		arg_79_0.viewComponent:switchToChapter(var_79_1, function()
			arg_79_0:loadSubState(var_79_1.subAutoAttack)
		end)
	elseif var_79_0 == ChapterProxy.CHAPTER_UPDATED then
		arg_79_0.viewComponent:updateChapterVO(var_79_1.chapter, var_79_1.dirty)
	elseif var_79_0 == GAME.COMMANDER_ELIT_FORMATION_OP_DONE then
		if arg_79_0.contextData.commanderOPChapter then
			local var_79_2 = getProxy(ChapterProxy):getChapterById(var_79_1.chapterId)

			arg_79_0.contextData.commanderOPChapter.eliteCommanderList = var_79_2.eliteCommanderList

			arg_79_0.viewComponent:RefreshFleetSelectView(arg_79_0.contextData.commanderOPChapter)
		end
	elseif var_79_0 == GAME.CHAPTER_OP_DONE then
		local var_79_3

		local function var_79_4()
			if var_79_3 and coroutine.status(var_79_3) == "suspended" then
				local var_81_0, var_81_1 = coroutine.resume(var_79_3)

				assert(var_81_0, debug.traceback(var_79_3, var_81_1))
			end
		end

		var_79_3 = coroutine.create(function()
			local var_82_0 = var_79_1.type
			local var_82_1 = arg_79_0.contextData.chapterVO
			local var_82_2 = var_82_1:IsAutoFight()

			if var_82_0 == ChapterConst.OpRetreat and not var_79_1.id then
				var_82_1 = var_79_1.finalChapterLevelData

				if var_79_1.exittype and var_79_1.exittype == ChapterConst.ExitFromMap then
					arg_79_0.viewComponent:setChapter(nil)
					arg_79_0.viewComponent:updateChapterTF(var_82_1.id)
					arg_79_0:OnExitChapter(var_82_1, var_79_1.win, var_79_1.extendData)

					return
				end

				if var_82_1:existOni() then
					local var_82_3 = var_82_1:checkOniState()

					if var_82_3 then
						arg_79_0.viewComponent:displaySpResult(var_82_3, var_79_4)
						coroutine.yield()
					end
				end

				if var_82_1:isPlayingWithBombEnemy() then
					arg_79_0.viewComponent:displayBombResult(var_79_4)
					coroutine.yield()
				end
			end

			local var_82_4 = var_79_1.items
			local var_82_5

			if var_82_4 and #var_82_4 > 0 then
				if var_82_0 == ChapterConst.OpBox then
					local var_82_6 = var_82_1.fleet.line
					local var_82_7 = var_82_1:getChapterCell(var_82_6.row, var_82_6.column)

					if pg.box_data_template[var_82_7.attachmentId].type == ChapterConst.BoxDrop and ChapterConst.IsAtelierMap(arg_79_0.contextData.map) then
						local var_82_8 = _.filter(var_82_4, function(arg_83_0)
							return arg_83_0.type == DROP_TYPE_RYZA_DROP
						end)

						if #var_82_8 > 0 then
							var_82_5 = AwardInfoLayer.TITLE.RYZA

							local var_82_9 = math.random(#var_82_8)
							local var_82_10 = AtelierMaterial.New({
								configId = var_82_8[var_82_9].id
							}):GetVoices()

							if var_82_10 and #var_82_10 > 0 then
								local var_82_11 = var_82_10[math.random(#var_82_10)]
								local var_82_12, var_82_13, var_82_14 = ShipWordHelper.GetWordAndCV(var_82_11[1], var_82_11[2], nil, PLATFORM_CODE ~= PLATFORM_US)

								arg_79_0.viewComponent:emit(LevelUIConst.ADD_TOAST_QUEUE, {
									iconScale = 0.75,
									Class = LevelStageAtelierMaterialToast,
									title = i18n("ryza_tip_toast_item_got"),
									desc = var_82_14,
									voice = var_82_13,
									icon = var_82_11[3]
								})
							end
						end
					end
				end

				seriesAsync({
					function(arg_84_0)
						getProxy(ChapterProxy):AddExtendChapterDataArray(var_82_1.id, "TotalDrops", _.filter(var_82_4, function(arg_85_0)
							return arg_85_0.type ~= DROP_TYPE_STRATEGY
						end))
						arg_79_0.viewComponent:emit(BaseUI.ON_WORLD_ACHIEVE, {
							items = var_82_4,
							title = var_82_5,
							closeOnCompleted = var_82_2,
							removeFunc = arg_84_0
						})
					end,
					function(arg_86_0)
						if var_82_0 == ChapterConst.OpBox and _.any(var_82_4, function(arg_87_0)
							if arg_87_0.type ~= DROP_TYPE_VITEM then
								return false
							end

							return arg_87_0:getConfig("virtual_type") == 1
						end) then
							(function()
								local var_88_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

								if not var_88_0 then
									return
								end

								local var_88_1 = pg.activity_event_picturepuzzle[var_88_0.id]

								if not var_88_1 then
									return
								end

								if #table.mergeArray(var_88_0.data1_list, var_88_0.data2_list, true) < #var_88_1.pickup_picturepuzzle + #var_88_1.drop_picturepuzzle then
									return
								end

								local var_88_2 = var_88_0:getConfig("config_client").comStory

								pg.NewStoryMgr.GetInstance():Play(var_88_2, arg_86_0)
							end)()
						end

						if _.any(var_82_4, function(arg_89_0)
							if arg_89_0.type ~= DROP_TYPE_STRATEGY then
								return false
							end

							return pg.strategy_data_template[arg_89_0.id].type == ChapterConst.StgTypeConsume
						end) then
							arg_79_0.viewComponent.levelStageView:popStageStrategy()
						end

						arg_86_0()
					end
				}, var_79_4)
				coroutine.yield()
			end

			assert(var_82_1)

			if var_82_0 == ChapterConst.OpSkipBattle or var_82_0 == ChapterConst.OpPreClear then
				arg_79_0.viewComponent.levelStageView:tryAutoAction(function()
					if not arg_79_0.viewComponent.levelStageView then
						return
					end

					arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
				end)
			elseif var_82_0 == ChapterConst.OpRetreat then
				local var_82_15 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

				if var_82_15 then
					local var_82_16 = {}
					local var_82_17 = var_82_15:getContextByMediator(ChapterPreCombatMediator)

					if var_82_17 then
						table.insert(var_82_16, var_82_17)
					end

					_.each(var_82_16, function(arg_91_0)
						arg_79_0:sendNotification(GAME.REMOVE_LAYERS, {
							context = arg_91_0
						})
					end)
				end

				if var_79_1.id then
					getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)

					return
				end

				local var_82_18 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN)

				if var_82_18 and not var_82_18.autoActionForbidden and not var_82_18.achieved and var_82_18.data1 == 7 and var_82_1.id == 204 and var_82_1:isClear() then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						hideNo = true,
						content = "有新的签到奖励可以领取，点击确定前往",
						onYes = function()
							arg_79_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)
						end,
						onNo = function()
							arg_79_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)
						end
					})

					return
				end

				arg_79_0:OnExitChapter(var_82_1, var_79_1.win, var_79_1.extendData)
			elseif var_82_0 == ChapterConst.OpMove then
				seriesAsync({
					function(arg_94_0)
						var_82_1 = arg_79_0.contextData.chapterVO

						local var_94_0 = var_79_1.fullpath[#var_79_1.fullpath]

						var_82_1.fleet.line = Clone(var_94_0)

						getProxy(ChapterProxy):updateChapter(var_82_1)
						arg_79_0.viewComponent.grid:moveFleet(var_79_1.path, var_79_1.fullpath, var_79_1.oldLine, arg_94_0)
					end,
					function(arg_95_0)
						if not var_79_1.teleportPaths then
							arg_95_0()

							return
						end

						local var_95_0 = var_79_1.teleportPaths[1]
						local var_95_1 = var_79_1.teleportPaths[2]

						if not var_95_0 or not var_95_1 then
							arg_95_0()

							return
						end

						var_82_1 = arg_79_0.contextData.chapterVO

						local var_95_2 = var_82_1:getFleet(FleetType.Normal, var_95_0.row, var_95_0.column)

						if not var_95_2 then
							arg_95_0()

							return
						end

						var_95_2.line = Clone(var_79_1.teleportPaths[2])

						getProxy(ChapterProxy):updateChapter(var_82_1)

						local var_95_3 = arg_79_0:getViewComponent().grid:GetCellFleet(var_95_2.id)

						arg_79_0:getViewComponent().grid:TeleportCellByPortalWithCameraMove(var_95_2, var_95_3, var_79_1.teleportPaths, arg_95_0)
					end,
					function(arg_96_0)
						arg_79_0:playAIActions(var_79_1.aiActs, var_79_1.extraFlag, arg_96_0)
					end
				}, function()
					var_82_1 = arg_79_0.contextData.chapterVO

					local var_97_0 = var_82_1.fleet:getStrategies()

					if _.any(var_97_0, function(arg_98_0)
						return arg_98_0.id == ChapterConst.StrategyExchange and arg_98_0.count > 0
					end) then
						arg_79_0.viewComponent.levelStageView:popStageStrategy()
					end

					arg_79_0.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)
					arg_79_0.viewComponent.levelStageView:updateAmbushRate(var_82_1.fleet.line, true)
					arg_79_0.viewComponent.levelStageView:updateStageStrategy()
					arg_79_0.viewComponent.levelStageView:updateFleetBuff()
					arg_79_0.viewComponent.levelStageView:updateBombPanel()
					arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
				end)
			elseif var_82_0 == ChapterConst.OpAmbush then
				arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_82_0 == ChapterConst.OpBox then
				arg_79_0:playAIActions(var_79_1.aiActs, var_79_1.extraFlag, function()
					if not arg_79_0.viewComponent.levelStageView then
						return
					end

					arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
				end)
			elseif var_82_0 == ChapterConst.OpStory then
				arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_82_0 == ChapterConst.OpSwitch then
				arg_79_0.viewComponent.grid:adjustCameraFocus()
			elseif var_82_0 == ChapterConst.OpEnemyRound then
				arg_79_0:playAIActions(var_79_1.aiActs, var_79_1.extraFlag, function()
					arg_79_0.viewComponent.levelStageView:updateBombPanel(true)

					local var_100_0 = var_82_1.fleet:getStrategies()

					if _.any(var_100_0, function(arg_101_0)
						return arg_101_0.id == ChapterConst.StrategyExchange and arg_101_0.count > 0
					end) then
						arg_79_0.viewComponent.levelStageView:updateStageStrategy()
						arg_79_0.viewComponent.levelStageView:popStageStrategy()
					end

					arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
					arg_79_0.viewComponent:updatePoisonAreaTip()
				end)
			elseif var_82_0 == ChapterConst.OpSubState then
				arg_79_0:saveSubState(var_82_1.subAutoAttack)
				arg_79_0.viewComponent.grid:OnChangeSubAutoAttack()
			elseif var_82_0 == ChapterConst.OpStrategy then
				if var_79_1.arg1 == ChapterConst.StrategyExchange then
					local var_82_19 = var_82_1.fleet:findSkills(FleetSkill.TypeStrategy)

					for iter_82_0, iter_82_1 in ipairs(var_82_19) do
						if iter_82_1:GetType() == FleetSkill.TypeStrategy and iter_82_1:GetArgs()[1] == ChapterConst.StrategyExchange then
							local var_82_20 = var_82_1.fleet:findCommanderBySkillId(iter_82_1.id)

							arg_79_0.viewComponent:doPlayCommander(var_82_20)

							break
						end
					end
				end

				arg_79_0:playAIActions(var_79_1.aiActs, var_79_1.extraFlag, function()
					arg_79_0.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)
				end)
			elseif var_82_0 == ChapterConst.OpSupply then
				arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_82_0 == ChapterConst.OpBarrier then
				arg_79_0.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_82_0 == ChapterConst.OpSubTeleport then
				seriesAsync({
					function(arg_103_0)
						local var_103_0 = _.detect(var_82_1.fleets, function(arg_104_0)
							return arg_104_0.id == var_79_1.id
						end)

						var_103_0.line = {
							row = var_79_1.arg1,
							column = var_79_1.arg2
						}
						var_103_0.startPos = {
							row = var_79_1.arg1,
							column = var_79_1.arg2
						}

						local var_103_1 = var_79_1.fullpath[1]
						local var_103_2 = var_79_1.fullpath[#var_79_1.fullpath]
						local var_103_3 = var_82_1:findPath(nil, var_103_1, var_103_2)
						local var_103_4 = pg.strategy_data_template[ChapterConst.StrategySubTeleport].arg[2]
						local var_103_5 = math.ceil(var_103_4 * #var_103_0:getShips(false) * var_103_3 - 1e-05)
						local var_103_6 = getProxy(PlayerProxy)
						local var_103_7 = var_103_6:getData()

						var_103_7:consume({
							oil = var_103_5
						})
						arg_79_0.viewComponent:updateRes(var_103_7)
						var_103_6:updatePlayer(var_103_7)
						arg_79_0.viewComponent.grid:moveSub(table.indexof(var_82_1.fleets, var_103_0), var_79_1.fullpath, nil, function()
							local var_105_0 = bit.bor(ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampionPosition)

							getProxy(ChapterProxy):updateChapter(var_82_1, var_105_0)

							var_82_1 = arg_79_0.contextData.chapterVO

							arg_103_0()
						end)
					end,
					function(arg_106_0)
						if not var_79_1.teleportPaths then
							arg_106_0()

							return
						end

						local var_106_0 = var_79_1.teleportPaths[1]
						local var_106_1 = var_79_1.teleportPaths[2]

						if not var_106_0 or not var_106_1 then
							arg_106_0()

							return
						end

						local var_106_2 = _.detect(var_82_1.fleets, function(arg_107_0)
							return arg_107_0.id == var_79_1.id
						end)

						var_106_2.startPos = Clone(var_79_1.teleportPaths[2])
						var_106_2.line = Clone(var_79_1.teleportPaths[2])

						local var_106_3 = arg_79_0:getViewComponent().grid:GetCellFleet(var_106_2.id)

						arg_79_0:getViewComponent().grid:TeleportFleetByPortal(var_106_3, var_79_1.teleportPaths, function()
							local var_108_0 = bit.bor(ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampionPosition)

							getProxy(ChapterProxy):updateChapter(var_82_1, var_108_0)

							var_82_1 = arg_79_0.contextData.chapterVO

							arg_106_0()
						end)
					end,
					function(arg_109_0)
						arg_79_0.viewComponent.levelStageView:SwitchBottomStagePanel(false)
						arg_79_0.viewComponent.grid:TurnOffSubTeleport()
						arg_79_0.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)
					end
				})
			end
		end)

		var_79_4()
	elseif var_79_0 == ChapterProxy.CHAPTER_TIMESUP then
		arg_79_0:onTimeUp()
	elseif var_79_0 == GAME.EVENT_LIST_UPDATE then
		arg_79_0.viewComponent:addbubbleMsgBox(function(arg_110_0)
			arg_79_0:OnEventUpdate(arg_110_0)
		end)
	elseif var_79_0 == GAME.VOTE_BOOK_BE_UPDATED_DONE then
		arg_79_0.viewComponent:addbubbleMsgBox(function(arg_111_0)
			arg_79_0:NoticeVoteBook(arg_111_0)
		end)
	elseif var_79_0 == DailyLevelProxy.ELITE_QUOTA_UPDATE then
		local var_79_5 = getProxy(DailyLevelProxy)

		arg_79_0.viewComponent:setEliteQuota(var_79_5.eliteCount, pg.gameset.elite_quota.key_value)
	elseif var_79_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_79_0.viewComponent:updateMapItems()
	elseif var_79_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_79_1 and var_79_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_RANK then
			arg_79_0.viewComponent:updatePtActivity(var_79_1)
		end
	elseif var_79_0 == GAME.GET_REMASTER_TICKETS_DONE then
		arg_79_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_79_1, function()
			arg_79_0.viewComponent:updateRemasterTicket()
		end)
	elseif var_79_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		local var_79_6 = getProxy(CommanderProxy):getPrefabFleet()

		arg_79_0.viewComponent:setCommanderPrefabs(var_79_6)
		arg_79_0.viewComponent:updateCommanderPrefab()
	elseif var_79_0 == GAME.COOMMANDER_EQUIP_TO_FLEET_DONE then
		local var_79_7 = getProxy(FleetProxy):GetRegularFleets()

		arg_79_0.viewComponent:updateFleet(var_79_7)
		arg_79_0.viewComponent:RefreshFleetSelectView()
	elseif var_79_0 == GAME.SUBMIT_TASK_DONE then
		if arg_79_0.contextData.map and arg_79_0.contextData.map:isSkirmish() then
			arg_79_0.viewComponent:updateMapItems()
		end

		arg_79_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_79_1, function()
			if arg_79_0.contextData.map and arg_79_0.contextData.map:isSkirmish() and arg_79_0.contextData.TaskToSubmit then
				local var_113_0 = arg_79_0.contextData.TaskToSubmit

				arg_79_0.contextData.TaskToSubmit = nil

				arg_79_0:sendNotification(GAME.SUBMIT_TASK, var_113_0)
			end
		end)
	elseif var_79_0 == BagProxy.ITEM_UPDATED then
		local var_79_8 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)

		arg_79_0.viewComponent:setSpecialOperationTickets(var_79_8)
	elseif var_79_0 == ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED then
		if not arg_79_0:getViewComponent().levelStageView then
			return
		end

		arg_79_0:getViewComponent().levelStageView:ActionInvoke("UpdateAutoFightMark")
	elseif var_79_0 == ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED then
		if not arg_79_0:getViewComponent().levelStageView then
			return
		end

		arg_79_0:getViewComponent().levelStageView:ActionInvoke("UpdateSkipPreCombatMark")
	elseif var_79_0 == ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED or var_79_0 == GAME.CHAPTER_REMASTER_INFO_REQUEST_DONE then
		arg_79_0.viewComponent:updateRemasterInfo()
		arg_79_0.viewComponent:updateRemasterBtnTip()
	elseif var_79_0 == GAME.CHAPTER_REMASTER_AWARD_RECEIVE_DONE then
		arg_79_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_79_1)
	elseif var_79_0 == GAME.STORY_UPDATE_DONE then
		arg_79_0.cachedStoryAwards = var_79_1
	elseif var_79_0 == GAME.STORY_END then
		if arg_79_0.cachedStoryAwards then
			arg_79_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_79_0.cachedStoryAwards.awards)

			arg_79_0.cachedStoryAwards = nil
		end
	elseif var_79_0 == LevelUIConst.CONTINUOUS_OPERATION then
		arg_79_0.viewComponent:emit(LevelUIConst.CONTINUOUS_OPERATION, var_79_1)
	elseif var_79_0 == GAME.TRACKING_ERROR then
		if arg_79_0.waitingTracking then
			arg_79_0:DisplayContinuousOperationResult(var_79_1.chapter, getProxy(ChapterProxy):PopContinuousData(SYSTEM_SCENARIO))
		end

		arg_79_0.waitingTracking = nil
	elseif var_79_0 == var_0_0.ON_SPITEM_CHANGED then
		arg_79_0.viewComponent:emit(var_0_0.ON_SPITEM_CHANGED, var_79_1)
	end
end

function var_0_0.OnExitChapter(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	assert(arg_114_1)
	seriesAsync({
		function(arg_115_0)
			if not arg_114_0.contextData.chapterVO then
				return arg_115_0()
			end

			arg_114_0.viewComponent:switchToMap(arg_115_0)
		end,
		function(arg_116_0)
			arg_114_0.viewComponent:addbubbleMsgBox(function()
				arg_114_0.viewComponent:CleanBubbleMsgbox()
				arg_116_0()
			end)
		end,
		function(arg_118_0)
			if not arg_114_2 then
				return arg_118_0()
			end

			local var_118_0 = getProxy(PlayerProxy):getData()

			if arg_114_1.id == 103 and not var_118_0:GetCommonFlag(BATTLE_AUTO_ENABLED) then
				arg_114_0.viewComponent:HandleShowMsgBox({
					modal = true,
					hideNo = true,
					content = i18n("battle_autobot_unlock"),
					onYes = arg_118_0,
					onNo = arg_118_0
				})
				arg_114_0.viewComponent:emit(LevelMediator2.NOTICE_AUTOBOT_ENABLED, {})

				return
			end

			arg_118_0()
		end,
		function(arg_119_0)
			if not arg_114_2 then
				return arg_119_0()
			end

			if getProxy(ChapterProxy):getMapById(arg_114_1:getConfig("map")):isSkirmish() then
				local var_119_0 = arg_114_1.id
				local var_119_1 = getProxy(SkirmishProxy):getRawData()
				local var_119_2 = _.detect(var_119_1, function(arg_120_0)
					return tonumber(arg_120_0:getConfig("event")) == var_119_0
				end)

				if not var_119_2 then
					arg_119_0()

					return
				end

				local var_119_3 = getProxy(TaskProxy)
				local var_119_4 = var_119_2:getConfig("task_id")
				local var_119_5 = var_119_3:getTaskVO(var_119_4)

				if var_119_5 and var_119_5:getTaskStatus() == 1 then
					arg_114_0:sendNotification(GAME.SUBMIT_TASK, var_119_4)

					if var_119_2 == var_119_1[#var_119_1] then
						local var_119_6 = getProxy(ActivityProxy)
						local var_119_7 = ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE
						local var_119_8 = var_119_6:getActivityById(var_119_7)

						assert(var_119_8, "Missing Skirmish Activity " .. (var_119_7 or "NIL"))

						local var_119_9 = var_119_8:getConfig("config_data")
						local var_119_10 = var_119_9[#var_119_9][2]
						local var_119_11 = var_119_3:getTaskVO(var_119_10)

						if var_119_11 and var_119_11:getTaskStatus() < 2 then
							arg_114_0.contextData.TaskToSubmit = var_119_10
						end
					end
				end
			end

			arg_119_0()
		end,
		function(arg_121_0)
			if not arg_114_2 then
				return arg_121_0()
			end

			local var_121_0 = getProxy(ChapterProxy):getMapById(arg_114_1:getConfig("map"))

			if var_121_0:isRemaster() then
				local var_121_1 = var_121_0:getRemaster()
				local var_121_2 = pg.re_map_template[var_121_1]
				local var_121_3 = Map.GetRearChaptersOfRemaster(var_121_1)

				assert(var_121_3)

				if _.any(var_121_3, function(arg_122_0)
					return arg_122_0 == arg_114_1.id
				end) then
					local var_121_4 = var_121_2.memory_group
					local var_121_5 = pg.memory_group[var_121_4].memories

					if _.any(var_121_5, function(arg_123_0)
						return not pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_123_0].story, true)
					end) then
						_.each(var_121_5, function(arg_124_0)
							local var_124_0 = pg.memory_template[arg_124_0].story
							local var_124_1, var_124_2 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_124_0)

							pg.NewStoryMgr.GetInstance():SetPlayedFlag(var_124_1)
						end)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							yesText = "text_go",
							content = i18n("levelScene_remaster_story_tip", pg.memory_group[var_121_4].title),
							weight = LayerWeightConst.SECOND_LAYER,
							onYes = function()
								arg_114_0:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
									page = WorldMediaCollectionScene.PAGE_MEMORTY,
									memoryGroup = var_121_4
								})
							end,
							onNo = function()
								local var_126_0 = getProxy(PlayerProxy):getRawData().id

								PlayerPrefs.SetInt("MEMORY_GROUP_NOTIFICATION" .. var_126_0 .. " " .. var_121_4, 1)
								PlayerPrefs.Save()
								arg_121_0()
							end
						})

						return
					end
				end
			end

			arg_121_0()
		end,
		function(arg_127_0)
			if arg_114_0.contextData.map and not arg_114_0.contextData.map:isUnlock() then
				arg_114_0.viewComponent:emit(var_0_0.ON_SWITCH_NORMAL_MAP)

				return
			end

			if not arg_114_3 then
				return arg_127_0()
			end

			local var_127_0 = arg_114_3 and arg_114_3.AutoFightFlag
			local var_127_1 = {}

			if arg_114_3 and arg_114_3.ResultDrops then
				for iter_127_0, iter_127_1 in ipairs(arg_114_3.ResultDrops) do
					var_127_1 = table.mergeArray(var_127_1, iter_127_1)
				end
			end

			local var_127_2 = {}

			if arg_114_3 and arg_114_3.TotalDrops then
				for iter_127_2, iter_127_3 in ipairs(arg_114_3.TotalDrops) do
					var_127_2 = table.mergeArray(var_127_2, iter_127_3)
				end
			end

			DropResultIntegration(var_127_2)

			local var_127_3 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

			if var_127_3 then
				var_127_3:MergeDrops(var_127_2, var_127_1)
				var_127_3:MergeEvents(arg_114_3.ListEventNotify, arg_114_3.ListGuildEventNotify, arg_114_3.ListGuildEventAutoReceiveNotify)

				if arg_114_2 then
					var_127_3:ConsumeBattleTime()
				end

				if var_127_3:IsActive() and var_127_3:GetRestBattleTime() > 0 then
					arg_114_0.waitingTracking = true

					arg_114_0.viewComponent:emit(var_0_0.ON_RETRACKING, arg_114_1, var_127_0)

					return
				end

				getProxy(ChapterProxy):PopContinuousData(SYSTEM_SCENARIO)
				arg_114_0:DisplayContinuousOperationResult(arg_114_1, var_127_3)
				arg_127_0()

				return
			end

			local var_127_4 = var_127_0 ~= nil

			if not var_127_4 and not arg_114_3.ResultDrops then
				return arg_127_0()
			end

			local var_127_5
			local var_127_6

			if var_127_4 then
				var_127_5 = i18n("autofight_rewards")
				var_127_6 = i18n("total_rewards_subtitle")
			else
				var_127_5 = i18n("settle_rewards_title")
				var_127_6 = i18n("settle_rewards_subtitle")
			end

			arg_114_0:addSubLayers(Context.New({
				viewComponent = LevelStageTotalRewardPanel,
				mediator = LevelStageTotalRewardPanelMediator,
				data = {
					title = var_127_5,
					subTitle = var_127_6,
					chapter = arg_114_1,
					onClose = arg_127_0,
					rewards = var_127_2,
					resultRewards = var_127_1,
					events = arg_114_3.ListEventNotify,
					guildTasks = arg_114_3.ListGuildEventNotify,
					guildAutoReceives = arg_114_3.ListGuildEventAutoReceiveNotify,
					isAutoFight = var_127_0
				}
			}), true)
		end,
		function(arg_128_0)
			if Map.autoNextPage then
				Map.autoNextPage = nil

				triggerButton(arg_114_0.viewComponent.btnNext)
			end

			if arg_114_2 then
				arg_114_0.viewComponent:RefreshMapBG()
			end

			arg_114_0:TryPlaySubGuide()
		end
	})
end

function var_0_0.DisplayContinuousWindow(arg_129_0, arg_129_1, arg_129_2, arg_129_3, arg_129_4)
	local var_129_0 = arg_129_1:getConfig("oil")
	local var_129_1 = arg_129_1:getPlayType()
	local var_129_2 = 0
	local var_129_3 = 0

	if var_129_1 == ChapterConst.TypeMultiStageBoss then
		local var_129_4 = pg.chapter_model_multistageboss[arg_129_1.id]

		var_129_2 = _.reduce(var_129_4.boss_refresh, 0, function(arg_130_0, arg_130_1)
			return arg_130_0 + arg_130_1
		end)
		var_129_3 = #var_129_4.boss_refresh
	else
		var_129_2, var_129_3 = arg_129_1:getConfig("boss_refresh"), 1
	end

	local var_129_5 = arg_129_1:getConfig("use_oil_limit")

	table.Foreach(arg_129_2, function(arg_131_0, arg_131_1)
		local var_131_0 = arg_129_4[arg_131_0]

		if var_131_0 == ChapterFleet.DUTY_IDLE then
			return
		end

		local var_131_1 = arg_131_1:GetCostSum().oil

		if var_131_0 == ChapterFleet.DUTY_KILLALL then
			local var_131_2 = var_129_5[1] or 0
			local var_131_3 = var_131_1

			if var_131_2 > 0 then
				var_131_3 = math.min(var_131_3, var_131_2)
			end

			local var_131_4 = var_129_5[2] or 0
			local var_131_5 = var_131_1

			if var_131_4 > 0 then
				var_131_5 = math.min(var_131_5, var_131_4)
			end

			var_129_0 = var_129_0 + var_131_3 * var_129_2 + var_131_5 * var_129_3
		elseif var_131_0 == ChapterFleet.DUTY_CLEANPATH then
			local var_131_6 = var_129_5[1] or 0
			local var_131_7 = var_131_1

			if var_131_6 > 0 then
				var_131_7 = math.min(var_131_7, var_131_6)
			end

			var_129_0 = var_129_0 + var_131_7 * var_129_2
		elseif var_131_0 == ChapterFleet.DUTY_KILLBOSS then
			local var_131_8 = var_129_5[2] or 0
			local var_131_9 = var_131_1

			if var_131_8 > 0 then
				var_131_9 = math.min(var_131_9, var_131_8)
			end

			var_129_0 = var_129_0 + var_131_9 * var_129_3
		end
	end)

	local var_129_6 = arg_129_1:GetMaxBattleCount()
	local var_129_7 = arg_129_3 and arg_129_3 > 0
	local var_129_8 = arg_129_1:GetSpItems()
	local var_129_9 = var_129_8[1] and var_129_8[1].count or 0
	local var_129_10 = var_129_8[1] and var_129_8[1].id or 0
	local var_129_11 = arg_129_1:GetRestDailyBonus()

	arg_129_0:addSubLayers(Context.New({
		mediator = LevelContinuousOperationWindowMediator,
		viewComponent = LevelContinuousOperationWindow,
		data = {
			maxCount = var_129_6,
			oilCost = var_129_0,
			chapter = arg_129_1,
			extraRate = {
				rate = 2,
				enabled = var_129_7,
				extraCount = var_129_9,
				spItemId = var_129_10,
				freeBonus = var_129_11
			}
		}
	}))
end

function var_0_0.DisplayContinuousOperationResult(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = i18n("autofight_rewards")
	local var_132_1 = i18n("total_rewards_subtitle")

	arg_132_0:addSubLayers(Context.New({
		viewComponent = LevelContinuousOperationTotalRewardPanel,
		mediator = LevelStageTotalRewardPanelMediator,
		data = {
			title = var_132_0,
			subTitle = var_132_1,
			chapter = arg_132_1,
			rewards = arg_132_2:GetDrops(),
			resultRewards = arg_132_2:GetSettlementDrops(),
			continuousData = arg_132_2,
			events = arg_132_2:GetEvents(1),
			guildTasks = arg_132_2:GetEvents(2),
			guildAutoReceives = arg_132_2:GetEvents(3)
		}
	}), true)
end

function var_0_0.OnEventUpdate(arg_133_0, arg_133_1)
	local var_133_0 = getProxy(EventProxy)

	arg_133_0.viewComponent:updateEvent(var_133_0)

	if pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_133_0.player.level, "EventMediator") and var_133_0.eventForMsg then
		local var_133_1 = var_133_0.eventForMsg.id or 0
		local var_133_2 = getProxy(ChapterProxy):getActiveChapter(true)

		if var_133_2 and var_133_2:IsAutoFight() then
			getProxy(ChapterProxy):AddExtendChapterDataArray(var_133_2.id, "ListEventNotify", var_133_1)
			existCall(arg_133_1)
		else
			local var_133_3 = pg.collection_template[var_133_1] and pg.collection_template[var_133_1].title or ""

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = false,
				hideNo = true,
				content = i18n("event_special_update", var_133_3),
				weight = LayerWeightConst.SECOND_LAYER,
				onYes = arg_133_1,
				onNo = arg_133_1
			})
		end

		var_133_0.eventForMsg = nil
	else
		existCall(arg_133_1)
	end
end

function var_0_0.onTimeUp(arg_134_0)
	local var_134_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_134_0 and not var_134_0:inWartime() then
		local function var_134_1()
			arg_134_0:sendNotification(GAME.CHAPTER_OP, {
				type = ChapterConst.OpRetreat
			})
		end

		if arg_134_0.contextData.chapterVO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = var_134_1,
				onNo = var_134_1
			})
		else
			var_134_1()
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_chapter_timeout"))
		end
	end
end

function var_0_0.getDockCallbackFuncs(arg_136_0, arg_136_1, arg_136_2, arg_136_3, arg_136_4)
	local var_136_0 = getProxy(ChapterProxy)

	local function var_136_1(arg_137_0, arg_137_1)
		local var_137_0, var_137_1 = ShipStatus.ShipStatusCheck("inElite", arg_137_0, arg_137_1, {
			inElite = arg_136_3:getConfig("formation")
		})

		if not var_137_0 then
			return var_137_0, var_137_1
		end

		for iter_137_0, iter_137_1 in pairs(arg_136_1) do
			if arg_137_0:isSameKind(iter_137_0) then
				return false, i18n("ship_formationMediator_changeNameError_sameShip")
			end
		end

		return true
	end

	local function var_136_2(arg_138_0, arg_138_1, arg_138_2)
		arg_138_1()
	end

	local function var_136_3(arg_139_0)
		local var_139_0 = arg_136_3:getEliteFleetList()[arg_136_4]

		if arg_136_2 then
			local var_139_1 = table.indexof(var_139_0, arg_136_2.id)

			assert(var_139_1)

			if arg_139_0[1] then
				var_139_0[var_139_1] = arg_139_0[1]
			else
				table.remove(var_139_0, var_139_1)
			end
		else
			table.insert(var_139_0, arg_139_0[1])
		end

		var_136_0:updateChapter(arg_136_3)
		var_136_0:duplicateEliteFleet(arg_136_3)
	end

	return var_136_1, var_136_2, var_136_3
end

function var_0_0.getSupportDockCallbackFuncs(arg_140_0, arg_140_1, arg_140_2, arg_140_3)
	local var_140_0 = getProxy(ChapterProxy)

	local function var_140_1(arg_141_0, arg_141_1)
		local var_141_0, var_141_1 = ShipStatus.ShipStatusCheck("inSupport", arg_141_0, arg_141_1)

		if not var_141_0 then
			return var_141_0, var_141_1
		end

		for iter_141_0, iter_141_1 in pairs(arg_140_1) do
			if arg_141_0:isSameKind(iter_141_0) then
				return false, i18n("ship_formationMediator_changeNameError_sameShip")
			end
		end

		return true
	end

	local function var_140_2(arg_142_0, arg_142_1, arg_142_2)
		arg_142_1()
	end

	local function var_140_3(arg_143_0)
		local var_143_0 = arg_140_3:getSupportFleet()

		if arg_140_2 then
			local var_143_1 = table.indexof(var_143_0, arg_140_2.id)

			assert(var_143_1)

			if arg_143_0[1] then
				var_143_0[var_143_1] = arg_143_0[1]
			else
				table.remove(var_143_0, var_143_1)
			end
		else
			table.insert(var_143_0, arg_143_0[1])
		end

		var_140_0:updateChapter(arg_140_3)
		var_140_0:duplicateSupportFleet(arg_140_3)
	end

	return var_140_1, var_140_2, var_140_3
end

function var_0_0.playAIActions(arg_144_0, arg_144_1, arg_144_2, arg_144_3)
	if not arg_144_0.viewComponent.grid then
		arg_144_3()

		return
	end

	local var_144_0 = getProxy(ChapterProxy)
	local var_144_1

	local function var_144_2()
		if var_144_1 and coroutine.status(var_144_1) == "suspended" then
			local var_145_0, var_145_1 = coroutine.resume(var_144_1)

			assert(var_145_0, debug.traceback(var_144_1, var_145_1))

			if not var_145_0 then
				arg_144_0.viewComponent:unfrozen(-1)
				arg_144_0:sendNotification(GAME.CHAPTER_OP, {
					type = ChapterConst.OpRequest
				})
			end
		end
	end

	var_144_1 = coroutine.create(function()
		arg_144_0.viewComponent:frozen()

		local var_146_0 = {}
		local var_146_1 = arg_144_2 or 0

		for iter_146_0, iter_146_1 in ipairs(arg_144_1) do
			local var_146_2 = arg_144_0.contextData.chapterVO
			local var_146_3, var_146_4 = iter_146_1:applyTo(var_146_2, true)

			assert(var_146_3, var_146_4)
			iter_146_1:PlayAIAction(arg_144_0.contextData.chapterVO, arg_144_0, function()
				local var_147_0, var_147_1, var_147_2 = iter_146_1:applyTo(var_146_2, false)

				if var_147_0 then
					var_144_0:updateChapter(var_146_2, var_147_1)

					var_146_1 = bit.bor(var_146_1, var_147_2 or 0)
				end

				onNextTick(var_144_2)
			end)
			coroutine.yield()

			if isa(iter_146_1, FleetAIAction) and iter_146_1.actType == ChapterConst.ActType_Poison and var_146_2:existFleet(FleetType.Normal, iter_146_1.line.row, iter_146_1.line.column) then
				local var_146_5 = var_146_2:getFleetIndex(FleetType.Normal, iter_146_1.line.row, iter_146_1.line.column)

				table.insert(var_146_0, var_146_5)
			end
		end

		local var_146_6 = bit.band(var_146_1, ChapterConst.DirtyAutoAction)

		var_146_1 = bit.band(var_146_1, bit.bnot(ChapterConst.DirtyAutoAction))

		if var_146_1 ~= 0 then
			local var_146_7 = arg_144_0.contextData.chapterVO

			var_144_0:updateChapter(var_146_7, var_146_1)
		end

		seriesAsync({
			function(arg_148_0)
				if var_146_6 ~= 0 then
					arg_144_0.viewComponent.levelStageView:tryAutoAction(arg_148_0)
				else
					arg_148_0()
				end
			end,
			function(arg_149_0)
				table.ParallelIpairsAsync(var_146_0, function(arg_150_0, arg_150_1, arg_150_2)
					arg_144_0.viewComponent.grid:showFleetPoisonDamage(arg_150_1, arg_150_2)
				end, arg_149_0)
			end,
			function(arg_151_0)
				arg_144_3()
				arg_144_0.viewComponent:unfrozen()
			end
		})
	end)

	var_144_2()
end

function var_0_0.saveSubState(arg_152_0, arg_152_1)
	local var_152_0 = getProxy(PlayerProxy):getRawData().id

	PlayerPrefs.SetInt("chapter_submarine_ai_type_" .. var_152_0, arg_152_1 + 1)
	PlayerPrefs.Save()
end

function var_0_0.loadSubState(arg_153_0, arg_153_1)
	local var_153_0 = getProxy(PlayerProxy):getRawData().id
	local var_153_1 = PlayerPrefs.GetInt("chapter_submarine_ai_type_" .. var_153_0) - 1

	if var_153_1 >= 0 and var_153_1 ~= arg_153_1 then
		arg_153_0.viewComponent:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSubState,
			arg1 = var_153_1
		})
	end
end

function var_0_0.remove(arg_154_0)
	arg_154_0:removeSubLayers(LevelContinuousOperationWindowMediator)
	var_0_0.super.remove(arg_154_0)
end

return var_0_0
