local var_0_0 = class("ActivityMainScene", import("..base.BaseUI"))

var_0_0.LOCK_ACT_MAIN = "ActivityMainScene:LOCK_ACT_MAIN"
var_0_0.UPDATE_ACTIVITY = "ActivityMainScene:UPDATE_ACTIVITY"
var_0_0.GET_PAGE_BGM = "ActivityMainScene.GET_PAGE_BGM"
var_0_0.FLUSH_TABS = "ActivityMainScene.FLUSH_TABS"

function var_0_0.preload(arg_1_0, arg_1_1)
	arg_1_1()
end

function var_0_0.getUIName(arg_2_0)
	return "ActivityMainUI"
end

function var_0_0.PlayBGM(arg_3_0)
	return
end

function var_0_0.onBackPressed(arg_4_0)
	if arg_4_0.locked then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.windowList) do
		if isActive(iter_4_1._tf) then
			arg_4_0:HideWindow(iter_4_1.class)

			return
		end
	end

	if arg_4_0.awardWindow and arg_4_0.awardWindow:GetLoaded() and arg_4_0.awardWindow:isShowing() then
		arg_4_0.awardWindow:Hide()

		return
	end

	arg_4_0:emit(var_0_0.ON_BACK_PRESSED)
end

local var_0_1

function var_0_0.init(arg_5_0)
	arg_5_0.btnBack = arg_5_0:findTF("blur_panel/adapt/top/back_btn")
	arg_5_0.pageContainer = arg_5_0:findTF("pages")
	arg_5_0.permanentFinshMask = arg_5_0:findTF("pages_finish")
	arg_5_0.tabs = arg_5_0:findTF("scroll/viewport/content")
	arg_5_0.tab = arg_5_0:findTF("tab", arg_5_0.tabs)
	arg_5_0.entranceList = UIItemList.New(arg_5_0:findTF("enter/viewport/content"), arg_5_0:findTF("enter/viewport/content/btn"))
	arg_5_0.windowList = {}
	arg_5_0.lockAll = arg_5_0:findTF("blur_panel/lock_all")
	arg_5_0.awardWindow = AwardWindow.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.chargeTipWindow = ChargeTipWindow.New(arg_5_0._tf, arg_5_0.event)

	setActive(arg_5_0.tab, false)
	setActive(arg_5_0.lockAll, false)
	setActive(arg_5_0.permanentFinshMask, false)
	setText(arg_5_0.permanentFinshMask:Find("piece/Text"), i18n("activity_permanent_tips2"))
	onButton(arg_5_0, arg_5_0.permanentFinshMask:Find("piece/arrow/Image"), function()
		arg_5_0:emit(ActivityMediator.FINISH_ACTIVITY_PERMANENT)
	end, SFX_PANEL)
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.btnBack, function()
		arg_7_0:emit(var_0_0.ON_BACK)
	end, SOUND_BACK)
	arg_7_0:updateEntrances()
	arg_7_0:emit(ActivityMediator.SHOW_NEXT_ACTIVITY)
	arg_7_0:bind(var_0_0.LOCK_ACT_MAIN, function(arg_9_0, arg_9_1)
		arg_7_0.locked = arg_9_1

		setActive(arg_7_0.lockAll, arg_9_1)
	end)
	arg_7_0:bind(var_0_0.UPDATE_ACTIVITY, function(arg_10_0, arg_10_1)
		arg_7_0:updateActivity(arg_10_1)
	end)
	arg_7_0:bind(var_0_0.GET_PAGE_BGM, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_2.bgm = arg_7_0:getBGM(arg_11_1) or arg_7_0:getBGM()
	end)
	arg_7_0:bind(var_0_0.FLUSH_TABS, function()
		arg_7_0:flushTabs()
	end)
end

function var_0_0.setPlayer(arg_13_0, arg_13_1)
	arg_13_0.shareData:SetPlayer(arg_13_1)
