local var_0_0 = class("ChapterPreCombatLayer", import("..base.BaseUI"))
local var_0_1 = import("..ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function var_0_0.getUIName(arg_1_0)
	return "ChapterPreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0._startBtn = arg_3_0:findTF("right/start")
	arg_3_0._popup = arg_3_0:findTF("right/popup")
	arg_3_0._costText = arg_3_0:findTF("right/popup/Text")
	arg_3_0._costTip = arg_3_0:findTF("right/popup/tip")
	arg_3_0._extraCostBuffIcon = arg_3_0:findTF("right/operation_buff_icon")
	arg_3_0._backBtn = arg_3_0:findTF("top/back_btn")
	arg_3_0._moveLayer = arg_3_0:findTF("moveLayer")

	local var_3_0 = arg_3_0:findTF("middle")

	arg_3_0._mainGS = var_3_0:Find("gear_score/main/Text")
	arg_3_0._vanguardGS = var_3_0:Find("gear_score/vanguard/Text")

	setText(arg_3_0._mainGS, 0)
	setText(arg_3_0._vanguardGS, 0)

	arg_3_0._gridTFs = {
		vanguard = {},
		main = {}
	}
	arg_3_0._gridFrame = var_3_0:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		arg_3_0._gridTFs[TeamType.Vanguard][iter_3_0] = arg_3_0._gridFrame:Find("vanguard_" .. iter_3_0)
		arg_3_0._gridTFs[TeamType.Main][iter_3_0] = arg_3_0._gridFrame:Find("main_" .. iter_3_0)
	end

	arg_3_0._heroContainer = var_3_0:Find("HeroContainer")
	arg_3_0._strategy = var_3_0:Find("strategy")

	setActive(arg_3_0._strategy, true)

	arg_3_0._spoilsContainer = arg_3_0:findTF("right/infomation/spoils/items/items_container")
	arg_3_0._goals = arg_3_0:findTF("right/infomation/goal")
	arg_3_0._item = arg_3_0:getTpl("right/infomation/spoils/items/item_tpl")
	arg_3_0._heroInfo = arg_3_0:getTpl("heroInfo")
	arg_3_0._starTpl = arg_3_0:getTpl("star_tpl")
	arg_3_0._middle = arg_3_0:findTF("middle")
	arg_3_0._right = arg_3_0:findTF("right")
	arg_3_0._formationLogic = BaseFormation.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	local var_3_1 = {
		Shift = function(arg_4_0, arg_4_1, arg_4_2)
			return
		end
	}

	setmetatable(var_3_1, arg_3_0._formationLogic)
	setText(findTF(arg_3_0._tf, "middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(findTF(arg_3_0._tf, "middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))

	arg_3_0._fleet = arg_3_0:findTF("middle/fleet")

	setText(findTF(arg_3_0._fleet, "title_bg/Text"), i18n("pre_combat_team"))

	arg_3_0._ship_tpl = findTF(arg_3_0._fleet, "shiptpl")
	arg_3_0._empty_tpl = findTF(arg_3_0._fleet, "emptytpl")

	setActive(arg_3_0._ship_tpl, false)
	setActive(arg_3_0._empty_tpl, false)

	arg_3_0._autoToggle = arg_3_0:findTF("middle/auto_toggle")
	arg_3_0._autoSubToggle = arg_3_0:findTF("middle/sub_toggle_container/sub_toggle")
	arg_3_0.topPanel = arg_3_0:findTF("top")
	arg_3_0.strategyInfo = arg_3_0:findTF("strategy_info")

	setActive(arg_3_0.strategyInfo, false)

	arg_3_0._operaionBuffTips = arg_3_0._extraCostBuffIcon:Find("popup")

	setAnchoredPosition(arg_3_0._middle, {
		x = -840
	})
	setAnchoredPosition(arg_3_0._right, {
		x = 470
	})
	arg_3_0:Register()
end

function var_0_0.uiStartAnimating(arg_5_0)
	setAnchoredPosition(arg_5_0.topPanel, {
		y = 100
	})

	local var_5_0 = 0
	local var_5_1 = 0.3

	shiftPanel(arg_5_0._middle, 0, nil, var_5_1, var_5_0, true, true)
	shiftPanel(arg_5_0._right, 0, nil, var_5_1, var_5_0, true, true, nil)
	shiftPanel(arg_5_0.topPanel, nil, 0, var_5_1, var_5_0, true, true, nil, nil)
end

function var_0_0.uiExitAnimating(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0.3

	shiftPanel(arg_6_0._middle, -840, nil, var_6_1, var_6_0, true, true)
	shiftPanel(arg_6_0._right, 470, nil, var_6_1, var_6_0, true, true)
	shiftPanel(arg_6_0.topPanel, nil, arg_6_0.topPanel.rect.height, var_6_1, var_6_0, true, true, nil, nil)
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._backBtn, function()
		GetOrAddComponent(arg_7_0._tf, typeof(CanvasGroup)).interactable = false

		arg_7_0:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			arg_7_0:emit(var_0_0.ON_CLOSE)
		end))
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0._startBtn, function()
		arg_7_0:emit(ChapterPreCombatMediator.ON_START)
	end, SFX_UI_WEIGHANCHOR)
	onToggle(arg_7_0, arg_7_0._autoToggle, function(arg_11_0)
		arg_7_0:emit(ChapterPreCombatMediator.ON_AUTO, {
			isOn = not arg_11_0,
			toggle = arg_7_0._autoToggle
		})

		if arg_11_0 and arg_7_0.subUseable == true then
			setActive(arg_7_0._autoSubToggle, true)
			onToggle(arg_7_0, arg_7_0._autoSubToggle, function(arg_12_0)
				arg_7_0:emit(ChapterPreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_12_0,
					toggle = arg_7_0._autoSubToggle
				})
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(arg_7_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(arg_7_0._autoSubToggle, false)
		end
	end, SFX_PANEL, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0._tf, {
		weight = LayerWeightConst.SECOND_LAYER,
		groupName = LayerWeightConst.GROUP_LEVELUI
	})
	onNextTick(function()
		if arg_7_0.exited then
			return
		end

		triggerToggle(arg_7_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	end)
	setAnchoredPosition(arg_7_0.topPanel, {
		y = arg_7_0.topPanel.rect.height
	})
	onNextTick(function()
		arg_7_0:uiStartAnimating()
	end)
	onButton(arg_7_0, arg_7_0:findTF("middle/gear_score/vanguard/SonarTip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip,
			weight = LayerWeightConst.SECOND_LAYER
		})
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._costTip, function()
		local var_16_0 = arg_7_0.chapter.fleet
		local var_16_1 = arg_7_0.chapter:getStageId(var_16_0.line.row, var_16_0.line.column)
		local var_16_2, var_16_3, var_16_4 = arg_7_0.chapter:isOverFleetCost(var_16_0, var_16_1)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("use_oil_limit_help", var_16_4, var_16_3),
			weight = LayerWeightConst.SECOND_LAYER
		})
	end)
