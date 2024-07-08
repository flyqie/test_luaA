local var_0_0 = class("BackYardDecorationThemePage", import(".BackYardDecorationBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardDecorationThemePage"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.msgbox = BackYardDecorationMsgBox.New(arg_2_0._parentTf.parent.parent.parent.parent.parent, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.refreshList = {}
end

function var_0_0.OnDisplayList(arg_3_0)
	arg_3_0:InitList()
end

function var_0_0.InitList(arg_4_0)
	arg_4_0.displays = {}

	local var_4_0 = arg_4_0.dorm:GetPurchasedFurnitures()
	local var_4_1 = getProxy(DormProxy):GetSystemThemes()

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if iter_4_1:IsPurchased(var_4_0) then
			table.insert(arg_4_0.displays, iter_4_1)
		end
	end

	local var_4_2 = 0

	if arg_4_0.customTheme then
		for iter_4_2, iter_4_3 in pairs(arg_4_0.customTheme) do
			var_4_2 = var_4_2 + 1

			table.insert(arg_4_0.displays, iter_4_3)
		end
	end

	if var_4_2 < BackYardConst.MAX_USER_THEME then
		table.insert(arg_4_0.displays, {
			id = "",
			isEmpty = true
		})
	end

	arg_4_0:SortDisplays()
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.isEmpty and 1 or 0
	local var_5_1 = arg_5_1.isEmpty and 1 or 0

	if var_5_0 == var_5_1 then
		local var_5_2 = arg_5_0:IsSystem() and 1 or 0
		local var_5_3 = arg_5_1:IsSystem() and 1 or 0

		if var_5_2 == var_5_3 then
			if arg_5_0.order == arg_5_1.order then
				return arg_5_0.id > arg_5_1.id
			else
				return arg_5_0.order > arg_5_1.order
			end
		else
			return var_5_2 < var_5_3
		end
	else
		return var_5_1 < var_5_0
	end
end

function var_0_0.SortDisplays(arg_6_0)
	table.sort(arg_6_0.displays, function(arg_7_0, arg_7_1)
		return var_0_1(arg_7_0, arg_7_1, arg_6_0.orderMode)
	end)
	arg_6_0:SetTotalCount()
end

function var_0_0.OnOrderModeUpdated(arg_8_0)
	arg_8_0:SortDisplays()
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = BackYardDecorationThemeCard.New(arg_9_1)

	onButton(arg_9_0, var_9_0._tf, function()
		if var_9_0:HasMask() then
			return
		end

		arg_9_0.msgbox:ExecuteAction("Show", var_9_0.themeVO, true)
	end)
	onButton(arg_9_0, var_9_0.add, function()
		local var_11_0 = getProxy(DormProxy):GetTemplateNewID()

		arg_9_0.msgbox:ExecuteAction("Show", {
			id = var_11_0
		}, false)
	end)

	arg_9_0.cards[arg_9_1] = var_9_0
end

function var_0_0.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.cards[arg_12_2]

	if not var_12_0 then
		arg_12_0:OnInitItem(arg_12_2)

		var_12_0 = arg_12_0.cards[arg_12_2]
	end

	local var_12_1 = arg_12_0.lastDiaplys[arg_12_1 + 1]

	var_12_0:Update(var_12_1, false)
end

function var_0_0.OnThemeUpdated(arg_13_0)
	arg_13_0.currHouse = nil

	arg_13_0:InitList()
end

function var_0_0.OnApplyThemeBefore(arg_14_0)
	arg_14_0.currHouse = nil

	for iter_14_0, iter_14_1 in pairs(arg_14_0.cards) do
		iter_14_1:Update(iter_14_1.themeVO, false)
	end

	arg_14_0.temps = {}
end

function var_0_0.OnApplyThemeAfter(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.cards) do
		if iter_15_1.themeVO.id == arg_15_1 then
			iter_15_1:Update(iter_15_1.themeVO, false)
		end
	end
end

function var_0_0.SetTotalCount(arg_16_0)
	if not arg_16_0.searchKey or arg_16_0.searchKey == "" then
		arg_16_0.lastDiaplys = arg_16_0.displays
	else
		arg_16_0.lastDiaplys = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_0.displays) do
			if iter_16_1.id == "" or iter_16_1:MatchSearchKey(arg_16_0.searchKey) then
				table.insert(arg_16_0.lastDiaplys, iter_16_1)
			end
		end
	end

	arg_16_0.scrollRect:SetTotalCount(#arg_16_0.lastDiaplys)
end

function var_0_0.OnSearchKeyChanged(arg_17_0)
	arg_17_0:SetTotalCount()
end

function var_0_0.OnDestroy(arg_18_0)
	arg_18_0.msgbox:Destroy()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.cards or {}) do
		iter_18_1:Dispose()
	end

	arg_18_0.cards = nil
end

function var_0_0.OnBackPressed(arg_19_0)
	if arg_19_0:GetLoaded() and arg_19_0.msgbox:GetLoaded() and arg_19_0.msgbox:isShowing() then
		arg_19_0.msgbox:Hide()

		return true
	end

	return false
end

return var_0_0
