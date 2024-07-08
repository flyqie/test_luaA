local var_0_0 = class("LevelScene", import("..base.BaseUI"))
local var_0_1 = 0.5
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.forceGC(arg_1_0)
	return true
end

function var_0_0.getUIName(arg_2_0)
	return "LevelMainScene"
end

function var_0_0.ResUISettings(arg_3_0)
	return {
		showType = PlayerResUI.TYPE_ALL,
		groupName = LayerWeightConst.GROUP_LEVELUI
	}
end

function var_0_0.getBGM(arg_4_0)
	local function var_4_0()
		return checkExist(arg_4_0.contextData.chapterVO, {
			"getConfig",
			{
				"bgm"
			}
		}) or ""
	end

	local function var_4_1()
		if not arg_4_0.contextData.map then
			return
		end

		local var_6_0 = arg_4_0.contextData.map:getConfig("ani_controller")

		if var_6_0 and #var_6_0 > 0 then
			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				local var_6_1 = _.rest(iter_6_1[2], 2)

				for iter_6_2, iter_6_3 in ipairs(var_6_1) do
					if string.find(iter_6_3, "^bgm_") and iter_6_1[1] == var_0_3 then
						local var_6_2 = iter_6_1[2][1]
						local var_6_3 = getProxy(ChapterProxy):GetChapterItemById(var_6_2)

						if var_6_3 and not var_6_3:isClear() then
							return string.sub(iter_6_3, 5)
						end
					end
				end
			end
		end

		return checkExist(arg_4_0.contextData.map, {
			"getConfig",
			{
				"bgm"
			}
		}) or ""
	end

	for iter_4_0, iter_4_1 in ipairs({
		var_4_0(),
		var_4_1()
	}) do
		if iter_4_1 ~= "" then
			return iter_4_1
		end
	end

	return var_0_0.super.getBGM(arg_4_0)
end

var_0_0.optionsPath = {
	"top/top_chapter/option"
}

function var_0_0.preload(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(ChapterProxy)

	if arg_7_0.contextData.mapIdx and arg_7_0.contextData.chapterId then
		local var_7_1 = var_7_0:getChapterById(arg_7_0.contextData.chapterId)

		if var_7_1:getConfig("map") == arg_7_0.contextData.mapIdx then
			arg_7_0.contextData.chapterVO = var_7_1

			if var_7_1.active then
				assert(not arg_7_0.contextData.openChapterId or arg_7_0.contextData.openChapterId == arg_7_0.contextData.chapterId)

				arg_7_0.contextData.openChapterId = nil
			end
		end
	end

	local var_7_2, var_7_3 = arg_7_0:GetInitializeMap()

	if arg_7_0.contextData.entranceStatus == nil then
		arg_7_0.contextData.entranceStatus = not var_7_3
	end

	if not arg_7_0.contextData.entranceStatus then
		arg_7_0:PreloadLevelMainUI(var_7_2, arg_7_1)
	else
		arg_7_1()
	end
end

function var_0_0.GetInitializeMap(arg_8_0)
	local var_8_0 = (function()
		local var_9_0 = arg_8_0.contextData.chapterVO

		if var_9_0 and var_9_0.active then
			return var_9_0:getConfig("map")
		end

		local var_9_1 = arg_8_0.contextData.mapIdx

		if var_9_1 then
			return var_9_1
		end

		local var_9_2

		if arg_8_0.contextData.targetChapter and arg_8_0.contextData.targetMap then
			arg_8_0.contextData.openChapterId = arg_8_0.contextData.targetChapter
			var_9_2 = arg_8_0.contextData.targetMap.id
			arg_8_0.contextData.targetChapter = nil
			arg_8_0.contextData.targetMap = nil
		elseif arg_8_0.contextData.eliteDefault then
			local var_9_3 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			var_9_2 = var_9_3 and var_9_3.id or nil
			arg_8_0.contextData.eliteDefault = nil
		end

		return var_9_2
	end)()
	local var_8_1 = var_8_0 and getProxy(ChapterProxy):getMapById(var_8_0)

	if var_8_1 then
		local var_8_2, var_8_3 = var_8_1:isUnlock()

		if not var_8_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_3)

			var_8_0 = getProxy(ChapterProxy):getLastUnlockMap().id
			arg_8_0.contextData.mapIdx = var_8_0
		end
	else
		var_8_0 = nil
	end

	return var_8_0 or arg_8_0:selectMap(), tobool(var_8_0)
end

function var_0_0.init(arg_10_0)
	arg_10_0:initData()
	arg_10_0:initUI()
	arg_10_0:initEvents()
	arg_10_0:updateClouds()
end

function var_0_0.initData(arg_11_0)
	arg_11_0.tweens = {}
	arg_11_0.mapWidth = 1920
	arg_11_0.mapHeight = 1440
	arg_11_0.levelCamIndices = 1
	arg_11_0.frozenCount = 0
	arg_11_0.currentBG = nil
	arg_11_0.mapBuilder = nil
	arg_11_0.mbDict = {}
	arg_11_0.mapGroup = {}

	if not arg_11_0.contextData.huntingRangeVisibility then
		arg_11_0.contextData.huntingRangeVisibility = 2
	end
end

function var_0_0.initUI(arg_12_0)
	arg_12_0.topPanel = arg_12_0:findTF("top")
	arg_12_0.canvasGroup = arg_12_0.topPanel:GetComponent("CanvasGroup")
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts
	arg_12_0.entranceLayer = arg_12_0:findTF("entrance")
	arg_12_0.ptBonus = EventPtBonus.New(arg_12_0.entranceLayer:Find("btns/btn_task/bonusPt"))
	arg_12_0.entranceBg = arg_12_0:findTF("entrance_bg")
	arg_12_0.topChapter = arg_12_0:findTF("top_chapter", arg_12_0.topPanel)

	setActive(arg_12_0.topChapter:Find("title_chapter"), false)
	setActive(arg_12_0.topChapter:Find("type_chapter"), false)
	setActive(arg_12_0.topChapter:Find("type_escort"), false)
	setActive(arg_12_0.topChapter:Find("type_skirmish"), false)

	arg_12_0.chapterName = arg_12_0:findTF("title_chapter/name", arg_12_0.topChapter)
	arg_12_0.chapterNoTitle = arg_12_0:findTF("title_chapter/chapter", arg_12_0.topChapter)
	arg_12_0.resChapter = arg_12_0:findTF("resources", arg_12_0.topChapter)

	setActive(arg_12_0.topChapter, true)

	arg_12_0._voteBookBtn = arg_12_0.topChapter:Find("vote_book")
	arg_12_0.leftChapter = arg_12_0:findTF("main/left_chapter")

	setActive(arg_12_0.leftChapter, true)

	arg_12_0.leftCanvasGroup = arg_12_0.leftChapter:GetComponent(typeof(CanvasGroup))
	arg_12_0.btnPrev = arg_12_0:findTF("btn_prev", arg_12_0.leftChapter)
	arg_12_0.btnPrevCol = arg_12_0:findTF("btn_prev/prev_image", arg_12_0.leftChapter)
	arg_12_0.eliteBtn = arg_12_0:findTF("buttons/btn_elite", arg_12_0.leftChapter)
	arg_12_0.normalBtn = arg_12_0:findTF("buttons/btn_normal", arg_12_0.leftChapter)
	arg_12_0.actNormalBtn = arg_12_0:findTF("buttons/btn_act_normal", arg_12_0.leftChapter)

	setActive(arg_12_0.actNormalBtn, false)

	arg_12_0.actEliteBtn = arg_12_0:findTF("buttons/btn_act_elite", arg_12_0.leftChapter)

	setActive(arg_12_0.actEliteBtn, false)

	arg_12_0.actExtraBtn = arg_12_0:findTF("buttons/btn_act_extra", arg_12_0.leftChapter)
	arg_12_0.actExtraBtnAnim = arg_12_0:findTF("usm", arg_12_0.actExtraBtn)
	arg_12_0.remasterBtn = arg_12_0:findTF("buttons/btn_remaster", arg_12_0.leftChapter)
	arg_12_0.escortBar = arg_12_0:findTF("escort_bar", arg_12_0.leftChapter)

	setActive(arg_12_0.escortBar, false)

	arg_12_0.eliteQuota = arg_12_0:findTF("elite_quota", arg_12_0.leftChapter)

	setActive(arg_12_0.eliteQuota, false)

	arg_12_0.skirmishBar = arg_12_0:findTF("left_times", arg_12_0.leftChapter)
	arg_12_0.mainLayer = arg_12_0:findTF("main")

	setActive(arg_12_0.mainLayer:Find("title_chapter_lines"), false)

	arg_12_0.rightChapter = arg_12_0:findTF("main/right_chapter")
	arg_12_0.rightCanvasGroup = arg_12_0.rightChapter:GetComponent(typeof(CanvasGroup))
	arg_12_0.eventContainer = arg_12_0:findTF("event_btns/event_container", arg_12_0.rightChapter)
	arg_12_0.btnSpecial = arg_12_0:findTF("btn_task", arg_12_0.eventContainer)
	arg_12_0.challengeBtn = arg_12_0:findTF("btn_challenge", arg_12_0.eventContainer)
	arg_12_0.dailyBtn = arg_12_0:findTF("btn_daily", arg_12_0.eventContainer)
	arg_12_0.militaryExerciseBtn = arg_12_0:findTF("btn_pvp", arg_12_0.eventContainer)
	arg_12_0.activityBtn = arg_12_0:findTF("event_btns/activity_btn", arg_12_0.rightChapter)
	arg_12_0.ptTotal = arg_12_0:findTF("event_btns/pt_text", arg_12_0.rightChapter)
	arg_12_0.ticketTxt = arg_12_0:findTF("event_btns/tickets/Text", arg_12_0.rightChapter)
	arg_12_0.remasterAwardBtn = arg_12_0:findTF("btn_remaster_award", arg_12_0.rightChapter)
	arg_12_0.btnNext = arg_12_0:findTF("btn_next", arg_12_0.rightChapter)
	arg_12_0.btnNextCol = arg_12_0:findTF("btn_next/next_image", arg_12_0.rightChapter)
	arg_12_0.countDown = arg_12_0:findTF("event_btns/count_down", arg_12_0.rightChapter)

	setActive(arg_12_0:findTF("event_btns/BottomList", arg_12_0.rightChapter), true)

	arg_12_0.actExchangeShopBtn = arg_12_0:findTF("event_btns/BottomList/btn_exchange", arg_12_0.rightChapter)
	arg_12_0.actAtelierBuffBtn = arg_12_0:findTF("event_btns/BottomList/btn_control_center", arg_12_0.rightChapter)
	arg_12_0.actExtraRank = arg_12_0:findTF("event_btns/BottomList/act_extra_rank", arg_12_0.rightChapter)

	setActive(arg_12_0.rightChapter, true)
	setActive(arg_12_0.remasterAwardBtn, false)

	arg_12_0.damageTextTemplate = go(arg_12_0:findTF("damage", arg_12_0.topPanel))

	setActive(arg_12_0.damageTextTemplate, false)

	arg_12_0.damageTextPool = {
		arg_12_0.damageTextTemplate
	}
	arg_12_0.damageTextActive = {}
	arg_12_0.mapHelpBtn = arg_12_0:findTF("help_button", arg_12_0.topPanel)

	setActive(arg_12_0.mapHelpBtn, false)

	arg_12_0.avoidText = arg_12_0:findTF("text_avoid", arg_12_0.topPanel)
	arg_12_0.commanderTinkle = arg_12_0:findTF("neko_tinkle", arg_12_0.topPanel)

	setActive(arg_12_0.commanderTinkle, false)

	arg_12_0.spResult = arg_12_0:findTF("sp_result", arg_12_0.topPanel)

	setActive(arg_12_0.spResult, false)

	arg_12_0.helpPage = arg_12_0:findTF("help_page", arg_12_0.topPanel)
	arg_12_0.helpImage = arg_12_0:findTF("icon", arg_12_0.helpPage)

	setActive(arg_12_0.helpPage, false)

	arg_12_0.curtain = arg_12_0:findTF("curtain", arg_12_0.topPanel)

	setActive(arg_12_0.curtain, false)

	arg_12_0.map = arg_12_0:findTF("maps")
	arg_12_0.mapTFs = {
		arg_12_0:findTF("maps/map1"),
		arg_12_0:findTF("maps/map2")
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.mapTFs) do
		iter_12_1:GetComponent(typeof(Image)).enabled = false
	end

	local var_12_0 = arg_12_0.map:GetComponent(typeof(AspectRatioFitter))

	var_12_0.aspectRatio, var_12_0.aspectRatio = var_12_0.aspectRatio, 1
	arg_12_0.UIFXList = arg_12_0:findTF("maps/UI_FX_list")

	local var_12_1 = arg_12_0.UIFXList:GetComponentsInChildren(typeof(Renderer))

	for iter_12_2 = 0, var_12_1.Length - 1 do
		var_12_1[iter_12_2].sortingOrder = -1
	end

	local var_12_2 = pg.UIMgr.GetInstance()

	arg_12_0.levelCam = var_12_2.levelCamera:GetComponent(typeof(Camera))
	arg_12_0.uiMain = var_12_2.LevelMain

	setActive(arg_12_0.uiMain, false)

	arg_12_0.uiCam = var_12_2.uiCamera:GetComponent(typeof(Camera))
	arg_12_0.levelGrid = arg_12_0.uiMain:Find("LevelGrid")

	setActive(arg_12_0.levelGrid, true)

	arg_12_0.dragLayer = arg_12_0.levelGrid:Find("DragLayer")
	arg_12_0.float = arg_12_0:findTF("float")
	arg_12_0.clouds = arg_12_0:findTF("clouds", arg_12_0.float)

	setActive(arg_12_0.clouds, true)
	setActive(arg_12_0.float:Find("levels"), false)

	arg_12_0.resources = arg_12_0:findTF("resources"):GetComponent("ItemList")
	arg_12_0.arrowTarget = arg_12_0.resources.prefabItem[0]
	arg_12_0.destinationMarkTpl = arg_12_0.resources.prefabItem[1]
	arg_12_0.championTpl = arg_12_0.resources.prefabItem[3]
	arg_12_0.deadTpl = arg_12_0.resources.prefabItem[4]
	arg_12_0.enemyTpl = Instantiate(arg_12_0.resources.prefabItem[5])
	arg_12_0.oniTpl = arg_12_0.resources.prefabItem[6]
	arg_12_0.shipTpl = arg_12_0.resources.prefabItem[8]
	arg_12_0.subTpl = arg_12_0.resources.prefabItem[9]
	arg_12_0.transportTpl = arg_12_0.resources.prefabItem[11]

	setText(arg_12_0:findTF("fighting/Text", arg_12_0.enemyTpl), i18n("ui_word_levelui2_inevent"))
	setAnchoredPosition(arg_12_0.topChapter, {
		y = 0
	})
	setAnchoredPosition(arg_12_0.leftChapter, {
		x = 0
	})
	setAnchoredPosition(arg_12_0.rightChapter, {
		x = 0
	})

	arg_12_0.bubbleMsgBoxes = {}
	arg_12_0.loader = AutoLoader.New()
	arg_12_0.levelFleetView = LevelFleetView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.levelInfoView = LevelInfoView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)

	arg_12_0:buildCommanderPanel()

	arg_12_0.levelRemasterView = LevelRemasterView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)
end

