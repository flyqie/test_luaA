﻿local var_0_0 = class("BayProxy", import(".NetProxy"))

var_0_0.SHIP_ADDED = "ship added"
var_0_0.SHIP_REMOVED = "ship removed"
var_0_0.SHIP_UPDATED = "ship updated"
var_0_0.SHIP_EQUIPMENT_ADDED = "ship equipment added"
var_0_0.SHIP_EQUIPMENT_REMOVED = "ship equipment removed"

function var_0_0.register(arg_1_0)
	arg_1_0:on(12001, function(arg_2_0)
		arg_1_0.data = {}
		arg_1_0.activityNpcShipIds = {}
		arg_1_0.metaShipIDList = {}
		arg_1_0.equipCountDic = {}
		arg_1_0.equipSkinCountDic = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.shiplist) do
			local var_2_0 = Ship.New(iter_2_1)

			var_2_0:display("loaded")

			arg_1_0.shipHighestLevel = math.max(arg_1_0.shipHighestLevel, var_2_0.level)

			if var_2_0:getConfigTable() then
				arg_1_0.data[var_2_0.id] = var_2_0

				if var_2_0:isActivityNpc() then
					table.insert(arg_1_0.activityNpcShipIds, var_2_0.id)
				elseif var_2_0:isMetaShip() and not table.contains(arg_1_0.metaShipIDList, var_2_0.id) then
					table.insert(arg_1_0.metaShipIDList, var_2_0.id)
				end

				var_0_0.recordShipLevelVertify(var_2_0)
				arg_1_0:UpdateShipEquipAndSkinCount(var_2_0, true)
			else
				warning("不存在的角色: " .. var_2_0.id)
			end
		end

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end)
	arg_1_0:on(12031, function(arg_3_0)
		arg_1_0.energyRecoverTime = arg_3_0.energy_auto_increase_time + Ship.ENERGY_RECOVER_TIME

		local var_3_0 = arg_1_0.energyRecoverTime - pg.TimeMgr.GetInstance():GetServerTime()

		arg_1_0:addEnergyListener(var_3_0)
	end)
	arg_1_0:on(12010, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.ship_list) do
			local var_4_0 = Ship.New(iter_4_1)

			var_4_0:display("loaded")

			arg_1_0.shipHighestLevel = math.max(arg_1_0.shipHighestLevel, var_4_0.level)

			if var_4_0:getConfigTable() then
				arg_1_0.data[var_4_0.id] = var_4_0

				if var_4_0:isActivityNpc() then
					table.insert(arg_1_0.activityNpcShipIds, var_4_0.id)
				elseif var_4_0:isMetaShip() and not table.contains(arg_1_0.metaShipIDList, var_4_0.id) then
					table.insert(arg_1_0.metaShipIDList, var_4_0.id)
				end

				var_0_0.recordShipLevelVertify(var_4_0)
				arg_1_0:UpdateShipEquipAndSkinCount(var_4_0, true)
			else
				warning("不存在的角色: " .. var_4_0.id)
			end
		end

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end)
	arg_1_0:on(12042, function(arg_5_0)
		local var_5_0 = getProxy(PlayerProxy):getInited()
		local var_5_1 = 0

		arg_1_0.newShipList = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.ship_list) do
			local var_5_2 = Ship.New(iter_5_1)

			if var_5_2:getConfigTable() and var_5_2.id > 0 then
				arg_1_0:addShip(var_5_2, false)

				if var_5_0 then
					var_5_1 = var_5_1 + 1
				end

				arg_1_0.newShipList[#arg_1_0.newShipList + 1] = var_5_2
			else
				warning("不存在的角色: " .. var_5_2.id)
			end
		end

		if var_5_1 > 0 then
			arg_1_0:countShip(var_5_1)
		end

		arg_1_0.metaTransItemMap = {}
	end)

	local var_1_0 = getProxy(PlayerProxy)

	arg_1_0:on(12019, function(arg_6_0)
		local var_6_0 = var_1_0:getData()
		local var_6_1 = arg_1_0:getShipById(var_6_0.character)

		var_6_1:setLikability(arg_6_0.intimacy)
		arg_1_0:updateShip(var_6_1)
	end)

	arg_1_0.shipHighestLevel = 0
end