end

function var_0_0.setFlagShip(arg_14_0, arg_14_1)
	arg_14_0.shareData:SetFlagShip(arg_14_1)
end

function var_0_0.updateTaskLayers(arg_15_0)
	if not arg_15_0.activity then
		return
	end

	arg_15_0:updateActivity(arg_15_0.activity)
end

function var_0_0.instanceActivityPage(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getConfig("page_info")

	if var_16_0.class_name and not arg_16_0.pageDic[arg_16_1.id] and not arg_16_1:isEnd() then
		local var_16_1 = import("view.activity.subPages." .. var_16_0.class_name).New(arg_16_0.pageContainer, arg_16_0.event, arg_16_0.contextData)

		if var_16_1:UseSecondPage(arg_16_1) then
			var_16_1:SetUIName(var_16_0.ui_name2)
		else
			var_16_1:SetUIName(var_16_0.ui_name)
		end

		var_16_1:SetShareData(arg_16_0.shareData)

		arg_16_0.pageDic[arg_16_1.id] = var_16_1
	end
end

function var_0_0.setActivities(arg_17_0, arg_17_1)
	arg_17_0.activities = arg_17_1 or {}
	arg_17_0.shareData = arg_17_0.shareData or ActivityShareData.New()
	arg_17_0.pageDic = arg_17_0.pageDic or {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0:instanceActivityPage(iter_17_1)
	end

	arg_17_0.activity = nil

	table.sort(arg_17_0.activities, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:getShowPriority()
		local var_18_1 = arg_18_1:getShowPriority()

		if var_18_0 == var_18_1 then
			return arg_18_0.id > arg_18_1.id
		end

		return var_18_1 < var_18_0
	end)
	arg_17_0:flushTabs()
end

function var_0_0.getActivityIndex(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.activities) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_0
		end
	end

	return nil
end

function var_0_0.updateActivity(arg_20_0, arg_20_1)
	if ActivityConst.PageIdLink[arg_20_1.id] then
		arg_20_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_20_1.id])
	end

	if arg_20_1:isShow() and not arg_20_1:isEnd() then
		arg_20_0.activities[arg_20_0:getActivityIndex(arg_20_1.id) or #arg_20_0.activities + 1] = arg_20_1

		table.sort(arg_20_0.activities, function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0:getShowPriority()
			local var_21_1 = arg_21_1:getShowPriority()

			if var_21_0 == var_21_1 then
				return arg_21_0.id > arg_21_1.id
			end

			return var_21_1 < var_21_0
		end)

		if not arg_20_0.pageDic[arg_20_1.id] then
			arg_20_0:instanceActivityPage(arg_20_1)
		end

		arg_20_0:flushTabs()

		if arg_20_0.activity and arg_20_0.activity.id == arg_20_1.id then
			arg_20_0.activity = arg_20_1

			arg_20_0.pageDic[arg_20_1.id]:ActionInvoke("Flush", arg_20_1)
			setActive(arg_20_0.permanentFinshMask, pg.activity_task_permanent[arg_20_1.id] and arg_20_1:canPermanentFinish())
		end
	end
end

function var_0_0.removeActivity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getActivityIndex(arg_22_1)

	if var_22_0 then
		table.remove(arg_22_0.activities, var_22_0)
		arg_22_0.pageDic[arg_22_1]:Destroy()

		arg_22_0.pageDic[arg_22_1] = nil

		arg_22_0:flushTabs()

		if arg_22_0.activity and arg_22_0.activity.id == arg_22_1 then
			arg_22_0.activity = nil

			arg_22_0:verifyTabs()
		end
	end
end

function var_0_0.loadLayers(arg_23_0)
	local var_23_0 = arg_23_0.pageDic[arg_23_0.activity.id]

	if var_23_0 and var_23_0.OnLoadLayers then
		var_23_0:OnLoadLayers()
	end
end

function var_0_0.removeLayers(arg_24_0)
	local var_24_0 = arg_24_0.pageDic[arg_24_0.activity.id]

	if var_24_0 and var_24_0.OnRemoveLayers then
		var_24_0:OnRemoveLayers()
	end
end

function var_0_0.GetOnShowEntranceData()
	var_0_1 = var_0_1 or require("GameCfg.activity.EntranceData")

	assert(var_0_1, "Missing EntranceData.lua!")

	var_0_1 = var_0_1 or {}

	return (_.select(var_0_1, function(arg_26_0)
		return arg_26_0.isShow and arg_26_0.isShow()
	end))
end

function var_0_0.updateEntrances(arg_27_0)
	local var_27_0 = var_0_0.GetOnShowEntranceData()
	local var_27_1 = math.max(#var_27_0, 5)

	arg_27_0.entranceList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_27_0[arg_28_1 + 1]
			local var_28_1 = "empty"

			removeOnButton(arg_28_2)

			local var_28_2 = false

			if var_28_0 and table.getCount(var_28_0) ~= 0 and var_28_0.isShow() then
				onButton(arg_27_0, arg_28_2, function()
					arg_27_0:emit(var_28_0.event, var_28_0.data[1], var_28_0.data[2])
				end, SFX_PANEL)

				var_28_1 = var_28_0.banner

				if var_28_0.isTip then
					var_28_2 = var_28_0.isTip()
				end
			end

			setActive(arg_28_2:Find("tip"), var_28_2)
			LoadImageSpriteAsync("activitybanner/" .. var_28_1, arg_28_2)
		end
	end)
	arg_27_0.entranceList:align(var_27_1)
end

function var_0_0.flushTabs(arg_30_0)
	if not arg_30_0.tabsList then
		arg_30_0.tabsList = UIItemList.New(arg_30_0.tabs, arg_30_0.tab)

		arg_30_0.tabsList:make(function(arg_31_0, arg_31_1, arg_31_2)
			if arg_31_0 == UIItemList.EventUpdate then
				local var_31_0 = arg_30_0.activities[arg_31_1 + 1]

				if arg_30_0.pageDic[var_31_0.id] ~= nil then
					local var_31_1 = var_31_0:getConfig("title_res_tag")

					if var_31_1 then
						local var_31_2 = arg_30_0:findTF("red", arg_31_2)
						local var_31_3 = GetSpriteFromAtlas("activityuitable/" .. var_31_1 .. "_text", "") or GetSpriteFromAtlas("activityuitable/activity_text", "")
						local var_31_4 = GetSpriteFromAtlas("activityuitable/" .. var_31_1 .. "_text_selected", "") or GetSpriteFromAtlas("activityuitable/activity_text_selected", "")

						setImageSprite(arg_30_0:findTF("off/text", arg_31_2), var_31_3, true)
						setImageSprite(arg_30_0:findTF("on/text", arg_31_2), var_31_4, true)
						setActive(var_31_2, var_31_0:readyToAchieve())
						onToggle(arg_30_0, arg_31_2, function(arg_32_0)
							if arg_32_0 then
								arg_30_0:selectActivity(var_31_0)
							end
						end, SFX_PANEL)
					else
						onToggle(arg_30_0, arg_31_2, function(arg_33_0)
							arg_30_0:loadActivityPanel(arg_33_0, var_31_0)
						end, SFX_PANEL)
					end

					triggerToggle(arg_31_2, false)
				end
			end
		end)
	end

	setActive(arg_30_0.tabs, false)
	arg_30_0.tabsList:align(#arg_30_0.activities)
	setActive(arg_30_0.tabs, true)

	local var_30_0 = arg_30_0.activity and arg_30_0:getActivityIndex(arg_30_0.activity.id)

	if var_30_0 then
		triggerToggle(arg_30_0.tabs:GetChild(var_30_0 - 1), true)
	end
end

function var_0_0.selectActivity(arg_34_0, arg_34_1)
	if arg_34_1 and (not arg_34_0.activity or arg_34_0.activity.id ~= arg_34_1.id) then
		local var_34_0 = arg_34_0.pageDic[arg_34_1.id]

		assert(var_34_0, "找不到id:" .. arg_34_1.id .. "的活动页，请检查")
		var_34_0:Load()
		var_34_0:ActionInvoke("Flush", arg_34_1)
		var_34_0:ActionInvoke("ShowOrHide", true)

		if arg_34_0.activity and arg_34_0.activity.id ~= arg_34_1.id then
			arg_34_0.pageDic[arg_34_0.activity.id]:ActionInvoke("ShowOrHide", false)
		end

		arg_34_0.activity = arg_34_1
		arg_34_0.contextData.id = arg_34_1.id

		setActive(arg_34_0.permanentFinshMask, pg.activity_task_permanent[arg_34_1.id] and arg_34_1:canPermanentFinish())
	end
end

function var_0_0.verifyTabs(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getActivityIndex(arg_35_1) or 1
	local var_35_1 = arg_35_0.tabs:GetChild(var_35_0 - 1)

	triggerToggle(var_35_1, true)
end

function var_0_0.loadActivityPanel(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_2:getConfig("type")
	local var_36_1

	if var_36_1 and arg_36_1 then
		arg_36_0:emit(ActivityMediator.OPEN_LAYER, var_36_1)
	elseif var_36_1 and not arg_36_1 then
		arg_36_0:emit(ActivityMediator.CLOSE_LAYER, var_36_1.mediator)
	else
		originalPrint("------活动id为" .. arg_36_2.id .. "类型为" .. arg_36_2:getConfig("type") .. "的页面不存在")
	end
end

function var_0_0.getBonusWindow(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:findTF(arg_37_1)

	if not var_37_0 then
		PoolMgr.GetInstance():GetUI("ActivitybonusWindow", true, function(arg_38_0)
			SetParent(arg_38_0, arg_37_0._tf, false)

			arg_38_0.name = arg_37_1

			arg_37_2(arg_38_0)
		end)
	else
		arg_37_2(var_37_0)
	end
end

function var_0_0.ShowWindow(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1.__cname

	if not arg_39_0.windowList[var_39_0] then
		arg_39_0:getBonusWindow(var_39_0, function(arg_40_0)
			arg_39_0.windowList[var_39_0] = arg_39_1.New(tf(arg_40_0), arg_39_0)

			arg_39_0.windowList[var_39_0]:Show(arg_39_2)
		end)
	else
		arg_39_0.windowList[var_39_0]:Show(arg_39_2)
	end
end

function var_0_0.HideWindow(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.__cname

	if not arg_41_0.windowList[var_41_0] then
		return
	end

	arg_41_0.windowList[var_41_0]:Hide()
end

function var_0_0.ShowAwardWindow(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0.awardWindow:ExecuteAction("Flush", arg_42_1, arg_42_2, arg_42_3)
end

function var_0_0.OnChargeSuccess(arg_43_0, arg_43_1)
	arg_43_0.chargeTipWindow:ExecuteAction("Show", arg_43_1)
end

function var_0_0.willExit(arg_44_0)
	arg_44_0.shareData = nil

	for iter_44_0, iter_44_1 in pairs(arg_44_0.pageDic) do
		iter_44_1:Destroy()
	end

	for iter_44_2, iter_44_3 in pairs(arg_44_0.windowList) do
		iter_44_3:Dispose()
	end

	if arg_44_0.awardWindow then
		arg_44_0.awardWindow:Destroy()

		arg_44_0.awardWindow = nil
	end

	if arg_44_0.chargeTipWindow then
		arg_44_0.chargeTipWindow:Destroy()

		arg_44_0.chargeTipWindow = nil
	end
end

return var_0_0