function var_0_0.initEvents(arg_13_0)
	arg_13_0:bind(LevelUIConst.OPEN_COMMANDER_PANEL, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		arg_13_0:openCommanderPanel(arg_14_1, arg_14_2, arg_14_3)
	end)
	arg_13_0:bind(LevelUIConst.HANDLE_SHOW_MSG_BOX, function(arg_15_0, arg_15_1)
		arg_13_0:HandleShowMsgBox(arg_15_1)
	end)
	arg_13_0:bind(LevelUIConst.DO_AMBUSH_WARNING, function(arg_16_0, arg_16_1)
		arg_13_0:doAmbushWarning(arg_16_1)
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_AMBUSH_INFO, function(arg_17_0, arg_17_1)
		arg_13_0:displayAmbushInfo(arg_17_1)
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_STRATEGY_INFO, function(arg_18_0, arg_18_1)
		arg_13_0:displayStrategyInfo(arg_18_1)
	end)
	arg_13_0:bind(LevelUIConst.FROZEN, function(arg_19_0)
		arg_13_0:frozen()
	end)
	arg_13_0:bind(LevelUIConst.UN_FROZEN, function(arg_20_0)
		arg_13_0:unfrozen()
	end)
	arg_13_0:bind(LevelUIConst.DO_TRACKING, function(arg_21_0, arg_21_1)
		arg_13_0:doTracking(arg_21_1)
	end)
	arg_13_0:bind(LevelUIConst.SWITCH_TO_MAP, function()
		if arg_13_0:isfrozen() then
			return
		end

		arg_13_0:switchToMap()
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_REPAIR_WINDOW, function(arg_23_0, arg_23_1)
		arg_13_0:displayRepairWindow(arg_23_1)
	end)
	arg_13_0:bind(LevelUIConst.DO_PLAY_ANIM, function(arg_24_0, arg_24_1)
		arg_13_0:doPlayAnim(arg_24_1.name, arg_24_1.callback, arg_24_1.onStart)
	end)
	arg_13_0:bind(LevelUIConst.HIDE_FLEET_SELECT, function()
		arg_13_0:hideFleetSelect()
	end)
	arg_13_0:bind(LevelUIConst.HIDE_FLEET_EDIT, function(arg_26_0)
		arg_13_0:hideFleetEdit()
	end)
	arg_13_0:bind(LevelUIConst.ADD_MSG_QUEUE, function(arg_27_0, arg_27_1)
		arg_13_0:addbubbleMsgBox(arg_27_1)
	end)
	arg_13_0:bind(LevelUIConst.SET_MAP, function(arg_28_0, arg_28_1)
		arg_13_0:setMap(arg_28_1)
	end)
end

function var_0_0.addbubbleMsgBox(arg_29_0, arg_29_1)
	table.insert(arg_29_0.bubbleMsgBoxes, arg_29_1)

	if #arg_29_0.bubbleMsgBoxes > 1 then
		return
	end

	local var_29_0

	local function var_29_1()
		local var_30_0 = arg_29_0.bubbleMsgBoxes[1]

		if var_30_0 then
			var_30_0(function()
				table.remove(arg_29_0.bubbleMsgBoxes, 1)
				var_29_1()
			end)
		end
	end

	var_29_1()
end

function var_0_0.CleanBubbleMsgbox(arg_32_0)
	table.clean(arg_32_0.bubbleMsgBoxes)
end

function var_0_0.updatePtActivity(arg_33_0, arg_33_1)
	arg_33_0.ptActivity = arg_33_1

	arg_33_0:updateActivityRes()
end

function var_0_0.updateActivityRes(arg_34_0)
	local var_34_0 = findTF(arg_34_0.ptTotal, "Text")
	local var_34_1 = findTF(arg_34_0.ptTotal, "icon/Image")

	if var_34_0 and var_34_1 and arg_34_0.ptActivity then
		setText(var_34_0, "x" .. arg_34_0.ptActivity.data1)
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = tonumber(arg_34_0.ptActivity:getConfig("config_id"))
		}):getIcon(), "", var_34_1, true)
	end
end

function var_0_0.setCommanderPrefabs(arg_35_0, arg_35_1)
	arg_35_0.commanderPrefabs = arg_35_1
end

function var_0_0.didEnter(arg_36_0)
	arg_36_0.openedCommanerSystem = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "CommanderCatMediator")

	onButton(arg_36_0, arg_36_0:findTF("back_button", arg_36_0.topChapter), function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_37_0 = arg_36_0.contextData.map

		if var_37_0 and (var_37_0:isActivity() or var_37_0:isEscort()) then
			arg_36_0:emit(LevelMediator2.ON_SWITCH_NORMAL_MAP)

			return
		elseif var_37_0 and var_37_0:isSkirmish() then
			arg_36_0:emit(var_0_0.ON_BACK)
		elseif not arg_36_0.contextData.entranceStatus then
			arg_36_0:ShowEntranceUI(true)
		else
			arg_36_0:emit(var_0_0.ON_BACK)
		end
	end, SFX_CANCEL)
	onButton(arg_36_0, arg_36_0.btnSpecial, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.dailyBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		arg_36_0:updatDailyBtnTip()
		arg_36_0:emit(LevelMediator2.ON_DAILY_LEVEL)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.challengeBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_40_0, var_40_1 = arg_36_0:checkChallengeOpen()

		if var_40_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_40_1)
		else
			arg_36_0:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.militaryExerciseBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.normalBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:setMap(arg_36_0.contextData.map:getBindMapId())
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.eliteBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		if arg_36_0.contextData.map:getBindMapId() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))

			local var_43_0 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			if var_43_0 then
				arg_36_0:setMap(var_43_0.configId)
				pg.TipsMgr.GetInstance():ShowTips(i18n("elite_warp_to_latest_map"))
			end
		elseif arg_36_0.contextData.map:isEliteEnabled() then
			arg_36_0:setMap(arg_36_0.contextData.map:getBindMapId())
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unsatisfied"))
		end
	end, SFX_UI_WEIGHANCHOR_HARD)
	onButton(arg_36_0, arg_36_0.remasterBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		arg_36_0:updateRemasterBtnTip()
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_main"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:ShowSelectedMap(arg_36_0:GetInitializeMap())
	end, SFX_PANEL)
	setText(arg_36_0.entranceLayer:Find("enters/enter_main/Text"), getProxy(ChapterProxy):getLastUnlockMap():getLastUnlockChapterName())
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_world/enter"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ENTER_WORLD)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_47_0 = getProxy(ActivityProxy):getEnterReadyActivity()

		switch(var_47_0:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function()
				arg_36_0:emit(LevelMediator2.ON_ACTIVITY_MAP)
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
				arg_36_0:emit(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE)
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
				arg_36_0:emit(LevelMediator2.ON_BOSSRUSH_MAP)
			end
		})
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_remaster"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		arg_36_0:updateRemasterBtnTip()
	end, SFX_PANEL)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_remaster"), OPEN_REMASTER)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_challenge"), function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_52_0, var_52_1 = arg_36_0:checkChallengeOpen()

		if var_52_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_52_1)
		else
			arg_36_0:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_pvp"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_daily"), function()
		if arg_36_0:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		arg_36_0:updatDailyBtnTip()
		arg_36_0:emit(LevelMediator2.ON_DAILY_LEVEL)
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_task"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)
	end, SFX_PANEL)
	setActive(arg_36_0.entranceLayer:Find("enters/enter_world/enter"), not WORLD_ENTER_LOCK)
	setActive(arg_36_0.entranceLayer:Find("enters/enter_world/nothing"), WORLD_ENTER_LOCK)

	local var_36_0 = getProxy(ActivityProxy):getEnterReadyActivity()

	setActive(arg_36_0.entranceLayer:Find("enters/enter_ready/nothing"), not tobool(var_36_0))
	setActive(arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), tobool(var_36_0))

	if tobool(var_36_0) then
		local var_36_1 = var_36_0:getConfig("config_client").entrance_bg

		if var_36_1 then
			GetImageSpriteFromAtlasAsync(var_36_1, "", arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), true)
		end
	end

	local var_36_2 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "EventMediator")

	setActive(arg_36_0.btnSpecial:Find("lock"), not var_36_2)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_task/lock"), not var_36_2)

	local var_36_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "DailyLevelMediator")

	setActive(arg_36_0.dailyBtn:Find("lock"), not var_36_3)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_daily/lock"), not var_36_3)

	local var_36_4 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "MilitaryExerciseMediator")

	setActive(arg_36_0.militaryExerciseBtn:Find("lock"), not var_36_4)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_pvp/lock"), not var_36_4)

	local var_36_5 = LimitChallengeConst.IsOpen()

	setActive(arg_36_0.challengeBtn:Find("lock"), not var_36_5)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge/lock"), not var_36_5)

	local var_36_6 = LimitChallengeConst.IsInAct()

	setActive(arg_36_0.challengeBtn, var_36_6)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge"), var_36_6)

	local var_36_7 = LimitChallengeConst.IsShowRedPoint()

	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge/tip"), var_36_7)
	arg_36_0:initMapBtn(arg_36_0.btnPrev, -1)
	arg_36_0:initMapBtn(arg_36_0.btnNext, 1)

	if arg_36_0.contextData.editEliteChapter then
		local var_36_8 = getProxy(ChapterProxy):getChapterById(arg_36_0.contextData.editEliteChapter)

		arg_36_0:displayFleetEdit(var_36_8)

		arg_36_0.contextData.editEliteChapter = nil
	elseif arg_36_0.contextData.selectedChapterVO then
		arg_36_0:displayFleetSelect(arg_36_0.contextData.selectedChapterVO)

		arg_36_0.contextData.selectedChapterVO = nil
	end

	local var_36_9 = arg_36_0.contextData.chapterVO

	if not var_36_9 or not var_36_9.active then
		arg_36_0:tryPlaySubGuide()
	end

	arg_36_0:updateRemasterBtnTip()
	arg_36_0:updatDailyBtnTip()

	if arg_36_0.contextData.open_remaster then
		arg_36_0:displayRemasterPanel(arg_36_0.contextData.isSP)

		arg_36_0.contextData.open_remaster = nil
	end

	arg_36_0:ShowEntranceUI(arg_36_0.contextData.entranceStatus)

	if not arg_36_0.contextData.entranceStatus then
		arg_36_0:emit(LevelMediator2.ON_ENTER_MAINLEVEL, arg_36_0:GetInitializeMap())
	end

	arg_36_0:emit(LevelMediator2.ON_DIDENTER)
end

function var_0_0.checkChallengeOpen(arg_56_0)
	local var_56_0 = getProxy(PlayerProxy):getRawData().level

	return pg.SystemOpenMgr.GetInstance():isOpenSystem(var_56_0, "ChallengeMainMediator")
end

function var_0_0.tryPlaySubGuide(arg_57_0)
	if arg_57_0.contextData.map and arg_57_0.contextData.map:isSkirmish() then
		return
	end

	pg.SystemGuideMgr.GetInstance():Play(arg_57_0)
end

function var_0_0.onBackPressed(arg_58_0)
	if arg_58_0:isfrozen() then
		return
	end

	if arg_58_0.levelAmbushView then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_58_0.levelInfoView:isShowing() then
		arg_58_0:hideChapterPanel()

		return
	end

	if arg_58_0.levelFleetView:isShowing() then
		arg_58_0:hideFleetEdit()

		return
	end

	if arg_58_0.levelStrategyView then
		arg_58_0:hideStrategyInfo()

		return
	end

	if arg_58_0.levelRepairView then
		arg_58_0:hideRepairWindow()

		return
	end

	if arg_58_0.levelRemasterView:isShowing() then
		arg_58_0:hideRemasterPanel()

		return
	end

	if isActive(arg_58_0.helpPage) then
		setActive(arg_58_0.helpPage, false)

		return
	end

	local var_58_0 = arg_58_0.contextData.chapterVO
	local var_58_1 = getProxy(ChapterProxy):getActiveChapter()

	if var_58_0 and var_58_1 then
		arg_58_0:switchToMap()

		return
	end

	triggerButton(arg_58_0:findTF("back_button", arg_58_0.topChapter))
end

function var_0_0.ShowEntranceUI(arg_59_0, arg_59_1)
	setActive(arg_59_0.entranceLayer, arg_59_1)
	setActive(arg_59_0.entranceBg, arg_59_1)
	setActive(arg_59_0.map, not arg_59_1)
	setActive(arg_59_0.float, not arg_59_1)
	setActive(arg_59_0.mainLayer, not arg_59_1)
	setActive(arg_59_0.topChapter:Find("type_entrance"), arg_59_1)

	arg_59_0.contextData.entranceStatus = tobool(arg_59_1)

	if arg_59_1 then
		setActive(arg_59_0.topChapter:Find("title_chapter"), false)
		setActive(arg_59_0.topChapter:Find("type_chapter"), false)
		setActive(arg_59_0.topChapter:Find("type_escort"), false)
		setActive(arg_59_0.topChapter:Find("type_skirmish"), false)

		if arg_59_0.newChapterCDTimer then
			arg_59_0.newChapterCDTimer:Stop()

			arg_59_0.newChapterCDTimer = nil
		end

		arg_59_0:RecordLastMapOnExit()

		arg_59_0.contextData.mapIdx = nil
		arg_59_0.contextData.map = nil
	end

	arg_59_0:PlayBGM()
end

function var_0_0.PreloadLevelMainUI(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_0.preloadLevelDone then
		existCall(arg_60_2)

		return
	end

	local var_60_0

	local function var_60_1()
		if not arg_60_0.exited then
			arg_60_0.preloadLevelDone = true

			existCall(arg_60_2)
		end
	end

	local var_60_2 = getProxy(ChapterProxy):getMapById(arg_60_1)
	local var_60_3 = arg_60_0:GetMapBG(var_60_2)

	table.ParallelIpairsAsync(var_60_3, function(arg_62_0, arg_62_1, arg_62_2)
		GetSpriteFromAtlasAsync("levelmap/" .. arg_62_1.BG, "", arg_62_2)
	end, var_60_1)
end

function var_0_0.selectMap(arg_63_0)
	local var_63_0 = arg_63_0.contextData.mapIdx

	if not var_63_0 then
		local var_63_1 = getProxy(ChapterProxy)
		local var_63_2 = Map.lastMap and var_63_1:getMapById(Map.lastMap)

		if var_63_2 and var_63_2:isUnlock() then
			var_63_0 = Map.lastMap
		else
			var_63_0 = var_63_1:getLastUnlockMap().id
		end
	end

	return var_63_0
end

function var_0_0.setShips(arg_64_0, arg_64_1)
	arg_64_0.shipVOs = arg_64_1
end

function var_0_0.updateRes(arg_65_0, arg_65_1)
	if arg_65_0.levelStageView then
		arg_65_0.levelStageView:ActionInvoke("SetPlayer", arg_65_1)
	end

	arg_65_0.player = arg_65_1
end

function var_0_0.setEliteQuota(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_2 - arg_66_1
	local var_66_1 = arg_66_0:findTF("bg/Text", arg_66_0.eliteQuota):GetComponent(typeof(Text))

	if arg_66_1 == arg_66_2 then
		var_66_1.color = Color.red
	else
		var_66_1.color = Color.New(0.47, 0.89, 0.27)
	end

	var_66_1.text = var_66_0 .. "/" .. arg_66_2
end

function var_0_0.updateEvent(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_1:hasFinishState()

	setActive(arg_67_0.btnSpecial:Find("tip"), var_67_0)
	setActive(arg_67_0.entranceLayer:Find("btns/btn_task/tip"), var_67_0)
end

function var_0_0.updateFleet(arg_68_0, arg_68_1)
	arg_68_0.fleets = arg_68_1
end

function var_0_0.updateChapterVO(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = arg_69_1:getConfig("map")

	if not arg_69_0.contextData.chapterVO and arg_69_0.contextData.mapIdx == var_69_0 and bit.band(arg_69_2, ChapterConst.DirtyMapItems) > 0 then
		arg_69_0:updateMapItems()
	end

	if arg_69_0.contextData.chapterVO and arg_69_0.contextData.chapterVO.id == arg_69_1.id and arg_69_1.active then
		arg_69_0:setChapter(arg_69_1)
	end

	if arg_69_0.contextData.chapterVO and arg_69_0.contextData.chapterVO.id == arg_69_1.id and arg_69_1.active and arg_69_0.levelStageView and arg_69_0.grid then
		local var_69_1 = false
		local var_69_2 = false
		local var_69_3 = false

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyFleet) > 0 then
			arg_69_0.levelStageView:updateStageFleet()
			arg_69_0.levelStageView:updateAmbushRate(arg_69_1.fleet.line, true)

			var_69_3 = true

			if arg_69_0.grid then
				arg_69_0.grid:RefreshFleetCells()
				arg_69_0.grid:UpdateFloor()

				var_69_1 = true
			end
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyChampion) > 0 then
			var_69_3 = true

			if arg_69_0.grid then
				arg_69_0.grid:UpdateFleets()
				arg_69_0.grid:clearChampions()
				arg_69_0.grid:initChampions()

				var_69_2 = true
			end
		elseif bit.band(arg_69_2, ChapterConst.DirtyChampionPosition) > 0 then
			var_69_3 = true

			if arg_69_0.grid then
				arg_69_0.grid:UpdateFleets()
				arg_69_0.grid:updateChampions()

				var_69_2 = true
			end
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyAchieve) > 0 then
			arg_69_0.levelStageView:updateStageAchieve()
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyAttachment) > 0 then
			arg_69_0.levelStageView:updateAmbushRate(arg_69_1.fleet.line, true)

			if arg_69_0.grid then
				if not (arg_69_2 < 0) and not (bit.band(arg_69_2, ChapterConst.DirtyFleet) > 0) then
					arg_69_0.grid:updateFleet(arg_69_1.fleets[arg_69_1.findex].id)
				end

				arg_69_0.grid:updateAttachments()

				if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyAutoAction) > 0 then
					arg_69_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)
				else
					var_69_1 = true
				end
			end
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyStrategy) > 0 then
			arg_69_0.levelStageView:updateStageStrategy()

			var_69_3 = true

			arg_69_0.levelStageView:updateStageBarrier()
			arg_69_0.levelStageView:UpdateAutoFightPanel()
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyAutoAction) > 0 then
			-- block empty
		elseif var_69_1 then
			arg_69_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)
		elseif var_69_2 then
			arg_69_0.grid:updateQuadCells(ChapterConst.QuadStateFrozen)
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyCellFlag) > 0 then
			arg_69_0.grid:UpdateFloor()
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyBase) > 0 then
			arg_69_0.levelStageView:UpdateDefenseStatus()
		end

		if arg_69_2 < 0 or bit.band(arg_69_2, ChapterConst.DirtyFloatItems) > 0 then
			arg_69_0.grid:UpdateItemCells()
		end

		if var_69_3 then
			arg_69_0.levelStageView:updateFleetBuff()
		end
	end