end

function var_0_0.Register(arg_17_0)
	arg_17_0._formationLogic:AddHeroInfoModify(function(arg_18_0, arg_18_1)
		setAnchoredPosition(arg_18_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_18_0, true)

		arg_18_0.name = "info"

		local var_18_0 = findTF(arg_18_0, "info")
		local var_18_1 = findTF(var_18_0, "stars")
		local var_18_2 = arg_18_1:getEnergy() <= Ship.ENERGY_MID
		local var_18_3 = findTF(var_18_0, "energy")

		if var_18_2 then
			local var_18_4, var_18_5 = arg_18_1:getEnergyPrint()
			local var_18_6 = GetSpriteFromAtlas("energy", var_18_4)

			if not var_18_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_18_3, var_18_6)
		end

		setActive(var_18_3, var_18_2)

		local var_18_7 = arg_18_1:getStar()

		for iter_18_0 = 1, var_18_7 do
			cloneTplTo(arg_17_0._starTpl, var_18_1)
		end

		local var_18_8 = GetSpriteFromAtlas("shiptype", shipType2print(arg_18_1:getShipType()))

		if not var_18_8 then
			warning("找不到船形, shipConfigId: " .. arg_18_1.configId)
		end

		setImageSprite(findTF(var_18_0, "type"), var_18_8, true)
		setText(findTF(var_18_0, "frame/lv_contain/lv"), arg_18_1.level)

		local var_18_9 = findTF(var_18_0, "blood")
		local var_18_10 = findTF(var_18_9, "fillarea/green")
		local var_18_11 = findTF(var_18_9, "fillarea/red")

		setActive(var_18_10, arg_18_1.hpRant >= ChapterConst.HpGreen)
		setActive(var_18_11, arg_18_1.hpRant < ChapterConst.HpGreen)

		;(arg_18_1.hpRant >= ChapterConst.HpGreen and var_18_10 or var_18_11):GetComponent("Image").fillAmount = arg_18_1.hpRant * 0.0001

		local var_18_12 = getProxy(ActivityProxy):getBuffShipList()[arg_18_1:getGroupId()]
		local var_18_13 = var_18_0:Find("expbuff")

		setActive(var_18_13, var_18_12 ~= nil)

		if var_18_12 then
			local var_18_14 = var_18_12 / 100
			local var_18_15 = var_18_12 % 100
			local var_18_16 = tostring(var_18_14)

			if var_18_15 > 0 then
				var_18_16 = var_18_16 .. "." .. tostring(var_18_15)
			end

			setText(var_18_13:Find("text"), string.format("EXP +%s%%", var_18_16))
		end
	end)
	arg_17_0._formationLogic:AddShiftOnly(function(arg_19_0)
		arg_17_0:updateView(false)
	end)
	arg_17_0._formationLogic:AddEndDrag(function()
		arg_17_0:emit(ChapterPreCombatMediator.ON_SWITCH_SHIP, arg_17_0.chapter.fleet)
	end)
	arg_17_0._formationLogic:AddCheckRemove(function(arg_21_0, arg_21_1)
		arg_21_0()
	end)
