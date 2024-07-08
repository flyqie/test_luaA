local var_0_0 = class("IdolMedalCollectionView2", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "IdolMedalCollectionUI2"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
end

local var_0_1 = {
	32.4,
	132.7
}

function var_0_0.didEnter(arg_3_0)
	arg_3_0:checkAward()
	arg_3_0:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)
end

function var_0_0.initData(arg_5_0)
	arg_5_0.activityProxy = getProxy(ActivityProxy)
	arg_5_0.activityData = arg_5_0.activityProxy:getActivityById(ActivityConst.MUSIC_FESTIVAL_MEDALCOLLECTION_2020)
	arg_5_0.allIDList = arg_5_0.activityData:GetPicturePuzzleIds()
	arg_5_0.activatableIDList = arg_5_0.activityData.data1_list
	arg_5_0.activeIDList = arg_5_0.activityData.data2_list
end

local var_0_2 = {}

function var_0_0.findUI(arg_6_0)
	arg_6_0.bg = arg_6_0:findTF("BG")

	local var_6_0 = arg_6_0:findTF("NotchAdapt")

	arg_6_0.backBtn = arg_6_0:findTF("BackBtn", var_6_0)
	arg_6_0.progressText = arg_6_0:findTF("ProgressText", var_6_0)
	arg_6_0.helpBtn = arg_6_0:findTF("HelpBtn", var_6_0)
	arg_6_0.top = var_6_0

	local var_6_1 = arg_6_0:findTF("MedalContainer")

	arg_6_0.medalContainer = var_6_1
	arg_6_0.buttonNext = arg_6_0:findTF("ButtonNext", var_6_1)
	arg_6_0.buttonNextLocked = arg_6_0:findTF("ButtonNextLocked", var_6_1)
	arg_6_0.buttonPrev = arg_6_0:findTF("ButtonPrev", var_6_1)
	arg_6_0.buttonShare = arg_6_0:findTF("ButtonShare", var_6_1)
	arg_6_0.buttonReset = arg_6_0:findTF("ButtonReset", var_6_1)
	arg_6_0.pageCollection = var_6_1:Find("PageCollection")
	arg_6_0.pageModified = var_6_1:Find("PageModified")
	arg_6_0.OverlayPanel = var_6_1:Find("Overlay")
	arg_6_0.pages = {
		arg_6_0.pageCollection,
		arg_6_0.pageModified
	}
	arg_6_0.pageIndex = 1
	arg_6_0.medalItemList = {}

	for iter_6_0 = 1, #arg_6_0.allIDList do
		table.insert(arg_6_0.medalItemList, arg_6_0:findTF("Images/Medal" .. iter_6_0, arg_6_0.pageCollection))
	end

	arg_6_0.medalTextList = {}

	for iter_6_1 = 1, #arg_6_0.allIDList do
		table.insert(arg_6_0.medalTextList, arg_6_0:findTF("Texts/Medal" .. iter_6_1, arg_6_0.pageCollection))
	end

	arg_6_0.selectPanel = var_6_1:Find("SelectPanel")
	arg_6_0.selectPanelContainer = arg_6_0.selectPanel:Find("Scroll/Container")
	arg_6_0.allItems = {}
	arg_6_0.selectedPositionsInPanels = {}
	arg_6_0.listStayInPanel = {}
	arg_6_0.listShowOnPanel = {}
	arg_6_0.overlayingImage = nil

	for iter_6_2 = 0, arg_6_0.selectPanelContainer.childCount - 1 do
		local var_6_2 = arg_6_0.selectPanelContainer:GetChild(iter_6_2)

		arg_6_0.selectedPositionsInPanels[var_6_2] = var_6_2.anchoredPosition

		table.insert(arg_6_0.listStayInPanel, var_6_2)
		table.insert(arg_6_0.allItems, var_6_2)
	end

	for iter_6_3, iter_6_4 in pairs(var_0_2) do
		local var_6_3 = arg_6_0.allItems[iter_6_3]

		setParent(var_6_3, arg_6_0.pageModified)
		table.removebyvalue(arg_6_0.listStayInPanel, var_6_3)
		table.insert(arg_6_0.listShowOnPanel, var_6_3)
		setAnchoredPosition(var_6_3, iter_6_4)
	end

	setText(arg_6_0.pageModified:Find("TextTip"), i18n("collect_idol_tip"))
	arg_6_0:AddLeanTween(function()
		return LeanTween.alphaText(rtf(arg_6_0.pageModified:Find("TextTip")), 1, 2):setFrom(0):setLoopPingPong()
	end)
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:closeView()
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_collection.tip
		})
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:SwitchSelectedImage(nil)
	end)
	onButton(arg_8_0, arg_8_0.selectPanelContainer, function()
		arg_8_0:SwitchSelectedImage(nil)
	end)
	onButton(arg_8_0, arg_8_0.buttonNext, function()
		arg_8_0:SwitchPage(1)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.buttonNextLocked, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("hand_account_tip"))
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.buttonPrev, function()
		arg_8_0:SwitchPage(-1)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.buttonReset, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("hand_account_resetting_tip"),
			onYes = function()
				arg_8_0:ResetPanel()
			end
		})
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.buttonShare, function()
		setAnchoredPosition(arg_8_0.medalContainer, {
			x = var_0_1[1]
		})
		setActive(arg_8_0.selectPanel, false)
		setActive(arg_8_0.buttonNext, false)
		setActive(arg_8_0.buttonNextLocked, false)
		setActive(arg_8_0.buttonPrev, false)
		setActive(arg_8_0.buttonShare, false)
		setActive(arg_8_0.buttonReset, false)
		setActive(arg_8_0.top, false)
		setActive(arg_8_0.pageModified:Find("TextTip"), false)

		local var_18_0 = arg_8_0.lastSelectedImage

		arg_8_0:SwitchSelectedImage(nil)
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePoraisMedals)
		setActive(arg_8_0.top, true)
		setActive(arg_8_0.pageModified:Find("TextTip"), true)
		arg_8_0:SwitchSelectedImage(var_18_0)
		arg_8_0:UpdateView()
	end, SFX_PANEL)

	local var_8_0 = GameObject.Find("OverlayCamera"):GetComponent("Camera")

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.allItems) do
		local var_8_1 = arg_8_0.selectedPositionsInPanels[iter_8_1]

		setActive(iter_8_1:Find("Selected"), false)

		local var_8_2 = GetOrAddComponent(iter_8_1, "EventTriggerListener")

		local function var_8_3()
			if not arg_8_0.overlayingImage then
				return
			end

			local var_19_0 = arg_8_0.overlayingImage

			arg_8_0.overlayingImage = nil

			for iter_19_0, iter_19_1 in ipairs(arg_8_0.listStayInPanel) do
				if iter_19_1 == var_19_0 then
					setParent(var_19_0, arg_8_0.selectPanelContainer)
					setAnchoredPosition(var_19_0, arg_8_0.selectedPositionsInPanels[var_19_0])

					return
				end
			end

			for iter_19_2, iter_19_3 in ipairs(arg_8_0.listShowOnPanel) do
				if iter_19_3 == var_19_0 then
					setParent(var_19_0, arg_8_0.pageModified)
					var_19_0:SetAsLastSibling()

					return
				end
			end
		end

		local var_8_4

		var_8_2:AddPointClickFunc(function(arg_20_0, arg_20_1)
			if var_8_4 then
				return
			end

			if arg_8_0.lastSelectedImage == iter_8_1 then
				arg_8_0:SwitchSelectedImage(nil)
			else
				arg_8_0:SwitchSelectedImage(iter_8_1)
				iter_8_1:SetAsLastSibling()
			end
		end)
		var_8_2:AddBeginDragFunc(function(arg_21_0, arg_21_1)
			var_8_4 = arg_21_1.position

			var_8_3()
			setParent(iter_8_1, arg_8_0.OverlayPanel)

			arg_8_0.overlayingImage = iter_8_1

			arg_8_0:SwitchSelectedImage(iter_8_1)
		end)
		var_8_2:AddDragFunc(function(arg_22_0, arg_22_1)
			local var_22_0 = LuaHelper.ScreenToLocal(rtf(arg_8_0.OverlayPanel), arg_22_1.position, var_8_0)

			setAnchoredPosition(iter_8_1, var_22_0)
		end)
		var_8_2:AddDragEndFunc(function(arg_23_0, arg_23_1)
			local var_23_0 = arg_23_1.position
			local var_23_1 = var_8_4 and var_8_4:Sub(var_23_0):SqrMagnitude() < 1

			var_8_4 = nil

			if var_23_1 then
				var_8_3()

				return
			end

			local var_23_2 = LuaHelper.ScreenToLocal(rtf(arg_8_0.pageModified), arg_23_1.position, var_8_0)

			if not rtf(arg_8_0.pageModified).rect:Contains(var_23_2) then
				setParent(iter_8_1, arg_8_0.selectPanelContainer)
				table.removebyvalue(arg_8_0.listStayInPanel, iter_8_1)
				table.removebyvalue(arg_8_0.listShowOnPanel, iter_8_1)
				table.insert(arg_8_0.listStayInPanel, iter_8_1)

				var_0_2[iter_8_0] = nil

				setAnchoredPosition(iter_8_1, var_8_1)
				iter_8_1:SetAsLastSibling()
			else
				setParent(iter_8_1, arg_8_0.pageModified)
				table.removebyvalue(arg_8_0.listStayInPanel, iter_8_1)
				table.removebyvalue(arg_8_0.listShowOnPanel, iter_8_1)
				table.insert(arg_8_0.listShowOnPanel, iter_8_1)

				var_0_2[iter_8_0] = var_23_2

				setAnchoredPosition(iter_8_1, var_23_2)
				iter_8_1:SetAsLastSibling()
			end

			arg_8_0.overlayingImage = nil
		end)
	end