end

function var_0_0.updateClouds(arg_70_0)
	arg_70_0.cloudRTFs = {}
	arg_70_0.cloudRects = {}
	arg_70_0.cloudTimer = {}

	for iter_70_0 = 1, 6 do
		local var_70_0 = arg_70_0:findTF("cloud_" .. iter_70_0, arg_70_0.clouds)
		local var_70_1 = rtf(var_70_0)

		table.insert(arg_70_0.cloudRTFs, var_70_1)
		table.insert(arg_70_0.cloudRects, var_70_1.rect.width)
	end

	arg_70_0:initCloudsPos()

	for iter_70_1, iter_70_2 in ipairs(arg_70_0.cloudRTFs) do
		local var_70_2 = arg_70_0.cloudRects[iter_70_1]
		local var_70_3 = arg_70_0.initPositions[iter_70_1] or Vector2(0, 0)
		local var_70_4 = 30 - var_70_3.y / 20
		local var_70_5 = (arg_70_0.mapWidth + var_70_2) / var_70_4
		local var_70_6

		var_70_6 = LeanTween.moveX(iter_70_2, arg_70_0.mapWidth, var_70_5):setRepeat(-1):setOnCompleteOnRepeat(true):setOnComplete(System.Action(function()
			var_70_2 = arg_70_0.cloudRects[iter_70_1]
			iter_70_2.anchoredPosition = Vector2(-var_70_2, var_70_3.y)

			var_70_6:setFrom(-var_70_2):setTime((arg_70_0.mapWidth + var_70_2) / var_70_4)
		end))
		var_70_6.passed = math.random() * var_70_5
		arg_70_0.cloudTimer[iter_70_1] = var_70_6.uniqueId
	end
end

function var_0_0.RefreshMapBG(arg_72_0)
	arg_72_0:PlayBGM()
	arg_72_0:SwitchMapBG(arg_72_0.contextData.map, arg_72_0.lastMapIdx, true)
end

function var_0_0.updateCouldAnimator(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_1 then
		local var_73_0 = arg_73_0.contextData.map:getConfig("ani_controller")

		local function var_73_1(arg_74_0)
			arg_74_0 = tf(arg_74_0)

			local var_74_0 = Vector3.one

			if arg_74_0.rect.width > 0 and arg_74_0.rect.height > 0 then
				var_74_0.x = arg_74_0.parent.rect.width / arg_74_0.rect.width
				var_74_0.y = arg_74_0.parent.rect.height / arg_74_0.rect.height
			end

			arg_74_0.localScale = var_74_0

			if var_73_0 and #var_73_0 > 0 then
				(function()
					for iter_75_0, iter_75_1 in ipairs(var_73_0) do
						if iter_75_1[1] == var_0_2 then
							local var_75_0 = iter_75_1[2][1]
							local var_75_1 = _.rest(iter_75_1[2], 2)

							for iter_75_2, iter_75_3 in ipairs(var_75_1) do
								local var_75_2 = arg_74_0:Find(iter_75_3)

								if not IsNil(var_75_2) then
									local var_75_3 = getProxy(ChapterProxy):GetChapterItemById(var_75_0)

									if var_75_3 and not var_75_3:isClear() then
										setActive(var_75_2, false)
									end
								end
							end
						elseif iter_75_1[1] == var_0_3 then
							local var_75_4 = iter_75_1[2][1]
							local var_75_5 = _.rest(iter_75_1[2], 2)

							for iter_75_4, iter_75_5 in ipairs(var_75_5) do
								local var_75_6 = arg_74_0:Find(iter_75_5)

								if not IsNil(var_75_6) then
									local var_75_7 = getProxy(ChapterProxy):GetChapterItemById(var_75_4)

									if var_75_7 and not var_75_7:isClear() then
										setActive(var_75_6, true)

										return
									end
								end
							end
						elseif iter_75_1[1] == var_0_4 then
							local var_75_8 = iter_75_1[2][1]
							local var_75_9 = _.rest(iter_75_1[2], 2)

							for iter_75_6, iter_75_7 in ipairs(var_75_9) do
								local var_75_10 = arg_74_0:Find(iter_75_7)

								if not IsNil(var_75_10) then
									local var_75_11 = getProxy(ChapterProxy):GetChapterItemById(var_75_8)

									if var_75_11 and not var_75_11:isClear() then
										setActive(var_75_10, true)
									end
								end
							end
						end
					end
				end)()
			end
		end

		local var_73_2 = arg_73_0.loader:GetPrefab("ui/" .. arg_73_1, arg_73_1, function(arg_76_0)
			arg_76_0:SetActive(true)

			local var_76_0 = arg_73_0.mapTFs[arg_73_2]

			setParent(arg_76_0, var_76_0)
			pg.ViewUtils.SetSortingOrder(arg_76_0, ChapterConst.LayerWeightMap + arg_73_2 * 2 - 1)
			var_73_1(arg_76_0)
		end)

		table.insert(arg_73_0.mapGroup, var_73_2)
	end
end

function var_0_0.updateMapItems(arg_77_0)
	local var_77_0 = arg_77_0.contextData.map
	local var_77_1 = var_77_0:getConfig("cloud_suffix")

	if var_77_1 == "" then
		setActive(arg_77_0.clouds, false)
	else
		setActive(arg_77_0.clouds, true)

		for iter_77_0, iter_77_1 in ipairs(var_77_0:getConfig("clouds_pos")) do
			local var_77_2 = arg_77_0.cloudRTFs[iter_77_0]
			local var_77_3 = var_77_2:GetComponent(typeof(Image))

			var_77_3.enabled = false

			GetSpriteFromAtlasAsync("clouds/cloud_" .. iter_77_0 .. "_" .. var_77_1, "", function(arg_78_0)
				if not arg_77_0.exited and not IsNil(var_77_3) and var_77_0 == arg_77_0.contextData.map then
					var_77_3.enabled = true
					var_77_3.sprite = arg_78_0

					var_77_3:SetNativeSize()

					arg_77_0.cloudRects[iter_77_0] = var_77_2.rect.width
				end
			end)
		end
	end

	arg_77_0.mapBuilder.buffer:UpdateMapItems(var_77_0)
end

function var_0_0.updateDifficultyBtns(arg_79_0)
	local var_79_0 = arg_79_0.contextData.map:getConfig("type")

	setActive(arg_79_0.normalBtn, var_79_0 == Map.ELITE)
	setActive(arg_79_0.eliteQuota, var_79_0 == Map.ELITE)
	setActive(arg_79_0.eliteBtn, var_79_0 == Map.SCENARIO)

	local var_79_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.ELITE_AWARD_ACTIVITY_ID)

	setActive(arg_79_0.eliteBtn:Find("pic_activity"), var_79_1 and not var_79_1:isEnd())
end

function var_0_0.updateActivityBtns(arg_80_0)
	local var_80_0, var_80_1 = arg_80_0.contextData.map:isActivity()
	local var_80_2 = arg_80_0.contextData.map:isRemaster()
	local var_80_3 = arg_80_0.contextData.map:isSkirmish()
	local var_80_4 = arg_80_0.contextData.map:isEscort()
	local var_80_5 = arg_80_0.contextData.map:getConfig("type")
	local var_80_6 = getProxy(ActivityProxy):GetEarliestActByType(ActivityConst.ACTIVITY_TYPE_ZPROJECT)
	local var_80_7 = var_80_6 and not var_80_6:isEnd() and not var_80_0 and not var_80_3 and not var_80_4

	if var_80_7 then
		local var_80_8 = setmetatable({}, MainActMapBtn)

		var_80_8.image = arg_80_0.activityBtn:Find("Image"):GetComponent(typeof(Image))
		var_80_8.subImage = arg_80_0.activityBtn:Find("sub_Image"):GetComponent(typeof(Image))
		var_80_8.tipTr = arg_80_0.activityBtn:Find("Tip"):GetComponent(typeof(Image))
		var_80_8.tipTxt = arg_80_0.activityBtn:Find("Tip/Text"):GetComponent(typeof(Text))
		var_80_7 = var_80_8:InShowTime()

		if var_80_7 then
			var_80_8:InitTipImage()
			var_80_8:InitSubImage()
			var_80_8:InitImage(function()
				return
			end)
			var_80_8:OnInit()
		end
	end

	setActive(arg_80_0.activityBtn, var_80_7)
	arg_80_0:updateRemasterInfo()

	if var_80_0 and var_80_1 then
		local var_80_9 = getProxy(ChapterProxy):getMapsByActivities()
		local var_80_10 = underscore.any(var_80_9, function(arg_82_0)
			return arg_82_0:isActExtra()
		end)

		setActive(arg_80_0.actExtraBtn, var_80_10 and not var_80_2 and var_80_5 ~= Map.ACT_EXTRA)

		if isActive(arg_80_0.actExtraBtn) then
			if underscore.all(underscore.filter(var_80_9, function(arg_83_0)
				local var_83_0 = arg_83_0:getMapType()

				return var_83_0 == Map.ACTIVITY_EASY or var_83_0 == Map.ACTIVITY_HARD
			end), function(arg_84_0)
				return arg_84_0:isAllChaptersClear()
			end) then
				setActive(arg_80_0.actExtraBtnAnim, true)
			else
				setActive(arg_80_0.actExtraBtnAnim, false)
			end

			setActive(arg_80_0.actExtraBtn:Find("Tip"), getProxy(ChapterProxy):IsActivitySPChapterActive() and SettingsProxy.IsShowActivityMapSPTip())
		end

		local var_80_11 = checkExist(arg_80_0.contextData.map:getBindMap(), {
			"isHardMap"
		})

		setActive(arg_80_0.actEliteBtn, var_80_11 and var_80_5 ~= Map.ACTIVITY_HARD)
		setActive(arg_80_0.actNormalBtn, var_80_5 ~= Map.ACTIVITY_EASY)
		setActive(arg_80_0.actExtraRank, var_80_5 == Map.ACT_EXTRA)
		setActive(arg_80_0.actExchangeShopBtn, not var_80_2 and var_80_1 and not ActivityConst.HIDE_PT_PANELS)
		setActive(arg_80_0.ptTotal, not var_80_2 and var_80_1 and not ActivityConst.HIDE_PT_PANELS and arg_80_0.ptActivity and not arg_80_0.ptActivity:isEnd())
		arg_80_0:updateActivityRes()
	else
		setActive(arg_80_0.actExtraBtn, false)
		setActive(arg_80_0.actEliteBtn, false)
		setActive(arg_80_0.actNormalBtn, false)
		setActive(arg_80_0.actExtraRank, false)
		setActive(arg_80_0.actExchangeShopBtn, false)
		setActive(arg_80_0.actAtelierBuffBtn, false)
		setActive(arg_80_0.ptTotal, false)
	end

	setActive(arg_80_0.eventContainer, (not var_80_0 or not var_80_1) and not var_80_4)
	setActive(arg_80_0.remasterBtn, OPEN_REMASTER and (var_80_2 or not var_80_0 and not var_80_4 and not var_80_3))
	setActive(arg_80_0.ticketTxt.parent, var_80_2)
	arg_80_0:updateRemasterTicket()
	arg_80_0:updateCountDown()
	arg_80_0:registerActBtn()

	if var_80_0 and var_80_5 ~= Map.ACT_EXTRA then
		Map.lastMapForActivity = arg_80_0.contextData.mapIdx
	end
end

function var_0_0.updateRemasterTicket(arg_85_0)
	setText(arg_85_0.ticketTxt, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	arg_85_0:emit(LevelUIConst.FLUSH_REMASTER_TICKET)
end

function var_0_0.updateRemasterBtnTip(arg_86_0)
	local var_86_0 = getProxy(ChapterProxy)
	local var_86_1 = var_86_0:ifShowRemasterTip() or var_86_0:anyRemasterAwardCanReceive()

	SetActive(arg_86_0.remasterBtn:Find("tip"), var_86_1)
	SetActive(arg_86_0.entranceLayer:Find("btns/btn_remaster/tip"), var_86_1)
end

function var_0_0.updatDailyBtnTip(arg_87_0)
	local var_87_0 = getProxy(DailyLevelProxy):ifShowDailyTip()

	SetActive(arg_87_0.dailyBtn:Find("tip"), var_87_0)
	SetActive(arg_87_0.entranceLayer:Find("btns/btn_daily/tip"), var_87_0)
end

function var_0_0.updateRemasterInfo(arg_88_0)
	arg_88_0:emit(LevelUIConst.FLUSH_REMASTER_INFO)

	if not arg_88_0.contextData.map then
		return
	end

	local var_88_0 = getProxy(ChapterProxy)
	local var_88_1
	local var_88_2 = arg_88_0.contextData.map:getRemaster()

	if var_88_2 and #pg.re_map_template[var_88_2].drop_gain > 0 then
		for iter_88_0, iter_88_1 in ipairs(pg.re_map_template[var_88_2].drop_gain) do
			if #iter_88_1 > 0 and var_88_0.remasterInfo[iter_88_1[1]][iter_88_0].receive == false then
				var_88_1 = {
					iter_88_0,
					iter_88_1
				}

				break
			end
		end
	end

	setActive(arg_88_0.remasterAwardBtn, var_88_1)

	if var_88_1 then
		local var_88_3 = var_88_1[1]
		local var_88_4, var_88_5, var_88_6, var_88_7 = unpack(var_88_1[2])
		local var_88_8 = var_88_0.remasterInfo[var_88_4][var_88_3]

		setText(arg_88_0.remasterAwardBtn:Find("Text"), var_88_8.count .. "/" .. var_88_7)
		updateDrop(arg_88_0.remasterAwardBtn:Find("IconTpl"), {
			type = var_88_5,
			id = var_88_6
		})
		setActive(arg_88_0.remasterAwardBtn:Find("tip"), var_88_7 <= var_88_8.count)
		onButton(arg_88_0, arg_88_0.remasterAwardBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				hideNo = true,
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = {
					type = var_88_5,
					id = var_88_6
				},
				weight = LayerWeightConst.TOP_LAYER,
				remaster = {
					word = i18n("level_remaster_tip4", pg.chapter_template[var_88_4].chapter_name),
					number = var_88_8.count .. "/" .. var_88_7,
					btn_text = i18n(var_88_8.count < var_88_7 and "level_remaster_tip2" or "level_remaster_tip3"),
					btn_call = function()
						if var_88_8.count < var_88_7 then
							local var_90_0 = pg.chapter_template[var_88_4].map
							local var_90_1, var_90_2 = var_88_0:getMapById(var_90_0):isUnlock()

							if not var_90_1 then
								pg.TipsMgr.GetInstance():ShowTips(var_90_2)
							else
								arg_88_0:ShowSelectedMap(var_90_0)
							end
						else
							arg_88_0:emit(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, var_88_4, var_88_3)
						end
					end
				}
			})
		end, SFX_PANEL)
	end
