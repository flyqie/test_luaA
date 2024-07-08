local var_0_0 = class("CourtYardMediator", import("..base.ContextMediator"))

var_0_0.SET_UP = "CourtYardMediator:SET_UP"
var_0_0.RENAME = "CourtYardMediator:RENAME"
var_0_0.FOLD = "CourtYardMediator:FOLD"
var_0_0.SWITCH = "CourtYardMediator:SWITCH"
var_0_0.GO_SHOP = "CourtYardMediator:GO_SHOP"
var_0_0.OPEN_DECORATION = "CourtYardMediator:OPEN_DECORATION"
var_0_0.SEL_TRAIN_SHIP = "CourtYardMediator:SEL_TRAIN_SHIP"
var_0_0.SEL_REST_SHIP = "CourtYardMediator:SEL_REST_SHIP"
var_0_0.GO_GRANARY = "CourtYardMediator:GO_GRANARY"
var_0_0.OPEN_ADD_EXP = "CourtYardMediator:OPEN_ADD_EXP"
var_0_0.CLOSE_ADD_EXP = "CourtYardMediator:CLOSE_ADD_EXP"
var_0_0.UN_LOCK_2FLOOR = "CourtYardMediator:UN_LOCK_2FLOOR"
var_0_0.GO_THEME_TEMPLATE = "CourtYardMediator:GO_THEME_TEMPLATE"
var_0_0.ON_ADD_VISITOR_SHIP = "CourtYardMediator:ON_ADD_VISITOR_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_ADD_VISITOR_SHIP, function(arg_2_0)
		local function var_2_0(arg_3_0)
			if arg_3_0 then
				_courtyard:GetController():AddVisitorShip(arg_3_0)
			end
		end

		local var_2_1 = getProxy(DormProxy)
		local var_2_2 = var_2_1:GetVisitorShip()

		if var_2_2 then
			var_2_0(var_2_2)

			return
		end

		arg_1_0:sendNotification(GAME.BACKYARD_GET_VISITOR_SHIP, {
			callback = function()
				var_2_0(var_2_1:GetVisitorShip())
			end
		})
	end)
	arg_1_0:bind(var_0_0.GO_THEME_TEMPLATE, function(arg_5_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BACKYARD_THEME_TEMPLATE)
	end)
	arg_1_0:bind(var_0_0.UN_LOCK_2FLOOR, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_6_1,
			count = arg_6_2
		})
	end)
	arg_1_0:bind(var_0_0.GO_GRANARY, function()
		arg_1_0:addSubLayers(Context.New({
			mediator = BackyardFeedMediator,
			viewComponent = BackyardFeedLayer
		}))
	end)
	arg_1_0:bind(var_0_0.SEL_TRAIN_SHIP, function(arg_8_0)
		local var_8_0 = _courtyard:GetController():GetMaxCntForShip()

		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = Ship.STATE_TRAIN,
				MaxRsetPos = var_8_0
			}
		}))
	end)
	arg_1_0:bind(var_0_0.SEL_REST_SHIP, function(arg_9_0)
		local var_9_0 = _courtyard:GetController():GetMaxCntForShip()

		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = Ship.STATE_REST,
				MaxRsetPos = var_9_0
			}
		}))
	end)
	arg_1_0:bind(var_0_0.GO_SHOP, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1 and {
			onDeattch = function()
				arg_1_0.viewComponent:emit(var_0_0.OPEN_DECORATION)
			end
		}

		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShopMediator,
			viewComponent = NewBackYardShopLayer,
			data = var_10_0
		}))
	end)
	arg_1_0:bind(var_0_0.OPEN_DECORATION, function(arg_12_0)
		_courtyard:GetController():EnterEditMode()
	end)
	arg_1_0:bind(var_0_0.SWITCH, function(arg_13_0, arg_13_1)
		if getProxy(DormProxy).floor == arg_13_1 then
			return
		end

		_courtyard:Dispose()

		_courtyard = nil

		gcAll()
		arg_1_0.viewComponent:emit(var_0_0.SET_UP, arg_13_1)
		arg_1_0.viewComponent:SwitchFloorDone()
	end)
	arg_1_0:bind(var_0_0.FOLD, function(arg_14_0, arg_14_1)
		arg_1_0.viewComponent:FoldPanel(arg_14_1)
	end)
	arg_1_0:bind(var_0_0.RENAME, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.BACKYARD_RENAME, arg_15_1)
	end)
	arg_1_0:bind(var_0_0.SET_UP, function(arg_16_0, arg_16_1)
		getProxy(DormProxy).floor = arg_16_1
		arg_1_0.contextData.floor = arg_16_1
		_courtyard = CourtYardBridge.New(arg_1_0:GenCourtYardData(arg_16_1))
	end)

	local var_1_0 = arg_1_0.contextData.dorm or getProxy(DormProxy):getRawData()

	arg_1_0.viewComponent:SetDorm(var_1_0)
