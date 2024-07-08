﻿local var_0_0 = class("CommanderCatUtil")

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(FleetProxy):GetRegularFleets()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1:getCommanders()) do
			local var_1_1 = iter_1_1.id % 10

			arg_1_1[iter_1_3.id].sub = iter_1_1:isSubmarineFleet()
			arg_1_1[iter_1_3.id].fleetId = var_1_1
			arg_1_1[iter_1_3.id].inFleet = true
		end
	end
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(FleetProxy)
	local var_2_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	assert(var_2_1 and not var_2_1:isEnd())

	local var_2_2 = var_2_0:getActivityFleets()[var_2_1.id]

	for iter_2_0, iter_2_1 in pairs(var_2_2) do
		local var_2_3 = iter_2_1:isSubmarineFleet()
		local var_2_4 = iter_2_1.id % 10

		for iter_2_2, iter_2_3 in pairs(iter_2_1:getCommanders()) do
			arg_2_1[iter_2_3.id].sub = var_2_3
			arg_2_1[iter_2_3.id].fleetId = var_2_4
			arg_2_1[iter_2_3.id].inFleet = true
		end
	end
end

local function var_0_3(arg_3_0, arg_3_1)
	assert(arg_3_0.chapterId)

	local var_3_0 = getProxy(ChapterProxy):getChapterById(arg_3_0.chapterId)

	for iter_3_0, iter_3_1 in pairs(var_3_0:getEliteFleetCommanders()) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			arg_3_1[iter_3_3].sub = false
			arg_3_1[iter_3_3].fleetId = iter_3_0
			arg_3_1[iter_3_3].inFleet = true
		end
	end
end