end

function var_0_0.updateCountDown(arg_91_0)
	local var_91_0 = getProxy(ChapterProxy)

	if arg_91_0.newChapterCDTimer then
		arg_91_0.newChapterCDTimer:Stop()

		arg_91_0.newChapterCDTimer = nil
	end

	local var_91_1 = 0

	if arg_91_0.contextData.map:isActivity() and not arg_91_0.contextData.map:isRemaster() then
		local var_91_2 = var_91_0:getMapsByActivities()

		_.each(var_91_2, function(arg_92_0)
			local var_92_0 = arg_92_0:getChapterTimeLimit()

			if var_91_1 == 0 then
				var_91_1 = var_92_0
			else
				var_91_1 = math.min(var_91_1, var_92_0)
			end
		end)
		setActive(arg_91_0.countDown, var_91_1 > 0)
		setText(arg_91_0.countDown:Find("title"), i18n("levelScene_new_chapter_coming"))
	else
		setActive(arg_91_0.countDown, false)
	end

	if var_91_1 > 0 then
		setText(arg_91_0.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_91_1))

		arg_91_0.newChapterCDTimer = Timer.New(function()
			var_91_1 = var_91_1 - 1

			if var_91_1 <= 0 then
				arg_91_0:updateCountDown()

				if not arg_91_0.contextData.chapterVO then
					arg_91_0:setMap(arg_91_0.contextData.mapIdx)
				end
			else
				setText(arg_91_0.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_91_1))
			end
		end, 1, -1)

		arg_91_0.newChapterCDTimer:Start()
	else
		setText(arg_91_0.countDown:Find("time"), "")
	end
end

function var_0_0.registerActBtn(arg_94_0)
	if arg_94_0.isRegisterBtn then
		return
	end

	arg_94_0.isRegisterBtn = true

	onButton(arg_94_0, arg_94_0.actExtraRank, function()
		if arg_94_0:isfrozen() then
			return
		end

		arg_94_0:emit(LevelMediator2.ON_EXTRA_RANK)
	end, SFX_PANEL)
	onButton(arg_94_0, arg_94_0.activityBtn, function()
		if arg_94_0:isfrozen() then
			return
		end

		arg_94_0:emit(LevelMediator2.ON_ACTIVITY_MAP)
	end, SFX_UI_CLICK)
	onButton(arg_94_0, arg_94_0.actExchangeShopBtn, function()
		if arg_94_0:isfrozen() then
			return
		end

		arg_94_0:emit(LevelMediator2.GO_ACT_SHOP)
	end, SFX_UI_CLICK)
	onButton(arg_94_0, arg_94_0.actAtelierBuffBtn, function()
		if arg_94_0:isfrozen() then
			return
		end

		arg_94_0:emit(LevelMediator2.SHOW_ATELIER_BUFF)
	end, SFX_UI_CLICK)

	local var_94_0 = getProxy(ChapterProxy)

	local function var_94_1(arg_99_0, arg_99_1, arg_99_2)
		local var_99_0

		if arg_99_0:isRemaster() then
			var_99_0 = var_94_0:getRemasterMaps(arg_99_0.remasterId)
		else
			var_99_0 = var_94_0:getMapsByActivities()
		end

		local var_99_1 = _.select(var_99_0, function(arg_100_0)
			return arg_100_0:getMapType() == arg_99_1
		end)

		table.sort(var_99_1, function(arg_101_0, arg_101_1)
			return arg_101_0.id < arg_101_1.id
		end)

		local var_99_2 = table.indexof(underscore.map(var_99_1, function(arg_102_0)
			return arg_102_0.id
		end), arg_99_2) or #var_99_1

		while not var_99_1[var_99_2]:isUnlock() do
			if var_99_2 > 1 then
				var_99_2 = var_99_2 - 1
			else
				break
			end
		end

		return var_99_1[var_99_2]
	end

	local function var_94_2()
		if arg_94_0:isfrozen() then
			return
		end

		local var_103_0 = arg_94_0.contextData.map:getBindMapId()
		local var_103_1 = var_94_1(arg_94_0.contextData.map, Map.ACTIVITY_HARD, var_103_0)
		local var_103_2, var_103_3 = var_103_1:isUnlock()

		if var_103_2 then
			arg_94_0:setMap(var_103_1.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_103_3)
		end
	end

	onButton(arg_94_0, arg_94_0.actEliteBtn, var_94_2, SFX_PANEL)
	arg_94_0:bind(LevelUIConst.SWITCH_CHALLENGE_MAP, var_94_2)
	onButton(arg_94_0, arg_94_0.actNormalBtn, function()
		if arg_94_0:isfrozen() then
			return
		end

		local var_104_0 = arg_94_0.contextData.map:getBindMapId()
		local var_104_1 = var_94_1(arg_94_0.contextData.map, Map.ACTIVITY_EASY, var_104_0)
		local var_104_2, var_104_3 = var_104_1:isUnlock()

		if var_104_2 then
			arg_94_0:setMap(var_104_1.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_104_3)
		end
	end, SFX_PANEL)
	onButton(arg_94_0, arg_94_0.actExtraBtn, function()
		if arg_94_0:isfrozen() then
			return
		end

		local var_105_0 = PlayerPrefs.HasKey("ex_mapId") and PlayerPrefs.GetInt("ex_mapId", 0) or 0
		local var_105_1 = var_94_1(arg_94_0.contextData.map, Map.ACT_EXTRA, var_105_0)
		local var_105_2, var_105_3 = var_105_1:isUnlock()

		if var_105_2 then
			arg_94_0:setMap(var_105_1.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_105_3)
		end
	end, SFX_PANEL)
end

function var_0_0.initCloudsPos(arg_106_0, arg_106_1)
	arg_106_0.initPositions = {}

	local var_106_0 = arg_106_1 or 1
	local var_106_1 = pg.expedition_data_by_map[var_106_0].clouds_pos

	for iter_106_0, iter_106_1 in ipairs(arg_106_0.cloudRTFs) do
		local var_106_2 = var_106_1[iter_106_0]

		if var_106_2 then
			iter_106_1.anchoredPosition = Vector2(var_106_2[1], var_106_2[2])

			table.insert(arg_106_0.initPositions, iter_106_1.anchoredPosition)
		else
			setActive(iter_106_1, false)
		end
	end
end

function var_0_0.initMapBtn(arg_107_0, arg_107_1, arg_107_2)
	onButton(arg_107_0, arg_107_1, function()
		if arg_107_0:isfrozen() then
			return
		end

		local var_108_0 = arg_107_0.contextData.mapIdx + arg_107_2
		local var_108_1 = getProxy(ChapterProxy):getMapById(var_108_0)

		if not var_108_1 then
			return
		end

		if var_108_1:getMapType() == Map.ELITE and not var_108_1:isEliteEnabled() then
			var_108_1 = var_108_1:getBindMap()
			var_108_0 = var_108_1.id

			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))
		end

		local var_108_2, var_108_3 = var_108_1:isUnlock()

		if arg_107_2 > 0 and not var_108_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_108_3)

			return
		end

		arg_107_0:setMap(var_108_0)
	end, SFX_PANEL)
end

function var_0_0.ShowSelectedMap(arg_109_0, arg_109_1, arg_109_2)
	seriesAsync({
		function(arg_110_0)
			if arg_109_0.contextData.entranceStatus then
				arg_109_0:frozen()

				arg_109_0.nextPreloadMap = arg_109_1

				arg_109_0:PreloadLevelMainUI(arg_109_1, function()
					arg_109_0:unfrozen()

					if arg_109_0.nextPreloadMap ~= arg_109_1 then
						return
					end

					arg_109_0:emit(LevelMediator2.ON_ENTER_MAINLEVEL, arg_109_1)
					arg_109_0:ShowEntranceUI(false)
					arg_110_0()
				end)
			else
				arg_109_0:setMap(arg_109_1)
				arg_110_0()
			end
		end
	}, arg_109_2)
end

function var_0_0.setMap(arg_112_0, arg_112_1)
	arg_112_0.lastMapIdx = arg_112_0.contextData.mapIdx
	arg_112_0.contextData.mapIdx = arg_112_1
	arg_112_0.contextData.map = getProxy(ChapterProxy):getMapById(arg_112_1)

	assert(arg_112_0.contextData.map, "map cannot be nil " .. arg_112_1)

	if arg_112_0.contextData.map:getMapType() == Map.ACT_EXTRA then
		PlayerPrefs.SetInt("ex_mapId", arg_112_0.contextData.map.id)
		PlayerPrefs.Save()
	elseif arg_112_0.contextData.map:isRemaster() then
		PlayerPrefs.SetInt("remaster_lastmap_" .. arg_112_0.contextData.map.remasterId, arg_112_1)
		PlayerPrefs.Save()
	end

	arg_112_0:updateMap()
	arg_112_0:tryPlayMapStory()
end

local var_0_5 = import("view.level.MapBuilder.MapBuilder")
local var_0_6 = {
	default = "MapBuilderNormal",
	[var_0_5.TYPENORMAL] = "MapBuilderNormal",
	[var_0_5.TYPEESCORT] = "MapBuilderEscort",
	[var_0_5.TYPESHINANO] = "MapBuilderShinano",
	[var_0_5.TYPESKIRMISH] = "MapBuilderSkirmish",
	[var_0_5.TYPEBISMARCK] = "MapBuilderBismarck",
	[var_0_5.TYPESSSS] = "MapBuilderSSSS",
	[var_0_5.TYPEATELIER] = "MapBuilderAtelier",
	[var_0_5.TYPESENRANKAGURA] = "MapBuilderSenrankagura"
}

function var_0_0.SwitchMapBuilder(arg_113_0, arg_113_1)
	if arg_113_0.mapBuilder and arg_113_0.mapBuilder:GetType() ~= arg_113_1 then
		arg_113_0.mapBuilder.buffer:Hide()
	end

	local var_113_0 = arg_113_0:GetMapBuilderInBuffer(arg_113_1)

	arg_113_0.mapBuilder = var_113_0

	var_113_0.buffer:Show()
	var_113_0.buffer:ShowButtons()
end

function var_0_0.GetMapBuilderInBuffer(arg_114_0, arg_114_1)
	if not arg_114_0.mbDict[arg_114_1] then
		local var_114_0 = _G[var_0_6[arg_114_1] or var_0_6.default]

		arg_114_0.mbDict[arg_114_1] = var_114_0.New(arg_114_0._tf, arg_114_0)
		arg_114_0.mbDict[arg_114_1].isFrozen = arg_114_0:isfrozen()

		arg_114_0.mbDict[arg_114_1]:Load()
	end

	return arg_114_0.mbDict[arg_114_1]
end

function var_0_0.JudgeMapBuilderType(arg_115_0)
	return (arg_115_0.contextData.map:getConfig("ui_type"))
end

function var_0_0.updateMap(arg_116_0)
	local var_116_0 = arg_116_0.contextData.map

	arg_116_0:SwitchMapBG(var_116_0, arg_116_0.lastMapIdx)

	arg_116_0.lastMapIdx = nil

	local var_116_1 = var_116_0:getConfig("anchor")
	local var_116_2

	if var_116_1 == "" then
		var_116_2 = Vector2.zero
	else
		var_116_2 = Vector2(unpack(var_116_1))
	end

	arg_116_0.map.pivot = var_116_2

	local var_116_3 = var_116_0:getConfig("uifx")

	for iter_116_0 = 1, arg_116_0.UIFXList.childCount do
		local var_116_4 = arg_116_0.UIFXList:GetChild(iter_116_0 - 1)

		setActive(var_116_4, var_116_4.name == var_116_3)
	end

	arg_116_0:PlayBGM()

	local var_116_5 = arg_116_0:JudgeMapBuilderType()

	arg_116_0:SwitchMapBuilder(var_116_5)
	arg_116_0.mapBuilder.buffer:Update(var_116_0)
	arg_116_0:UpdateSwitchMapButton()
	arg_116_0:updateMapItems()
	arg_116_0.mapBuilder.buffer:UpdateButtons()
	arg_116_0.mapBuilder.buffer:PostUpdateMap(var_116_0)

	if arg_116_0.contextData.openChapterId then
		arg_116_0.mapBuilder.buffer:TryOpenChapter(arg_116_0.contextData.openChapterId)

		arg_116_0.contextData.openChapterId = nil
	end
end

function var_0_0.UpdateSwitchMapButton(arg_117_0)
	local var_117_0 = arg_117_0.contextData.map
	local var_117_1 = getProxy(ChapterProxy)
	local var_117_2 = var_117_1:getMapById(var_117_0.id - 1)
	local var_117_3 = var_117_1:getMapById(var_117_0.id + 1)

	setActive(arg_117_0.btnPrev, tobool(var_117_2))
	setActive(arg_117_0.btnNext, tobool(var_117_3))

	local var_117_4 = Color.New(0.5, 0.5, 0.5, 1)

	setImageColor(arg_117_0.btnPrevCol, var_117_2 and Color.white or var_117_4)
	setImageColor(arg_117_0.btnNextCol, var_117_3 and var_117_3:isUnlock() and Color.white or var_117_4)
end

function var_0_0.TrySwitchChapter(arg_118_0, arg_118_1)
	local var_118_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_118_0 then
		if var_118_0.id == arg_118_1.id then
			arg_118_0:switchToChapter(var_118_0)
		else
			local var_118_1 = i18n("levelScene_chapter_strategying", var_118_0:getConfig("chapter_name"))

			pg.TipsMgr.GetInstance():ShowTips(var_118_1)
		end
	else
		arg_118_0:displayChapterPanel(arg_118_1)
	end
end

function var_0_0.updateChapterTF(arg_119_0, arg_119_1)
	if not arg_119_0.mapBuilder.UpdateChapterTF then
		return
	end

	arg_119_0.mapBuilder.buffer:UpdateChapterTF(arg_119_1)
end

function var_0_0.tryPlayMapStory(arg_120_0)
	if IsUnityEditor and not ENABLE_GUIDE then
		return
	end

	seriesAsync({
		function(arg_121_0)
			local var_121_0 = arg_120_0.contextData.map:getConfig("enter_story")

			if var_121_0 and var_121_0 ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(var_121_0) and not arg_120_0.contextData.map:isRemaster() and not pg.SystemOpenMgr.GetInstance().active then
				local var_121_1 = tonumber(var_121_0)

				if var_121_1 and var_121_1 > 0 then
					arg_120_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_121_1)
				else
					pg.NewStoryMgr.GetInstance():Play(var_121_0, arg_121_0)
				end

				return
			end

			arg_121_0()
		end,
		function(arg_122_0)
			local var_122_0 = arg_120_0.contextData.map:getConfig("guide_id")

			if var_122_0 and var_122_0 ~= "" then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_122_0, nil, arg_122_0)

				return
			end

			arg_122_0()
		end,
		function(arg_123_0)
			if isActive(arg_120_0.actAtelierBuffBtn) and getProxy(ActivityProxy):AtelierActivityAllSlotIsEmpty() and getProxy(ActivityProxy):OwnAtelierActivityItemCnt(34, 1) then
				local var_123_0 = PlayerPrefs.GetInt("first_enter_ryza_buff_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0
				local var_123_1

				if var_123_0 then
					var_123_1 = {
						1,
						2
					}
				else
					var_123_1 = {
						1
					}
				end

				pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0034", var_123_1)
			else
				arg_123_0()
			end
		end,
		function(arg_124_0)
			if arg_120_0.exited then
				return
			end

			pg.SystemOpenMgr.GetInstance():notification(arg_120_0.player.level)

			if pg.SystemOpenMgr.GetInstance().active then
				getProxy(ChapterProxy):StopAutoFight()
			end
		end
	})