function var_0_0.recoverAllShipEnergy(arg_7_0)
	local var_7_0 = pg.energy_template[3].upper_bound - 1
	local var_7_1 = pg.energy_template[4].upper_bound
	local var_7_2 = {}
	local var_7_3 = getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	table.insertto(var_7_3, getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))
	table.Foreach(var_7_3, function(arg_8_0, arg_8_1)
		if arg_8_1 and not arg_8_1:isEnd() then
			local var_8_0 = arg_8_1:GetEnergyRecoverAddition()

			_.each(arg_8_1:getData1List(), function(arg_9_0)
				var_7_2[arg_9_0] = (var_7_2[arg_9_0] or 0) + var_8_0
			end)
		end
	end)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.data) do
		local var_7_4 = iter_7_1:getRecoverEnergyPoint()
		local var_7_5 = 0
		local var_7_6 = var_7_0

		if iter_7_1.state == Ship.STATE_REST or iter_7_1.state == Ship.STATE_TRAIN then
			if iter_7_1.state == Ship.STATE_TRAIN then
				var_7_5 = var_7_5 + Ship.BACKYARD_1F_ENERGY_ADDITION
			elseif iter_7_1.state == Ship.STATE_REST then
				var_7_5 = var_7_5 + Ship.BACKYARD_2F_ENERGY_ADDITION
			end

			for iter_7_2, iter_7_3 in ipairs(getProxy(ActivityProxy):getBackyardEnergyActivityBuffs()) do
				var_7_5 = var_7_5 + tonumber(iter_7_3:getConfig("benefit_effect"))
			end

			var_7_6 = var_7_1
		end

		if var_7_2[iter_7_1.id] then
			var_7_5 = var_7_5 + var_7_2[iter_7_1.id]
			var_7_6 = var_7_1
		end

		local var_7_7 = math.max(math.min(var_7_4, var_7_6 - iter_7_1:getEnergy()), 0)
		local var_7_8 = math.min(iter_7_1:getEnergy() + var_7_7 + var_7_5, var_7_1)

		iter_7_1:setEnergy(var_7_8)
		arg_7_0:updateShip(iter_7_1)
	end
end

function var_0_0.addEnergyListener(arg_10_0, arg_10_1)
	if arg_10_1 <= 0 then
		arg_10_0:recoverAllShipEnergy()
		arg_10_0:addEnergyListener(Ship.ENERGY_RECOVER_TIME)

		return
	end

	if arg_10_0.energyTimer then
		arg_10_0.energyTimer:Stop()

		arg_10_0.energyTimer = nil
	end

	arg_10_0.energyTimer = Timer.New(function()
		arg_10_0:recoverAllShipEnergy()
		arg_10_0:addEnergyListener(Ship.ENERGY_RECOVER_TIME)
	end, arg_10_1, 1)

	arg_10_0.energyTimer:Start()
end

function var_0_0.remove(arg_12_0)
	if arg_12_0.energyTimer then
		arg_12_0.energyTimer:Stop()

		arg_12_0.energyTimer = nil
	end
end

function var_0_0.recordShipLevelVertify(arg_13_0)
	if arg_13_0 then
		ys.BattleShipLevelVertify[arg_13_0.id] = var_0_0.generateLevelVertify(arg_13_0.level)
	end
end

function var_0_0.checkShiplevelVertify(arg_14_0)
	if var_0_0.generateLevelVertify(arg_14_0.level) == ys.BattleShipLevelVertify[arg_14_0.id] then
		return true
	else
		return false
	end
end

function var_0_0.generateLevelVertify(arg_15_0)
	return (arg_15_0 + 1114) * 824
end