end

function var_0_0.setPlayerInfo(arg_22_0, arg_22_1)
	return
end

function var_0_0.updateChapter(arg_23_0, arg_23_1)
	arg_23_0.chapter = arg_23_1

	local var_23_0 = arg_23_0.chapter.fleet

	arg_23_0._formationLogic:SetFleetVO(var_23_0)

	local var_23_1 = var_23_0.ships

	arg_23_0._formationLogic:SetShipVOs(var_23_1)
	arg_23_0:updateView(true)
end

function var_0_0.setSubFlag(arg_24_0, arg_24_1)
	arg_24_0.subUseable = arg_24_1 or false
end

function var_0_0.updateView(arg_25_0, arg_25_1)
	arg_25_0._formationLogic:ResetGrid(TeamType.Vanguard, true)
	arg_25_0._formationLogic:ResetGrid(TeamType.Main, true)
	SetActive(arg_25_0._gridTFs[TeamType.Main][1]:Find("flag"), true)

	if arg_25_1 then
		local var_25_0 = arg_25_0.chapter.fleet
		local var_25_1 = arg_25_0.chapter:getStageId(var_25_0.line.row, var_25_0.line.column)

		arg_25_0:updateStageView(var_25_1)
		arg_25_0._formationLogic:LoadAllCharacter()
	else
		arg_25_0._formationLogic:SetAllCharacterPos()
	end

	arg_25_0:updateBattleFleetView()
	arg_25_0:updateStrategyIcon()
	arg_25_0:displayFleetInfo()
end

