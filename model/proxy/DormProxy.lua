local var_0_0 = class("DormProxy", import(".NetProxy"))

var_0_0.DORM_UPDATEED = "DormProxy updated"
var_0_0.LEVEL_UP = "DormProxy level up"
var_0_0.FURNITURE_ADDED = "DormProxy FURNITURE ADDED"
var_0_0.FURNITURE_UPDATED = "DormProxy FURNITURE UPDATED"
var_0_0.SHIP_ADDED = "DormProxy ship added"
var_0_0.SHIP_EXIT = "DormProxy ship exit"
var_0_0.INIMACY_AND_MONEY_ADD = "DormProxy inimacy and money added"
var_0_0.SHIPS_EXP_ADDED = "DormProxy SHIPS_EXP_ADDED"
var_0_0.THEME_ADDED = "DormProxy THEME_ADDED"
var_0_0.THEME_DELETED = "DormProxy THEME_DELETED"
var_0_0.THEME_TEMPLATE_UPDATED = "DormProxy THEME_TEMPLATE_UPDATED"
var_0_0.THEME_TEMPLATE_DELTETED = "DormProxy THEME_TEMPLATE_DELTETED"
var_0_0.COLLECTION_THEME_TEMPLATE_ADDED = "DormProxy COLLECTION_THEME_TEMPLATE_ADDED"
var_0_0.COLLECTION_THEME_TEMPLATE_DELETED = "DormProxy COLLECTION_THEME_TEMPLATE_DELETED"
var_0_0.THEME_TEMPLATE_ADDED = "DormProxy THEME_TEMPLATE_ADDED"
var_0_0.SHOP_THEME_TEMPLATE_DELETED = "DormProxy SHOP_THEME_TEMPLATE_DELETED"

function var_0_0.register(arg_1_0)
	arg_1_0.TYPE = 2
	arg_1_0.PAGE = 1
	arg_1_0.MAX_PAGE = 10
	arg_1_0.lastPages = {
		[2] = math.huge,
		[3] = math.huge,
		[5] = math.huge
	}
	arg_1_0.friendData = nil
	arg_1_0.systemThemes = {}

	arg_1_0:on(19001, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GET_BACKYARD_DATA, {
			isMine = true,
			data = arg_2_0
		})
	end)

	arg_1_0.isLoadExp = nil

	arg_1_0:on(19009, function(arg_3_0)
		arg_1_0.isLoadExp = true
		arg_1_0.data.load_exp = arg_1_0.data.load_exp + arg_3_0.exp
		arg_1_0.data.load_food = arg_1_0.data.load_food + arg_3_0.food_consume

		arg_1_0:updateFood(arg_3_0.food_consume)
		arg_1_0:sendNotification(GAME.BACKYARD_ADD_EXP, arg_3_0.exp)
	end)
	arg_1_0:on(19010, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.pop_list) do
			arg_1_0:addInimacyAndMoney(arg_4_0.pop_list[iter_4_0].id, arg_4_0.pop_list[iter_4_0].intimacy, arg_4_0.pop_list[iter_4_0].dorm_icon)
		end
	end)
end

function var_0_0.GetVisitorShip(arg_5_0)
	return arg_5_0.visitorShip
end

function var_0_0.SetVisitorShip(arg_6_0, arg_6_1)
	arg_6_0.visitorShip = arg_6_1
end

