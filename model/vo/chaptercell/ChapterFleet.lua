local var_0_0 = class("ChapterFleet", import(".LevelCellData"))

var_0_0.DUTY_CLEANPATH = 1
var_0_0.DUTY_KILLBOSS = 2
var_0_0.DUTY_KILLALL = 3
var_0_0.DUTY_IDLE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:updateNpcShipList(arg_1_2)

	arg_1_0.id = arg_1_1.id
	arg_1_0.name = nil
	arg_1_0.fleetId = arg_1_1.fleet_id

	if arg_1_1.fleet_id then
		local var_1_0 = getProxy(FleetProxy):getFleetById(arg_1_1.fleet_id)

		arg_1_0.name = var_1_0 and var_1_0:GetName() or Fleet.DEFAULT_NAME[arg_1_1.fleet_id]
	end

	arg_1_0.name = arg_1_0.name or Fleet.DEFAULT_NAME[arg_1_0.id]

	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	_.each(arg_1_1.box_strategy_list, function(arg_2_0)
		var_1_1[arg_2_0.id] = arg_2_0.count
	end)
	_.each(arg_1_1.ship_strategy_list, function(arg_3_0)
		var_1_2[arg_3_0.id] = arg_3_0.count
	end)
	_.each(arg_1_1.strategy_ids, function(arg_4_0)
		if pg.strategy_data_template[arg_4_0] then
			table.insert(var_1_3, arg_4_0)
		end
	end)

	if not _.detect(var_1_3, function(arg_5_0)
		return pg.strategy_data_template[arg_5_0].type == ChapterConst.StgTypeForm
	end) then
		table.insert(var_1_3, arg_1_0:getFormationStg())
	end

	arg_1_0.stgPicked = var_1_1
	arg_1_0.stgUsed = var_1_2
	arg_1_0.stgIds = var_1_3
	arg_1_0.line = {
		row = arg_1_1.pos.row,
		column = arg_1_1.pos.column
	}
	arg_1_0.step = arg_1_1.step_count
	arg_1_0.restAmmo = arg_1_1.bullet
	arg_1_0.startPos = {
		row = arg_1_1.start_pos.row,
		column = arg_1_1.start_pos.column
	}

	arg_1_0:prepareShips(arg_1_1.ship_list)
	arg_1_0:updateShips(arg_1_1.ship_list)

	arg_1_0.baseSpeed = arg_1_0:calcBaseSpeed()
	arg_1_0.rotation = Quaternion.identity
	arg_1_0.slowSpeedFactor = arg_1_1.move_step_down
	arg_1_0.defeatEnemies = arg_1_1.kill_count or 0

	arg_1_0:updateCommanders(arg_1_1.commander_list)

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()
end

function var_0_0.setup(arg_6_0, arg_6_1)
	arg_6_0.chapter = arg_6_1
end

