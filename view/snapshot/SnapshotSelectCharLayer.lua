local var_0_0 = class("SnapshotSelectCharLayer", import("..base.BaseUI"))

var_0_0.ON_INDEX = "SnapshotSelectCharLayer.ON_INDEX"
var_0_0.SELECT_CHAR = "SnapshotSelectCharLayer.SELECT_CHAR"
var_0_0.TOGGLE_UNDEFINED = -1
var_0_0.TOGGLE_CHAR = 0
var_0_0.TOGGLE_LINK = 1
var_0_0.TOGGLE_BLUEPRINT = 2
var_0_0.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll
}
var_0_0.ShipIndexData = {
	customPanels = {
		typeIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.TypeIndexs,
			names = ShipIndexConst.TypeNames
		},
		campIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.CampIndexs,
			names = ShipIndexConst.CampNames
		},
		rarityIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.RarityIndexs,
			names = ShipIndexConst.RarityNames
		}
	},
	groupList = {
		{
			dropdown = false,
			titleTxt = "indexsort_index",
			titleENTxt = "indexsort_indexeng",
			tags = {
				"typeIndex"
			}
		},
		{
			dropdown = false,
			titleTxt = "indexsort_camp",
			titleENTxt = "indexsort_campeng",
			tags = {
				"campIndex"
			}
		},
		{
			dropdown = false,
			titleTxt = "indexsort_rarity",
			titleENTxt = "indexsort_rarityeng",
			tags = {
				"rarityIndex"
			}
		}
	}
}

function var_0_0.setShipGroups(arg_1_0, arg_1_1)
	arg_1_0.shipGroups = arg_1_1
end

function var_0_0.setProposeList(arg_2_0, arg_2_1)
	arg_2_0.proposeList = arg_2_1
end

function var_0_0.getUIName(arg_3_0)
	return "snapshotselectchar"
end

function var_0_0.back(arg_4_0)
	if arg_4_0.exited then
		return
	end

	arg_4_0:emit(var_0_0.ON_CLOSE)

	arg_4_0.scrollValue = 0
end

function var_0_0.init(arg_5_0)
	arg_5_0.toggleType = var_0_0.TOGGLE_UNDEFINED
	arg_5_0.topTF = arg_5_0:findTF("blur_panel/adapt/top")
	arg_5_0.backBtn = arg_5_0:findTF("back_btn", arg_5_0.topTF)
	arg_5_0.indexBtn = arg_5_0:findTF("index_button", arg_5_0.topTF)
	arg_5_0.toggleChar = arg_5_0:findTF("list_card/types/char")
	arg_5_0.toggleLink = arg_5_0:findTF("list_card/types/link")
	arg_5_0.toggleBlueprint = arg_5_0:findTF("list_card/types/blueprint")
	arg_5_0.cardItems = {}
	arg_5_0.cardList = arg_5_0:findTF("list_card/scroll"):GetComponent("LScrollRect")

	function arg_5_0.cardList.onInitItem(arg_6_0)
		arg_5_0:onInitCard(arg_6_0)
	end

	function arg_5_0.cardList.onUpdateItem(arg_7_0, arg_7_1)
		arg_5_0:onUpdateCard(arg_7_0, arg_7_1)
	end

	function arg_5_0.cardList.onReturnItem(arg_8_0, arg_8_1)
		arg_5_0:onReturnCard(arg_8_0, arg_8_1)
	end

	arg_5_0:initSelectSkinPanel()
	cameraPaintViewAdjust(false)
	pg.UIMgr.GetInstance():OverlayPanel(arg_5_0._tf)
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:back()
	end)
	onToggle(arg_9_0, arg_9_0.toggleChar, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_CHAR then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_CHAR

		arg_9_0:updateCardList()
	end)
	onToggle(arg_9_0, arg_9_0.toggleLink, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_LINK then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_LINK

		arg_9_0:updateCardList()
	end)
	onToggle(arg_9_0, arg_9_0.toggleBlueprint, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_BLUEPRINT then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_BLUEPRINT

		arg_9_0:updateCardList()
	end)
	onButton(arg_9_0, arg_9_0.indexBtn, function()
		local var_14_0 = Clone(var_0_0.ShipIndexData)

		if arg_9_0.toggleType == var_0_0.TOGGLE_LINK then
			var_14_0.customPanels.campIndex = nil
			var_14_0.groupList[2] = nil
		end

		var_14_0.indexDatas = Clone(var_0_0.ShipIndex)

		function var_14_0.callback(arg_15_0)
			var_0_0.ShipIndex.typeIndex = arg_15_0.typeIndex

			if arg_15_0.campIndex then
				var_0_0.ShipIndex.campIndex = arg_15_0.campIndex
			end

			var_0_0.ShipIndex.rarityIndex = arg_15_0.rarityIndex

			arg_9_0:updateCardList()
		end

		arg_9_0:emit(var_0_0.ON_INDEX, var_14_0)
	end)
	triggerToggle(arg_9_0.toggleChar, true)