function var_0_0.getBackYardShips(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = getProxy(BayProxy)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.data.shipIds) do
		local var_7_2 = var_7_1:getShipById(iter_7_1)

		if var_7_2 then
			var_7_0[var_7_2.id] = var_7_2
		else
			print("not found ship >>>", iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.addShip(arg_8_0, arg_8_1)
	arg_8_0.data:addShip(arg_8_1)
	arg_8_0:updateDrom(arg_8_0.data, BackYardConst.DORM_UPDATE_TYPE_SHIP)
end

function var_0_0.exitYardById(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getShipById(arg_9_1)

	assert(var_9_0, "ship should exist")
	arg_9_0.data:deleteShip(arg_9_1)
	arg_9_0:sendNotification(var_0_0.SHIP_EXIT, var_9_0)
	arg_9_0:updateDrom(arg_9_0.data, BackYardConst.DORM_UPDATE_TYPE_SHIP)
end

function var_0_0.getShipById(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getBackYardShips()

	if var_10_0[arg_10_1] then
		return var_10_0[arg_10_1]
	end
end

function var_0_0.getShipsByState(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getBackYardShips()
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.state == arg_11_1 then
			var_11_1[iter_11_1.id] = iter_11_1
		end
	end

	return var_11_1
end

function var_0_0.getTrainShipIds(arg_12_0)
	return _.keys(arg_12_0:getShipsByState(Ship.STATE_TRAIN) or {})
end

function var_0_0.getRestShipIds(arg_13_0)
	return _.keys(arg_13_0:getShipsByState(Ship.STATE_REST) or {})
end

function var_0_0.getTrainShipCount(arg_14_0)
	return #arg_14_0:getTrainShipIds()
end

function var_0_0.addInimacyAndMoney(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = getProxy(BayProxy)
	local var_15_1 = var_15_0:getShipById(arg_15_1)

	if not var_15_1 then
		return
	end

	var_15_1:updateStateInfo34(arg_15_2, arg_15_3)
	var_15_0:updateShip(var_15_1)
	arg_15_0:sendNotification(var_0_0.INIMACY_AND_MONEY_ADD, {
		id = arg_15_1,
		intimacy = arg_15_2,
		money = arg_15_3
	})
end

function var_0_0.isLackOfFood(arg_16_0)
	if arg_16_0:getTrainShipCount() == 0 then
		return false
	end

	local var_16_0 = arg_16_0:getRestFood()

	if not arg_16_0.isLoadExp then
		var_16_0 = var_16_0 - arg_16_0.data.load_food
	end

	return var_16_0 <= 0
end

function var_0_0.havePopEvent(arg_17_0)
	local var_17_0 = arg_17_0:getBackYardShips()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if iter_17_1:hasStateInfo3Or4() then
			return true
		end
	end

	return false
end

function var_0_0.AddFurniture(arg_18_0, arg_18_1)
	assert(isa(arg_18_1, Furniture))
	arg_18_0.data:AddFurniture(arg_18_1)
	arg_18_0:updateDrom(arg_18_0.data, BackYardConst.DORM_UPDATE_TYPE_FURNITURE)
end

function var_0_0.AddFurnitrues(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_0 = Furniture.New({
			count = 1,
			id = iter_19_1
		})

		arg_19_0.data:AddFurniture(var_19_0)
	end

	arg_19_0:updateDrom(arg_19_0.data, BackYardConst.DORM_UPDATE_TYPE_FURNITURE)
end

function var_0_0.ClearNewFlag(arg_20_0)
	local var_20_0 = arg_20_0.data:GetPurchasedFurnitures()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		iter_20_1:ClearNewFlag()
	end
end

function var_0_0._ClearNewFlag(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.data:GetPurchasedFurnitures()[arg_21_1]

	if var_21_0 then
		var_21_0:ClearNewFlag()
	end
end

function var_0_0.addDorm(arg_22_0, arg_22_1)
	assert(isa(arg_22_1, Dorm), "dorm should instance of Dorm")

	arg_22_0.data = arg_22_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")
end

function var_0_0.updateDrom(arg_23_0, arg_23_1, arg_23_2)
	assert(isa(arg_23_1, Dorm), "dorm should instance of Dorm")
	assert(arg_23_1, "drom should exist")

	arg_23_0.data = arg_23_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")
	arg_23_0.facade:sendNotification(var_0_0.DORM_UPDATEED, {}, arg_23_2)
end

function var_0_0.getData(arg_24_0)
	return (arg_24_0.data or Dorm.New({
		id = 1
	})):clone()
end

function var_0_0.updateFood(arg_25_0, arg_25_1)
	arg_25_0.data:consumeFood(arg_25_1)
	arg_25_0.data:restNextTime()
	arg_25_0:updateDrom(arg_25_0.data, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD)
end

function var_0_0.getRestFood(arg_26_0)
	return arg_26_0.data.food
end

function var_0_0.GetCustomThemeTemplates(arg_27_0)
	return arg_27_0.customThemeTemplates
end

function var_0_0.SetCustomThemeTemplates(arg_28_0, arg_28_1)
	arg_28_0.customThemeTemplates = arg_28_1
end

function var_0_0.GetCustomThemeTemplateById(arg_29_0, arg_29_1)
	return arg_29_0.customThemeTemplates[arg_29_1]
end

function var_0_0.UpdateCustomThemeTemplate(arg_30_0, arg_30_1)
	arg_30_0.customThemeTemplates[arg_30_1.id] = arg_30_1

	arg_30_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM,
		template = arg_30_1
	})
end

function var_0_0.DeleteCustomThemeTemplate(arg_31_0, arg_31_1)
	arg_31_0.customThemeTemplates[arg_31_1] = nil

	arg_31_0:sendNotification(var_0_0.THEME_TEMPLATE_DELTETED, {
		templateId = arg_31_1
	})
end

function var_0_0.AddCustomThemeTemplate(arg_32_0, arg_32_1)
	arg_32_0.customThemeTemplates[arg_32_1.id] = arg_32_1

	arg_32_0:sendNotification(var_0_0.THEME_TEMPLATE_ADDED, {
		template = arg_32_1
	})
end

function var_0_0.GetUploadThemeTemplateCnt(arg_33_0)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.customThemeTemplates) do
		if iter_33_1:IsPushed() then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0
end

function var_0_0.GetShopThemeTemplates(arg_34_0)
	return arg_34_0.shopThemeTemplates
end

function var_0_0.SetShopThemeTemplates(arg_35_0, arg_35_1)
	arg_35_0.shopThemeTemplates = arg_35_1
end

function var_0_0.GetShopThemeTemplateById(arg_36_0, arg_36_1)
	return arg_36_0.shopThemeTemplates[arg_36_1]
end

function var_0_0.IsInitShopThemeTemplates(arg_37_0)
	return arg_37_0.shopThemeTemplates ~= nil
end

function var_0_0.UpdateShopThemeTemplate(arg_38_0, arg_38_1)
	arg_38_0.shopThemeTemplates[arg_38_1.id] = arg_38_1

	arg_38_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_SHOP,
		template = arg_38_1
	})
end

function var_0_0.DeleteShopThemeTemplate(arg_39_0, arg_39_1)
	arg_39_0.shopThemeTemplates[arg_39_1] = nil

	arg_39_0:sendNotification(var_0_0.SHOP_THEME_TEMPLATE_DELETED, {
		id = arg_39_1
	})
end

function var_0_0.GetCollectionThemeTemplates(arg_40_0)
	return arg_40_0.collectionThemeTemplates
end

function var_0_0.SetCollectionThemeTemplates(arg_41_0, arg_41_1)
	arg_41_0.collectionThemeTemplates = arg_41_1
end

function var_0_0.GetCollectionThemeTemplateById(arg_42_0, arg_42_1)
	return arg_42_0.collectionThemeTemplates[arg_42_1]
end

function var_0_0.AddCollectionThemeTemplate(arg_43_0, arg_43_1)
	arg_43_0.collectionThemeTemplates[arg_43_1.id] = arg_43_1

	arg_43_0:sendNotification(var_0_0.COLLECTION_THEME_TEMPLATE_ADDED, {
		template = arg_43_1
	})
end

function var_0_0.DeleteCollectionThemeTemplate(arg_44_0, arg_44_1)
	arg_44_0.collectionThemeTemplates[arg_44_1] = nil

	arg_44_0:sendNotification(var_0_0.COLLECTION_THEME_TEMPLATE_DELETED, {
		id = arg_44_1
	})
end

function var_0_0.GetThemeTemplateCollectionCnt(arg_45_0)
	return table.getCount(arg_45_0.collectionThemeTemplates or {})
end

function var_0_0.UpdateCollectionThemeTemplate(arg_46_0, arg_46_1)
	arg_46_0.collectionThemeTemplates[arg_46_1.id] = arg_46_1

	arg_46_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION,
		template = arg_46_1
	})