function var_0_0.addShip(arg_16_0, arg_16_1, arg_16_2)
	assert(isa(arg_16_1, Ship), "should be an instance of Ship")
	assert(arg_16_0.data[arg_16_1.id] == nil, "ship already exist, use updateShip() instead")

	arg_16_0.data[arg_16_1.id] = arg_16_1

	var_0_0.recordShipLevelVertify(arg_16_1)
	arg_16_0:UpdateShipEquipAndSkinCount(arg_16_1, true)

	arg_16_2 = defaultValue(arg_16_2, true)

	if arg_16_2 then
		arg_16_0:countShip()
	end

	arg_16_0.shipHighestLevel = math.max(arg_16_0.shipHighestLevel, arg_16_1.level)

	if arg_16_1:isActivityNpc() then
		table.insert(arg_16_0.activityNpcShipIds, arg_16_1.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	else
		if arg_16_1:isMetaShip() and not table.contains(arg_16_0.metaShipIDList, arg_16_1.id) then
			table.insert(arg_16_0.metaShipIDList, arg_16_1.id)
			getProxy(MetaCharacterProxy):requestMetaTacticsInfo({
				arg_16_1.id
			})
		end

		local var_16_0 = getProxy(CollectionProxy)

		if var_16_0 then
			var_16_0:flushCollection(arg_16_1)
		end
	end

	if getProxy(PlayerProxy):getInited() then
		arg_16_0.facade:sendNotification(var_0_0.SHIP_ADDED, arg_16_1:clone())
	end
end

function var_0_0.countShip(arg_17_0, arg_17_1)
	local var_17_0 = getProxy(PlayerProxy)
	local var_17_1 = var_17_0:getData()

	var_17_1:increaseShipCount(arg_17_1)
	var_17_0:updatePlayer(var_17_1)
end

function var_0_0.getNewShip(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.newShipList or {}

	if arg_18_1 then
		arg_18_0.newShipList = nil
	end

	return var_18_0
end

function var_0_0.getMetaTransItemMap(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_0.metaTransItemMap and arg_19_0.metaTransItemMap[arg_19_1] and #arg_19_0.metaTransItemMap[arg_19_1] > 0 then
		var_19_0 = arg_19_0.metaTransItemMap[arg_19_1][1]

		table.remove(arg_19_0.metaTransItemMap[arg_19_1], 1)
	end

	return var_19_0
end

function var_0_0.addMetaTransItemMap(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.metaTransItemMap then
		arg_20_0.metaTransItemMap = {}
	end

	if not arg_20_0.metaTransItemMap[arg_20_1] then
		arg_20_0.metaTransItemMap[arg_20_1] = {}
	end

	table.insert(arg_20_0.metaTransItemMap[arg_20_1], arg_20_2)
end

function var_0_0.getShipsByFleet(arg_21_0, arg_21_1)
	assert(isa(arg_21_1, Fleet), "should be an instance of Fleet")

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1:getShipIds()) do
		table.insert(var_21_0, arg_21_0.data[iter_21_1])
	end

	return var_21_0
end

function var_0_0.getSortShipsByFleet(arg_22_0, arg_22_1)
	assert(isa(arg_22_1, Fleet), "should be an instance of Fleet")

	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1.mainShips) do
		table.insert(var_22_0, arg_22_0.data[iter_22_1])
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_1.vanguardShips) do
		table.insert(var_22_0, arg_22_0.data[iter_22_3])
	end

	for iter_22_4, iter_22_5 in ipairs(arg_22_1.subShips) do
		table.insert(var_22_0, arg_22_0.data[iter_22_5])
	end

	return var_22_0
end

function var_0_0.getShipByTeam(arg_23_0, arg_23_1, arg_23_2)
	assert(isa(arg_23_1, Fleet), "should be an instance of Fleet")

	local var_23_0 = {}

	if arg_23_2 == TeamType.Vanguard then
		for iter_23_0, iter_23_1 in ipairs(arg_23_1.vanguardShips) do
			table.insert(var_23_0, arg_23_0.data[iter_23_1])
		end
	elseif arg_23_2 == TeamType.Main then
		for iter_23_2, iter_23_3 in ipairs(arg_23_1.mainShips) do
			table.insert(var_23_0, arg_23_0.data[iter_23_3])
		end
	elseif arg_23_2 == TeamType.Submarine then
		for iter_23_4, iter_23_5 in ipairs(arg_23_1.subShips) do
			table.insert(var_23_0, arg_23_0.data[iter_23_5])
		end
	end

	return Clone(var_23_0)
end

function var_0_0.getShipsByTypes(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.data) do
		if table.contains(arg_24_1, iter_24_1:getShipType()) then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.getShipsByStatus(arg_25_0, arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0.data) do
		if iter_25_1.status == arg_25_1 then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function var_0_0.getShipsByTeamType(arg_26_0, arg_26_1)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.data) do
		if iter_26_1:getTeamType() == arg_26_1 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_0.getConfigShipCount(arg_27_0, arg_27_1)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(arg_27_0.data) do
		if iter_27_1.configId == arg_27_1 then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

function var_0_0.getShips(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0.data) do
		table.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function var_0_0.getShipCount(arg_29_0)
	return (table.getCount(arg_29_0.data))
end

function var_0_0.getShipById(arg_30_0, arg_30_1)
	if arg_30_0.data[arg_30_1] ~= nil then
		return arg_30_0.data[arg_30_1]:clone()
	end
end

function var_0_0.RawGetShipById(arg_31_0, arg_31_1)
	return arg_31_0.data[arg_31_1]
end

function var_0_0.getMetaShipByGroupId(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.data) do
		if iter_32_1:isMetaShip() and iter_32_1.metaCharacter.id == arg_32_1 then
			return iter_32_1
		end
	end
end

function var_0_0.getMetaShipIDList(arg_33_0)
	return arg_33_0.metaShipIDList
end

function var_0_0.updateShip(arg_34_0, arg_34_1)
	if arg_34_1.isNpc then
		return
	end

	assert(isa(arg_34_1, Ship), "should be an instance of Ship")
	assert(arg_34_0.data[arg_34_1.id] ~= nil, "ship should exist")

	if arg_34_1.level > arg_34_0.shipHighestLevel then
		arg_34_0.shipHighestLevel = arg_34_1.level

		pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIP_HIGHEST_LEVEL, arg_34_0.shipHighestLevel)
	end

	local var_34_0 = arg_34_0.data[arg_34_1.id]

	arg_34_0:UpdateShipEquipAndSkinCount(var_34_0, false)

	arg_34_0.data[arg_34_1.id] = arg_34_1

	var_0_0.recordShipLevelVertify(arg_34_1)
	arg_34_0:UpdateShipEquipAndSkinCount(arg_34_1, true)

	if var_34_0:isActivityNpc() and not arg_34_1:isActivityNpc() then
		table.removebyvalue(arg_34_0.activityNpcShipIds, arg_34_1.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end

	if var_34_0.level < arg_34_1.level then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIP_LEVEL_UP, arg_34_1.level - var_34_0.level)
	end

	if var_34_0:getStar() < arg_34_1:getStar() or var_34_0.intimacy < arg_34_1.intimacy or var_34_0.level < arg_34_1.level or not var_34_0.propose and arg_34_1.propose then
		local var_34_1 = getProxy(CollectionProxy)

		if var_34_1 and not arg_34_1:isActivityNpc() then
			var_34_1:flushCollection(arg_34_1)
		end
	end

	arg_34_0.facade:sendNotification(var_0_0.SHIP_UPDATED, arg_34_1:clone())