local function var_0_4(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(FleetProxy)
	local var_4_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	assert(var_4_1 and not var_4_1:isEnd())

	local var_4_2 = var_4_0:getActivityFleets()[var_4_1.id]

	for iter_4_0, iter_4_1 in pairs(var_4_2) do
		local var_4_3 = iter_4_1:isSubmarineFleet()
		local var_4_4 = iter_4_1.id % 10

		for iter_4_2, iter_4_3 in pairs(iter_4_1:getCommanders()) do
			arg_4_1[iter_4_3.id].sub = var_4_3
			arg_4_1[iter_4_3.id].fleetId = var_4_4
			arg_4_1[iter_4_3.id].inFleet = true
		end
	end
end

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	assert(var_5_0)

	local var_5_1 = var_5_0:GetBossMission():GetFleets()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		local var_5_2 = arg_5_0.fleets[iter_5_0] or iter_5_1
		local var_5_3 = not var_5_2:IsMainFleet()

		for iter_5_2, iter_5_3 in pairs(var_5_2:getCommanders()) do
			arg_5_1[iter_5_3.id].sub = var_5_3
			arg_5_1[iter_5_3.id].fleetId = 1
			arg_5_1[iter_5_3.id].inFleet = true
		end
	end
end

local function var_0_6(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = nowWorld():BuildFormationIds()

	if arg_6_0.fleets then
		var_6_1 = arg_6_0.fleets
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_2 = FleetType.Submarine == iter_6_0

		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			local var_6_3 = Fleet.New({
				ship_list = {},
				commanders = iter_6_3.commanders
			})

			for iter_6_4, iter_6_5 in pairs(var_6_3:getCommanders()) do
				arg_6_1[iter_6_5.id].sub = var_6_2
				arg_6_1[iter_6_5.id].fleetId = iter_6_2
				arg_6_1[iter_6_5.id].inFleet = true
			end
		end
	end
end

local function var_0_7(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.fleets

	assert(var_7_0)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_1 = iter_7_0 == #var_7_0

		for iter_7_2, iter_7_3 in pairs(iter_7_1:getCommanders()) do
			arg_7_1[iter_7_3.id].sub = var_7_1
			arg_7_1[iter_7_3.id].fleetId = iter_7_1.id
			arg_7_1[iter_7_3.id].inFleet = true
		end
	end
end

local function var_0_8(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(FleetProxy)
	local var_8_1 = _.map({
		FleetProxy.CHALLENGE_FLEET_ID,
		FleetProxy.CHALLENGE_SUB_FLEET_ID
	}, function(arg_9_0)
		return var_8_0:getFleetById(arg_9_0)
	end)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		local var_8_2 = iter_8_1:isSubmarineFleet()
		local var_8_3 = iter_8_1.id

		for iter_8_2, iter_8_3 in pairs(iter_8_1:getCommanders()) do
			arg_8_1[iter_8_3.id].sub = var_8_2
			arg_8_1[iter_8_3.id].fleetId = var_8_3
			arg_8_1[iter_8_3.id].inFleet = true
		end
	end
end

function var_0_0.GetCommanderList(arg_10_0)
	local var_10_0 = getProxy(CommanderProxy):getData()

	if CommanderCatScene.FLEET_TYPE_COMMON == arg_10_0.fleetType then
		var_0_1(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_ACTBOSS == arg_10_0.fleetType then
		var_0_2(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_HARD_CHAPTER == arg_10_0.fleetType then
		var_0_3(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_CHALLENGE == arg_10_0.fleetType then
		var_0_4(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_GUILDBOSS == arg_10_0.fleetType then
		var_0_5(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_WORLD == arg_10_0.fleetType then
		var_0_6(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_BOSSRUSH == arg_10_0.fleetType then
		var_0_7(arg_10_0, var_10_0)
	elseif CommanderCatScene.FLEET_TYPE_LIMIT_CHALLENGE == arg_10_0.fleetType then
		var_0_8(arg_10_0, var_10_0)
	end

	local var_10_1 = getProxy(ChapterProxy):getActiveChapter()

	if var_10_1 then
		_.each(var_10_1.fleets, function(arg_11_0)
			local var_11_0 = arg_11_0:getCommanders()

			for iter_11_0, iter_11_1 in pairs(arg_11_0:getCommanders()) do
				var_10_0[iter_11_1.id].inBattle = true
			end
		end)
	end

	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.ignoredIds or {}) do
		var_10_2[iter_10_1] = true
	end

	local var_10_3 = {}

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		if not var_10_2[iter_10_2] then
			table.insert(var_10_3, iter_10_3)
		end
	end

	return var_10_3
end

function var_0_0.GetSkillExpAndCommanderExp(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = getProxy(CommanderProxy)

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		local var_12_3 = var_12_2:getCommanderById(iter_12_1)

		var_12_1 = var_12_1 + var_12_3:getDestoryedExp(arg_12_0.groupId)
		var_12_0 = var_12_0 + var_12_3:getDestoryedSkillExp(arg_12_0.groupId)
	end

	return math.floor(var_12_1), math.floor(var_12_0)
end

function var_0_0.AnySSRCommander(arg_13_0)
	local var_13_0 = getProxy(CommanderProxy)

	if _.any(arg_13_0, function(arg_14_0)
		return var_13_0:RawGetCommanderById(arg_14_0):getRarity() >= 5
	end) then
		return true
	end

	return false
end

function var_0_0.CalcCommanderConsume(arg_15_0)
	local var_15_0 = getProxy(CommanderProxy)
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
		local var_15_2 = var_15_0:RawGetCommanderById(iter_15_1)

		assert(var_15_2, iter_15_1)

		var_15_1 = var_15_1 + var_15_2:getUpgradeConsume()
	end

	return math.floor(var_15_1)
end

function var_0_0.SetActive(arg_16_0, arg_16_1)
	local var_16_0 = GetOrAddComponent(arg_16_0, typeof(CanvasGroup))

	var_16_0.alpha = arg_16_1 and 1 or 0
	var_16_0.blocksRaycasts = arg_16_1
end

function var_0_0.CommanderInChapter(arg_17_0)
	local var_17_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_17_0 then
		local var_17_1 = var_17_0.fleets

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			local var_17_2 = iter_17_1:getCommanders()

			if _.any(_.values(var_17_2), function(arg_18_0)
				return arg_18_0.id == arg_17_0.id
			end) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetAllTalentNames()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(pg.commander_ability_group.all) do
		local var_19_1 = pg.commander_ability_group[iter_19_1]

		if var_19_1.ability_list and #var_19_1.ability_list > 0 then
			local var_19_2 = var_19_1.ability_list[1]
			local var_19_3 = pg.commander_ability_template[var_19_2].name

			table.insert(var_19_0, {
				id = var_19_1.id,
				name = var_19_3
			})
		end
	end

	return var_19_0
end

function var_0_0.ShortenString(arg_20_0, arg_20_1)
	local function var_20_0(arg_21_0)
		if not arg_21_0 then
			return 0, 1
		elseif arg_21_0 > 240 then
			return 4, 1
		elseif arg_21_0 > 225 then
			return 3, 1
		elseif arg_21_0 > 192 then
			return 2, 1
		elseif arg_21_0 < 126 then
			return 1, 0.75
		else
			return 1, 1
		end
	end

	local var_20_1 = 1
	local var_20_2 = 0
	local var_20_3 = 0
	local var_20_4 = #arg_20_0
	local var_20_5 = false

	while var_20_1 <= var_20_4 do
		local var_20_6 = string.byte(arg_20_0, var_20_1)
		local var_20_7, var_20_8 = var_20_0(var_20_6)

		var_20_1 = var_20_1 + var_20_7
		var_20_2 = var_20_2 + var_20_8

		local var_20_9 = math.ceil(var_20_2)

		if var_20_9 == arg_20_1 - 1 then
			var_20_3 = var_20_1
		elseif arg_20_1 < var_20_9 then
			var_20_5 = true

			break
		end
	end

	if var_20_3 == 0 or var_20_4 < var_20_3 or not var_20_5 then
		return arg_20_0
	end

	return string.sub(arg_20_0, 1, var_20_3 - 1) .. ".."
end

return var_0_0