end

function var_0_0.SwitchSelectedImage(arg_24_0, arg_24_1)
	if arg_24_0.lastSelectedImage == arg_24_1 then
		return
	end

	if arg_24_0.lastSelectedImage then
		setActive(arg_24_0.lastSelectedImage:Find("Selected"), false)
	end

	arg_24_0.lastSelectedImage = arg_24_1

	if arg_24_1 then
		setActive(arg_24_1:Find("Selected"), true)
	end
end

function var_0_0.ResetPanel(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.listShowOnPanel) do
		table.insert(arg_25_0.listStayInPanel, iter_25_1)
		setParent(iter_25_1, arg_25_0.selectPanelContainer)

		local var_25_0 = arg_25_0.selectedPositionsInPanels[iter_25_1] or Vector2.zero

		setAnchoredPosition(iter_25_1, var_25_0)
	end

	table.clean(arg_25_0.listShowOnPanel)
	table.clear(var_0_2)
end

function var_0_0.UpdateView(arg_26_0)
	if arg_26_0.pageIndex == 1 then
		arg_26_0:updateMedalContainerView()
	end

	for iter_26_0 = 1, #arg_26_0.pages do
		setActive(arg_26_0.pages[iter_26_0], iter_26_0 == arg_26_0.pageIndex)
	end

	setAnchoredPosition(arg_26_0.medalContainer, {
		x = var_0_1[arg_26_0.pageIndex]
	})
	setActive(arg_26_0.selectPanel, arg_26_0.pageIndex == 2)

	local var_26_0 = #arg_26_0.activeIDList == #arg_26_0.allIDList and arg_26_0.activityData.data1 == 1

	setActive(arg_26_0.buttonNext, var_26_0 and arg_26_0.pageIndex == 1)
	setActive(arg_26_0.buttonNextLocked, not var_26_0 and arg_26_0.pageIndex == 1)
	setActive(arg_26_0.buttonPrev, arg_26_0.pageIndex == 2)
	setActive(arg_26_0.buttonShare, arg_26_0.pageIndex == 2)
	setActive(arg_26_0.buttonReset, arg_26_0.pageIndex == 2)
	setText(arg_26_0.progressText, setColorStr(tostring(#arg_26_0.activeIDList), COLOR_RED) .. "/" .. #arg_26_0.allIDList)
end

function var_0_0.updateMedalContainerView(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.allIDList) do
		arg_27_0:updateMedalView(arg_27_0.allIDList, iter_27_1)
	end
end

function var_0_0.updateMedalView(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = table.indexof(arg_28_1, arg_28_2, 1)
	local var_28_1 = table.contains(arg_28_0.activeIDList, arg_28_2)
	local var_28_2 = table.contains(arg_28_0.activatableIDList, arg_28_2) and not var_28_1
	local var_28_3 = not var_28_1 and not var_28_2
	local var_28_4 = arg_28_0.medalItemList[var_28_0]
	local var_28_5 = arg_28_0.medalTextList[var_28_0]
	local var_28_6 = arg_28_0:findTF("Activable", var_28_5)
	local var_28_7 = arg_28_0:findTF("DisActive", var_28_5)

	setImageAlpha(var_28_4, var_28_1 and 1 or 0)
	setActive(var_28_6, var_28_2)
	setActive(var_28_7, var_28_3)
	onButton(arg_28_0, var_28_4, function()
		if not var_28_2 then
			return
		end

		pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
			id = arg_28_2,
			actId = arg_28_0.activityData.id
		})
	end, SFX_PANEL)

	local var_28_8 = ""

	setText(var_28_7, var_28_8)
end

function var_0_0.updateAfterSubmit(arg_30_0)
	return
end

function var_0_0.UpdateActivity(arg_31_0)
	arg_31_0:initData()
	arg_31_0:checkAward()
	arg_31_0:UpdateView()
end

function var_0_0.SwitchPage(arg_32_0, arg_32_1)
	arg_32_0.pageIndex = math.clamp(arg_32_0.pageIndex + arg_32_1, 1, #arg_32_0.pages)

	arg_32_0:UpdateView()
end

function var_0_0.checkAward(arg_33_0)
	if #arg_33_0.activeIDList == #arg_33_0.allIDList and arg_33_0.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_33_0.activityData.id
		})
	end
end

return var_0_0