end

function var_0_0.listNotificationInterests(arg_17_0)
	return {
		DormProxy.DORM_UPDATEED,
		DormProxy.INIMACY_AND_MONEY_ADD,
		DormProxy.SHIPS_EXP_ADDED,
		GAME.EXTEND_BACKYARD_AREA_DONE,
		GAME.BACKYARD_ADD_MONEY_DONE,
		GAME.BACKYARD_ADD_INTIMACY_DONE,
		GAME.BACKYARD_SHIP_EXP_ADDED,
		GAME.OPEN_BACKYARD_SHOP,
		GAME.EXIT_SHIP_DONE,
		GAME.ADD_SHIP_DONE,
		GAME.LOAD_LAYERS,
		GAME.REMOVE_LAYERS,
		GAME.ON_APPLICATION_PAUSE,
		GAME.BUY_FURNITURE_DONE,
		GAME.ON_RECONNECTION,
		CourtYardEvent._EXTEND,
		CourtYardEvent._QUIT,
		CourtYardEvent._ENTER_MODE,
		CourtYardEvent._EXIT_MODE,
		CourtYardEvent._INITED,
		CourtYardEvent._NO_POS_TO_ADD_SHIP,
		CourtYardEvent._DRAG_ITEM,
		CourtYardEvent._DRAG_ITEM_END,
		CourtYardEvent._TOUCH_SHIP,
		CourtYardEvent._ADD_ITEM_FAILED,
		BackYardDecorationMediator.START_TAKE_THEME_PHOTO,
		BackYardDecorationMediator.END_TAKE_THEME_PHOTO
	}
end

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()
	local var_18_2 = arg_18_1:getType()

	if var_18_0 == DormProxy.SHIPS_EXP_ADDED then
		if arg_18_0.contextData.OpenShop then
			return
		end

		if not CourtYardMediator.firstTimeAddExp and not pg.NewGuideMgr.GetInstance():IsBusy() then
			CourtYardMediator.firstTimeAddExp = true

			arg_18_0:SettleExp(var_18_1)
		elseif not arg_18_0.isTipFood then
			arg_18_0.viewComponent:ShowAddFoodTip()
		end

		arg_18_0.isTipFood = true
	elseif var_18_0 == GAME.LOAD_LAYERS then
		CourtYardMediator.firstTimeAddExp = true
	elseif var_18_0 == GAME.REMOVE_LAYERS then
		arg_18_0.viewComponent:OnRemoveLayer(var_18_1)
	elseif var_18_0 == CourtYardEvent._NO_POS_TO_ADD_SHIP then
		arg_18_0:sendNotification(GAME.EXIT_SHIP, {
			shipId = var_18_1
		})
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_notPosition_shipExit"))
		arg_18_0.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), BackYardConst.DORM_UPDATE_TYPE_SHIP)
	elseif var_18_0 == CourtYardEvent._ADD_ITEM_FAILED then
		getProxy(DormProxy):getRawData():GetTheme(getProxy(DormProxy).floor):DeleteFurniture(var_18_1)
	end

	arg_18_0:handleCourtyardNotification(var_18_0, var_18_1, var_18_2)
end