function var_0_0.updateStageView(arg_26_0, arg_26_1)
	local var_26_0 = pg.expedition_data_template[arg_26_1]

	assert(var_26_0, "expedition_data_template not exist: " .. arg_26_1)

	local var_26_1 = var_26_0.limit_type
	local var_26_2 = var_26_0.time_limit
	local var_26_3 = var_26_0.sink_limit
	local var_26_4 = Clone(var_26_0.award_display)
	local var_26_5 = checkExist(pg.expedition_activity_template[arg_26_1], {
		"pt_drop_display"
	})

	if var_26_5 and type(var_26_5) == "table" then
		local var_26_6 = getProxy(ActivityProxy)

		for iter_26_0 = #var_26_5, 1, -1 do
			local var_26_7 = var_26_6:getActivityById(var_26_5[iter_26_0][1])

			if var_26_7 and not var_26_7:isEnd() then
				table.insert(var_26_4, 1, {
					2,
					id2ItemId(var_26_5[iter_26_0][2])
				})
			end
		end
	end

	local var_26_8 = UIItemList.New(arg_26_0._spoilsContainer, arg_26_0._item)

	var_26_8:make(function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = arg_27_2
		local var_27_1 = var_26_4[arg_27_1 + 1]
		local var_27_2 = {
			type = var_27_1[1],
			id = var_27_1[2]
		}

		updateDrop(var_27_0, var_27_2)
		onButton(arg_26_0, var_27_0, function()
			local var_28_0 = Item.getConfigData(var_27_1[2])

			if var_28_0 and var_0_2[var_28_0.type] then
				local function var_28_1(arg_29_0)
					local var_29_0 = var_28_0.display_icon
					local var_29_1 = {}

					for iter_29_0, iter_29_1 in ipairs(var_29_0) do
						local var_29_2 = iter_29_1[1]
						local var_29_3 = iter_29_1[2]
						local var_29_4 = var_29_2 == DROP_TYPE_SHIP and not table.contains(arg_29_0, var_29_3)

						var_29_1[#var_29_1 + 1] = {
							type = var_29_2,
							id = var_29_3,
							anonymous = var_29_4
						}
					end

					arg_26_0:emit(var_0_0.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_29_1,
						content = var_28_0.display
					})
				end

				arg_26_0:emit(ChapterPreCombatMediator.GET_CHAPTER_DROP_SHIP_LIST, arg_26_0.chapter.id, var_28_1)
			else
				arg_26_0:emit(var_0_0.ON_DROP, var_27_2)
			end
		end, SFX_PANEL)
	end)
	var_26_8:align(math.min(#var_26_4, 6))

	local function var_26_9(arg_30_0, arg_30_1)
		if type(arg_30_0) == "table" then
			setActive(arg_30_1, true)

			local var_30_0 = i18n(PreCombatLayer.ObjectiveList[arg_30_0[1]], arg_30_0[2])

			setWidgetText(arg_30_1, var_30_0)
		else
			setActive(arg_30_1, false)
		end
	end

	local var_26_10 = {
		findTF(arg_26_0._goals, "goal_tpl"),
		findTF(arg_26_0._goals, "goal_sink"),
		findTF(arg_26_0._goals, "goal_time")
	}
	local var_26_11 = {
		var_26_0.objective_1,
		var_26_0.objective_2,
		var_26_0.objective_3
	}
	local var_26_12 = 1

	for iter_26_1, iter_26_2 in ipairs(var_26_11) do
		if type(iter_26_2) ~= "string" then
			var_26_9(iter_26_2, var_26_10[var_26_12])

			var_26_12 = var_26_12 + 1
		end
	end

	for iter_26_3 = var_26_12, #var_26_10 do
		var_26_9("", var_26_10[iter_26_3])
	end
end

function var_0_0.updateBattleFleetView(arg_31_0)
	local function var_31_0(arg_32_0, arg_32_1)
		removeAllChildren(arg_32_0)

		for iter_32_0 = 1, 3 do
			if arg_32_1[iter_32_0] then
				local var_32_0 = cloneTplTo(arg_31_0._ship_tpl, arg_32_0)

				updateShip(var_32_0, arg_32_1[iter_32_0])

				local var_32_1 = arg_32_1[iter_32_0].hpRant
				local var_32_2 = findTF(var_32_0, "blood")
				local var_32_3 = findTF(var_32_0, "blood/fillarea/green")
				local var_32_4 = findTF(var_32_0, "blood/fillarea/red")

				setActive(var_32_3, var_32_1 >= ChapterConst.HpGreen)
				setActive(var_32_4, var_32_1 < ChapterConst.HpGreen)

				;(var_32_1 >= ChapterConst.HpGreen and var_32_3 or var_32_4):GetComponent("Image").fillAmount = var_32_1 * 0.0001
			end
		end
	end

	local var_31_1 = arg_31_0.chapter.fleet

	var_31_0(arg_31_0._fleet:Find("main"), var_31_1:getShipsByTeam(TeamType.Main, true))
	var_31_0(arg_31_0._fleet:Find("vanguard"), var_31_1:getShipsByTeam(TeamType.Vanguard, true))
end

function var_0_0.displayFleetInfo(arg_33_0)
	local var_33_0 = arg_33_0.chapter.fleet
	local var_33_1 = arg_33_0.chapter:getStageId(var_33_0.line.row, var_33_0.line.column)
	local var_33_2 = var_33_0:getCommanders()
	local var_33_3 = _.reduce(var_33_0:getShipsByTeam(TeamType.Vanguard, false), 0, function(arg_34_0, arg_34_1)
		return arg_34_0 + arg_34_1:getShipCombatPower(var_33_2)
	end)
	local var_33_4 = _.reduce(var_33_0:getShipsByTeam(TeamType.Main, false), 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + arg_35_1:getShipCombatPower(var_33_2)
	end)
	local var_33_5 = 0

	for iter_33_0, iter_33_1 in ipairs({
		arg_33_0.chapter:getFleetCost(var_33_0, var_33_1)
	}) do
		var_33_5 = var_33_5 + iter_33_1.oil
	end

	local var_33_6 = arg_33_0.chapter:isOverFleetCost(var_33_0, var_33_1)

	setActive(arg_33_0._popup, true)
	setActive(arg_33_0._costTip, var_33_6)
	setTextColor(arg_33_0._costText, var_33_6 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white)
	var_0_1.tweenNumText(arg_33_0._costText, var_33_5)
	var_0_1.tweenNumText(arg_33_0._vanguardGS, var_33_3)
	var_0_1.tweenNumText(arg_33_0._mainGS, var_33_4)

	local var_33_7, var_33_8 = arg_33_0.chapter:GetExtraCostRate()

	setActive(arg_33_0._extraCostBuffIcon, #var_33_8 > 0)

	for iter_33_2, iter_33_3 in ipairs(var_33_8) do
		if iter_33_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_COST then
			setText(arg_33_0._extraCostBuffIcon:Find("text_cost"), tonumber(iter_33_3.benefit_effect) * 0.01 + 1)
		elseif iter_33_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			setText(arg_33_0._extraCostBuffIcon:Find("text_reward"), tonumber(iter_33_3.benefit_effect) * 0.01 + 1)
		elseif iter_33_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			onButton(arg_33_0, arg_33_0._extraCostBuffIcon, function()
				local var_36_0 = tonumber(iter_33_3.benefit_condition)
				local var_36_1 = pg.strategy_data_template[iter_33_3.id]

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = {
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_36_0
					},
					intro = var_36_1.desc,
					weight = LayerWeightConst.TOP_LAYER
				})
			end)
		end
	end

	local var_33_9 = arg_33_0:findTF("middle/gear_score/vanguard")
	local var_33_10 = ChapterFleet.StaticTransformChapterFleet2Fleet(var_33_0):GetFleetSonarRange()

	setActive(var_33_9:Find("SonarActive"), var_33_10 > 0)
	setActive(var_33_9:Find("SonarInactive"), var_33_10 <= 0)

	if var_33_10 > 0 then
		setText(var_33_9:Find("SonarActive/Text"), math.floor(var_33_10))
	end
end

function var_0_0.updateStrategyIcon(arg_37_0)
	local var_37_0 = arg_37_0.chapter.fleet:getStrategies()
	local var_37_1 = _.detect(var_37_0, function(arg_38_0)
		return arg_38_0.id == ChapterConst.StrategyRepair
	end)
	local var_37_2 = pg.strategy_data_template[var_37_1.id]

	GetImageSpriteFromAtlasAsync("strategyicon/" .. var_37_2.icon, "", arg_37_0._strategy:Find("icon"))
	onButton(arg_37_0, arg_37_0._strategy, function()
		arg_37_0:displayStrategyInfo(var_37_1)
	end, SFX_PANEL)
	setText(arg_37_0._strategy:Find("nums"), var_37_1.count)
	setActive(arg_37_0._strategy:Find("mask"), var_37_1.count == 0)
	setActive(arg_37_0._strategy:Find("selected"), false)

	local var_37_3 = arg_37_0:findTF("middle/formation_list")
	local var_37_4 = findTF(var_37_3, "formation")

	setActive(var_37_4, false)

	local var_37_5 = ChapterConst.StrategyForms
	local var_37_6 = {}
	local var_37_7 = arg_37_0.chapter.fleet:getFormationStg()

	table.insert(var_37_6, 1, {
		id = var_37_7
	})

	local var_37_8 = UIItemList.New(var_37_3, var_37_4)

	var_37_8:make(function(arg_40_0, arg_40_1, arg_40_2)
		if arg_40_0 == UIItemList.EventUpdate then
			local var_40_0 = var_37_6[arg_40_1 + 1]
			local var_40_1 = pg.strategy_data_template[var_40_0.id]

			if var_40_1.type ~= ChapterConst.StgTypeForm then
				return
			end

			GetImageSpriteFromAtlasAsync("strategyicon/" .. var_40_1.icon, "", arg_40_2:Find("icon"))
			onButton(arg_37_0, arg_40_2, function()
				if var_40_1.type == ChapterConst.StgTypeForm then
					local var_41_0 = arg_37_0.chapter.fleet:getNextStgUser(var_40_0.id)
					local var_41_1 = table.indexof(var_37_5, var_40_0.id)

					arg_37_0:emit(ChapterPreCombatMediator.ON_OP, {
						type = ChapterConst.OpStrategy,
						id = var_41_0,
						arg1 = var_37_5[var_41_1 % #var_37_5 + 1]
					})
				end
			end, SFX_PANEL)
			setText(arg_40_2:Find("nums"), "")
			setActive(arg_40_2:Find("mask"), false)
			setActive(arg_40_2:Find("selected"), false)
		end
	end)
	var_37_8:align(#var_37_6)
end

function var_0_0.displayStrategyInfo(arg_42_0, arg_42_1)
	arg_42_0.strategyPanel = arg_42_0.strategyPanel or StrategyPanel.New(arg_42_0.strategyInfo)

	arg_42_0.strategyPanel:attach(arg_42_0)
	arg_42_0.strategyPanel:set(arg_42_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_42_0.strategyPanel._tf, false, {
		weight = LayerWeightConst.SECOND_LAYER
	})

	function arg_42_0.strategyPanel.onConfirm()
		local var_43_0 = arg_42_0.chapter.fleet
		local var_43_1 = pg.strategy_data_template[arg_42_1.id]

		if not var_43_0:canUseStrategy(arg_42_1) then
			return
		end

		local var_43_2 = var_43_0:getNextStgUser(arg_42_1.id)

		arg_42_0:emit(ChapterPreCombatMediator.ON_OP, {
			type = ChapterConst.OpStrategy,
			id = var_43_2,
			arg1 = arg_42_1.id
		})
		arg_42_0:hideStrategyInfo()
	end

	function arg_42_0.strategyPanel.onCancel()
		arg_42_0:hideStrategyInfo()
	end
end

function var_0_0.hideStrategyInfo(arg_45_0)
	if arg_45_0.strategyPanel then
		pg.UIMgr.GetInstance():UnblurPanel(arg_45_0.strategyPanel._tf)
		arg_45_0.strategyPanel:detach()
	end
end

function var_0_0.onBackPressed(arg_46_0)
	if arg_46_0.strategyPanel and arg_46_0.strategyPanel._go and isActive(arg_46_0.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_46_0:hideStrategyInfo()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_46_0._backBtn)
	end
end

function var_0_0.willExit(arg_47_0)
	if arg_47_0.strategyPanel and arg_47_0.strategyPanel._go and isActive(arg_47_0.strategyPanel._go) then
		arg_47_0:hideStrategyInfo()
	end

	arg_47_0._formationLogic:Destroy()

	arg_47_0._formationLogic = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_47_0._tf)
end

return var_0_0