end

function var_0_0.DisplaySPAnim(arg_125_0, arg_125_1, arg_125_2, arg_125_3)
	arg_125_0.uiAnims = arg_125_0.uiAnims or {}

	local var_125_0 = arg_125_0.uiAnims[arg_125_1]

	local function var_125_1()
		arg_125_0.playing = true

		arg_125_0:frozen()
		var_125_0:SetActive(true)

		local var_126_0 = tf(var_125_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_126_0, {
			groupName = LayerWeightConst.GROUP_LEVELUI
		})

		if arg_125_3 then
			arg_125_3(var_125_0)
		end

		var_126_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_127_0)
			arg_125_0.playing = false

			if arg_125_2 then
				arg_125_2(var_125_0)
			end

			arg_125_0:unfrozen()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
	end

	if not var_125_0 then
		PoolMgr.GetInstance():GetUI(arg_125_1, true, function(arg_128_0)
			arg_128_0:SetActive(true)

			arg_125_0.uiAnims[arg_125_1] = arg_128_0
			var_125_0 = arg_125_0.uiAnims[arg_125_1]

			var_125_1()
		end)
	else
		var_125_1()
	end
end

function var_0_0.displaySpResult(arg_129_0, arg_129_1, arg_129_2)
	setActive(arg_129_0.spResult, true)
	arg_129_0:DisplaySPAnim(arg_129_1 == 1 and "SpUnitWin" or "SpUnitLose", function(arg_130_0)
		onButton(arg_129_0, arg_130_0, function()
			removeOnButton(arg_130_0)
			setActive(arg_130_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_130_0, arg_129_0._tf)
			arg_129_0:hideSpResult()
			arg_129_2()
		end, SFX_PANEL)
	end)
end

function var_0_0.hideSpResult(arg_132_0)
	setActive(arg_132_0.spResult, false)
end

function var_0_0.displayBombResult(arg_133_0, arg_133_1)
	setActive(arg_133_0.spResult, true)
	arg_133_0:DisplaySPAnim("SpBombRet", function(arg_134_0)
		onButton(arg_133_0, arg_134_0, function()
			removeOnButton(arg_134_0)
			setActive(arg_134_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_134_0, arg_133_0._tf)
			arg_133_0:hideSpResult()
			arg_133_1()
		end, SFX_PANEL)
	end, function(arg_136_0)
		setText(arg_136_0.transform:Find("right/name_bg/en"), arg_133_0.contextData.chapterVO.modelCount)
	end)
end

function var_0_0.displayChapterPanel(arg_137_0, arg_137_1, arg_137_2)
	local function var_137_0(arg_138_0)
		if getProxy(BayProxy):getShipCount() >= arg_137_0.player:getMaxShipBag() then
			NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

			return
		end

		arg_137_0:hideChapterPanel()

		local var_138_0 = arg_137_1:getConfig("type")

		arg_137_0.contextData.chapterLoopFlag = arg_138_0

		if var_138_0 == Chapter.CustomFleet then
			arg_137_0:displayFleetEdit(arg_137_1)
		elseif #arg_137_1:getNpcShipByType(1) > 0 then
			arg_137_0:emit(LevelMediator2.ON_TRACKING, arg_137_1.id)

			return
		else
			arg_137_0:displayFleetSelect(arg_137_1)
		end
	end

	local function var_137_1()
		arg_137_0:hideChapterPanel()
	end

	if getProxy(ChapterProxy):getMapById(arg_137_1:getConfig("map")):isSkirmish() and #arg_137_1:getNpcShipByType(1) > 0 then
		var_137_0(false)

		return
	end

	arg_137_0.levelInfoView:Load()
	arg_137_0.levelInfoView:ActionInvoke("set", arg_137_1, arg_137_2)
	arg_137_0.levelInfoView:ActionInvoke("setCBFunc", var_137_0, var_137_1)
	arg_137_0.levelInfoView:ActionInvoke("Show")
end

function var_0_0.hideChapterPanel(arg_140_0)
	if arg_140_0.levelInfoView:isShowing() then
		arg_140_0.levelInfoView:ActionInvoke("Hide")
	end
end

function var_0_0.destroyChapterPanel(arg_141_0)
	arg_141_0.levelInfoView:Destroy()

	arg_141_0.levelInfoView = nil
end

function var_0_0.displayFleetSelect(arg_142_0, arg_142_1)
	local var_142_0 = arg_142_0.contextData.selectedFleetIDs or arg_142_1:GetDefaultFleetIndex()

	arg_142_1 = Clone(arg_142_1)
	arg_142_1.loopFlag = arg_142_0.contextData.chapterLoopFlag

	arg_142_0.levelFleetView:updateSpecialOperationTickets(arg_142_0.spTickets)
	arg_142_0.levelFleetView:Load()
	arg_142_0.levelFleetView:ActionInvoke("setHardShipVOs", arg_142_0.shipVOs)
	arg_142_0.levelFleetView:ActionInvoke("setOpenCommanderTag", arg_142_0.openedCommanerSystem)
	arg_142_0.levelFleetView:ActionInvoke("set", arg_142_1, arg_142_0.fleets, var_142_0)
	arg_142_0.levelFleetView:ActionInvoke("Show")
end

function var_0_0.hideFleetSelect(arg_143_0)
	if arg_143_0.levelCMDFormationView:isShowing() then
		arg_143_0.levelCMDFormationView:Hide()
	end

	if arg_143_0.levelFleetView then
		arg_143_0.levelFleetView:Hide()
	end
end

function var_0_0.buildCommanderPanel(arg_144_0)
	arg_144_0.levelCMDFormationView = LevelCMDFormationView.New(arg_144_0.topPanel, arg_144_0.event, arg_144_0.contextData)
end

function var_0_0.destroyFleetSelect(arg_145_0)
	if not arg_145_0.levelFleetView then
		return
	end

	arg_145_0.levelFleetView:Destroy()

	arg_145_0.levelFleetView = nil
end

function var_0_0.displayFleetEdit(arg_146_0, arg_146_1)
	arg_146_1 = Clone(arg_146_1)
	arg_146_1.loopFlag = arg_146_0.contextData.chapterLoopFlag

	arg_146_0.levelFleetView:updateSpecialOperationTickets(arg_146_0.spTickets)
	arg_146_0.levelFleetView:Load()
	arg_146_0.levelFleetView:ActionInvoke("setOpenCommanderTag", arg_146_0.openedCommanerSystem)
	arg_146_0.levelFleetView:ActionInvoke("setHardShipVOs", arg_146_0.shipVOs)
	arg_146_0.levelFleetView:ActionInvoke("setOnHard", arg_146_1)
	arg_146_0.levelFleetView:ActionInvoke("Show")
end

function var_0_0.hideFleetEdit(arg_147_0)
	arg_147_0:hideFleetSelect()
end

function var_0_0.destroyFleetEdit(arg_148_0)
	arg_148_0:destroyFleetSelect()
end

function var_0_0.RefreshFleetSelectView(arg_149_0, arg_149_1)
	if not arg_149_0.levelFleetView then
		return
	end

	assert(arg_149_0.levelFleetView:GetLoaded())

	local var_149_0 = arg_149_0.levelFleetView:IsSelectMode()
	local var_149_1

	if var_149_0 then
		arg_149_0.levelFleetView:ActionInvoke("set", arg_149_1 or arg_149_0.levelFleetView.chapter, arg_149_0.fleets, arg_149_0.levelFleetView:getSelectIds())

		if arg_149_0.levelCMDFormationView:isShowing() then
			local var_149_2 = arg_149_0.levelCMDFormationView.fleet.id

			var_149_1 = arg_149_0.fleets[var_149_2]
		end
	else
		arg_149_0.levelFleetView:ActionInvoke("setOnHard", arg_149_1 or arg_149_0.levelFleetView.chapter)

		if arg_149_0.levelCMDFormationView:isShowing() then
			local var_149_3 = arg_149_0.levelCMDFormationView.fleet.id

			var_149_1 = arg_149_1:wrapEliteFleet(var_149_3)
		end
	end

	if var_149_1 then
		arg_149_0.levelCMDFormationView:ActionInvoke("updateFleet", var_149_1)
	end
end

function var_0_0.setChapter(arg_150_0, arg_150_1)
	local var_150_0

	if arg_150_1 then
		var_150_0 = arg_150_1.id
	end

	arg_150_0.contextData.chapterId = var_150_0
	arg_150_0.contextData.chapterVO = arg_150_1
end