end

function var_0_0.GetTemplateNewID(arg_47_0)
	local var_47_0 = _.map(_.values(arg_47_0.customThemeTemplates or {}), function(arg_48_0)
		return arg_48_0:GetPos()
	end)

	for iter_47_0 = 1, 10 do
		if not table.contains(var_47_0, iter_47_0) then
			return iter_47_0
		end
	end
end

function var_0_0.GetSystemThemes(arg_49_0)
	if not arg_49_0.systemThemes or #arg_49_0.systemThemes == 0 then
		local var_49_0 = pg.backyard_theme_template

		for iter_49_0, iter_49_1 in ipairs(var_49_0.all) do
			if var_49_0[iter_49_1].is_view == 1 then
				local var_49_1 = BackYardSystemTheme.New({
					id = iter_49_1
				})

				table.insert(arg_49_0.systemThemes, var_49_1)
			end
		end
	end

	return arg_49_0.systemThemes
end

function var_0_0.ResetSystemTheme(arg_50_0, arg_50_1)
	if not arg_50_0.systemThemes or #arg_50_0.systemThemes == 0 then
		return
	end

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.systemThemes) do
		if iter_50_1.id == arg_50_1 then
			arg_50_0.systemThemes[iter_50_0] = BackYardSystemTheme.New({
				id = arg_50_1
			})

			break
		end
	end