function var_0_0.handleCourtyardNotification(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not _courtyard or not _courtyard:IsLoaed() then
		return
	end

	if arg_19_1 == CourtYardEvent._QUIT then
		arg_19_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif arg_19_1 == CourtYardEvent._INITED then
		arg_19_0.viewComponent:OnCourtYardLoaded()
	elseif arg_19_1 == GAME.LOAD_LAYERS then
		local var_19_0 = arg_19_2.context.mediator == NewBackYardShipInfoMediator

		_courtyard:GetController():OnOpenLayerOrCloseLayer(true, var_19_0)
	elseif arg_19_1 == GAME.REMOVE_LAYERS then
		local var_19_1 = arg_19_2.context.mediator == NewBackYardShipInfoMediator

		_courtyard:GetController():OnOpenLayerOrCloseLayer(false, var_19_1)
	elseif arg_19_1 == GAME.ON_APPLICATION_PAUSE and arg_19_2 then
		_courtyard:GetController():OnApplicationPaused()
	end

	if arg_19_0.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	if arg_19_1 == GAME.BACKYARD_ADD_MONEY_DONE then
		_courtyard:GetController():ClearShipCoin(arg_19_2.id)
	elseif arg_19_1 == GAME.EXIT_SHIP_DONE then
		_courtyard:GetController():ExitShip(arg_19_2.id)
	elseif arg_19_1 == GAME.BUY_FURNITURE_DONE then
		arg_19_0.viewComponent:OnAddFurniture()
	elseif arg_19_1 == GAME.ON_RECONNECTION then
		arg_19_0.viewComponent:OnReconnection()
	elseif arg_19_1 == GAME.ADD_SHIP_DONE then
		local var_19_2 = getProxy(BayProxy):getShipById(arg_19_2.id)

		if ({
			Ship.STATE_TRAIN,
			Ship.STATE_REST
		})[getProxy(DormProxy).floor] == var_19_2.state then
			_courtyard:GetController():AddShip(var_19_2)
		end
	elseif arg_19_1 == GAME.BACKYARD_ADD_INTIMACY_DONE then
		_courtyard:GetController():ClearShipIntimacy(arg_19_2.id)
	elseif arg_19_1 == GAME.EXTEND_BACKYARD_AREA_DONE then
		_courtyard:GetController():LevelUp()
	elseif arg_19_1 == DormProxy.INIMACY_AND_MONEY_ADD then
		local var_19_3 = arg_19_2.id
		local var_19_4 = arg_19_2.money
		local var_19_5 = arg_19_2.intimacy

		_courtyard:GetController():UpdateShipCoinAndIntimacy(var_19_3, var_19_4, var_19_5)
	elseif arg_19_1 == GAME.BACKYARD_SHIP_EXP_ADDED then
		_courtyard:GetController():AddShipExp(arg_19_2.id, arg_19_2.exp)
	elseif arg_19_1 == DormProxy.DORM_UPDATEED then
		arg_19_0.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), arg_19_3)
	elseif arg_19_1 == CourtYardEvent._ENTER_MODE then
		arg_19_0:addSubLayers(Context.New({
			mediator = BackYardDecorationMediator,
			viewComponent = BackYardDecrationLayer
		}))
		arg_19_0.viewComponent:OnEnterOrExitEdit(true)
	elseif arg_19_1 == CourtYardEvent._EXIT_MODE then
		arg_19_0.viewComponent:OnEnterOrExitEdit(false)
	elseif arg_19_1 == GAME.OPEN_BACKYARD_SHOP then
		arg_19_0.viewComponent:emit(var_0_0.GO_SHOP, true)
	elseif arg_19_1 == CourtYardEvent._EXTEND then
		arg_19_0:OnExtend()
	elseif arg_19_1 == BackYardDecorationMediator.START_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_19_0.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 0

		_courtyard:GetController():OnTakeThemePhoto()
	elseif arg_19_1 == BackYardDecorationMediator.END_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_19_0.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 1

		_courtyard:GetController():OnEndTakeThemePhoto()
	elseif arg_19_1 == CourtYardEvent._DRAG_ITEM then
		arg_19_0.viewComponent:BlockEvents()
	elseif arg_19_1 == CourtYardEvent._DRAG_ITEM_END then
		arg_19_0.viewComponent:UnBlockEvents()
	elseif arg_19_1 == CourtYardEvent._TOUCH_SHIP then
		local var_19_6 = getProxy(TaskProxy):GetBackYardInterActionTaskList()

		if var_19_6 and #var_19_6 > 0 then
			for iter_19_0, iter_19_1 in ipairs(var_19_6) do
				pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
					taskId = iter_19_1.id
				})
			end
		end
	end