function var_0_0.fetchShipVO(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_0.npcShipList[arg_7_1] then
		var_7_0 = Clone(arg_7_0.npcShipList[arg_7_1])
	else
		var_7_0 = getProxy(BayProxy):getShipById(arg_7_1)
	end

	if arg_7_0.staticsReady then
		var_7_0.triggers.TeamNumbers = arg_7_0.statics[var_7_0:getTeamType()].count
	end

	return var_7_0
end

function var_0_0.updateNpcShipList(arg_8_0, arg_8_1)
	arg_8_0.npcShipList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0.npcShipList[iter_8_1.id] = iter_8_1
	end
end

function var_0_0.GetLine(arg_9_0)
	return arg_9_0.line
end

function var_0_0.SetLine(arg_10_0, arg_10_1)
	arg_10_0.line = {
		row = arg_10_1.row,
		column = arg_10_1.column
	}
end

function var_0_0.updateCommanders(arg_11_0, arg_11_1)
	arg_11_0.commanders = {}

	local var_11_0 = getProxy(CommanderProxy)

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = iter_11_1.id
		local var_11_2 = var_11_0:getCommanderById(var_11_1)

		if var_11_2 then
			arg_11_0.commanders[iter_11_1.pos] = var_11_2
		end
	end
end

function var_0_0.getCommanders(arg_12_0)
	return arg_12_0.commanders or {}
end

function var_0_0.prepareShips(arg_13_0, arg_13_1)
	arg_13_0.statics = {}
	arg_13_0.statics[TeamType.Vanguard] = {
		count = 0
	}
	arg_13_0.statics[TeamType.Main] = {
		count = 0
	}
	arg_13_0.statics[TeamType.Submarine] = {
		count = 0
	}

	_.each(arg_13_1 or {}, function(arg_14_0)
		local var_14_0 = arg_13_0:fetchShipVO(arg_14_0.id)

		if var_14_0 then
			local var_14_1 = arg_13_0.statics[var_14_0:getTeamType()]

			var_14_1.count = var_14_1.count + 1
		end
	end)

	arg_13_0.staticsReady = true
end

function var_0_0.updateShips(arg_15_0, arg_15_1)
	arg_15_0[TeamType.Vanguard] = {}
	arg_15_0[TeamType.Main] = {}
	arg_15_0[TeamType.Submarine] = {}
	arg_15_0.ships = {}

	_.each(arg_15_1 or {}, function(arg_16_0)
		local var_16_0 = arg_15_0:fetchShipVO(arg_16_0.id)

		if var_16_0 then
			var_16_0.hpRant = arg_16_0.hp_rant
			arg_15_0.ships[var_16_0.id] = var_16_0

			table.insert(arg_15_0[var_16_0:getTeamType()], var_16_0)
		end
	end)
end

function var_0_0.getTeamByName(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_0[arg_17_1]

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		table.insert(var_17_0, iter_17_1.id)
	end

	return var_17_0
end

function var_0_0.flushShips(arg_18_0)
	local var_18_0 = getProxy(FleetProxy):getFleetById(arg_18_0.fleetId)

	arg_18_0.name = var_18_0 and var_18_0.name ~= "" and var_18_0.name or Fleet.DEFAULT_NAME[arg_18_0.fleetId] or Fleet.DEFAULT_NAME[arg_18_0.id]

	local var_18_1 = _.keys(arg_18_0.ships)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = arg_18_0:fetchShipVO(iter_18_1)

		if var_18_2 then
			var_18_2.hpRant = arg_18_0.ships[iter_18_1].hpRant
		end

		arg_18_0.ships[iter_18_1] = var_18_2
	end

	local var_18_3 = {}

	_.each(arg_18_0[TeamType.Vanguard], function(arg_19_0)
		if arg_18_0.ships[arg_19_0.id] then
			table.insert(var_18_3, arg_18_0.ships[arg_19_0.id])
		end
	end)

	arg_18_0[TeamType.Vanguard] = var_18_3

	local var_18_4 = {}

	_.each(arg_18_0[TeamType.Main], function(arg_20_0)
		if arg_18_0.ships[arg_20_0.id] then
			table.insert(var_18_4, arg_18_0.ships[arg_20_0.id])
		end
	end)

	arg_18_0[TeamType.Main] = var_18_4

	local var_18_5 = {}

	_.each(arg_18_0[TeamType.Submarine], function(arg_21_0)
		if arg_18_0.ships[arg_21_0.id] then
			table.insert(var_18_5, arg_18_0.ships[arg_21_0.id])
		end
	end)

	arg_18_0[TeamType.Submarine] = var_18_5
end

function var_0_0.updateShipHp(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.ships[arg_22_1]

	if var_22_0 then
		var_22_0.hpChange = arg_22_2 - var_22_0.hpRant
		var_22_0.hpRant = arg_22_2
	end
end

function var_0_0.getShip(arg_23_0, arg_23_1)
	return arg_23_0.ships[arg_23_1]
end

function var_0_0.getShips(arg_24_0, arg_24_1)
	local var_24_0 = {}
	local var_24_1 = arg_24_0:getFleetType()

	if var_24_1 == FleetType.Normal then
		_.each(arg_24_0:getShipsByTeam(TeamType.Main, arg_24_1), function(arg_25_0)
			table.insert(var_24_0, arg_25_0)
		end)
		_.each(arg_24_0:getShipsByTeam(TeamType.Vanguard, arg_24_1), function(arg_26_0)
			table.insert(var_24_0, arg_26_0)
		end)
	elseif var_24_1 == FleetType.Submarine then
		_.each(arg_24_0:getShipsByTeam(TeamType.Submarine, arg_24_1), function(arg_27_0)
			table.insert(var_24_0, arg_27_0)
		end)
	elseif var_24_1 == FleetType.Support then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.ships) do
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.getShipsByTeam(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0[arg_28_1]) do
		if iter_28_1.hpRant > 0 then
			var_28_0[#var_28_0 + 1] = iter_28_1
		end
	end

	if arg_28_2 then
		for iter_28_2, iter_28_3 in ipairs(arg_28_0[arg_28_1]) do
			if iter_28_3.hpRant <= 0 then
				var_28_0[#var_28_0 + 1] = iter_28_3
			end
		end
	end

	return var_28_0
end

function var_0_0.containsShip(arg_29_0, arg_29_1)
	return arg_29_0.ships[arg_29_1] and true or false
end

function var_0_0.replaceShip(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.ships[arg_30_1] and not arg_30_0.ships[arg_30_2.id] then
		local var_30_0 = arg_30_0.ships[arg_30_1]
		local var_30_1 = arg_30_0:fetchShipVO(arg_30_2.id)

		if var_30_1 then
			if var_30_1:getTeamType() == var_30_0:getTeamType() then
				if not var_30_0:isSameKind(var_30_1) and arg_30_0:containsSameKind(var_30_1) then
					arg_30_0:removeShip(arg_30_1)
				else
					var_30_1.hpRant = arg_30_2.hp_rant
					arg_30_0.ships[arg_30_1] = nil
					arg_30_0.ships[var_30_1.id] = var_30_1

					local var_30_2 = arg_30_0[var_30_1:getTeamType()]

					for iter_30_0 = 1, #var_30_2 do
						if var_30_2[iter_30_0].id == arg_30_1 then
							var_30_2[iter_30_0] = var_30_1

							break
						end
					end
				end
			else
				arg_30_0:removeShip(arg_30_1)
			end
		end
	end
end

function var_0_0.addShip(arg_31_0, arg_31_1)
	if not arg_31_0.ships[arg_31_1.id] then
		local var_31_0 = arg_31_0:fetchShipVO(arg_31_1.id)

		if var_31_0 then
			var_31_0.hpRant = arg_31_1.hp_rant

			local var_31_1 = arg_31_0[var_31_0:getTeamType()]

			if #var_31_1 < 3 then
				table.insert(var_31_1, var_31_0)

				arg_31_0.ships[var_31_0.id] = var_31_0
			end
		end
	end
end

function var_0_0.removeShip(arg_32_0, arg_32_1)
	arg_32_0.ships[arg_32_1] = nil

	local var_32_0 = {
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}

	for iter_32_0 = 1, #var_32_0 do
		local var_32_1 = arg_32_0[var_32_0[iter_32_0]]

		for iter_32_1 = #var_32_1, 1, -1 do
			if var_32_1[iter_32_1].id == arg_32_1 then
				table.remove(var_32_1, iter_32_1)
			end
		end
	end
end

function var_0_0.switchShip(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:getShipsByTeam(arg_33_1, false)
	local var_33_1 = var_33_0[arg_33_2].id
	local var_33_2 = var_33_0[arg_33_3].id
	local var_33_3
	local var_33_4
	local var_33_5
	local var_33_6

	for iter_33_0, iter_33_1 in pairs(arg_33_0.ships) do
		if iter_33_0 == var_33_1 then
			var_33_3 = iter_33_1:getTeamType()
			var_33_4 = table.indexof(arg_33_0[var_33_3], iter_33_1)
		end

		if iter_33_0 == var_33_2 then
			var_33_5 = iter_33_1:getTeamType()
			var_33_6 = table.indexof(arg_33_0[var_33_5], iter_33_1)
		end
	end

	assert(var_33_4 and var_33_6)

	if var_33_3 == var_33_5 and var_33_4 ~= var_33_6 then
		arg_33_0[var_33_3][var_33_4], arg_33_0[var_33_5][var_33_6] = arg_33_0[var_33_5][var_33_6], arg_33_0[var_33_3][var_33_4]
	end
end

function var_0_0.synchronousShipIndex(arg_34_0, arg_34_1)
	local var_34_0 = {
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		for iter_34_2 = 1, 3 do
			if arg_34_1[iter_34_1][iter_34_2] then
				local var_34_1 = arg_34_1[iter_34_1][iter_34_2].id

				arg_34_0[iter_34_1][iter_34_2] = arg_34_0.ships[var_34_1]
			else
				arg_34_0[iter_34_1][iter_34_2] = nil
			end
		end
	end
end

function var_0_0.isValid(arg_35_0)
	local var_35_0 = arg_35_0:getFleetType()

	if var_35_0 == FleetType.Normal then
		return _.any(arg_35_0[TeamType.Vanguard], function(arg_36_0)
			return arg_36_0.hpRant > 0
		end) and _.any(arg_35_0[TeamType.Main], function(arg_37_0)
			return arg_37_0.hpRant > 0
		end)
	elseif var_35_0 == FleetType.Submarine then
		return _.any(arg_35_0[TeamType.Submarine], function(arg_38_0)
			return arg_38_0.hpRant > 0
		end)
	elseif var_35_0 == FleetType.Support then
		return true
	end

	return false
end

function var_0_0.getCost(arg_39_0)
	local var_39_0 = {
		gold = 0,
		oil = 0
	}
	local var_39_1 = {
		gold = 0,
		oil = 0
	}
	local var_39_2 = arg_39_0:getShips(false)

	_.each(var_39_2, function(arg_40_0)
		var_39_0.oil = var_39_0.oil + arg_40_0:getStartBattleExpend()
		var_39_1.oil = var_39_1.oil + arg_40_0:getEndBattleExpend()
	end)

	return var_39_0, var_39_1
end

function var_0_0.getInvestSums(arg_41_0, arg_41_1)
	local function var_41_0(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_1:getProperties(arg_41_0:getCommanders())

		return arg_42_0 + var_42_0[AttributeType.Air] + var_42_0[AttributeType.Dodge]
	end

	local var_41_1 = _.reduce(arg_41_0:getShips(arg_41_1), 0, var_41_0)

	return math.pow(var_41_1, 0.6666666666666666)
end

function var_0_0.getDodgeSums(arg_43_0)
	local function var_43_0(arg_44_0, arg_44_1)
		return arg_44_0 + arg_44_1:getProperties(arg_43_0:getCommanders())[AttributeType.Dodge]
	end

	local var_43_1 = _.reduce(arg_43_0:getShips(false), 0, var_43_0)

	return math.pow(var_43_1, 0.6666666666666666)
end

function var_0_0.getAntiAircraftSums(arg_45_0)
	local function var_45_0(arg_46_0, arg_46_1)
		return arg_46_0 + arg_46_1:getProperties(arg_45_0:getCommanders())[AttributeType.AntiAircraft]
	end

	return (_.reduce(arg_45_0:getShips(false), 0, var_45_0))
end

function var_0_0.getShipAmmo(arg_47_0)
	local var_47_0 = 0

	if arg_47_0:getFleetType() == FleetType.Normal then
		for iter_47_0, iter_47_1 in pairs(arg_47_0.ships) do
			var_47_0 = math.max(var_47_0, iter_47_1:getShipAmmo())
		end
	elseif arg_47_0:getFleetType() == FleetType.Submarine then
		for iter_47_2, iter_47_3 in pairs(arg_47_0.ships) do
			var_47_0 = var_47_0 + iter_47_3:getShipAmmo()
		end
	elseif arg_47_0:getFleetType() == FleetType.Support then
		var_47_0 = 0
	end

	return var_47_0
end

function var_0_0.clearShipHpChange(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0.ships) do
		arg_48_0.ships[iter_48_1.id].hpChange = 0
	end
end

function var_0_0.getEquipAmbushRateReduce(arg_49_0)
	local var_49_0 = 0

	for iter_49_0, iter_49_1 in pairs(arg_49_0.ships) do
		for iter_49_2, iter_49_3 in pairs(iter_49_1:getActiveEquipments()) do
			if iter_49_3 then
				var_49_0 = math.max(var_49_0, iter_49_3:getConfig("equip_parameters").ambush_extra or 0)
			end
		end
	end

	return var_49_0 / 10000
end

function var_0_0.getEquipDodgeRateUp(arg_50_0)
	local var_50_0 = 0

	for iter_50_0, iter_50_1 in pairs(arg_50_0.ships) do
		for iter_50_2, iter_50_3 in pairs(iter_50_1:getActiveEquipments()) do
			if iter_50_3 then
				var_50_0 = math.max(var_50_0, iter_50_3:getConfig("equip_parameters").avoid_extra or 0)
			end
		end
	end

	return var_50_0 / 10000
end

function var_0_0.isFormationDiffWith(arg_51_0, arg_51_1)
	local var_51_0 = {
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		local var_51_1 = arg_51_0[iter_51_1]
		local var_51_2 = arg_51_1[iter_51_1]

		for iter_51_2 = 1, math.max(#var_51_1, #var_51_2) do
			if var_51_1[iter_51_2] ~= var_51_2[iter_51_2] and (var_51_1[iter_51_2] == nil or var_51_2[iter_51_2] == nil or var_51_1[iter_51_2].id ~= var_51_2[iter_51_2].id) then
				return true
			end
		end
	end

	return false
end

function var_0_0.getShipIds(arg_52_0)
	local var_52_0 = {}
	local var_52_1 = arg_52_0:getFleetType()

	if var_52_1 == FleetType.Normal then
		_.each(arg_52_0[TeamType.Main], function(arg_53_0)
			table.insert(var_52_0, arg_53_0.id)
		end)
		_.each(arg_52_0[TeamType.Vanguard], function(arg_54_0)
			table.insert(var_52_0, arg_54_0.id)
		end)
	elseif var_52_1 == FleetType.Submarine then
		_.each(arg_52_0[TeamType.Submarine], function(arg_55_0)
			table.insert(var_52_0, arg_55_0.id)
		end)
	elseif var_52_1 == FleetType.Support then
		for iter_52_0, iter_52_1 in pairs(arg_52_0.ships) do
			table.insert(var_52_0, iter_52_1.id)
		end
	end

	return var_52_0
end

function var_0_0.containsSameKind(arg_56_0, arg_56_1)
	return arg_56_1 and _.any(_.values(arg_56_0.ships), function(arg_57_0)
		return arg_56_1:isSameKind(arg_57_0)
	end)
end

function var_0_0.increaseSlowSpeedFactor(arg_58_0)
	arg_58_0.slowSpeedFactor = arg_58_0.slowSpeedFactor + 1
end

function var_0_0.getSpeed(arg_59_0)
	local var_59_0 = arg_59_0:triggerSkill(FleetSkill.TypeMoveSpeed) or 0

	return math.max(arg_59_0.baseSpeed + var_59_0 - arg_59_0.slowSpeedFactor, 1)
end

function var_0_0.calcBaseSpeed(arg_60_0)
	local var_60_0 = arg_60_0:getShips(true)
	local var_60_1 = _.reduce(var_60_0, 0, function(arg_61_0, arg_61_1)
		return arg_61_0 + arg_61_1:getProperties()[AttributeType.Speed]
	end) / #var_60_0 * (1 - 0.02 * (#var_60_0 - 1))
	local var_60_2
	local var_60_3
	local var_60_4 = arg_60_0:getFleetType()

	if var_60_4 == FleetType.Normal then
		var_60_2 = pg.gameset.chapter_move_speed_1.key_value
		var_60_3 = pg.gameset.chapter_move_speed_2.key_value
	elseif var_60_4 == FleetType.Submarine then
		var_60_2 = pg.gameset.submarine_move_speed_1.key_value
		var_60_3 = pg.gameset.submarine_move_speed_2.key_value
	elseif var_60_4 == FleetType.Support then
		var_60_2 = pg.gameset.chapter_move_speed_1.key_value
		var_60_3 = pg.gameset.chapter_move_speed_2.key_value
	end

	if var_60_1 <= var_60_2 then
		return 2
	elseif var_60_3 < var_60_1 then
		return 4
	else
		return 3
	end
end

function var_0_0.getDefeatCount(arg_62_0)
	return arg_62_0.defeatEnemies
end

function var_0_0.getStrategies(arg_63_0)
	local var_63_0 = arg_63_0:getOwnStrategies()

	for iter_63_0, iter_63_1 in pairs(arg_63_0.stgPicked) do
		var_63_0[iter_63_0] = (var_63_0[iter_63_0] or 0) + iter_63_1
	end

	for iter_63_2, iter_63_3 in pairs(arg_63_0.stgUsed) do
		if var_63_0[iter_63_2] then
			var_63_0[iter_63_2] = math.max(0, var_63_0[iter_63_2] - iter_63_3)
		end
	end

	for iter_63_4, iter_63_5 in pairs(ChapterConst.StrategyPresents) do
		var_63_0[iter_63_5] = var_63_0[iter_63_5] or 0
	end

	local var_63_1 = {}

	for iter_63_6, iter_63_7 in pairs(var_63_0) do
		table.insert(var_63_1, {
			id = iter_63_6,
			count = iter_63_7
		})
	end

	return _.sort(var_63_1, function(arg_64_0, arg_64_1)
		return arg_64_0.id < arg_64_1.id
	end)
end

function var_0_0.getOwnStrategies(arg_65_0)
	local var_65_0 = {}
	local var_65_1 = arg_65_0:getShips(true)

	_.each(var_65_1, function(arg_66_0)
		local var_66_0 = arg_66_0:getConfig("strategy_list")

		_.each(var_66_0, function(arg_67_0)
			var_65_0[arg_67_0[1]] = (var_65_0[arg_67_0[1]] or 0) + arg_67_0[2]
		end)
	end)

	local var_65_2 = arg_65_0:triggerSkill(FleetSkill.TypeStrategy)

	if var_65_2 then
		_.each(var_65_2, function(arg_68_0)
			var_65_0[arg_68_0[1]] = (var_65_0[arg_68_0[1]] or 0) + arg_68_0[2]
		end)
	end

	return var_65_0
end

function var_0_0.achievedStrategy(arg_69_0, arg_69_1, arg_69_2)
	arg_69_0.stgPicked[arg_69_1] = (arg_69_0.stgPicked[arg_69_1] or 0) + arg_69_2
end

function var_0_0.consumeOneStrategy(arg_70_0, arg_70_1)
	local var_70_0 = arg_70_0:getOwnStrategies()

	if var_70_0[arg_70_1] and var_70_0[arg_70_1] > 0 then
		local var_70_1 = arg_70_0.stgUsed

		var_70_1[arg_70_1] = (var_70_1[arg_70_1] or 0) + 1
	else
		local var_70_2 = arg_70_0.stgPicked

		if var_70_2[arg_70_1] then
			var_70_2[arg_70_1] = math.max(0, var_70_2[arg_70_1] - 1)
		end
	end
end

function var_0_0.GetStrategyCount(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0:getStrategies()
	local var_71_1 = _.detect(var_71_0, function(arg_72_0)
		return arg_72_0.id == arg_71_1
	end)

	return var_71_1 and var_71_1.count or 0
end

function var_0_0.getFormationStg(arg_73_0)
	return PlayerPrefs.GetInt("team_formation_" .. arg_73_0.id, 1)
end

function var_0_0.canUseStrategy(arg_74_0, arg_74_1)
	local var_74_0 = pg.strategy_data_template[arg_74_1.id]

	if var_74_0.type == ChapterConst.StgTypeForm then
		if arg_74_0:getFormationStg() == var_74_0.id then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_formation_active_already"))

			return false
		end
	elseif var_74_0.type == ChapterConst.StgTypeConsume or var_74_0.type == ChapterConst.StgTypeBindSupportConsume then
		if arg_74_1.count <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_not_enough"))

			return false
		end

		if var_74_0.id == ChapterConst.StrategyRepair and _.all(arg_74_0:getShips(true), function(arg_75_0)
			return arg_75_0.hpRant == 0 or arg_75_0.hpRant == 10000
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_full_hp"))

			return false
		end
	end

	return true
end

function var_0_0.getNextStgUser(arg_76_0, arg_76_1)
	return arg_76_0.id
end

function var_0_0.GetStatusStrategy(arg_77_0)
	return arg_77_0.stgIds
end

function var_0_0.getFleetType(arg_78_0)
	local var_78_0 = 0

	for iter_78_0, iter_78_1 in pairs(arg_78_0.ships) do
		local var_78_1 = iter_78_1:getTeamType()

		if var_78_1 == TeamType.Submarine then
			return FleetType.Submarine
		elseif var_78_1 == TeamType.Vanguard then
			var_78_0 = var_78_0 + 1
		end
	end

	if var_78_0 == 0 then
		return FleetType.Support
	else
		return FleetType.Normal
	end
end

function var_0_0.canClearTorpedo(arg_79_0)
	local var_79_0 = arg_79_0:getShipsByTeam(TeamType.Vanguard, true)

	return _.any(var_79_0, function(arg_80_0)
		return ShipType.IsTypeQuZhu(arg_80_0:getShipType())
	end)
end

function var_0_0.getHuntingRange(arg_81_0, arg_81_1)
	if arg_81_0:getFleetType() ~= FleetType.Submarine then
		assert(false)

		return {}
	end

	local var_81_0 = arg_81_1 or arg_81_0.startPos
	local var_81_1 = arg_81_0:getShipsByTeam(TeamType.Submarine, true)[1]
	local var_81_2 = arg_81_0:triggerSkill(FleetSkill.TypeHuntingLv) or 0
	local var_81_3 = var_81_1:getHuntingRange(var_81_1:getHuntingLv() + var_81_2)

	return (_.map(var_81_3, function(arg_82_0)
		return {
			row = var_81_0.row + arg_82_0[1],
			column = var_81_0.column + arg_82_0[2]
		}
	end))
end

function var_0_0.inHuntingRange(arg_83_0, arg_83_1, arg_83_2)
	return _.any(arg_83_0:getHuntingRange(), function(arg_84_0)
		return arg_84_0.row == arg_83_1 and arg_84_0.column == arg_83_2
	end)
end

function var_0_0.getSummonCost(arg_85_0)
	local var_85_0 = arg_85_0:getShips(false)

	return _.reduce(var_85_0, 0, function(arg_86_0, arg_86_1)
		return arg_86_0 + arg_86_1:getEndBattleExpend()
	end)
end

function var_0_0.DealDMG2Ships(arg_87_0, arg_87_1)
	for iter_87_0, iter_87_1 in pairs(arg_87_0.ships) do
		local var_87_0 = iter_87_1.hpRant

		iter_87_1.hpRant = math.clamp(iter_87_1.hpRant - arg_87_1, 0, 10000)
		iter_87_1.hpChange = (iter_87_1.hpChange or 0) + (iter_87_1.hpRant - var_87_0)
	end
end

function var_0_0.getMapAura(arg_88_0)
	local var_88_0 = {}

	for iter_88_0, iter_88_1 in pairs(arg_88_0.ships) do
		local var_88_1 = iter_88_1:getMapAuras()

		for iter_88_2, iter_88_3 in ipairs(var_88_1) do
			table.insert(var_88_0, iter_88_3)
		end
	end

	return var_88_0
end

function var_0_0.getMapAid(arg_89_0)
	local var_89_0 = {}

	for iter_89_0, iter_89_1 in pairs(arg_89_0.ships) do
		local var_89_1 = iter_89_1:getMapAids()

		for iter_89_2, iter_89_3 in ipairs(var_89_1) do
			local var_89_2 = var_89_0[iter_89_1] or {}

			table.insert(var_89_2, iter_89_3)

			var_89_0[iter_89_1] = var_89_2
		end
	end

	return var_89_0
end

function var_0_0.updateCommanderSkills(arg_90_0)
	local var_90_0 = arg_90_0:getCommanders()

	for iter_90_0, iter_90_1 in pairs(var_90_0) do
		_.each(iter_90_1:getSkills(), function(arg_91_0)
			_.each(arg_91_0:getTacticSkill(), function(arg_92_0)
				table.insert(arg_90_0.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, arg_92_0))
			end)
		end)
	end
end

function var_0_0.getSkills(arg_93_0)
	return arg_93_0.skills
end

function var_0_0.getSkill(arg_94_0, arg_94_1)
	return _.detect(arg_94_0:getSkills(), function(arg_95_0)
		return arg_95_0.id == arg_94_1
	end)
end

function var_0_0.findSkills(arg_96_0, arg_96_1)
	return _.filter(arg_96_0:getSkills(), function(arg_97_0)
		return arg_97_0:GetType() == arg_96_1
	end)
end

function var_0_0.triggerSkill(arg_98_0, arg_98_1)
	return arg_98_0.chapter:triggerSkill(arg_98_0, arg_98_1)
end

function var_0_0.findCommanderBySkillId(arg_99_0, arg_99_1)
	local var_99_0 = arg_99_0:getCommanders()

	for iter_99_0, iter_99_1 in pairs(var_99_0) do
		if _.any(iter_99_1:getSkills(), function(arg_100_0)
			return _.any(arg_100_0:getTacticSkill(), function(arg_101_0)
				return arg_101_0 == arg_99_1
			end)
		end) then
			return iter_99_1
		end
	end
end

function var_0_0.getFleetAirDominanceValue(arg_102_0)
	local var_102_0 = 0

	for iter_102_0, iter_102_1 in ipairs(arg_102_0:getShips(false)) do
		var_102_0 = var_102_0 + calcAirDominanceValue(iter_102_1, arg_102_0:getCommanders())
	end

	return var_102_0
end

function var_0_0.StaticTransformChapterFleet2Fleet(arg_103_0, arg_103_1)
	local var_103_0 = _.pluck(arg_103_0:getShipsByTeam(TeamType.Vanguard, arg_103_1), "id")

	table.insertto(var_103_0, _.pluck(arg_103_0:getShipsByTeam(TeamType.Main, arg_103_1), "id"))

	local var_103_1 = {}

	for iter_103_0, iter_103_1 in pairs(arg_103_0.commanders) do
		table.insert(var_103_1, {
			pos = iter_103_0,
			id = iter_103_1 and iter_103_1.id
		})
	end

	return TypedFleet.New({
		fleetType = FleetType.Normal,
		ship_list = var_103_0,
		commanders = var_103_1
	})
end

return var_0_0