end

function var_0_0.NeedRefreshThemeTemplateShop(arg_51_0)
	if not arg_51_0.refreshThemeTemplateShopTime then
		arg_51_0.refreshThemeTemplateShopTime = 0
	end

	local var_51_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_51_0 > arg_51_0.refreshThemeTemplateShopTime then
		arg_51_0.refreshThemeTemplateShopTime = var_51_0 + BackYardConst.AUTO_REFRESH_THEME_TEMPLATE_TIME

		return true
	end

	return false
end

function var_0_0.NeedCollectionTip(arg_52_0)
	local var_52_0 = getProxy(PlayerProxy):getRawData().id
	local var_52_1 = PlayerPrefs.GetInt("backyard_template" .. var_52_0, 0)
	local var_52_2 = arg_52_0:GetThemeTemplateCollectionCnt()

	if var_52_2 ~= var_52_1 then
		PlayerPrefs.SetInt("backyard_template" .. var_52_0, var_52_2)
		PlayerPrefs.Save()
	end

	if var_52_2 < var_52_1 then
		return true
	end

	return false
end

function var_0_0.NeedShopShowHelp(arg_53_0)
	local var_53_0 = getProxy(PlayerProxy):getRawData().id

	if not (PlayerPrefs.GetInt("backyard_template_help" .. var_53_0, 0) > 0) then
		PlayerPrefs.SetInt("backyard_template_help" .. var_53_0, 1)
		PlayerPrefs.Save()

		return true
	end

	return false
end

function var_0_0.GetTag7Furnitures(arg_54_0)
	local var_54_0 = {}
	local var_54_1 = pg.furniture_data_template.get_id_list_by_tag[7]

	for iter_54_0, iter_54_1 in ipairs(var_54_1) do
		local var_54_2 = pg.furniture_shop_template[iter_54_1]

		if var_54_2 and var_54_2.not_for_sale == 0 and pg.TimeMgr.GetInstance():inTime(var_54_2.time) then
			table.insert(var_54_0, iter_54_1)
		end
	end

	return var_54_0
end

function var_0_0.IsShowRedDot(arg_55_0)
	local var_55_0 = getProxy(PlayerProxy):getRawData()
	local var_55_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_55_0.level, "CourtYardMediator")
	local var_55_2 = getProxy(DormProxy)
	local var_55_3 = var_55_2:isLackOfFood()
	local var_55_4 = var_55_2:havePopEvent()

	return var_55_1 and (var_55_3 or var_55_4 or getProxy(SettingsProxy):IsTipNewTheme() or getProxy(SettingsProxy):IsTipNewGemFurniture())
end

return var_0_0