end

function var_0_0.willExit(arg_16_0)
	cameraPaintViewAdjust(true)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf)
end

local function var_0_1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 == var_0_0.TOGGLE_CHAR and not arg_17_1 then
		return arg_17_2
	elseif arg_17_0 == var_0_0.TOGGLE_LINK and arg_17_1 then
		return arg_17_2 - 10000
	elseif arg_17_0 == var_0_0.TOGGLE_BLUEPRINT then
		return arg_17_2 - 20000
	end

	return -1
end

function var_0_0.updateCardList(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = underscore.rest(pg.ship_data_group.get_id_list_by_handbook_type[arg_18_0.toggleType], 1)

	if var_0_0.ShipIndex.typeIndex == ShipIndexConst.TypeAll and var_0_0.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and var_0_0.ShipIndex.campIndex == ShipIndexConst.CampAll and arg_18_0.toggleType == var_0_0.TOGGLE_CHAR then
		for iter_18_0, iter_18_1 in ipairs(var_18_1) do
			local var_18_2 = pg.ship_data_group[iter_18_1]
			local var_18_3
			local var_18_4 = false

			if var_18_2 then
				var_18_3 = arg_18_0.shipGroups[var_18_2.group_type]
				var_18_4 = Nation.IsLinkType(ShipGroup.getDefaultShipConfig(var_18_2.group_type).nationality)
			end

			local var_18_5 = var_0_1(arg_18_0.toggleType, var_18_4, iter_18_1)

			if var_18_5 ~= -1 then
				var_18_0[iter_18_0] = {
					showTrans = false,
					code = var_18_5,
					group = var_18_3
				}
			end
		end
	else
		for iter_18_2, iter_18_3 in ipairs(var_18_1) do
			local var_18_6 = pg.ship_data_group[iter_18_3]

			if var_18_6 then
				local var_18_7 = ShipGroup.New({
					id = var_18_6.group_type
				})
				local var_18_8 = arg_18_0.shipGroups[var_18_6.group_type]

				if var_18_7 and ShipIndexConst.filterByType(var_18_7, var_0_0.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_18_7, var_0_0.ShipIndex.rarityIndex) then
					local var_18_9 = Nation.IsLinkType(var_18_7:getNation())

					if arg_18_0.toggleType == var_0_0.TOGGLE_CHAR and not var_18_9 and ShipIndexConst.filterByCamp(var_18_7, var_0_0.ShipIndex.campIndex) then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_9, iter_18_3),
							group = var_18_8
						}
					elseif arg_18_0.toggleType == var_0_0.TOGGLE_LINK and var_18_9 then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_9, iter_18_3),
							group = var_18_8
						}
					elseif arg_18_0.toggleType == var_0_0.TOGGLE_BLUEPRINT and ShipIndexConst.filterByCamp(var_18_7, var_0_0.ShipIndex.campIndex) then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_9, iter_18_3),
							group = var_18_8
						}
					end
				end
			end
		end
	end

	arg_18_0.cardInfos = var_18_0

	arg_18_0.cardList:SetTotalCount(#arg_18_0.cardInfos, -1)
	arg_18_0.cardList:ScrollTo(arg_18_0.scrollValue or 0)
end

local function var_0_2(arg_19_0)
	return getProxy(ShipSkinProxy):GetAllSkinForARCamera(arg_19_0)
end

local function var_0_3(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = getProxy(ShipSkinProxy):getSkinList()
	local var_20_2 = getProxy(CollectionProxy):getShipGroup(arg_20_0)

	if var_20_2 then
		local var_20_3 = ShipGroup.getSkinList(arg_20_0)

		for iter_20_0, iter_20_1 in ipairs(var_20_3) do
			if iter_20_1.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or table.contains(var_20_1, iter_20_1.id) or iter_20_1.skin_type == ShipSkin.SKIN_TYPE_REMAKE and var_20_2.trans or iter_20_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE and var_20_2.married == 1 then
				var_20_0[iter_20_1.id] = true
			end
		end
	end

	return var_20_0
end

function var_0_0.onInitCard(arg_21_0, arg_21_1)
	local var_21_0 = SnapshotShipCard.New(arg_21_1)

	onButton(arg_21_0, var_21_0.go, function()
		if var_21_0.shipGroup then
			if HXSet.isHxSkin() then
				local var_22_0 = ShipGroup.getDefaultSkin(var_21_0.shipGroup.id)

				arg_21_0:emit(var_0_0.SELECT_CHAR, var_22_0.id)
				arg_21_0:back()

				return
			end

			local var_22_1 = var_0_2(var_21_0.shipGroup.id)

			if #var_22_1 > 1 then
				local var_22_2 = var_0_3(var_21_0.shipGroup.id)

				arg_21_0:openSelectSkinPanel(var_22_1, var_22_2)
			elseif #var_22_1 == 1 then
				arg_21_0:emit(var_0_0.SELECT_CHAR, var_22_1[1].id)
				arg_21_0:back()
			end
		end
	end)

	arg_21_0.cardItems[arg_21_1] = var_21_0
end

function var_0_0.onUpdateCard(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.cardItems[arg_23_2]

	if not var_23_0 then
		arg_23_0:onInitCard(arg_23_2)

		var_23_0 = arg_23_0.cardItems[arg_23_2]
	end

	local var_23_1 = arg_23_1 + 1
	local var_23_2 = arg_23_0.cardInfos[var_23_1]

	if not var_23_2 then
		return
	end

	local var_23_3

	if var_23_2.group then
		var_23_3 = arg_23_0.proposeList[var_23_2.group.id]
	end

	var_23_0:update(var_23_2.code, var_23_2.group, var_23_2.showTrans, var_23_3)
end

function var_0_0.onReturnCard(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.exited then
		return
	end

	local var_24_0 = arg_24_0.cardItems[arg_24_2]

	if var_24_0 then
		var_24_0:clear()
	end

	arg_24_0.cardItems[arg_24_2] = nil
end

function var_0_0.initSelectSkinPanel(arg_25_0)
	arg_25_0.skinPanel = arg_25_0:findTF("selectSkinPnl")

	local var_25_0 = arg_25_0:findTF("select_skin/btnBack", arg_25_0.skinPanel)

	onButton(arg_25_0, var_25_0, function()
		arg_25_0:closeSelectSkinPanel()
	end)

	arg_25_0.skinScroll = arg_25_0:findTF("select_skin/style_scroll", arg_25_0.skinPanel)
	arg_25_0.skinContainer = arg_25_0:findTF("view_port", arg_25_0.skinScroll)
	arg_25_0.skinCard = arg_25_0._tf:GetComponent(typeof(ItemList)).prefabItem[0]

	setActive(arg_25_0.skinCard, false)
	setActive(arg_25_0.skinPanel, false)

	arg_25_0.skinCardMap = {}
end

function var_0_0.openSelectSkinPanel(arg_27_0, arg_27_1, arg_27_2)
	setActive(arg_27_0.skinPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_27_0.skinPanel, false)

	for iter_27_0 = arg_27_0.skinContainer.childCount, #arg_27_1 - 1 do
		cloneTplTo(arg_27_0.skinCard, arg_27_0.skinContainer)
	end

	for iter_27_1 = #arg_27_1, arg_27_0.skinContainer.childCount - 1 do
		setActive(arg_27_0.skinContainer:GetChild(iter_27_1), false)
	end

	local var_27_0 = arg_27_0.skinContainer.childCount

	for iter_27_2, iter_27_3 in ipairs(arg_27_1) do
		local var_27_1 = arg_27_0.skinContainer:GetChild(iter_27_2 - 1)
		local var_27_2 = arg_27_0.skinCardMap[var_27_1]

		if not var_27_2 then
			var_27_2 = ShipSkinCard.New(var_27_1.gameObject)
			arg_27_0.skinCardMap[var_27_1] = var_27_2
		end

		local var_27_3 = arg_27_2[iter_27_3.id]

		var_27_2:updateSkin(iter_27_3, var_27_3)
		var_27_2:updateUsing(false)
		removeOnButton(var_27_1)
		onButton(arg_27_0, var_27_1, function()
			if var_27_3 then
				arg_27_0:emit(var_0_0.SELECT_CHAR, iter_27_3.id)
				arg_27_0:closeSelectSkinPanel()
				arg_27_0:back()
			end
		end)
		setActive(var_27_1, true)
	end
end

function var_0_0.closeSelectSkinPanel(arg_29_0)
	pg.UIMgr.GetInstance():UnblurPanel(arg_29_0.skinPanel, arg_29_0._tf)
	setActive(arg_29_0.skinPanel, false)
end

return var_0_0