function var_0_0.switchToChapter(arg_151_0, arg_151_1, arg_151_2)
	if arg_151_0.contextData.mapIdx ~= arg_151_1:getConfig("map") then
		arg_151_0:setMap(arg_151_1:getConfig("map"))
	end

	arg_151_0:setChapter(arg_151_1)
	setActive(arg_151_0.clouds, false)
	arg_151_0.mapBuilder.buffer:Hide()

	arg_151_0.leftCanvasGroup.blocksRaycasts = false
	arg_151_0.rightCanvasGroup.blocksRaycasts = false

	assert(not arg_151_0.levelStageView, "LevelStageView Exists On SwitchToChapter")
	arg_151_0:DestroyLevelStageView()

	if not arg_151_0.levelStageView then
		arg_151_0.levelStageView = LevelStageView.New(arg_151_0.topPanel, arg_151_0.event, arg_151_0.contextData)

		arg_151_0.levelStageView:Load()

		arg_151_0.levelStageView.isFrozen = arg_151_0:isfrozen()
	end

	arg_151_0:frozen()

	local function var_151_0()
		seriesAsync({
			function(arg_153_0)
				pg.UIMgr.GetInstance():BlurPanel(arg_151_0.topPanel, false, {
					blurCamList = {
						pg.UIMgr.CameraUI
					},
					groupName = LayerWeightConst.GROUP_LEVELUI
				})
				pg.playerResUI:SetActive({
					active = true,
					groupName = LayerWeightConst.GROUP_LEVELUI,
					showType = PlayerResUI.TYPE_ALL
				})
				arg_151_0.levelStageView:updateStageInfo()
				arg_151_0.levelStageView:updateAmbushRate(arg_151_1.fleet.line, true)
				arg_151_0.levelStageView:updateStageAchieve()
				arg_151_0.levelStageView:updateStageBarrier()
				arg_151_0.levelStageView:updateBombPanel()
				arg_151_0.levelStageView:UpdateDefenseStatus()
				onNextTick(arg_153_0)
			end,
			function(arg_154_0)
				if arg_151_0.exited then
					return
				end

				arg_151_0.levelStageView:updateStageStrategy()

				arg_151_0.canvasGroup.blocksRaycasts = arg_151_0.frozenCount == 0

				onNextTick(arg_154_0)
			end,
			function(arg_155_0)
				if arg_151_0.exited then
					return
				end

				arg_151_0.levelStageView:updateStageFleet()
				arg_151_0.levelStageView:updateSupportFleet()
				arg_151_0.levelStageView:updateFleetBuff()
				onNextTick(arg_155_0)
			end,
			function(arg_156_0)
				if arg_151_0.exited then
					return
				end

				parallelAsync({
					function(arg_157_0)
						local var_157_0 = arg_151_1:getConfig("scale")
						local var_157_1 = LeanTween.value(go(arg_151_0.map), arg_151_0.map.localScale, Vector3.New(var_157_0[3], var_157_0[3], 1), var_0_1):setOnUpdateVector3(function(arg_158_0)
							arg_151_0.map.localScale = arg_158_0
							arg_151_0.float.localScale = arg_158_0
						end):setOnComplete(System.Action(arg_157_0)):setEase(LeanTweenType.easeOutSine)

						arg_151_0:RecordTween("mapScale", var_157_1.uniqueId)

						local var_157_2 = LeanTween.value(go(arg_151_0.map), arg_151_0.map.pivot, Vector2.New(math.clamp(var_157_0[1] - 0.5, 0, 1), math.clamp(var_157_0[2] - 0.5, 0, 1)), var_0_1)

						var_157_2:setOnUpdateVector2(function(arg_159_0)
							arg_151_0.map.pivot = arg_159_0
							arg_151_0.float.pivot = arg_159_0
						end):setEase(LeanTweenType.easeOutSine)
						arg_151_0:RecordTween("mapPivot", var_157_2.uniqueId)
						shiftPanel(arg_151_0.leftChapter, -arg_151_0.leftChapter.rect.width - 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(arg_151_0.rightChapter, arg_151_0.rightChapter.rect.width + 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(arg_151_0.topChapter, 0, arg_151_0.topChapter.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						arg_151_0.levelStageView:ShiftStagePanelIn()
					end,
					function(arg_160_0)
						arg_151_0:PlayBGM()

						local var_160_0 = {}
						local var_160_1 = arg_151_1:getConfig("bg")

						if var_160_1 and #var_160_1 > 0 then
							var_160_0[1] = {
								BG = var_160_1
							}
						end

						arg_151_0:SwitchBG(var_160_0, arg_160_0)
					end
				}, function()
					onNextTick(arg_156_0)
					arg_151_0.mapBuilder.buffer:HideButtons()
				end)
			end,
			function(arg_162_0)
				if arg_151_0.exited then
					return
				end

				setActive(arg_151_0.topChapter, false)
				setActive(arg_151_0.leftChapter, false)
				setActive(arg_151_0.rightChapter, false)

				arg_151_0.leftCanvasGroup.blocksRaycasts = true
				arg_151_0.rightCanvasGroup.blocksRaycasts = true

				arg_151_0:initGrid(arg_162_0)
			end,
			function(arg_163_0)
				if arg_151_0.exited then
					return
				end

				arg_151_0.levelStageView:SetGrid(arg_151_0.grid)

				arg_151_0.contextData.huntingRangeVisibility = arg_151_0.contextData.huntingRangeVisibility - 1

				arg_151_0.grid:toggleHuntingRange()

				local var_163_0 = arg_151_1:getConfig("pop_pic")

				if var_163_0 and #var_163_0 > 0 and arg_151_0.FirstEnterChapter == arg_151_1.id then
					arg_151_0:doPlayAnim(var_163_0, function(arg_164_0)
						setActive(arg_164_0, false)

						if arg_151_0.exited then
							return
						end

						arg_163_0()
					end)

					arg_151_0.FirstEnterChapter = nil
				else
					arg_163_0()
				end
			end,
			function(arg_165_0)
				arg_151_0.levelStageView:tryAutoAction(arg_165_0)
			end,
			function(arg_166_0)
				if arg_151_0.exited then
					return
				end

				arg_151_0:unfrozen()
				arg_151_0.levelStageView:tryAutoTrigger(true)

				if arg_151_2 then
					arg_151_2()
				end
			end
		})
	end

	arg_151_0.levelStageView:ActionInvoke("SetSeriesOperation", var_151_0)
	arg_151_0.levelStageView:ActionInvoke("SetPlayer", arg_151_0.player)
	arg_151_0.levelStageView:ActionInvoke("SwitchToChapter", arg_151_1)
end

function var_0_0.switchToMap(arg_167_0, arg_167_1)
	arg_167_0:frozen()
	arg_167_0:destroyGrid()
	LeanTween.cancel(go(arg_167_0.map))

	local var_167_0 = LeanTween.value(go(arg_167_0.map), arg_167_0.map.localScale, Vector3.one, var_0_1):setOnUpdateVector3(function(arg_168_0)
		arg_167_0.map.localScale = arg_168_0
		arg_167_0.float.localScale = arg_168_0
	end):setOnComplete(System.Action(function()
		arg_167_0.mapBuilder.buffer:Show()
		arg_167_0.mapBuilder.buffer:Update(arg_167_0.contextData.map)
		arg_167_0:UpdateSwitchMapButton()
		arg_167_0:updateMapItems()
		arg_167_0.mapBuilder.buffer:UpdateButtons()
		arg_167_0.mapBuilder.buffer:PostUpdateMap(arg_167_0.contextData.map)
		arg_167_0:unfrozen()
		existCall(arg_167_1)
	end)):setEase(LeanTweenType.easeOutSine)

	arg_167_0:RecordTween("mapScale", var_167_0.uniqueId)

	local var_167_1 = arg_167_0.contextData.map:getConfig("anchor")
	local var_167_2

	if var_167_1 == "" then
		var_167_2 = Vector2.zero
	else
		var_167_2 = Vector2(unpack(var_167_1))
	end

	local var_167_3 = LeanTween.value(go(arg_167_0.map), arg_167_0.map.pivot, var_167_2, var_0_1)

	var_167_3:setOnUpdateVector2(function(arg_170_0)
		arg_167_0.map.pivot = arg_170_0
		arg_167_0.float.pivot = arg_170_0
	end):setEase(LeanTweenType.easeOutSine)
	arg_167_0:RecordTween("mapPivot", var_167_3.uniqueId)
	setActive(arg_167_0.topChapter, true)
	setActive(arg_167_0.leftChapter, true)
	setActive(arg_167_0.rightChapter, true)
	shiftPanel(arg_167_0.leftChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_167_0.rightChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_167_0.topChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	assert(arg_167_0.levelStageView, "LevelStageView Doesnt Exist On SwitchToMap")

	if arg_167_0.levelStageView then
		arg_167_0.levelStageView:ActionInvoke("ShiftStagePanelOut", function()
			arg_167_0:DestroyLevelStageView()
		end)
		arg_167_0.levelStageView:ActionInvoke("SwitchToMap")
	end

	arg_167_0:SwitchMapBG(arg_167_0.contextData.map)
	arg_167_0.mapBuilder.buffer:ShowButtons()
	arg_167_0:setChapter(nil)
	arg_167_0:PlayBGM()
	pg.UIMgr.GetInstance():UnblurPanel(arg_167_0.topPanel, arg_167_0._tf)
	pg.playerResUI:SetActive({
		active = false
	})

	arg_167_0.canvasGroup.blocksRaycasts = arg_167_0.frozenCount == 0
	arg_167_0.canvasGroup.interactable = true

	if arg_167_0.ambushWarning and arg_167_0.ambushWarning.activeSelf then
		arg_167_0.ambushWarning:SetActive(false)
		arg_167_0:unfrozen()
	end
end

function var_0_0.SwitchBG(arg_172_0, arg_172_1, arg_172_2, arg_172_3)
	if not arg_172_1 or #arg_172_1 <= 0 then
		existCall(arg_172_2)

		return
	elseif arg_172_3 then
		-- block empty
	elseif table.equal(arg_172_0.currentBG, arg_172_1) then
		return
	end

	arg_172_0.currentBG = arg_172_1

	for iter_172_0, iter_172_1 in ipairs(arg_172_0.mapGroup) do
		arg_172_0.loader:ClearRequest(iter_172_1)
	end

	table.clear(arg_172_0.mapGroup)

	local var_172_0 = {}

	table.ParallelIpairsAsync(arg_172_1, function(arg_173_0, arg_173_1, arg_173_2)
		local var_173_0 = arg_172_0.mapTFs[arg_173_0]
		local var_173_1 = arg_172_0.loader:GetSpriteDirect("levelmap/" .. arg_173_1.BG, "", function(arg_174_0)
			var_172_0[arg_173_0] = arg_174_0

			arg_173_2()
		end, var_173_0)

		table.insert(arg_172_0.mapGroup, var_173_1)
		arg_172_0:updateCouldAnimator(arg_173_1.Animator, arg_173_0)
	end, function()
		for iter_175_0, iter_175_1 in ipairs(arg_172_0.mapTFs) do
			setImageSprite(iter_175_1, var_172_0[iter_175_0])
			setActive(iter_175_1, arg_172_1[iter_175_0])
			SetCompomentEnabled(iter_175_1, typeof(Image), true)
		end

		existCall(arg_172_2)
	end)
end

local var_0_7 = {
	1520001,
	1520002,
	1520011,
	1520012
}
local var_0_8 = {
	{
		1420008,
		"map_1420008",
		1420021,
		"map_1420001"
	},
	{
		1420018,
		"map_1420018",
		1420031,
		"map_1420011"
	}
}
local var_0_9 = {
	1420001,
	1420011
}

function var_0_0.ClearMapTransitions(arg_176_0)
	if not arg_176_0.mapTransitions then
		return
	end

	for iter_176_0, iter_176_1 in pairs(arg_176_0.mapTransitions) do
		if iter_176_1 then
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. iter_176_0, iter_176_0, iter_176_1, true)
		else
			PoolMgr.GetInstance():DestroyPrefab("ui/" .. iter_176_0, iter_176_0)
		end
	end

	arg_176_0.mapTransitions = nil
end

function var_0_0.SwitchMapBG(arg_177_0, arg_177_1, arg_177_2, arg_177_3)
	local var_177_0, var_177_1, var_177_2 = arg_177_0:GetMapBG(arg_177_1, arg_177_2)

	if not var_177_1 then
		arg_177_0:SwitchBG(var_177_0, arg_177_3)

		return
	end

	arg_177_0:PlayMapTransition("LevelMapTransition_" .. var_177_1, var_177_2, function()
		arg_177_0:SwitchBG(var_177_0, arg_177_3)
	end)
end

function var_0_0.GetMapBG(arg_179_0, arg_179_1, arg_179_2)
	if not table.contains(var_0_7, arg_179_1.id) then
		return {
			arg_179_0:GetMapElement(arg_179_1)
		}
	end

	local var_179_0 = arg_179_1.id
	local var_179_1 = table.indexof(var_0_7, var_179_0) - 1
	local var_179_2 = bit.lshift(bit.rshift(var_179_1, 1), 1) + 1
	local var_179_3 = {
		var_0_7[var_179_2],
		var_0_7[var_179_2 + 1]
	}
	local var_179_4 = _.map(var_179_3, function(arg_180_0)
		return getProxy(ChapterProxy):getMapById(arg_180_0)
	end)

	if _.all(var_179_4, function(arg_181_0)
		return arg_181_0:isAllChaptersClear()
	end) then
		local var_179_5 = {
			arg_179_0:GetMapElement(arg_179_1)
		}

		if not arg_179_2 or math.abs(var_179_0 - arg_179_2) ~= 1 then
			return var_179_5
		end

		local var_179_6 = var_0_9[bit.rshift(var_179_2 - 1, 1) + 1]
		local var_179_7 = bit.band(var_179_1, 1) == 1

		return var_179_5, var_179_6, var_179_7
	else
		local var_179_8 = 0

		;(function()
			local var_182_0 = var_179_4[1]:getChapters()

			for iter_182_0, iter_182_1 in ipairs(var_182_0) do
				if not iter_182_1:isClear() then
					return
				end

				var_179_8 = var_179_8 + 1
			end

			if not var_179_4[2]:isAnyChapterUnlocked(true) then
				return
			end

			var_179_8 = var_179_8 + 1

			local var_182_1 = var_179_4[2]:getChapters()

			for iter_182_2, iter_182_3 in ipairs(var_182_1) do
				if not iter_182_3:isClear() then
					return
				end

				var_179_8 = var_179_8 + 1
			end
		end)()

		local var_179_9

		if var_179_8 > 0 then
			local var_179_10 = var_0_8[bit.rshift(var_179_2 - 1, 1) + 1]

			var_179_9 = {
				{
					BG = "map_" .. var_179_10[1],
					Animator = var_179_10[2]
				},
				{
					BG = "map_" .. var_179_10[3] + var_179_8,
					Animator = var_179_10[4]
				}
			}
		else
			var_179_9 = {
				arg_179_0:GetMapElement(arg_179_1)
			}
		end

		return var_179_9
	end
end

function var_0_0.GetMapElement(arg_183_0, arg_183_1)
	local var_183_0 = arg_183_1:getConfig("bg")
	local var_183_1 = arg_183_1:getConfig("ani_controller")

	if var_183_1 and #var_183_1 > 0 then
		(function()
			for iter_184_0, iter_184_1 in ipairs(var_183_1) do
				local var_184_0 = _.rest(iter_184_1[2], 2)

				for iter_184_2, iter_184_3 in ipairs(var_184_0) do
					if string.find(iter_184_3, "^map_") and iter_184_1[1] == var_0_3 then
						local var_184_1 = iter_184_1[2][1]
						local var_184_2 = getProxy(ChapterProxy):GetChapterItemById(var_184_1)

						if var_184_2 and not var_184_2:isClear() then
							var_183_0 = iter_184_3

							return
						end
					end
				end
			end
		end)()
	end

	local var_183_2 = {
		BG = var_183_0
	}

	var_183_2.Animator, var_183_2.AnimatorController = arg_183_0:GetMapAnimator(arg_183_1)

	return var_183_2
end

function var_0_0.GetMapAnimator(arg_185_0, arg_185_1)
	local var_185_0 = arg_185_1:getConfig("ani_name")

	if arg_185_1:getConfig("animtor") == 1 and var_185_0 and #var_185_0 > 0 then
		local var_185_1 = arg_185_1:getConfig("ani_controller")

		if var_185_1 and #var_185_1 > 0 then
			(function()
				for iter_186_0, iter_186_1 in ipairs(var_185_1) do
					local var_186_0 = _.rest(iter_186_1[2], 2)

					for iter_186_2, iter_186_3 in ipairs(var_186_0) do
						if string.find(iter_186_3, "^effect_") and iter_186_1[1] == var_0_3 then
							local var_186_1 = iter_186_1[2][1]
							local var_186_2 = getProxy(ChapterProxy):GetChapterItemById(var_186_1)

							if var_186_2 and not var_186_2:isClear() then
								var_185_0 = "map_" .. string.sub(iter_186_3, 8)

								return
							end
						end
					end
				end
			end)()
		end

		return var_185_0, var_185_1
	end
end

function var_0_0.PlayMapTransition(arg_187_0, arg_187_1, arg_187_2, arg_187_3, arg_187_4)
	arg_187_0.mapTransitions = arg_187_0.mapTransitions or {}

	local var_187_0

	local function var_187_1()
		arg_187_0:frozen()
		existCall(arg_187_3, var_187_0)
		var_187_0:SetActive(true)

		local var_188_0 = tf(var_187_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_188_0, {
			groupName = LayerWeightConst.GROUP_LEVELUI
		})
		var_187_0:GetComponent(typeof(Animator)):Play(arg_187_2 and "Sequence" or "Inverted", -1, 0)
		var_188_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_189_0)
			pg.UIMgr.GetInstance():UnOverlayPanel(var_188_0, arg_187_0._tf)
			existCall(arg_187_4, var_187_0)
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_187_1, arg_187_1, var_187_0)

			arg_187_0.mapTransitions[arg_187_1] = false

			arg_187_0:unfrozen()
		end)
	end

	PoolMgr.GetInstance():GetPrefab("ui/" .. arg_187_1, arg_187_1, true, function(arg_190_0)
		var_187_0 = arg_190_0
		arg_187_0.mapTransitions[arg_187_1] = arg_190_0

		var_187_1()
	end)
end

function var_0_0.DestroyLevelStageView(arg_191_0)
	if arg_191_0.levelStageView then
		arg_191_0.levelStageView:Destroy()

		arg_191_0.levelStageView = nil
	end
end

function var_0_0.displayAmbushInfo(arg_192_0, arg_192_1)
	arg_192_0.levelAmbushView = LevelAmbushView.New(arg_192_0.topPanel, arg_192_0.event, arg_192_0.contextData)

	arg_192_0.levelAmbushView:Load()
	arg_192_0.levelAmbushView:ActionInvoke("SetFuncOnComplete", arg_192_1)
end

function var_0_0.hideAmbushInfo(arg_193_0)
	if arg_193_0.levelAmbushView then
		arg_193_0.levelAmbushView:Destroy()

		arg_193_0.levelAmbushView = nil
	end
end

function var_0_0.doAmbushWarning(arg_194_0, arg_194_1)
	arg_194_0:frozen()

	local function var_194_0()
		arg_194_0.ambushWarning:SetActive(true)

		local var_195_0 = tf(arg_194_0.ambushWarning)

		var_195_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_195_0:SetSiblingIndex(1)

		local var_195_1 = var_195_0:GetComponent("DftAniEvent")

		var_195_1:SetTriggerEvent(function(arg_196_0)
			arg_194_1()
		end)
		var_195_1:SetEndEvent(function(arg_197_0)
			arg_194_0.ambushWarning:SetActive(false)
			arg_194_0:unfrozen()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
		Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
		end, 1, 1):Start()
	end

	if not arg_194_0.ambushWarning then
		PoolMgr.GetInstance():GetUI("ambushwarnui", true, function(arg_199_0)
			arg_199_0:SetActive(true)

			arg_194_0.ambushWarning = arg_199_0

			var_194_0()
		end)
	else
		var_194_0()
	end
end

function var_0_0.destroyAmbushWarn(arg_200_0)
	if arg_200_0.ambushWarning then
		PoolMgr.GetInstance():ReturnUI("ambushwarnui", arg_200_0.ambushWarning)

		arg_200_0.ambushWarning = nil
	end
end

function var_0_0.displayStrategyInfo(arg_201_0, arg_201_1)
	arg_201_0.levelStrategyView = LevelStrategyView.New(arg_201_0.topPanel, arg_201_0.event, arg_201_0.contextData)

	arg_201_0.levelStrategyView:Load()
	arg_201_0.levelStrategyView:ActionInvoke("set", arg_201_1)

	local function var_201_0()
		local var_202_0 = arg_201_0.contextData.chapterVO.fleet
		local var_202_1 = pg.strategy_data_template[arg_201_1.id]

		if not var_202_0:canUseStrategy(arg_201_1) then
			return
		end

		local var_202_2 = var_202_0:getNextStgUser(arg_201_1.id)

		if var_202_1.type == ChapterConst.StgTypeForm then
			arg_201_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_202_2,
				arg1 = arg_201_1.id
			})
		elseif var_202_1.type == ChapterConst.StgTypeConsume then
			arg_201_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_202_2,
				arg1 = arg_201_1.id
			})
		end

		arg_201_0:hideStrategyInfo()
	end

	local function var_201_1()
		arg_201_0:hideStrategyInfo()
	end

	arg_201_0.levelStrategyView:ActionInvoke("setCBFunc", var_201_0, var_201_1)
end

function var_0_0.hideStrategyInfo(arg_204_0)
	if arg_204_0.levelStrategyView then
		arg_204_0.levelStrategyView:Destroy()

		arg_204_0.levelStrategyView = nil
	end
end

function var_0_0.displayRepairWindow(arg_205_0, arg_205_1)
	local var_205_0 = arg_205_0.contextData.chapterVO
	local var_205_1 = getProxy(ChapterProxy)
	local var_205_2
	local var_205_3
	local var_205_4
	local var_205_5
	local var_205_6 = var_205_1.repairTimes
	local var_205_7, var_205_8, var_205_9 = ChapterConst.GetRepairParams()

	arg_205_0.levelRepairView = LevelRepairView.New(arg_205_0.topPanel, arg_205_0.event, arg_205_0.contextData)

	arg_205_0.levelRepairView:Load()
	arg_205_0.levelRepairView:ActionInvoke("set", var_205_6, var_205_7, var_205_8, var_205_9)

	local function var_205_10()
		if var_205_7 - math.min(var_205_6, var_205_7) == 0 and arg_205_0.player:getTotalGem() < var_205_9 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_rmb"))

			return
		end

		arg_205_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpRepair,
			id = var_205_0.fleet.id,
			arg1 = arg_205_1.id
		})
		arg_205_0:hideRepairWindow()
	end

	local function var_205_11()
		arg_205_0:hideRepairWindow()
	end

	arg_205_0.levelRepairView:ActionInvoke("setCBFunc", var_205_10, var_205_11)