end

function var_0_0.SettleExp(arg_20_0, arg_20_1)
	if arg_20_0.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	local var_20_0 = getProxy(DormProxy):getRawData()
	local var_20_1 = getProxy(BayProxy)
	local var_20_2 = 0

	for iter_20_0, iter_20_1 in ipairs(var_20_0.shipIds) do
		local var_20_3 = var_20_1:RawGetShipById(iter_20_1)

		if var_20_3 and var_20_3.state == Ship.STATE_TRAIN then
			var_20_2 = var_20_2 + 1
		end
	end

	local var_20_4 = var_20_0.load_exp * var_20_2

	if var_20_2 ~= 0 and (var_20_4 ~= 0 or var_20_0.food ~= 0) then
		onNextTick(function()
			arg_20_0:addSubLayers(Context.New({
				mediator = BackYardSettlementMediator,
				viewComponent = BackYardSettlementLayer,
				data = {
					oldShips = arg_20_1.oldShips,
					newShips = arg_20_1.newShips
				}
			}))
		end)

		arg_20_0.contextData.settleShipExp = true
	end
end

function var_0_0.OnExtend(arg_22_0)
	if getProxy(BagProxy):getItemCountById(ITEM_BACKYARD_AREA_EXTEND) <= 0 then
		local var_22_0 = getProxy(DormProxy):getRawData():GetExpandId()
		local var_22_1 = pg.shop_template[var_22_0]
		local var_22_2 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_22_1.resource_type
		}):getName()

		_BackyardMsgBoxMgr:Show({
			content = i18n("backyard_buyExtendItem_question", var_22_1.resource_num .. var_22_2),
			onYes = function()
				arg_22_0:sendNotification(GAME.SHOPPING, {
					count = 1,
					id = var_22_0
				})
			end
		})
	else
		arg_22_0:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = ITEM_BACKYARD_AREA_EXTEND
		})
	end
end

function var_0_0.remove(arg_24_0)
	if _courtyard then
		_courtyard:Dispose()

		_courtyard = nil
	end
end

function var_0_0.GenCourtYardData(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.contextData.mode or CourtYardConst.SYSTEM_DEFAULT
	local var_25_1
	local var_25_2

	if var_25_0 == CourtYardConst.SYSTEM_VISIT then
		var_25_1 = arg_25_0.contextData.dorm
		var_25_2 = CourtYardConst.STYLE_INNER
	elseif var_25_0 == CourtYardConst.SYSTEM_DEFAULT then
		var_25_1 = getProxy(DormProxy):getRawData()
		var_25_2 = CourtYardConst.STYLE_INNER
	elseif var_25_0 == CourtYardConst.SYSTEM_FEAST then
		var_25_1 = getProxy(FeastProxy):getRawData()
		var_25_2 = CourtYardConst.STYLE_FEAST
	elseif var_25_0 == CourtYardConst.SYSTEM_OUTSIDE then
		assert(false)

		var_25_2 = CourtYardConst.STYLE_OUTSIDE
	elseif var_25_0 == CourtYardConst.SYSTEM_EDIT_FEAST then
		var_25_1 = getProxy(DormProxy):getRawData()
		var_25_2 = CourtYardConst.STYLE_FEAST
	end

	local var_25_3 = var_25_1:GetMapSize()

	if var_25_0 == CourtYardConst.SYSTEM_EDIT_FEAST then
		var_25_3 = getProxy(FeastProxy):getRawData():GetMapSize()
	end

	local var_25_4 = {
		[arg_25_1] = {
			id = arg_25_1,
			level = var_25_1.level,
			furnitures = var_25_1:GetPutFurnitureList(arg_25_1),
			ships = var_25_1:GetPutShipList(arg_25_1)
		}
	}

	return {
		system = var_25_0,
		storeys = var_25_4,
		storeyId = arg_25_1,
		style = var_25_2,
		mapSize = var_25_3,
		name = arg_25_0.viewComponent:getUIName(),
		core = pg.m02
	}
end

return var_0_0