end

function var_0_0.removeShip(arg_35_0, arg_35_1)
	assert(isa(arg_35_1, Ship), "should be an instance of Ship")
	arg_35_0:removeShipById(arg_35_1.id)
end

function var_0_0.getEquipment2ByflagShip(arg_36_0)
	local var_36_0 = getProxy(PlayerProxy):getData()
	local var_36_1 = arg_36_0:getShipById(var_36_0.character)

	assert(var_36_1, "ship is nil")

	return var_36_1:getEquip(2)
end

function var_0_0.removeShipById(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.data[arg_37_1]

	assert(var_37_0 ~= nil, "ship should exist")

	if var_37_0:isActivityNpc() then
		table.removebyvalue(arg_37_0.activityNpcShipIds, var_37_0.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end

	arg_37_0.data[var_37_0.id] = nil

	var_37_0:display("removed")
	arg_37_0:UpdateShipEquipAndSkinCount(var_37_0, false)
	arg_37_0.facade:sendNotification(var_0_0.SHIP_REMOVED, var_37_0)
end

function var_0_0.findShipByGroup(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.data) do
		if iter_38_1.groupId == arg_38_1 then
			return iter_38_1
		end
	end

	return nil
end

function var_0_0.findShipsByGroup(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_0.data) do
		if iter_39_1.groupId == arg_39_1 then
			table.insert(var_39_0, iter_39_1)
		end
	end

	return var_39_0
end

function var_0_0._findShipsByGroup(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local function var_40_0(arg_41_0)
		if arg_40_2 then
			return arg_41_0:isRemoulded()
		else
			return true
		end
	end

	local function var_40_1(arg_42_0)
		if arg_40_3 then
			return arg_42_0.propose
		else
			return true
		end
	end

	local var_40_2 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_0.data) do
		if iter_40_1.groupId == arg_40_1 and var_40_0(iter_40_1) and var_40_1(iter_40_1) then
			table.insert(var_40_2, iter_40_1)
		end
	end

	return var_40_2
end

function var_0_0.ExistGroupShip(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.data) do
		if iter_43_1.groupId == arg_43_1 then
			return true
		end
	end

	return false
end

function var_0_0._ExistGroupShip(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local function var_44_0(arg_45_0)
		if arg_44_2 then
			return arg_45_0:isRemoulded()
		else
			return true
		end
	end

	local function var_44_1(arg_46_0)
		if arg_44_3 then
			return arg_46_0.propose
		else
			return true
		end
	end

	for iter_44_0, iter_44_1 in pairs(arg_44_0.data) do
		if iter_44_1.groupId == arg_44_1 and var_44_0(iter_44_1) and var_44_1(iter_44_1) then
			return true
		end
	end

	return false
end

function var_0_0.getSameGroupShipCount(arg_47_0, arg_47_1)
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in pairs(arg_47_0.data) do
		if iter_47_1.groupId == arg_47_1 then
			var_47_0 = var_47_0 + 1
		end
	end

	return var_47_0
end

function var_0_0.getUpgradeShips(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1:getConfig("rarity")
	local var_48_1 = arg_48_1.groupId
	local var_48_2 = {}

	for iter_48_0, iter_48_1 in pairs(arg_48_0.data) do
		if iter_48_1.groupId == var_48_1 or iter_48_1:isTestShip() and iter_48_1:canUseTestShip(var_48_0) then
			table.insert(var_48_2, iter_48_1)
		end
	end

	return var_48_2
end

function var_0_0.getBayPower(arg_49_0)
	local var_49_0 = {}
	local var_49_1 = 0

	for iter_49_0, iter_49_1 in pairs(arg_49_0.data) do
		local var_49_2 = iter_49_1.configId
		local var_49_3 = iter_49_1:getShipCombatPower()

		if ShipGroup.GetGroupConfig(iter_49_1:getGroupId()).handbook_type ~= 1 and (not var_49_0[var_49_2] or var_49_3 > var_49_0[var_49_2]) then
			var_49_1 = var_49_1 - defaultValue(var_49_0[var_49_2], 0)
			var_49_0[var_49_2] = var_49_3
			var_49_1 = var_49_1 + var_49_3
		end
	end

	return var_49_1
end

function var_0_0.GetBayPowerRootedAsyn(arg_50_0, arg_50_1)
	local var_50_0

	var_50_0 = coroutine.wrap(function()
		local var_51_0 = {}
		local var_51_1 = 0
		local var_51_2 = 0

		for iter_51_0, iter_51_1 in pairs(arg_50_0.data) do
			local var_51_3 = iter_51_1.configId
			local var_51_4 = iter_51_1:getShipCombatPower()

			if ShipGroup.GetGroupConfig(iter_51_1:getGroupId()).handbook_type ~= 1 and (not var_51_0[var_51_3] or var_51_4 > var_51_0[var_51_3]) then
				var_51_1 = var_51_1 - defaultValue(var_51_0[var_51_3], 0)
				var_51_0[var_51_3] = var_51_4
				var_51_1 = var_51_1 + var_51_4
			end

			var_51_2 = var_51_2 + 1

			if var_51_2 == 1 or var_51_2 % 50 == 0 then
				onNextTick(var_50_0)
				coroutine.yield()
			end
		end

		arg_50_1(var_51_1^0.667)
	end)

	var_50_0()
end

function var_0_0.getBayPowerRooted(arg_52_0)
	return arg_52_0:getBayPower()^0.667
end

function var_0_0.getEquipsInShips(arg_53_0, arg_53_1)
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(arg_53_0.data) do
		for iter_53_2, iter_53_3 in pairs(iter_53_1.equipments) do
			if iter_53_3 and (not arg_53_1 or arg_53_1(iter_53_3, iter_53_1.id)) then
				table.insert(var_53_0, setmetatable({
					shipId = iter_53_1.id,
					shipPos = iter_53_2
				}, {
					__index = iter_53_3
				}))
			end
		end
	end

	return var_53_0
end

function var_0_0.UpdateShipEquipAndSkinCount(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_1 then
		return
	end

	local var_54_0 = arg_54_2 and 1 or -1

	for iter_54_0, iter_54_1 in pairs(arg_54_1.equipments) do
		if iter_54_1 then
			arg_54_0.equipCountDic[iter_54_1.id] = defaultValue(arg_54_0.equipCountDic[iter_54_1.id], 0) + var_54_0

			assert(arg_54_0.equipCountDic[iter_54_1.id] >= 0)
		end
	end

	for iter_54_2, iter_54_3 in pairs(arg_54_1.equipmentSkins) do
		if iter_54_3 > 0 then
			arg_54_0.equipSkinCountDic[iter_54_3] = defaultValue(arg_54_0.equipSkinCountDic[iter_54_3], 0) + var_54_0

			assert(arg_54_0.equipSkinCountDic[iter_54_3] >= 0)
		end
	end
end

function var_0_0.GetEquipCountInShips(arg_55_0, arg_55_1)
	return arg_55_0.equipCountDic[arg_55_1] or 0
end

function var_0_0.GetEquipSkinCountInShips(arg_56_0, arg_56_1)
	return arg_56_0.equipSkinCountDic[arg_56_1] or 0
end

function var_0_0.GetEquipsInShipsRaw(arg_57_0)
	local function var_57_0(arg_58_0, arg_58_1, arg_58_2)
		local var_58_0 = CreateShell(arg_58_0)

		var_58_0.shipId = arg_58_1
		var_58_0.shipPos = arg_58_2

		return var_58_0
	end

	local var_57_1 = {}

	for iter_57_0, iter_57_1 in pairs(arg_57_0.data) do
		for iter_57_2, iter_57_3 in pairs(iter_57_1.equipments) do
			if iter_57_3 then
				table.insert(var_57_1, var_57_0(iter_57_3, iter_57_1.id, iter_57_2))
			end
		end
	end

	return var_57_1
end

function var_0_0.getEquipmentSkinInShips(arg_59_0, arg_59_1, arg_59_2)
	local function var_59_0(arg_60_0)
		local var_60_0 = false

		if arg_60_0 and arg_60_0 > 0 then
			local var_60_1 = pg.equip_skin_template[arg_60_0]

			var_60_0 = _.any(var_60_1.equip_type, function(arg_61_0)
				return not arg_59_2 or table.contains(arg_59_2, arg_61_0)
			end)
		end

		return var_60_0
	end

	local var_59_1 = {}

	for iter_59_0, iter_59_1 in pairs(arg_59_0.data) do
		if not arg_59_1 or arg_59_1.id ~= iter_59_1.id then
			for iter_59_2, iter_59_3 in pairs(iter_59_1:getEquipSkins()) do
				local var_59_2 = var_59_0(iter_59_3)

				if iter_59_3 and var_59_2 then
					table.insert(var_59_1, {
						id = iter_59_3,
						shipId = iter_59_1.id,
						shipPos = iter_59_2
					})
				end
			end
		end
	end

	return var_59_1
end

function var_0_0.GetSpWeaponsInShips(arg_62_0, arg_62_1)
	local var_62_0 = {}

	for iter_62_0, iter_62_1 in pairs(arg_62_0.data) do
		if not arg_62_1 or arg_62_1.id ~= iter_62_1.id then
			local var_62_1 = iter_62_1:GetSpWeapon()

			if var_62_1 and (not arg_62_1 or not arg_62_1:IsSpWeaponForbidden(var_62_1)) then
				table.insert(var_62_0, var_62_1)
			end
		end
	end

	return var_62_0
end

function var_0_0.getProposeGroupList(arg_63_0)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(arg_63_0.data) do
		if iter_63_1:ShowPropose() then
			var_63_0[iter_63_1.groupId] = true
		end
	end

	return var_63_0
end

function var_0_0.GetRecommendShip(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	assert(arg_64_3)

	local var_64_0 = arg_64_0:getShipsByTypes(arg_64_1)
	local var_64_1 = {}

	for iter_64_0, iter_64_1 in ipairs(var_64_0) do
		var_64_1[iter_64_1] = iter_64_1:getShipCombatPower()
	end

	table.sort(var_64_0, function(arg_65_0, arg_65_1)
		return var_64_1[arg_65_0] < var_64_1[arg_65_1]
	end)

	local var_64_2 = {}

	for iter_64_2, iter_64_3 in ipairs(arg_64_2) do
		var_64_2[#var_64_2 + 1] = arg_64_0.data[iter_64_3]:getGroupId()
	end

	local var_64_3 = #var_64_0
	local var_64_4

	while var_64_3 > 0 do
		local var_64_5 = var_64_0[var_64_3]
		local var_64_6 = var_64_5.id
		local var_64_7 = var_64_5:getGroupId()

		if not table.contains(arg_64_2, var_64_6) and not table.contains(var_64_2, var_64_7) and arg_64_3(var_64_5) then
			var_64_4 = var_64_5

			break
		else
			var_64_3 = var_64_3 - 1
		end
	end

	return var_64_4
end

function var_0_0.getActivityRecommendShips(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = arg_66_0:getShipsByTypes(arg_66_1)
	local var_66_1 = {}

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		var_66_1[iter_66_1] = iter_66_1:getShipCombatPower()
	end

	table.sort(var_66_0, function(arg_67_0, arg_67_1)
		return var_66_1[arg_67_0] < var_66_1[arg_67_1]
	end)

	local var_66_2 = {}

	for iter_66_2, iter_66_3 in ipairs(arg_66_2) do
		local var_66_3 = arg_66_0.data[iter_66_3]

		var_66_2[#var_66_2 + 1] = var_66_3:getGroupId()
	end

	local var_66_4 = #var_66_0
	local var_66_5 = {}

	while var_66_4 > 0 and arg_66_3 > 0 do
		local var_66_6 = var_66_0[var_66_4]
		local var_66_7 = var_66_6.id
		local var_66_8 = var_66_6:getGroupId()

		if not table.contains(arg_66_2, var_66_7) and not table.contains(var_66_2, var_66_8) and ShipStatus.ShipStatusCheck("inActivity", var_66_6, nil, {
			inActivity = arg_66_4
		}) then
			table.insert(var_66_5, var_66_6)
			table.insert(var_66_2, var_66_8)

			arg_66_3 = arg_66_3 - 1
		end

		var_66_4 = var_66_4 - 1
	end

	return var_66_5
end

function var_0_0.getDelegationRecommendShips(arg_68_0, arg_68_1)
	local var_68_0 = 6 - #arg_68_1.shipIds
	local var_68_1 = arg_68_1.template.ship_type
	local var_68_2 = arg_68_1.template.ship_lv
	local var_68_3 = math.max(var_68_2, 2)
	local var_68_4 = Clone(arg_68_1.shipIds)
	local var_68_5 = arg_68_0:getShipsByTypes(var_68_1)

	table.sort(var_68_5, function(arg_69_0, arg_69_1)
		return arg_69_0.level > arg_69_1.level
	end)

	local var_68_6 = {}
	local var_68_7 = false

	for iter_68_0, iter_68_1 in ipairs(var_68_4) do
		local var_68_8 = arg_68_0.data[iter_68_1]

		if var_68_3 <= var_68_8.level then
			var_68_7 = true
		end

		var_68_6[#var_68_6 + 1] = var_68_8:getGroupId()
	end

	if var_68_7 then
		var_68_3 = 2
	end

	local var_68_9 = {}
	local var_68_10 = #var_68_5

	while var_68_10 > 0 do
		if var_68_0 <= 0 then
			break
		end

		local var_68_11 = var_68_5[var_68_10]
		local var_68_12 = var_68_11.id
		local var_68_13 = var_68_11:getGroupId()

		if var_68_3 <= var_68_11.level and var_68_11.lockState ~= Ship.LOCK_STATE_UNLOCK and not table.contains(var_68_4, var_68_12) and not table.contains(var_68_6, var_68_13) and not table.contains(var_68_9, var_68_12) and not var_68_11:getFlag("inElite") and not var_68_11:getFlag("inActivity") and ShipStatus.ShipStatusCheck("inEvent", var_68_11) then
			table.insert(var_68_6, var_68_13)
			table.insert(var_68_9, var_68_12)

			var_68_0 = var_68_0 - 1

			if var_68_7 == false then
				var_68_7 = true
				var_68_3 = 2
				var_68_10 = #var_68_5
			end
		else
			var_68_10 = var_68_10 - 1
		end
	end

	return var_68_9
end

function var_0_0.getDelegationRecommendShipsLV1(arg_70_0, arg_70_1)
	local var_70_0 = 6 - #arg_70_1.shipIds
	local var_70_1 = arg_70_1.template.ship_type
	local var_70_2 = Clone(arg_70_1.shipIds)
	local var_70_3 = arg_70_0:getShipsByTypes(var_70_1)
	local var_70_4 = _.select(var_70_3, function(arg_71_0)
		return arg_71_0.level == 1
	end)

	table.sort(var_70_4, CompareFuncs({
		function(arg_72_0)
			return arg_72_0.lockState == arg_72_0.LOCK_STATE_UNLOCK and 0 or 1
		end
	}))

	local var_70_5 = {}

	for iter_70_0, iter_70_1 in ipairs(var_70_2) do
		local var_70_6 = arg_70_0.data[iter_70_1]

		var_70_5[#var_70_5 + 1] = var_70_6:getGroupId()
	end

	local var_70_7 = {}
	local var_70_8 = #var_70_4

	while var_70_8 > 0 do
		if var_70_0 <= 0 then
			break
		end

		local var_70_9 = var_70_4[var_70_8]
		local var_70_10 = var_70_9.id
		local var_70_11 = var_70_9:getGroupId()

		if not table.contains(var_70_2, var_70_10) and not table.contains(var_70_5, var_70_11) and not table.contains(var_70_7, var_70_10) and not var_70_9:getFlag("inElite") and not var_70_9:getFlag("inActivity") and ShipStatus.ShipStatusCheck("inEvent", var_70_9) then
			table.insert(var_70_5, var_70_11)
			table.insert(var_70_7, var_70_10)

			var_70_0 = var_70_0 - 1
		else
			var_70_8 = var_70_8 - 1
		end
	end

	return var_70_7
end

function var_0_0.getWorldRecommendShip(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = arg_73_0:getShipsByTeamType(arg_73_1)
	local var_73_1 = {}

	for iter_73_0, iter_73_1 in ipairs(var_73_0) do
		var_73_1[iter_73_1] = iter_73_1:getShipCombatPower()
	end

	table.sort(var_73_0, function(arg_74_0, arg_74_1)
		return var_73_1[arg_74_0] < var_73_1[arg_74_1]
	end)

	local var_73_2 = {}

	for iter_73_2, iter_73_3 in ipairs(arg_73_2) do
		var_73_2[#var_73_2 + 1] = arg_73_0.data[iter_73_3]:getGroupId()
	end

	local var_73_3 = #var_73_0
	local var_73_4

	while var_73_3 > 0 do
		local var_73_5 = var_73_0[var_73_3]
		local var_73_6 = var_73_5.id
		local var_73_7 = var_73_5:getGroupId()

		if not table.contains(arg_73_2, var_73_6) and not table.contains(var_73_2, var_73_7) and ShipStatus.ShipStatusCheck("inWorld", var_73_5) then
			var_73_4 = var_73_5

			break
		else
			var_73_3 = var_73_3 - 1
		end
	end

	return var_73_4
end

function var_0_0.getModRecommendShip(arg_75_0, arg_75_1, arg_75_2)
	Timekeeping()

	local var_75_0 = underscore.map(arg_75_2, function(arg_76_0)
		return arg_75_0.data[arg_76_0]
	end)

	Timekeeping()

	local var_75_1 = Clone(arg_75_1)

	for iter_75_0, iter_75_1 in pairs(ShipModLayer.getModExpAdditions(var_75_1, var_75_0)) do
		var_75_1:addModAttrExp(iter_75_0, iter_75_1)
	end

	local var_75_2 = var_75_1:getNeedModExp()
	local var_75_3 = 0

	for iter_75_2, iter_75_3 in pairs(var_75_2) do
		var_75_3 = var_75_3 + iter_75_3
	end

	Timekeeping()

	local var_75_4 = {}

	for iter_75_4, iter_75_5 in pairs(arg_75_0.data) do
		if iter_75_5:isSameKind(arg_75_1) then
			var_75_4.sameKind = var_75_4.sameKind or {}

			table.insert(var_75_4.sameKind, iter_75_5)
		else
			local var_75_5 = iter_75_5:getShipType()

			var_75_4[var_75_5] = var_75_4[var_75_5] or {}

			table.insert(var_75_4[var_75_5], iter_75_5)
		end
	end

	Timekeeping()

	local var_75_6 = arg_75_1:getConfig("type")

	for iter_75_6, iter_75_7 in ipairs(table.mergeArray({
		"sameKind"
	}, pg.ship_data_by_type[var_75_6].strengthen_choose_type)) do
		if #var_75_0 == 12 or var_75_3 == 0 then
			break
		end

		local var_75_7 = var_75_4[iter_75_7] or {}
		local var_75_8 = {}

		for iter_75_8, iter_75_9 in ipairs(pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_2, underscore.map(var_75_7, function(arg_77_0)
			return arg_77_0.id
		end))) do
			var_75_8[iter_75_9] = true
		end

		local var_75_9 = underscore.filter(var_75_7, function(arg_78_0)
			return arg_78_0.level == 1 and arg_78_0:getRarity() <= ShipRarity.Gray and arg_78_0:GetLockState() ~= Ship.LOCK_STATE_LOCK and not table.contains(arg_75_2, arg_78_0.id) and arg_75_1.id ~= arg_78_0.id and not var_75_8[arg_78_0.id]
		end)

		for iter_75_10, iter_75_11 in ipairs(var_75_9) do
			if #var_75_0 == 12 or var_75_3 == 0 then
				break
			end

			local var_75_10 = ShipModLayer.getModExpAdditions(var_75_1, {
				iter_75_11
			})
			local var_75_11 = false

			for iter_75_12, iter_75_13 in pairs(var_75_10) do
				if iter_75_13 > 0 and var_75_2[iter_75_12] > 0 then
					var_75_11 = true
					var_75_3 = var_75_3 - math.min(var_75_2[iter_75_12], iter_75_13)
					var_75_2[iter_75_12] = math.max(var_75_2[iter_75_12] - iter_75_13, 0)
				end
			end

			if var_75_11 then
				table.insert(var_75_0, iter_75_11)
			end
		end
	end

	Timekeeping()

	return underscore.map(var_75_0, function(arg_79_0)
		return arg_79_0.id
	end)
end

function var_0_0.getUpgradeRecommendShip(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	local var_80_0 = arg_80_0:getUpgradeShips(arg_80_1)
	local var_80_1 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_4, underscore.keys(arg_80_0.data))

	local function var_80_2(arg_81_0)
		return arg_81_0.level == 1 and arg_81_0:GetLockState() ~= Ship.LOCK_STATE_LOCK and not table.contains(arg_80_2, arg_81_0.id) and arg_80_1.id ~= arg_81_0.id and not table.contains(var_80_1, arg_81_0.id)
	end

	local var_80_3 = {}

	for iter_80_0, iter_80_1 in ipairs(var_80_0) do
		if var_80_2(iter_80_1) then
			table.insert(var_80_3, iter_80_1)
		end
	end

	local var_80_4 = {
		function(arg_82_0)
			return arg_82_0:isSameKind(arg_80_1) and 0 or 1
		end
	}

	table.sort(var_80_3, CompareFuncs(var_80_4))

	local var_80_5 = {}

	for iter_80_2, iter_80_3 in pairs(arg_80_2) do
		table.insert(var_80_5, arg_80_0.data[iter_80_3])
	end

	for iter_80_4, iter_80_5 in ipairs(var_80_3) do
		if #var_80_5 == arg_80_3 then
			break
		end

		table.insert(var_80_5, iter_80_5)
	end

	return underscore.map(var_80_5, function(arg_83_0)
		return arg_83_0.id
	end)
end

function var_0_0.getGroupPropose(arg_84_0, arg_84_1)
	local var_84_0 = false

	if arg_84_0.data then
		for iter_84_0, iter_84_1 in ipairs(arg_84_0.data) do
			if pg.ship_data_template[iter_84_1.configId].group_type == arg_84_1 and iter_84_1.propose then
				return true
			end
		end
	end

	return var_84_0
end

function var_0_0.CanUseShareSkinShips(arg_85_0, arg_85_1)
	local var_85_0 = pg.ship_skin_template[arg_85_1].ship_group
	local var_85_1 = pg.ship_data_group.get_id_list_by_group_type[var_85_0][1]
	local var_85_2 = pg.ship_data_group[var_85_1].share_group_id
	local var_85_3 = {}
	local var_85_4 = arg_85_0:getRawData()

	for iter_85_0, iter_85_1 in pairs(var_85_4) do
		if table.contains(var_85_2, iter_85_1.groupId) and math.floor(iter_85_1:getIntimacy() / 100) >= iter_85_1:GetNoProposeIntimacyMax() then
			table.insert(var_85_3, iter_85_1)
		end
	end

	return var_85_3
end

return var_0_0