end

function var_0_0.hideRepairWindow(arg_208_0)
	if arg_208_0.levelRepairView then
		arg_208_0.levelRepairView:Destroy()

		arg_208_0.levelRepairView = nil
	end
end

function var_0_0.displayRemasterPanel(arg_209_0, arg_209_1)
	arg_209_0.levelRemasterView:Load()

	local function var_209_0(arg_210_0)
		arg_209_0:ShowSelectedMap(arg_210_0)
	end

	arg_209_0.levelRemasterView:ActionInvoke("Show")
	arg_209_0.levelRemasterView:ActionInvoke("set", var_209_0, arg_209_1)
end

function var_0_0.hideRemasterPanel(arg_211_0)
	if arg_211_0.levelRemasterView:isShowing() then
		arg_211_0.levelRemasterView:ActionInvoke("Hide")
	end
end

function var_0_0.initGrid(arg_212_0, arg_212_1)
	local var_212_0 = arg_212_0.contextData.chapterVO

	if not var_212_0 then
		return
	end

	arg_212_0:enableLevelCamera()
	setActive(arg_212_0.uiMain, true)

	arg_212_0.levelGrid.localEulerAngles = Vector3(var_212_0.theme.angle, 0, 0)
	arg_212_0.grid = LevelGrid.New(arg_212_0.dragLayer)

	arg_212_0.grid:attach(arg_212_0)
	arg_212_0.grid:ExtendItem("shipTpl", arg_212_0.shipTpl)
	arg_212_0.grid:ExtendItem("subTpl", arg_212_0.subTpl)
	arg_212_0.grid:ExtendItem("transportTpl", arg_212_0.transportTpl)
	arg_212_0.grid:ExtendItem("enemyTpl", arg_212_0.enemyTpl)
	arg_212_0.grid:ExtendItem("championTpl", arg_212_0.championTpl)
	arg_212_0.grid:ExtendItem("oniTpl", arg_212_0.oniTpl)
	arg_212_0.grid:ExtendItem("arrowTpl", arg_212_0.arrowTarget)
	arg_212_0.grid:ExtendItem("destinationMarkTpl", arg_212_0.destinationMarkTpl)

	function arg_212_0.grid.onShipStepChange(arg_213_0)
		arg_212_0.levelStageView:updateAmbushRate(arg_213_0)
	end

	arg_212_0.grid:initAll(arg_212_1)
end

function var_0_0.destroyGrid(arg_214_0)
	if arg_214_0.grid then
		arg_214_0.grid:detach()

		arg_214_0.grid = nil

		arg_214_0:disableLevelCamera()
		setActive(arg_214_0.dragLayer, true)
		setActive(arg_214_0.uiMain, false)
	end
end

function var_0_0.doTracking(arg_215_0, arg_215_1)
	arg_215_0:frozen()

	local function var_215_0()
		arg_215_0.radar:SetActive(true)

		local var_216_0 = tf(arg_215_0.radar)

		var_216_0:SetParent(arg_215_0.topPanel, false)
		var_216_0:SetSiblingIndex(1)
		var_216_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_217_0)
			arg_215_0.radar:SetActive(false)
			arg_215_0:unfrozen()
			arg_215_1()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_SEARCH)
	end

	if not arg_215_0.radar then
		PoolMgr.GetInstance():GetUI("RadarEffectUI", true, function(arg_218_0)
			arg_218_0:SetActive(true)

			arg_215_0.radar = arg_218_0

			var_215_0()
		end)
	else
		var_215_0()
	end
end

function var_0_0.destroyTracking(arg_219_0)
	if arg_219_0.radar then
		PoolMgr.GetInstance():ReturnUI("RadarEffectUI", arg_219_0.radar)

		arg_219_0.radar = nil
	end
end

function var_0_0.doPlayAirStrike(arg_220_0, arg_220_1, arg_220_2, arg_220_3)
	local function var_220_0()
		arg_220_0.playing = true

		arg_220_0:frozen()
		arg_220_0.airStrike:SetActive(true)

		local var_221_0 = tf(arg_220_0.airStrike)

		var_221_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_221_0:SetAsLastSibling()
		setActive(var_221_0:Find("words/be_striked"), arg_220_1 == ChapterConst.SubjectChampion)
		setActive(var_221_0:Find("words/strike_enemy"), arg_220_1 == ChapterConst.SubjectPlayer)

		local function var_221_1()
			arg_220_0.playing = false

			SetActive(arg_220_0.airStrike, false)

			if arg_220_3 then
				arg_220_3()
			end

			arg_220_0:unfrozen()
		end

		var_221_0:GetComponent("DftAniEvent"):SetEndEvent(var_221_1)

		if arg_220_2 then
			onButton(arg_220_0, var_221_0, var_221_1, SFX_PANEL)
		else
			removeOnButton(var_221_0)
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
	end

	if not arg_220_0.airStrike then
		PoolMgr.GetInstance():GetUI("AirStrike", true, function(arg_223_0)
			arg_223_0:SetActive(true)

			arg_220_0.airStrike = arg_223_0

			var_220_0()
		end)
	else
		var_220_0()
	end
end

function var_0_0.destroyAirStrike(arg_224_0)
	if arg_224_0.airStrike then
		arg_224_0.airStrike:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("AirStrike", arg_224_0.airStrike)

		arg_224_0.airStrike = nil
	end
end

function var_0_0.doPlayAnim(arg_225_0, arg_225_1, arg_225_2, arg_225_3)
	arg_225_0.uiAnims = arg_225_0.uiAnims or {}

	local var_225_0 = arg_225_0.uiAnims[arg_225_1]

	local function var_225_1()
		arg_225_0.playing = true

		arg_225_0:frozen()
		var_225_0:SetActive(true)

		local var_226_0 = tf(var_225_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_226_0, {
			groupName = LayerWeightConst.GROUP_LEVELUI
		})

		if arg_225_3 then
			arg_225_3(var_225_0)
		end

		var_226_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_227_0)
			arg_225_0.playing = false

			pg.UIMgr.GetInstance():UnOverlayPanel(var_226_0, arg_225_0._tf)

			if arg_225_2 then
				arg_225_2(var_225_0)
			end

			arg_225_0:unfrozen()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
	end

	if not var_225_0 then
		PoolMgr.GetInstance():GetUI(arg_225_1, true, function(arg_228_0)
			arg_228_0:SetActive(true)

			arg_225_0.uiAnims[arg_225_1] = arg_228_0
			var_225_0 = arg_225_0.uiAnims[arg_225_1]

			var_225_1()
		end)
	else
		var_225_1()
	end
end

function var_0_0.destroyUIAnims(arg_229_0)
	if arg_229_0.uiAnims then
		for iter_229_0, iter_229_1 in pairs(arg_229_0.uiAnims) do
			pg.UIMgr.GetInstance():UnOverlayPanel(tf(iter_229_1), arg_229_0._tf)
			iter_229_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_229_0, iter_229_1)
		end

		arg_229_0.uiAnims = nil
	end
end

function var_0_0.doPlayTorpedo(arg_230_0, arg_230_1)
	local function var_230_0()
		arg_230_0.playing = true

		arg_230_0:frozen()
		arg_230_0.torpetoAni:SetActive(true)

		local var_231_0 = tf(arg_230_0.torpetoAni)

		var_231_0:SetParent(arg_230_0.topPanel, false)
		var_231_0:SetAsLastSibling()
		var_231_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_232_0)
			arg_230_0.playing = false

			SetActive(arg_230_0.torpetoAni, false)

			if arg_230_1 then
				arg_230_1()
			end

			arg_230_0:unfrozen()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
	end

	if not arg_230_0.torpetoAni then
		PoolMgr.GetInstance():GetUI("Torpeto", true, function(arg_233_0)
			arg_233_0:SetActive(true)

			arg_230_0.torpetoAni = arg_233_0

			var_230_0()
		end)
	else
		var_230_0()
	end
end

function var_0_0.destroyTorpedo(arg_234_0)
	if arg_234_0.torpetoAni then
		arg_234_0.torpetoAni:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("Torpeto", arg_234_0.torpetoAni)

		arg_234_0.torpetoAni = nil
	end
end

function var_0_0.doPlayStrikeAnim(arg_235_0, arg_235_1, arg_235_2, arg_235_3)
	arg_235_0.strikeAnims = arg_235_0.strikeAnims or {}

	local var_235_0
	local var_235_1
	local var_235_2

	local function var_235_3()
		if coroutine.status(var_235_2) == "suspended" then
			local var_236_0, var_236_1 = coroutine.resume(var_235_2)

			assert(var_236_0, debug.traceback(var_235_2, var_236_1))
		end
	end

	var_235_2 = coroutine.create(function()
		arg_235_0.playing = true

		arg_235_0:frozen()

		local var_237_0 = arg_235_0.strikeAnims[arg_235_2]

		setActive(var_237_0, true)

		local var_237_1 = tf(var_237_0)
		local var_237_2 = findTF(var_237_1, "torpedo")
		local var_237_3 = findTF(var_237_1, "mask/painting")
		local var_237_4 = findTF(var_237_1, "ship")

		setParent(var_235_0, var_237_3:Find("fitter"), false)
		setParent(var_235_1, var_237_4, false)
		setActive(var_237_4, false)
		setActive(var_237_2, false)
		var_237_1:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_237_1:SetAsLastSibling()

		local var_237_5 = var_237_1:GetComponent("DftAniEvent")
		local var_237_6 = var_235_1:GetComponent("SpineAnimUI")
		local var_237_7 = var_237_6:GetComponent("SkeletonGraphic")

		var_237_5:SetStartEvent(function(arg_238_0)
			var_237_6:SetAction("attack", 0)

			var_237_7.freeze = true
		end)
		var_237_5:SetTriggerEvent(function(arg_239_0)
			var_237_7.freeze = false

			var_237_6:SetActionCallBack(function(arg_240_0)
				if arg_240_0 == "action" then
					-- block empty
				elseif arg_240_0 == "finish" then
					var_237_7.freeze = true
				end
			end)
		end)
		var_237_5:SetEndEvent(function(arg_241_0)
			var_237_7.freeze = false

			var_235_3()
		end)
		onButton(arg_235_0, var_237_1, var_235_3, SFX_CANCEL)
		coroutine.yield()
		retPaintingPrefab(var_237_3, arg_235_1:getPainting())
		var_237_6:SetActionCallBack(nil)

		var_237_7.freeze = false

		PoolMgr.GetInstance():ReturnSpineChar(arg_235_1:getPrefab(), var_235_1)
		setActive(var_237_0, false)

		arg_235_0.playing = false

		arg_235_0:unfrozen()

		if arg_235_3 then
			arg_235_3()
		end
	end)

	local function var_235_4()
		if arg_235_0.strikeAnims[arg_235_2] and var_235_0 and var_235_1 then
			var_235_3()
		end
	end

	PoolMgr.GetInstance():GetPainting(arg_235_1:getPainting(), true, function(arg_243_0)
		var_235_0 = arg_243_0

		ShipExpressionHelper.SetExpression(var_235_0, arg_235_1:getPainting())
		var_235_4()
	end)
	PoolMgr.GetInstance():GetSpineChar(arg_235_1:getPrefab(), true, function(arg_244_0)
		var_235_1 = arg_244_0
		var_235_1.transform.localScale = Vector3.one

		var_235_4()
	end)

	if not arg_235_0.strikeAnims[arg_235_2] then
		PoolMgr.GetInstance():GetUI(arg_235_2, true, function(arg_245_0)
			arg_235_0.strikeAnims[arg_235_2] = arg_245_0

			var_235_4()
		end)
	end
end

function var_0_0.destroyStrikeAnim(arg_246_0)
	if arg_246_0.strikeAnims then
		for iter_246_0, iter_246_1 in pairs(arg_246_0.strikeAnims) do
			iter_246_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_246_0, iter_246_1)
		end

		arg_246_0.strikeAnims = nil
	end
end

function var_0_0.doPlayEnemyAnim(arg_247_0, arg_247_1, arg_247_2, arg_247_3)
	arg_247_0.strikeAnims = arg_247_0.strikeAnims or {}

	local var_247_0
	local var_247_1

	local function var_247_2()
		if coroutine.status(var_247_1) == "suspended" then
			local var_248_0, var_248_1 = coroutine.resume(var_247_1)

			assert(var_248_0, debug.traceback(var_247_1, var_248_1))
		end
	end

	var_247_1 = coroutine.create(function()
		arg_247_0.playing = true

		arg_247_0:frozen()

		local var_249_0 = arg_247_0.strikeAnims[arg_247_2]

		setActive(var_249_0, true)

		local var_249_1 = tf(var_249_0)
		local var_249_2 = findTF(var_249_1, "torpedo")
		local var_249_3 = findTF(var_249_1, "ship")

		setParent(var_247_0, var_249_3, false)
		setActive(var_249_3, false)
		setActive(var_249_2, false)
		var_249_1:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_249_1:SetAsLastSibling()

		local var_249_4 = var_249_1:GetComponent("DftAniEvent")
		local var_249_5 = var_247_0:GetComponent("SpineAnimUI")
		local var_249_6 = var_249_5:GetComponent("SkeletonGraphic")

		var_249_4:SetStartEvent(function(arg_250_0)
			var_249_5:SetAction("attack", 0)

			var_249_6.freeze = true
		end)
		var_249_4:SetTriggerEvent(function(arg_251_0)
			var_249_6.freeze = false

			var_249_5:SetActionCallBack(function(arg_252_0)
				if arg_252_0 == "action" then
					-- block empty
				elseif arg_252_0 == "finish" then
					var_249_6.freeze = true
				end
			end)
		end)
		var_249_4:SetEndEvent(function(arg_253_0)
			var_249_6.freeze = false

			var_247_2()
		end)
		onButton(arg_247_0, var_249_1, var_247_2, SFX_CANCEL)
		coroutine.yield()
		var_249_5:SetActionCallBack(nil)

		var_249_6.freeze = false

		PoolMgr.GetInstance():ReturnSpineChar(arg_247_1:getPrefab(), var_247_0)
		setActive(var_249_0, false)

		arg_247_0.playing = false

		arg_247_0:unfrozen()

		if arg_247_3 then
			arg_247_3()
		end
	end)

	local function var_247_3()
		if arg_247_0.strikeAnims[arg_247_2] and var_247_0 then
			var_247_2()
		end
	end

	PoolMgr.GetInstance():GetSpineChar(arg_247_1:getPrefab(), true, function(arg_255_0)
		var_247_0 = arg_255_0
		var_247_0.transform.localScale = Vector3.one

		var_247_3()
	end)

	if not arg_247_0.strikeAnims[arg_247_2] then
		PoolMgr.GetInstance():GetUI(arg_247_2, true, function(arg_256_0)
			arg_247_0.strikeAnims[arg_247_2] = arg_256_0

			var_247_3()
		end)
	end
end

function var_0_0.doSignalSearch(arg_257_0, arg_257_1)
	arg_257_0:frozen()

	local function var_257_0()
		arg_257_0.playing = true

		arg_257_0.signalAni:SetActive(true)

		local var_258_0 = tf(arg_257_0.signalAni)

		var_258_0:SetParent(arg_257_0.topPanel, false)
		var_258_0:SetAsLastSibling()
		var_258_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_259_0)
			arg_257_0.playing = false

			SetActive(arg_257_0.signalAni, false)

			if arg_257_1 then
				arg_257_1()
			end

			arg_257_0:unfrozen()
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
	end

	if not arg_257_0.signalAni then
		PoolMgr.GetInstance():GetUI("SignalUI", true, function(arg_260_0)
			arg_260_0:SetActive(true)

			arg_257_0.signalAni = arg_260_0

			var_257_0()
		end)
	else
		var_257_0()
	end
end

function var_0_0.destroySignalSearch(arg_261_0)
	if arg_261_0.signalAni then
		arg_261_0.signalAni:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("SignalUI", arg_261_0.signalAni)

		arg_261_0.signalAni = nil
	end
end

function var_0_0.doPlayCommander(arg_262_0, arg_262_1, arg_262_2)
	arg_262_0:frozen()
	setActive(arg_262_0.commanderTinkle, true)

	local var_262_0 = arg_262_1:getSkills()

	setText(arg_262_0.commanderTinkle:Find("name"), #var_262_0 > 0 and var_262_0[1]:getConfig("name") or "")
	setImageSprite(arg_262_0.commanderTinkle:Find("icon"), GetSpriteFromAtlas("commanderhrz/" .. arg_262_1:getConfig("painting"), ""))

	local var_262_1 = arg_262_0.commanderTinkle:GetComponent(typeof(CanvasGroup))

	var_262_1.alpha = 0

	local var_262_2 = Vector2(248, 237)

	LeanTween.value(go(arg_262_0.commanderTinkle), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_263_0)
		local var_263_0 = arg_262_0.commanderTinkle.localPosition

		var_263_0.x = var_262_2.x + -100 * (1 - arg_263_0)
		arg_262_0.commanderTinkle.localPosition = var_263_0
		var_262_1.alpha = arg_263_0
	end)):setEase(LeanTweenType.easeOutSine)
	LeanTween.value(go(arg_262_0.commanderTinkle), 0, 1, 0.3):setDelay(0.7):setOnUpdate(System.Action_float(function(arg_264_0)
		local var_264_0 = arg_262_0.commanderTinkle.localPosition

		var_264_0.x = var_262_2.x + 100 * arg_264_0
		arg_262_0.commanderTinkle.localPosition = var_264_0
		var_262_1.alpha = 1 - arg_264_0
	end)):setOnComplete(System.Action(function()
		if arg_262_2 then
			arg_262_2()
		end

		arg_262_0:unfrozen()
	end))
end

function var_0_0.strikeEnemy(arg_266_0, arg_266_1, arg_266_2, arg_266_3)
	local var_266_0 = arg_266_0.grid:shakeCell(arg_266_1)

	if not var_266_0 then
		arg_266_3()

		return
	end

	arg_266_0:easeDamage(var_266_0, arg_266_2, function()
		arg_266_3()
	end)
end

function var_0_0.easeDamage(arg_268_0, arg_268_1, arg_268_2, arg_268_3)
	arg_268_0:frozen()

	local var_268_0 = arg_268_0.levelCam:WorldToScreenPoint(arg_268_1.position)
	local var_268_1 = tf(arg_268_0:GetDamageText())

	var_268_1.position = arg_268_0.uiCam:ScreenToWorldPoint(var_268_0)

	local var_268_2 = var_268_1.localPosition

	var_268_2.y = var_268_2.y + 40
	var_268_2.z = 0

	setText(var_268_1, arg_268_2)

	var_268_1.localPosition = var_268_2

	LeanTween.value(go(var_268_1), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_269_0)
		local var_269_0 = var_268_1.localPosition

		var_269_0.y = var_268_2.y + 60 * arg_269_0
		var_268_1.localPosition = var_269_0

		setTextAlpha(var_268_1, 1 - arg_269_0)
	end)):setOnComplete(System.Action(function()
		arg_268_0:ReturnDamageText(var_268_1)
		arg_268_0:unfrozen()

		if arg_268_3 then
			arg_268_3()
		end
	end))
end

function var_0_0.easeAvoid(arg_271_0, arg_271_1, arg_271_2)
	arg_271_0:frozen()

	local var_271_0 = arg_271_0.levelCam:WorldToScreenPoint(arg_271_1)

	arg_271_0.avoidText.position = arg_271_0.uiCam:ScreenToWorldPoint(var_271_0)

	local var_271_1 = arg_271_0.avoidText.localPosition

	var_271_1.z = 0
	arg_271_0.avoidText.localPosition = var_271_1

	setActive(arg_271_0.avoidText, true)

	local var_271_2 = arg_271_0.avoidText:Find("avoid")

	LeanTween.value(go(arg_271_0.avoidText), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_272_0)
		local var_272_0 = arg_271_0.avoidText.localPosition

		var_272_0.y = var_271_1.y + 100 * arg_272_0
		arg_271_0.avoidText.localPosition = var_272_0

		setImageAlpha(arg_271_0.avoidText, 1 - arg_272_0)
		setImageAlpha(var_271_2, 1 - arg_272_0)
	end)):setOnComplete(System.Action(function()
		setActive(arg_271_0.avoidText, false)
		arg_271_0:unfrozen()

		if arg_271_2 then
			arg_271_2()
		end
	end))
end

function var_0_0.GetDamageText(arg_274_0)
	local var_274_0 = table.remove(arg_274_0.damageTextPool)

	if not var_274_0 then
		var_274_0 = Instantiate(arg_274_0.damageTextTemplate)

		local var_274_1 = tf(arg_274_0.damageTextTemplate):GetSiblingIndex()

		setParent(var_274_0, tf(arg_274_0.damageTextTemplate).parent)
		tf(var_274_0):SetSiblingIndex(var_274_1 + 1)
	end

	table.insert(arg_274_0.damageTextActive, var_274_0)
	setActive(var_274_0, true)

	return var_274_0
end

function var_0_0.ReturnDamageText(arg_275_0, arg_275_1)
	assert(arg_275_1)

	if not arg_275_1 then
		return
	end

	arg_275_1 = go(arg_275_1)

	table.removebyvalue(arg_275_0.damageTextActive, arg_275_1)
	table.insert(arg_275_0.damageTextPool, arg_275_1)
	setActive(arg_275_1, false)
end

function var_0_0.resetLevelGrid(arg_276_0)
	arg_276_0.dragLayer.localPosition = Vector3.zero
end

function var_0_0.ShowCurtains(arg_277_0, arg_277_1)
	setActive(arg_277_0.curtain, arg_277_1)
end

function var_0_0.frozen(arg_278_0)
	local var_278_0 = arg_278_0.frozenCount

	arg_278_0.frozenCount = arg_278_0.frozenCount + 1
	arg_278_0.canvasGroup.blocksRaycasts = arg_278_0.frozenCount == 0

	if var_278_0 == 0 and arg_278_0.frozenCount ~= 0 then
		arg_278_0:emit(LevelUIConst.ON_FROZEN)
	end
end

function var_0_0.unfrozen(arg_279_0, arg_279_1)
	if arg_279_0.exited then
		return
	end

	local var_279_0 = arg_279_0.frozenCount
	local var_279_1 = arg_279_1 == -1 and arg_279_0.frozenCount or arg_279_1 or 1

	arg_279_0.frozenCount = arg_279_0.frozenCount - var_279_1
	arg_279_0.canvasGroup.blocksRaycasts = arg_279_0.frozenCount == 0

	if var_279_0 ~= 0 and arg_279_0.frozenCount == 0 then
		arg_279_0:emit(LevelUIConst.ON_UNFROZEN)
	end
end

function var_0_0.isfrozen(arg_280_0)
	return arg_280_0.frozenCount > 0
end

function var_0_0.enableLevelCamera(arg_281_0)
	arg_281_0.levelCamIndices = math.max(arg_281_0.levelCamIndices - 1, 0)

	if arg_281_0.levelCamIndices == 0 then
		arg_281_0.levelCam.enabled = true

		pg.LayerWeightMgr.GetInstance():switchOriginParent()
	end
end

function var_0_0.disableLevelCamera(arg_282_0)
	arg_282_0.levelCamIndices = arg_282_0.levelCamIndices + 1

	if arg_282_0.levelCamIndices > 0 then
		arg_282_0.levelCam.enabled = false

		pg.LayerWeightMgr.GetInstance():switchOriginParent()
	end
end

function var_0_0.RecordTween(arg_283_0, arg_283_1, arg_283_2)
	arg_283_0.tweens[arg_283_1] = arg_283_2
end

function var_0_0.DeleteTween(arg_284_0, arg_284_1)
	local var_284_0 = arg_284_0.tweens[arg_284_1]

	if var_284_0 then
		LeanTween.cancel(var_284_0)

		arg_284_0.tweens[arg_284_1] = nil
	end
end

function var_0_0.openCommanderPanel(arg_285_0, arg_285_1, arg_285_2, arg_285_3)
	local var_285_0 = arg_285_2.id

	arg_285_0.levelCMDFormationView:setCallback(function(arg_286_0)
		if not arg_285_3 then
			if arg_286_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
				arg_285_0:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_286_0.skill)
			elseif arg_286_0.type == LevelUIConst.COMMANDER_OP_ADD then
				arg_285_0.contextData.commanderSelected = {
					chapterId = var_285_0,
					fleetId = arg_285_1.id
				}

				arg_285_0:emit(LevelMediator2.ON_SELECT_COMMANDER, arg_286_0.pos, arg_285_1.id, arg_285_2)
				arg_285_0:closeCommanderPanel()
			else
				arg_285_0:emit(LevelMediator2.ON_COMMANDER_OP, {
					FleetType = LevelUIConst.FLEET_TYPE_SELECT,
					data = arg_286_0,
					fleetId = arg_285_1.id,
					chapterId = var_285_0
				}, arg_285_2)
			end
		elseif arg_286_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_285_0:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_286_0.skill)
		elseif arg_286_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_285_0.contextData.eliteCommanderSelected = {
				index = arg_285_3,
				pos = arg_286_0.pos,
				chapterId = var_285_0
			}

			arg_285_0:emit(LevelMediator2.ON_SELECT_ELITE_COMMANDER, arg_285_3, arg_286_0.pos, arg_285_2)
			arg_285_0:closeCommanderPanel()
		else
			arg_285_0:emit(LevelMediator2.ON_COMMANDER_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_EDIT,
				data = arg_286_0,
				index = arg_285_3,
				chapterId = var_285_0
			}, arg_285_2)
		end
	end)
	arg_285_0.levelCMDFormationView:Load()
	arg_285_0.levelCMDFormationView:ActionInvoke("update", arg_285_1, arg_285_0.commanderPrefabs)
	arg_285_0.levelCMDFormationView:ActionInvoke("Show")
end

function var_0_0.updateCommanderPrefab(arg_287_0)
	if arg_287_0.levelCMDFormationView:isShowing() then
		arg_287_0.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_287_0.commanderPrefabs)
	end
end

function var_0_0.closeCommanderPanel(arg_288_0)
	arg_288_0.levelCMDFormationView:ActionInvoke("Hide")
end

function var_0_0.destroyCommanderPanel(arg_289_0)
	arg_289_0.levelCMDFormationView:Destroy()

	arg_289_0.levelCMDFormationView = nil
end

function var_0_0.setSpecialOperationTickets(arg_290_0, arg_290_1)
	arg_290_0.spTickets = arg_290_1
end

function var_0_0.HandleShowMsgBox(arg_291_0, arg_291_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_291_1)
end

function var_0_0.updatePoisonAreaTip(arg_292_0)
	local var_292_0 = arg_292_0.contextData.chapterVO
	local var_292_1 = (function(arg_293_0)
		local var_293_0 = {}
		local var_293_1 = pg.map_event_list[var_292_0.id] or {}
		local var_293_2

		if var_292_0:isLoop() then
			var_293_2 = var_293_1.event_list_loop or {}
		else
			var_293_2 = var_293_1.event_list or {}
		end

		for iter_293_0, iter_293_1 in ipairs(var_293_2) do
			local var_293_3 = pg.map_event_template[iter_293_1]

			if var_293_3.c_type == arg_293_0 then
				table.insert(var_293_0, var_293_3)
			end
		end

		return var_293_0
	end)(ChapterConst.EvtType_Poison)

	if var_292_1 then
		for iter_292_0, iter_292_1 in ipairs(var_292_1) do
			local var_292_2 = iter_292_1.round_gametip

			if var_292_2 ~= nil and var_292_2 ~= "" and var_292_0:getRoundNum() == var_292_2[1] then
				pg.TipsMgr.GetInstance():ShowTips(i18n(var_292_2[2]))
			end
		end
	end
end

function var_0_0.updateVoteBookBtn(arg_294_0)
	setActive(arg_294_0._voteBookBtn, false)
end

function var_0_0.RecordLastMapOnExit(arg_295_0)
	local var_295_0 = getProxy(ChapterProxy)

	if var_295_0 and not arg_295_0.contextData.noRecord then
		local var_295_1 = arg_295_0.contextData.map

		if not var_295_1 then
			return
		end

		if var_295_1 and var_295_1:NeedRecordMap() then
			var_295_0:recordLastMap(ChapterProxy.LAST_MAP, var_295_1.id)
		end

		if Map.lastMapForActivity then
			var_295_0:recordLastMap(ChapterProxy.LAST_MAP_FOR_ACTIVITY, Map.lastMapForActivity)
		end
	end
end

function var_0_0.willExit(arg_296_0)
	arg_296_0:ClearMapTransitions()
	arg_296_0.loader:Clear()

	if arg_296_0.contextData.chapterVO then
		pg.UIMgr.GetInstance():UnblurPanel(arg_296_0.topPanel, arg_296_0._tf)
		pg.playerResUI:SetActive({
			active = false
		})
	end

	if arg_296_0.levelFleetView and arg_296_0.levelFleetView.selectIds then
		arg_296_0.contextData.selectedFleetIDs = {}

		for iter_296_0, iter_296_1 in pairs(arg_296_0.levelFleetView.selectIds) do
			for iter_296_2, iter_296_3 in pairs(iter_296_1) do
				arg_296_0.contextData.selectedFleetIDs[#arg_296_0.contextData.selectedFleetIDs + 1] = iter_296_3
			end
		end
	end

	arg_296_0:destroyChapterPanel()
	arg_296_0:destroyFleetEdit()
	arg_296_0:destroyCommanderPanel()
	arg_296_0:DestroyLevelStageView()
	arg_296_0:hideRepairWindow()
	arg_296_0:hideStrategyInfo()
	arg_296_0:hideRemasterPanel()
	arg_296_0:hideSpResult()
	arg_296_0:destroyGrid()
	arg_296_0:destroyAmbushWarn()
	arg_296_0:destroyAirStrike()
	arg_296_0:destroyTorpedo()
	arg_296_0:destroyStrikeAnim()
	arg_296_0:destroyTracking()
	arg_296_0:destroyUIAnims()
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad_mark", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/plane", "")

	for iter_296_4, iter_296_5 in pairs(arg_296_0.mbDict) do
		iter_296_5:Destroy()
	end

	arg_296_0.mbDict = nil

	for iter_296_6, iter_296_7 in pairs(arg_296_0.tweens) do
		LeanTween.cancel(iter_296_7)
	end

	arg_296_0.tweens = nil

	if arg_296_0.cloudTimer then
		_.each(arg_296_0.cloudTimer, function(arg_297_0)
			LeanTween.cancel(arg_297_0)
		end)

		arg_296_0.cloudTimer = nil
	end

	if arg_296_0.newChapterCDTimer then
		arg_296_0.newChapterCDTimer:Stop()

		arg_296_0.newChapterCDTimer = nil
	end

	for iter_296_8, iter_296_9 in ipairs(arg_296_0.damageTextActive) do
		LeanTween.cancel(iter_296_9)
	end

	LeanTween.cancel(go(arg_296_0.avoidText))

	arg_296_0.map.localScale = Vector3.one
	arg_296_0.map.pivot = Vector2(0.5, 0.5)
	arg_296_0.float.localScale = Vector3.one
	arg_296_0.float.pivot = Vector2(0.5, 0.5)

	for iter_296_10, iter_296_11 in ipairs(arg_296_0.mapTFs) do
		clearImageSprite(iter_296_11)
	end

	_.each(arg_296_0.cloudRTFs, function(arg_298_0)
		clearImageSprite(arg_298_0)
	end)
	PoolMgr.GetInstance():DestroyAllSprite()
	Destroy(arg_296_0.enemyTpl)
	arg_296_0:RecordLastMapOnExit()
	arg_296_0.levelRemasterView:Destroy()
end

return var_0_0
