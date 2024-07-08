local var_0_0 = import(".Chapter")

function var_0_0.update(arg_1_0, arg_1_1)
	assert(arg_1_1.id == arg_1_0.id, "章节ID不一致, 无法更新数据")

	arg_1_0.active = true
	arg_1_0.dueTime = arg_1_1.time
	arg_1_0.loopFlag = arg_1_1.loop_flag
	arg_1_0.modelCount = arg_1_1.model_act_count
	arg_1_0.roundIndex = arg_1_1.round
	arg_1_0.subAutoAttack = arg_1_1.is_submarine_auto_attack
	arg_1_0.barriers = 0
	arg_1_0.pathFinder = OrientedPathFinding.New({}, ChapterConst.MaxRow, ChapterConst.MaxColumn)
	arg_1_0.wallAssets = {}

	if arg_1_0:getConfig("wall_prefab") and #arg_1_0:getConfig("wall_prefab") > 0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0:getConfig("wall_prefab")) do
			arg_1_0.wallAssets[iter_1_1[1] .. "_" .. iter_1_1[2]] = iter_1_1
		end
	end

	arg_1_0.winConditions = {}

	local var_1_0 = arg_1_0:getConfig("win_condition")

	assert(var_1_0, "Assure Chapter's WIN Conditions is not empty")

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		table.insert(arg_1_0.winConditions, {
			type = iter_1_3[1],
			param = iter_1_3[2]
		})
	end

	arg_1_0.loseConditions = {}

	local var_1_1 = arg_1_0:getConfig("lose_condition")

	assert(var_1_1, "Assure Chapter's LOSE Conditions is not empty")

	for iter_1_4, iter_1_5 in pairs(var_1_1) do
		table.insert(arg_1_0.loseConditions, {
			type = iter_1_5[1],
			param = iter_1_5[2]
		})
	end

	arg_1_0.theme = ChapterTheme.New(arg_1_0:getConfig("theme"))

	local var_1_2 = arg_1_1.cell_list
	local var_1_3 = arg_1_1.cell_flag_list
	local var_1_4 = arg_1_0:getConfig("float_items")
	local var_1_5 = arg_1_0:getConfig("grids")

	arg_1_0.cells = {}
	arg_1_0.cellAttachments = {}

	local function var_1_6(arg_2_0)
		local var_2_0 = ChapterCell.Line2Name(arg_2_0.pos.row, arg_2_0.pos.column)

		if arg_2_0.item_type == ChapterConst.AttachStory and arg_2_0.item_data == ChapterConst.StoryTrigger then
			if arg_1_0.cellAttachments[var_2_0] then
				warning("Multi Cell Attachemnts in one cell " .. arg_2_0.pos.row .. " " .. arg_2_0.pos.column)
			end

			arg_1_0.cellAttachments[var_2_0] = ChapterCell.New(arg_2_0)
			arg_2_0 = {
				item_id = 0,
				item_data = 0,
				item_flag = 0,
				pos = {
					row = arg_2_0.pos.row,
					column = arg_2_0.pos.column
				},
				item_type = ChapterConst.AttachNone
			}
		end

		if not arg_1_0.cells[var_2_0] or arg_1_0.cells[var_2_0].attachment == ChapterConst.AttachNone then
			local var_2_1 = ChapterCell.New(arg_2_0)

			if var_2_1.attachment == ChapterConst.AttachOni_Target or var_2_1.attachment == ChapterConst.AttachOni then
				var_2_1.attachment = ChapterConst.AttachNone
			end

			local var_2_2 = _.detect(var_1_4, function(arg_3_0)
				return arg_3_0[1] == var_2_1.row and arg_3_0[2] == var_2_1.column
			end)

			if var_2_2 then
				var_2_1.item = var_2_2[3]
				var_2_1.itemOffset = Vector2(var_2_2[4], var_2_2[5])
			end

			arg_1_0.cells[var_2_0] = var_2_1

			return var_2_1
		end
	end

	_.each(var_1_2, function(arg_4_0)
		var_1_6(arg_4_0)
	end)
	_.each(var_1_5, function(arg_5_0)
		local var_5_0 = ChapterCell.Line2Name(arg_5_0[1], arg_5_0[2])

		;(arg_1_0.cells[var_5_0] or var_1_6({
			pos = {
				row = arg_5_0[1],
				column = arg_5_0[2]
			},
			item_type = ChapterConst.AttachNone
		})):SetWalkable(arg_5_0[3])
	end)

	arg_1_0.indexMin, arg_1_0.indexMax = Vector2(ChapterConst.MaxRow, ChapterConst.MaxColumn), Vector2(-ChapterConst.MaxRow, -ChapterConst.MaxColumn)

	_.each(var_1_5, function(arg_6_0)
		arg_1_0.indexMin.x = math.min(arg_1_0.indexMin.x, arg_6_0[1])
		arg_1_0.indexMin.y = math.min(arg_1_0.indexMin.y, arg_6_0[2])
		arg_1_0.indexMax.x = math.max(arg_1_0.indexMax.x, arg_6_0[1])
		arg_1_0.indexMax.y = math.max(arg_1_0.indexMax.y, arg_6_0[2])
	end)
	_.each(var_1_3 or {}, function(arg_7_0)
		local var_7_0 = ChapterCell.Line2Name(arg_7_0.pos.row, arg_7_0.pos.column)
		local var_7_1 = arg_1_0.cells[var_7_0]

		assert(var_7_1, "Attach cellFlaglist On NIL Cell " .. var_7_0)

		if var_7_1 then
			var_7_1:updateFlagList(arg_7_0)
		end
	end)

	arg_1_0.buff_list = {}

	if arg_1_1.buff_list then
		for iter_1_6, iter_1_7 in ipairs(arg_1_1.buff_list) do
			arg_1_0.buff_list[iter_1_6] = iter_1_7
		end
	end

	arg_1_0.operationBuffList = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.operation_buff) do
		arg_1_0.operationBuffList[#arg_1_0.operationBuffList + 1] = iter_1_9
	end

	local var_1_7 = arg_1_0:getNpcShipByType()

	arg_1_0.fleets = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.group_list) do
		local var_1_8 = ChapterFleet.New(iter_1_11, var_1_7)

		var_1_8:setup(arg_1_0)

		arg_1_0.fleets[iter_1_10] = var_1_8
	end

	arg_1_0.fleets = _.sort(arg_1_0.fleets, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	if arg_1_1.escort_list then
		for iter_1_12, iter_1_13 in ipairs(arg_1_1.escort_list) do
			arg_1_0.fleets[#arg_1_0.fleets + 1] = ChapterTransportFleet.New(iter_1_13, #arg_1_0.fleets + 1)
		end
	end

	arg_1_0.findex = 0
	arg_1_0.findex = arg_1_0:getNextValidIndex()

	if arg_1_0.findex == 0 then
		arg_1_0.findex = 1
	end

	arg_1_0.champions = {}

	if arg_1_1.ai_list then
		for iter_1_14, iter_1_15 in ipairs(arg_1_1.ai_list) do
			if iter_1_15.item_flag ~= 1 then
				local var_1_9 = ChapterChampionPackage.New(iter_1_15)

				arg_1_0:mergeChampion(var_1_9, true)
			end
		end
	end

	arg_1_0.airDominanceStatus = nil
	arg_1_0.extraFlagList = {}

	for iter_1_16, iter_1_17 in ipairs(arg_1_1.extra_flag_list) do
		table.insert(arg_1_0.extraFlagList, iter_1_17)
	end

	arg_1_0.defeatEnemies = arg_1_1.kill_count or 0
	arg_1_0.BaseHP = arg_1_1.chapter_hp or 0
	arg_1_0.orignalShipCount = arg_1_1.init_ship_count or 0
	arg_1_0.combo = arg_1_1.continuous_kill_count or 0
	arg_1_0.scoreHistory = {}

	for iter_1_18 = ys.Battle.BattleConst.BattleScore.D, ys.Battle.BattleConst.BattleScore.S do
		arg_1_0.scoreHistory[iter_1_18] = 0
	end

	if arg_1_1.battle_statistics then
		for iter_1_19, iter_1_20 in ipairs(arg_1_1.battle_statistics) do
			arg_1_0.scoreHistory[iter_1_20.id] = iter_1_20.count
		end
	end

	local var_1_10 = {}

	if arg_1_1.chapter_strategy_list then
		for iter_1_21, iter_1_22 in ipairs(arg_1_1.chapter_strategy_list) do
			var_1_10[iter_1_22.id] = iter_1_22.count
		end
	end

	arg_1_0.strategies = var_1_10
	arg_1_0.duties = {}

	if #arg_1_1.fleet_duties > 0 then
		_.each(arg_1_1.fleet_duties, function(arg_9_0)
			arg_1_0.duties[arg_9_0.key] = arg_9_0.value
		end)
	end

	arg_1_0.moveStep = arg_1_1.move_step_count or 0
	arg_1_0.activateAmbush = not arg_1_0:isLoop() and arg_1_0:GetWillActiveAmbush()
end

function var_0_0.retreat(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.todayDefeatCount = arg_10_0.todayDefeatCount + 1

		arg_10_0:updateTodayDefeatCount()
	end
end

function var_0_0.CleanLevelData(arg_11_0)
	arg_11_0.active = false
	arg_11_0.loopFlag = 0
	arg_11_0.dueTime = nil
	arg_11_0.cells = nil
	arg_11_0.fleets = nil
	arg_11_0.findex = nil
	arg_11_0.champions = nil
	arg_11_0.cellAttachments = nil
	arg_11_0.round = nil
	arg_11_0.airDominanceStatus = nil
	arg_11_0.winConditions, arg_11_0.loseConditions = nil
	arg_11_0.theme = nil
	arg_11_0.buff_list = nil
	arg_11_0.operationBuffList = nil
	arg_11_0.modelCount = nil
	arg_11_0.roundIndex = nil
	arg_11_0.subAutoAttack = nil
	arg_11_0.barriers = nil
	arg_11_0.pathFinder = nil
	arg_11_0.wallAssets = nil
	arg_11_0.strategies = nil
	arg_11_0.duties = nil
	arg_11_0.indexMin, arg_11_0.indexMax = nil
	arg_11_0.extraFlagList = nil
	arg_11_0.defeatEnemies = nil
	arg_11_0.BaseHP = nil
	arg_11_0.orignalShipCount = nil
	arg_11_0.combo = nil
	arg_11_0.scoreHistory = nil
end

function var_0_0.__index(arg_12_0, arg_12_1)
	if arg_12_1 == "fleet" then
		local var_12_0 = rawget(arg_12_0, "fleets")

		if not var_12_0 then
			return nil
		end

		return var_12_0[rawget(arg_12_0, "findex")]
	end

	return rawget(arg_12_0, arg_12_1) or var_0_0[arg_12_1]
end

function var_0_0.GetActiveFleet(arg_13_0)
	if not arg_13_0.fleets then
		return nil
	end

	return arg_13_0.fleets[arg_13_0.findex]
end

function var_0_0.getFleetById(arg_14_0, arg_14_1)
	return _.detect(arg_14_0.fleets, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end)
end

function var_0_0.getChapterSupportFleet(arg_16_0)
	return table.Find(arg_16_0.fleets, function(arg_17_0, arg_17_1)
		return arg_17_1:getFleetType() == FleetType.Support
	end)
end

function var_0_0.getFleetByShipVO(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.id
	local var_18_1

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.fleets) do
		if iter_18_1:getShip(var_18_0) then
			var_18_1 = iter_18_1

			break
		end
	end

	return var_18_1
end

function var_0_0.getRound(arg_19_0)
	return arg_19_0.roundIndex % 2
end

function var_0_0.getRoundNum(arg_20_0)
	return math.floor(arg_20_0.roundIndex / 2)
end

function var_0_0.IncreaseRound(arg_21_0)
	arg_21_0.roundIndex = arg_21_0.roundIndex + 1
end

function var_0_0.existMoveLimit(arg_22_0)
	return arg_22_0:getConfig("is_limit_move") == 1 or arg_22_0:existOni() or arg_22_0:isPlayingWithBombEnemy()
end

function var_0_0.getChapterCell(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = ChapterCell.Line2Name(arg_23_1, arg_23_2)

	return Clone(arg_23_0.cells[var_23_0])
end

function var_0_0.GetRawChapterCell(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = ChapterCell.Line2Name(arg_24_1, arg_24_2)

	return arg_24_0.cells[var_24_0]
end

function var_0_0.FilterCell(arg_25_0, arg_25_1)
	return table.Checkout(arg_25_0.cells, arg_25_1)
end

function var_0_0.findChapterCell(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.cells) do
		if iter_26_1.attachment == arg_26_1 and (not arg_26_2 or iter_26_1.attachmentId == arg_26_2) then
			return iter_26_1
		end
	end

	return nil
end

function var_0_0.findChapterCells(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0.cells) do
		if iter_27_1.attachment == arg_27_1 and (not arg_27_2 or iter_27_1.attachmentId == arg_27_2) then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_0.GetBossCell(arg_28_0)
	return table.Find(arg_28_0.cells, function(arg_29_0, arg_29_1)
		return ChapterConst.IsBossCell(arg_29_1)
	end)
end

function var_0_0.mergeChapterCell(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = ChapterCell.Line2Name(arg_30_1.row, arg_30_1.column)
	local var_30_1 = arg_30_0.cells[var_30_0]
	local var_30_2 = var_30_1 == nil or var_30_1.attachment ~= arg_30_1.attachment or var_30_1.attachmentId ~= arg_30_1.attachmentId

	if var_30_1 then
		var_30_1.attachment = arg_30_1.attachment
		var_30_1.attachmentId = arg_30_1.attachmentId
		var_30_1.flag = arg_30_1.flag
		var_30_1.data = arg_30_1.data
		arg_30_1 = var_30_1
	end

	if not arg_30_2 and var_30_2 and ChapterConst.NeedMarkAsLurk(arg_30_1) then
		arg_30_1.trait = ChapterConst.TraitLurk
	end

	if ChapterConst.IsBossCell(arg_30_1) then
		local var_30_3 = arg_30_0:getChampionIndex(arg_30_1.row, arg_30_1.column)

		if var_30_3 then
			table.remove(arg_30_0.champions, var_30_3)
		end
	end

	arg_30_0:updateChapterCell(arg_30_1)
end

function var_0_0.updateChapterCell(arg_31_0, arg_31_1)
	local var_31_0 = ChapterCell.Line2Name(arg_31_1.row, arg_31_1.column)

	arg_31_0.cells[var_31_0] = Clone(arg_31_1)
end

function var_0_0.clearChapterCell(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = ChapterCell.Line2Name(arg_32_1, arg_32_2)
	local var_32_1 = arg_32_0.cells[var_32_0]

	var_32_1.attachment = ChapterConst.AttachNone
	var_32_1.attachmentId = 0
	var_32_1.flag = ChapterConst.CellFlagActive
	var_32_1.data = 0
	var_32_1.trait = ChapterConst.TraitNone
end

function var_0_0.GetChapterCellAttachemnts(arg_33_0)
	return arg_33_0.cellAttachments
end

function var_0_0.GetRawChapterAttachemnt(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = ChapterCell.Line2Name(arg_34_1, arg_34_2)

	return arg_34_0.cellAttachments[var_34_0]
end

function var_0_0.getShips(arg_35_0)
	local var_35_0 = {}

	_.each(arg_35_0.fleets, function(arg_36_0)
		local var_36_0 = arg_36_0:getShips(true)

		_.each(var_36_0, function(arg_37_0)
			table.insert(var_35_0, Clone(arg_37_0))
		end)
	end)

	return var_35_0
end

function var_0_0.getNextValidIndex(arg_38_0)
	for iter_38_0 = arg_38_0.findex + 1, #arg_38_0.fleets do
		if arg_38_0.fleets[iter_38_0]:getFleetType() == FleetType.Normal and arg_38_0.fleets[iter_38_0]:isValid() then
			return iter_38_0
		end
	end

	for iter_38_1 = 1, arg_38_0.findex - 1 do
		if arg_38_0.fleets[iter_38_1]:getFleetType() == FleetType.Normal and arg_38_0.fleets[iter_38_1]:isValid() then
			return iter_38_1
		end
	end

	return 0
end

function var_0_0.getAmbushRate(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1:getInvestSums()
	local var_39_1 = arg_39_0:getConfig("investigation_ratio")
	local var_39_2 = var_39_1 / (var_39_1 + var_39_0) / 4
	local var_39_3 = _.detect(arg_39_0:getConfig("ambush_ratio_extra"), function(arg_40_0)
		return arg_40_0[1] == arg_39_2.row and arg_40_0[2] == arg_39_2.column
	end)
	local var_39_4 = _.detect(arg_39_0:getConfig("ambush_ratio_extra"), function(arg_41_0)
		return #arg_41_0 == 1
	end)
	local var_39_5

	var_39_5 = var_39_3 and var_39_3[3] / 10000 or 0

	local var_39_6 = var_39_5 + (var_39_4 and var_39_4[1] / 10000 or 0)
	local var_39_7 = 0.05 + var_39_2 * math.max(arg_39_1.step - 1, 0) + var_39_6

	if var_39_6 == 0 then
		var_39_7 = var_39_7 - arg_39_1:getEquipAmbushRateReduce()
	end

	return (math.clamp(var_39_7, 0, 1))
end

function var_0_0.getAmbushDodge(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.line
	local var_42_1 = arg_42_1:getDodgeSums()
	local var_42_2 = var_42_1 / (var_42_1 + arg_42_0:getConfig("avoid_ratio"))
	local var_42_3 = _.detect(arg_42_0:getConfig("ambush_ratio_extra"), function(arg_43_0)
		return arg_43_0[1] == var_42_0.row and arg_43_0[2] == var_42_0.column
	end)
	local var_42_4

	var_42_4 = var_42_3 and var_42_3[3] / 10000 or 0

	if var_42_4 == 0 then
		var_42_2 = var_42_2 + arg_42_1:getEquipDodgeRateUp()
	end

	return (math.clamp(var_42_2, 0, 1))
end

function var_0_0.inWartime(arg_44_0)
	return arg_44_0.dueTime and pg.TimeMgr.GetInstance():GetServerTime() < arg_44_0.dueTime
end

function var_0_0.inActTime(arg_45_0)
	local var_45_0 = arg_45_0:GetBindActID()

	if var_45_0 == 0 then
		return true
	end

	local var_45_1 = var_45_0 and getProxy(ActivityProxy):getActivityById(var_45_0)

	return var_45_1 and not var_45_1:isEnd()
end

function var_0_0.getRemainTime(arg_46_0)
	return arg_46_0.dueTime and math.max(arg_46_0.dueTime - pg.TimeMgr.GetInstance():GetServerTime() - 1, 0) or 0
end

function var_0_0.getStartTime(arg_47_0)
	return math.max(arg_47_0.dueTime - arg_47_0:getConfig("time"), 0)
end

function var_0_0.GetWillActiveAmbush(arg_48_0)
	if not arg_48_0:existAmbush() then
		return false
	end

	local var_48_0 = arg_48_0:getConfig("avoid_require")

	return not _.any(arg_48_0.fleets, function(arg_49_0)
		return arg_49_0:getFleetType() == FleetType.Normal and arg_49_0:getInvestSums(true) >= var_48_0
	end)
end

function var_0_0.findPath(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = {}

	for iter_50_0 = 0, ChapterConst.MaxRow - 1 do
		var_50_0[iter_50_0] = var_50_0[iter_50_0] or {}

		for iter_50_1 = 0, ChapterConst.MaxColumn - 1 do
			var_50_0[iter_50_0][iter_50_1] = var_50_0[iter_50_0][iter_50_1] or {}

			local var_50_1 = PathFinding.PrioForbidden
			local var_50_2 = ChapterConst.ForbiddenAll
			local var_50_3 = ChapterCell.Line2Name(iter_50_0, iter_50_1)
			local var_50_4 = arg_50_0.cells[var_50_3]

			if var_50_4 and var_50_4:IsWalkable() then
				var_50_1 = PathFinding.PrioNormal

				if arg_50_0:considerAsObstacle(arg_50_1, var_50_4.row, var_50_4.column) then
					var_50_1 = PathFinding.PrioObstacle
				end

				if arg_50_1 == ChapterConst.SubjectPlayer then
					var_50_2 = var_50_4.forbiddenDirections
				else
					var_50_2 = ChapterConst.ForbiddenNone
				end
			end

			var_50_0[iter_50_0][iter_50_1].forbiddens = var_50_2
			var_50_0[iter_50_0][iter_50_1].priority = var_50_1
		end
	end

	if arg_50_1 == ChapterConst.SubjectPlayer then
		local var_50_5 = arg_50_0:getCoastalGunArea()

		for iter_50_2, iter_50_3 in ipairs(var_50_5) do
			var_50_0[iter_50_3.row][iter_50_3.column].priority = math.max(var_50_0[iter_50_3.row][iter_50_3.column].priority, PathFinding.PrioObstacle)
		end
	end

	local var_50_6 = var_50_0[arg_50_3.row] and var_50_0[arg_50_3.row][arg_50_3.column]

	if var_50_6 then
		var_50_6.priority = arg_50_0:considerAsStayPoint(arg_50_1, arg_50_3.row, arg_50_3.column) and PathFinding.PrioNormal or PathFinding.PrioObstacle
	end

	arg_50_0.pathFinder.cells = var_50_0

	return arg_50_0.pathFinder:Find(arg_50_2, arg_50_3)
end

function var_0_0.FindBossPath(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = ChapterConst.SubjectPlayer
	local var_51_1 = {}

	for iter_51_0 = 0, ChapterConst.MaxRow - 1 do
		var_51_1[iter_51_0] = var_51_1[iter_51_0] or {}

		for iter_51_1 = 0, ChapterConst.MaxColumn - 1 do
			var_51_1[iter_51_0][iter_51_1] = var_51_1[iter_51_0][iter_51_1] or {}

			local var_51_2 = PathFinding.PrioForbidden
			local var_51_3 = ChapterConst.ForbiddenAll
			local var_51_4
			local var_51_5 = ChapterCell.Line2Name(iter_51_0, iter_51_1)
			local var_51_6 = arg_51_0.cells[var_51_5]

			if var_51_6 and var_51_6:IsWalkable() then
				var_51_2 = PathFinding.PrioNormal

				if arg_51_0:considerAsObstacle(var_51_0, var_51_6.row, var_51_6.column) then
					var_51_2 = PathFinding.PrioObstacle
				end

				local var_51_7 = arg_51_0:GetEnemy(var_51_6.row, var_51_6.column)

				if var_51_7 then
					var_51_2 = PathFinding.PrioNormal
					var_51_4 = not ChapterConst.IsBossCell(var_51_7)
				end

				var_51_3 = var_51_6.forbiddenDirections
			end

			var_51_1[iter_51_0][iter_51_1].forbiddens = var_51_3
			var_51_1[iter_51_0][iter_51_1].priority = var_51_2
			var_51_1[iter_51_0][iter_51_1].isEnemy = var_51_4
		end
	end

	local var_51_8 = arg_51_0:getCoastalGunArea()

	for iter_51_2, iter_51_3 in ipairs(var_51_8) do
		var_51_1[iter_51_3.row][iter_51_3.column].priority = math.max(var_51_1[iter_51_3.row][iter_51_3.column].priority, PathFinding.PrioObstacle)
	end

	local var_51_9 = var_51_1[arg_51_2.row] and var_51_1[arg_51_2.row][arg_51_2.column]

	if var_51_9 then
		var_51_9.priority = arg_51_0:considerAsStayPoint(var_51_0, arg_51_2.row, arg_51_2.column) and PathFinding.PrioNormal or PathFinding.PrioObstacle
	end

	return OrientedWeightPathFinding.StaticFind(var_51_1, ChapterConst.MaxRow, ChapterConst.MaxColumn, arg_51_1, arg_51_2)
end

function var_0_0.getWaveCount(arg_52_0)
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in pairs(arg_52_0.cells) do
		if iter_52_1.attachment == ChapterConst.AttachEnemy and underscore.detect(arg_52_0:getConfig("grids"), function(arg_53_0)
			if arg_53_0[1] == iter_52_1.row and arg_53_0[2] == iter_52_1.column and (arg_53_0[4] == ChapterConst.AttachElite or arg_53_0[4] == ChapterConst.AttachEnemy) then
				return true
			end

			return false
		end) then
			var_52_0 = var_52_0 + 1
		end
	end

	local var_52_1 = 0
	local var_52_2 = pg.chapter_group_refresh[arg_52_0.id]

	if var_52_2 then
		local var_52_3 = 1

		repeat
			local var_52_4 = false

			for iter_52_2, iter_52_3 in ipairs(var_52_2.enemy_refresh) do
				var_52_1 = var_52_1 + (iter_52_3[var_52_3] or 0)
				var_52_4 = var_52_4 or tobool(iter_52_3[var_52_3])
			end

			if var_52_0 <= var_52_1 then
				return var_52_3
			end

			var_52_3 = var_52_3 + 1
		until not var_52_4
	else
		local var_52_5 = arg_52_0:getConfig("enemy_refresh")
		local var_52_6 = arg_52_0:getConfig("elite_refresh")

		for iter_52_4, iter_52_5 in pairs(var_52_5) do
			var_52_1 = var_52_1 + iter_52_5

			if iter_52_4 <= #var_52_6 then
				var_52_1 = var_52_1 + var_52_6[iter_52_4]
			end

			if var_52_0 <= var_52_1 then
				return iter_52_4
			end
		end
	end

	return 1
end

function var_0_0.IsFinalBossRefreshed(arg_54_0)
	return tobool(arg_54_0:findChapterCell(ChapterConst.AttachBoss))
end

function var_0_0.getFleetAmmo(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1:getShipAmmo()
	local var_55_1 = arg_55_1:getFleetType()

	if var_55_1 == FleetType.Normal then
		var_55_0 = var_55_0 + arg_55_0:getConfig("ammo_total")
	elseif var_55_1 == FleetType.Submarine then
		var_55_0 = var_55_0 + arg_55_0:getConfig("ammo_submarine")
	else
		assert(false, "invalide operation.")
	end

	local var_55_2 = arg_55_1.restAmmo

	return var_55_0, var_55_2
end

function var_0_0.GetInteractableStrategies(arg_56_0)
	local var_56_0 = arg_56_0.fleet:getStrategies()
	local var_56_1 = _.filter(var_56_0, function(arg_57_0)
		local var_57_0 = pg.strategy_data_template[arg_57_0.id]

		return var_57_0 and var_57_0.type ~= ChapterConst.StgTypeBindFleetPassive
	end)
	local var_56_2 = arg_56_0.fleet:getFormationStg()

	table.insert(var_56_1, 1, {
		id = var_56_2
	})

	if arg_56_0:GetSubmarineFleet() then
		table.insert(var_56_1, 3, {
			id = ChapterConst.StrategyHuntingRange
		})
		table.insert(var_56_1, 4, {
			id = ChapterConst.StrategySubAutoAttack
		})
		table.insert(var_56_1, 5, {
			id = ChapterConst.StrategySubTeleport
		})
	end

	local var_56_3 = arg_56_0:getChapterSupportFleet()

	if var_56_3 then
		table.insertto(var_56_1, _.filter(var_56_3:getStrategies(), function(arg_58_0)
			local var_58_0 = pg.strategy_data_template[arg_58_0.id]

			return var_58_0 and var_58_0.type == ChapterConst.StgTypeBindSupportConsume
		end))
	end

	if #arg_56_0.strategies > 0 then
		for iter_56_0, iter_56_1 in pairs(arg_56_0.strategies) do
			table.insert(var_56_1, {
				id = iter_56_0,
				count = iter_56_1
			})
		end
	end

	return var_56_1
end

function var_0_0.getFleetStates(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1, var_59_2 = arg_59_0:getFleetAmmo(arg_59_1)

	if var_59_2 >= ChapterConst.AmmoRich then
		table.insert(var_59_0, ChapterConst.StrategyAmmoRich)
	elseif var_59_2 <= ChapterConst.AmmoPoor then
		table.insert(var_59_0, ChapterConst.StrategyAmmoPoor)
	end

	local var_59_3 = underscore.filter(arg_59_1:getStrategies(), function(arg_60_0)
		local var_60_0 = pg.strategy_data_template[arg_60_0.id]

		return var_60_0 and var_60_0.type == ChapterConst.StgTypeBindFleetPassive and arg_60_0.count > 0
	end)

	table.insertto(var_59_0, underscore.map(var_59_3, function(arg_61_0)
		return arg_61_0.id
	end))
	table.insertto(var_59_0, arg_59_1.stgIds)

	local var_59_4 = arg_59_0:getConfig("chapter_strategy")

	for iter_59_0, iter_59_1 in ipairs(var_59_4) do
		table.insert(var_59_0, iter_59_1)
	end

	if OPEN_AIR_DOMINANCE and arg_59_0:getConfig("air_dominance") > 0 then
		table.insert(var_59_0, arg_59_0:getAirDominanceStg())
	end

	for iter_59_2, iter_59_3 in ipairs(arg_59_0:getExtraFlags()) do
		table.insert(var_59_0, ChapterConst.Status2Stg[iter_59_3])
	end

	local var_59_5 = arg_59_0:getOperationBuffDescStg()

	if var_59_5 then
		table.insert(var_59_0, var_59_5)
	end

	underscore.each(arg_59_0.buff_list, function(arg_62_0)
		if ChapterConst.Buff2Stg[arg_62_0] then
			table.insert(var_59_0, ChapterConst.Buff2Stg[arg_62_0])
		end
	end)

	if arg_59_0:getPlayType() == ChapterConst.TypeDOALink then
		local var_59_6 = arg_59_0:GetBuffOfLinkAct()

		if var_59_6 then
			local var_59_7 = pg.gameset.doa_fever_buff.description

			table.insert(var_59_0, pg.gameset.doa_fever_strategy.description[table.indexof(var_59_7, var_59_6)])
		end
	end

	return var_59_0
end

function var_0_0.GetShowingStrategies(arg_63_0)
	local var_63_0 = arg_63_0.fleet
	local var_63_1 = arg_63_0:getFleetStates(var_63_0)

	return (_.filter(var_63_1, function(arg_64_0)
		local var_64_0 = pg.strategy_data_template[arg_64_0]

		return var_64_0 and var_64_0.icon ~= ""
	end))
end

function var_0_0.getAirDominanceStg(arg_65_0)
	local var_65_0, var_65_1 = arg_65_0:getAirDominanceValue()

	return ChapterConst.AirDominance[var_65_1].StgId
end

function var_0_0.getAirDominanceValue(arg_66_0)
	local var_66_0 = 0
	local var_66_1 = 0

	for iter_66_0, iter_66_1 in pairs(arg_66_0.fleets) do
		if iter_66_1:isValid() and (iter_66_1:getFleetType() == FleetType.Normal or iter_66_1:getFleetType() == FleetType.Submarine) then
			var_66_0 = var_66_0 + iter_66_1:getFleetAirDominanceValue()
			var_66_1 = var_66_1 + iter_66_1:getAntiAircraftSums()
		end
	end

	return var_66_0, calcAirDominanceStatus(var_66_0, arg_66_0:getConfig("air_dominance"), var_66_1), arg_66_0.airDominanceStatus
end

function var_0_0.setAirDominanceStatus(arg_67_0, arg_67_1)
	arg_67_0.airDominanceStatus = arg_67_1
end

function var_0_0.updateExtraFlags(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = false

	for iter_68_0, iter_68_1 in ipairs(arg_68_2) do
		for iter_68_2, iter_68_3 in ipairs(arg_68_0.extraFlagList) do
			if iter_68_3 == iter_68_1 then
				table.remove(arg_68_0.extraFlagList, iter_68_2)

				var_68_0 = true

				break
			end
		end
	end

	for iter_68_4, iter_68_5 in ipairs(arg_68_1) do
		if not table.contains(arg_68_0.extraFlagList, iter_68_5) then
			table.insert(arg_68_0.extraFlagList, 1, iter_68_5)

			var_68_0 = true
		end
	end

	return var_68_0
end

function var_0_0.getExtraFlags(arg_69_0)
	local var_69_0 = arg_69_0.extraFlagList

	if #var_69_0 == 0 then
		var_69_0 = ChapterConst.StatusDefaultList
	end

	return var_69_0
end

function var_0_0.UpdateBuffList(arg_70_0, arg_70_1)
	if not arg_70_1 then
		return
	end

	for iter_70_0, iter_70_1 in ipairs(arg_70_1) do
		if not _.include(arg_70_0.buff_list, iter_70_1) then
			table.insert(arg_70_0.buff_list, iter_70_1)
		end
	end
end

function var_0_0.getFleetBattleBuffs(arg_71_0, arg_71_1)
	local var_71_0 = table.shallowCopy(arg_71_0.buff_list)

	_.each(arg_71_0:getFleetStates(arg_71_1), function(arg_72_0)
		local var_72_0 = pg.strategy_data_template[arg_72_0]
		local var_72_1 = var_72_0.buff_id

		if var_72_1 == 0 then
			return
		end

		if var_72_0.buff_type == ChapterConst.StrategyBuffTypeOnlyBoss then
			local var_72_2 = arg_71_0:GetEnemy(arg_71_1.line.row, arg_71_1.line.column)

			if var_72_2 and not ChapterConst.IsBossCell(var_72_2) then
				return
			end
		end

		table.insert(var_71_0, var_72_1)
	end)
	table.insertto(var_71_0, arg_71_0:GetCellEventByKey("attach_buff", arg_71_1.line.row, arg_71_1.line.column) or {})
	_.each(arg_71_0:GetWeather(), function(arg_73_0)
		local var_73_0 = pg.weather_data_template[arg_73_0].effect_args

		if type(var_73_0) == "table" and var_73_0.buff and var_73_0.buff > 0 then
			table.insert(var_71_0, var_73_0.buff)
		end
	end)

	local var_71_1 = arg_71_0:buildBattleBuffList(arg_71_1)

	return var_71_0, var_71_1
end

function var_0_0.GetStageFlags(arg_74_0)
	local var_74_0 = arg_74_0.fleet.line.row
	local var_74_1 = arg_74_0.fleet.line.column

	return arg_74_0:GetCellEventByKey("stage_flags", var_74_0, var_74_1) or {}
end

function var_0_0.GetCellEventByKey(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	arg_75_2 = arg_75_2 or arg_75_0.fleet.line.row
	arg_75_3 = arg_75_3 or arg_75_0.fleet.line.column

	local var_75_0 = ChapterCell.Line2Name(arg_75_2, arg_75_3)
	local var_75_1 = arg_75_0.cells[var_75_0]

	if not var_75_1 then
		return
	end

	return var_0_0.GetEventTemplateByKey(arg_75_1, var_75_1.attachmentId)
end

function var_0_0.GetEventTemplateByKey(arg_76_0, arg_76_1)
	local var_76_0 = pg.map_event_template[arg_76_1]

	if not var_76_0 then
		return
	end

	local var_76_1

	for iter_76_0, iter_76_1 in ipairs(var_76_0.effect) do
		if iter_76_1[1] == arg_76_0 then
			for iter_76_2 = 2, #iter_76_1 do
				var_76_1 = var_76_1 or {}

				table.insert(var_76_1, iter_76_1[iter_76_2])
			end
		end
	end

	return var_76_1
end

function var_0_0.buildBattleBuffList(arg_77_0, arg_77_1)
	local var_77_0 = {}
	local var_77_1, var_77_2 = arg_77_0:triggerSkill(arg_77_1, FleetSkill.TypeBattleBuff)

	if var_77_1 and #var_77_1 > 0 then
		local var_77_3 = {}

		for iter_77_0, iter_77_1 in ipairs(var_77_1) do
			local var_77_4 = var_77_2[iter_77_0]
			local var_77_5 = arg_77_1:findCommanderBySkillId(var_77_4.id)

			var_77_3[var_77_5] = var_77_3[var_77_5] or {}

			table.insert(var_77_3[var_77_5], iter_77_1)
		end

		for iter_77_2, iter_77_3 in pairs(var_77_3) do
			table.insert(var_77_0, {
				iter_77_2,
				iter_77_3
			})
		end
	end

	local var_77_6 = arg_77_1:getCommanders()

	for iter_77_4, iter_77_5 in pairs(var_77_6) do
		local var_77_7 = iter_77_5:getTalents()

		for iter_77_6, iter_77_7 in ipairs(var_77_7) do
			local var_77_8 = iter_77_7:getBuffsAddition()

			if #var_77_8 > 0 then
				local var_77_9

				for iter_77_8, iter_77_9 in ipairs(var_77_0) do
					if iter_77_9[1] == iter_77_5 then
						var_77_9 = iter_77_9[2]

						break
					end
				end

				if not var_77_9 then
					var_77_9 = {}

					table.insert(var_77_0, {
						iter_77_5,
						var_77_9
					})
				end

				for iter_77_10, iter_77_11 in ipairs(var_77_8) do
					table.insert(var_77_9, iter_77_11)
				end
			end
		end
	end

	return var_77_0
end

function var_0_0.updateShipHp(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0.fleet:updateShipHp(arg_78_1, arg_78_2)
end

function var_0_0.updateFleetShipHp(arg_79_0, arg_79_1, arg_79_2)
	for iter_79_0, iter_79_1 in ipairs(arg_79_0.fleets) do
		iter_79_1:updateShipHp(arg_79_1, arg_79_2)

		if iter_79_1.id ~= arg_79_0.fleet.id then
			iter_79_1:clearShipHpChange()
		end
	end
end

function var_0_0.DealDMG2Fleets(arg_80_0, arg_80_1)
	for iter_80_0, iter_80_1 in ipairs(arg_80_0.fleets) do
		iter_80_1:DealDMG2Ships(arg_80_1)
	end
end

function var_0_0.getDragExtend(arg_81_0)
	local var_81_0 = arg_81_0.theme
	local var_81_1 = 99999999
	local var_81_2 = 99999999
	local var_81_3 = 0
	local var_81_4 = 0

	for iter_81_0, iter_81_1 in pairs(arg_81_0.cells) do
		if var_81_1 > iter_81_1.row then
			var_81_1 = iter_81_1.row
		end

		if var_81_3 < iter_81_1.row then
			var_81_3 = iter_81_1.row
		end

		if var_81_2 > iter_81_1.column then
			var_81_2 = iter_81_1.column
		end

		if var_81_4 < iter_81_1.column then
			var_81_4 = iter_81_1.column
		end
	end

	local var_81_5 = (var_81_4 + var_81_2) * 0.5
	local var_81_6 = (var_81_3 + var_81_1) * 0.5
	local var_81_7 = var_81_0.cellSize + var_81_0.cellSpace
	local var_81_8 = math.max((var_81_4 - var_81_5 + 1) * var_81_7.x, 0)
	local var_81_9 = math.max((var_81_5 - var_81_2 + 1) * var_81_7.x, 0)
	local var_81_10 = math.max((var_81_6 - var_81_1 + 1) * var_81_7.y, 0)
	local var_81_11 = math.max((var_81_3 - var_81_6 + 1) * var_81_7.y, 0)

	return var_81_9, var_81_8, var_81_10, var_81_11
end

function var_0_0.getPoisonArea(arg_82_0, arg_82_1)
	local var_82_0 = {}
	local var_82_1 = arg_82_0.theme.cellSize + arg_82_0.theme.cellSpace

	for iter_82_0, iter_82_1 in pairs(arg_82_0.cells) do
		if iter_82_1:checkHadFlag(ChapterConst.FlagPoison) then
			local var_82_2 = math.floor((iter_82_1.column - arg_82_0.indexMin.y) * var_82_1.x * arg_82_1)
			local var_82_3 = math.ceil((iter_82_1.column - arg_82_0.indexMin.y + 1) * var_82_1.x * arg_82_1)
			local var_82_4 = math.floor((iter_82_1.row - arg_82_0.indexMin.x) * var_82_1.y * arg_82_1)
			local var_82_5 = math.ceil((iter_82_1.row - arg_82_0.indexMin.x + 1) * var_82_1.y * arg_82_1)
			local var_82_6 = var_82_3 - var_82_2
			local var_82_7 = var_82_5 - var_82_4

			var_82_0[iter_82_0] = {
				x = var_82_2,
				y = var_82_4,
				w = var_82_6,
				h = var_82_7
			}
		end
	end

	return var_82_0
end

function var_0_0.selectFleets(arg_83_0, arg_83_1)
	local var_83_0 = Clone(arg_83_1) or {}
	local var_83_1 = getProxy(FleetProxy):GetRegularFleets()

	for iter_83_0 = #var_83_0, 1, -1 do
		local var_83_2 = var_83_1[var_83_0[iter_83_0]]

		if not var_83_2 or not var_83_2:isUnlock() or var_83_2:isLegalToFight() ~= true then
			table.remove(var_83_0, iter_83_0)
		end
	end

	local var_83_3 = {
		[FleetType.Normal] = _.filter(var_83_0, function(arg_84_0)
			return var_83_1[arg_84_0]:getFleetType() == FleetType.Normal
		end),
		[FleetType.Submarine] = _.filter(var_83_0, function(arg_85_0)
			return var_83_1[arg_85_0]:getFleetType() == FleetType.Submarine
		end)
	}
	local var_83_4 = arg_83_0:getConfig("group_num")
	local var_83_5 = arg_83_0:getConfig("submarine_num")

	for iter_83_1 = #var_83_3[FleetType.Normal], var_83_4 + 1, -1 do
		table.remove(var_83_3[FleetType.Normal], iter_83_1)
	end

	for iter_83_2 = #var_83_3[FleetType.Submarine], var_83_5 + 1, -1 do
		table.remove(var_83_3[FleetType.Submarine], iter_83_2)
	end

	for iter_83_3, iter_83_4 in pairs(var_83_3) do
		if #iter_83_4 == 0 then
			local var_83_6 = 0

			if iter_83_3 == FleetType.Normal then
				var_83_6 = var_83_4
			elseif iter_83_3 == FleetType.Submarine then
				var_83_6 = var_83_5
			end

			for iter_83_5, iter_83_6 in pairs(var_83_1) do
				if var_83_6 <= #iter_83_4 then
					break
				end

				if iter_83_6 and iter_83_6:getFleetType() == iter_83_3 and iter_83_6:isUnlock() and iter_83_6:isLegalToFight() == true then
					table.insert(iter_83_4, iter_83_5)
				end
			end
		end
	end

	local var_83_7 = {}

	for iter_83_7, iter_83_8 in ipairs(var_83_3) do
		for iter_83_9, iter_83_10 in ipairs(iter_83_8) do
			table.insert(var_83_7, iter_83_10)
		end
	end

	return var_83_7
end

function var_0_0.GetDefaultFleetIndex(arg_86_0)
	local var_86_0 = getProxy(ChapterProxy):GetLastFleetIndex()

	return arg_86_0:selectFleets(var_86_0)
end

function var_0_0.getMaxColumnByRow(arg_87_0, arg_87_1)
	local var_87_0 = -1

	for iter_87_0, iter_87_1 in pairs(arg_87_0.cells) do
		if iter_87_1.row == arg_87_1 then
			var_87_0 = math.max(var_87_0, iter_87_1.column)
		end
	end

	return var_87_0
end

function var_0_0.getFleet(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	return _.detect(arg_88_0.fleets, function(arg_89_0)
		return arg_89_0.line.row == arg_88_2 and arg_89_0.line.column == arg_88_3 and (not arg_88_1 or arg_89_0:getFleetType() == arg_88_1) and arg_89_0:isValid()
	end) or _.detect(arg_88_0.fleets, function(arg_90_0)
		return arg_90_0.line.row == arg_88_2 and arg_90_0.line.column == arg_88_3 and (not arg_88_1 or arg_90_0:getFleetType() == arg_88_1)
	end)
end

function var_0_0.getFleetIndex(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	local var_91_0 = arg_91_0:getFleet(arg_91_1, arg_91_2, arg_91_3)

	if var_91_0 then
		return table.indexof(arg_91_0.fleets, var_91_0)
	end
end

function var_0_0.getOni(arg_92_0)
	return _.detect(arg_92_0.champions, function(arg_93_0)
		return arg_93_0.attachment == ChapterConst.AttachOni
	end)
end

function var_0_0.getChampion(arg_94_0, arg_94_1, arg_94_2)
	return (_.detect(arg_94_0.champions, function(arg_95_0)
		return arg_95_0.row == arg_94_1 and arg_95_0.column == arg_94_2
	end))
end

function var_0_0.getChampionIndex(arg_96_0, arg_96_1, arg_96_2)
	local var_96_0 = arg_96_0:getChampion(arg_96_1, arg_96_2)

	if not var_96_0 then
		return
	end

	return table.indexof(arg_96_0.champions, var_96_0)
end

function var_0_0.getChampionVisibility(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	assert(arg_97_1, "chapter champion not exist.")

	return arg_97_1.flag == ChapterConst.CellFlagActive
end

function var_0_0.mergeChampion(arg_98_0, arg_98_1, arg_98_2)
	local var_98_0 = arg_98_0:getChampionIndex(arg_98_1.row, arg_98_1.column)

	if var_98_0 then
		arg_98_0.champions[var_98_0] = arg_98_1

		return true
	else
		if not arg_98_2 then
			arg_98_1.trait = ChapterConst.TraitLurk
		end

		table.insert(arg_98_0.champions, arg_98_1)

		return false
	end
end

function var_0_0.RemoveChampion(arg_99_0, arg_99_1)
	local var_99_0 = table.indexof(arg_99_0.champions, arg_99_1)

	if var_99_0 then
		table.remove(arg_99_0.champions, var_99_0)
	end
end

function var_0_0.considerAsObstacle(arg_100_0, arg_100_1, arg_100_2, arg_100_3)
	local var_100_0 = arg_100_0:getChapterCell(arg_100_2, arg_100_3)

	if not var_100_0 or not var_100_0:IsWalkable() then
		return true
	end

	if arg_100_0:existBarrier(arg_100_2, arg_100_3) then
		return true
	end

	if arg_100_1 == ChapterConst.SubjectPlayer then
		if var_100_0.flag == ChapterConst.CellFlagActive then
			if ChapterConst.IsEnemyAttach(var_100_0.attachment) then
				return true
			end

			if var_100_0.attachment == ChapterConst.AttachBox then
				local var_100_1 = pg.box_data_template[var_100_0.attachmentId]

				assert(var_100_1, "box_data_template not exist: " .. var_100_0.attachmentId)

				if var_100_1.type == ChapterConst.BoxTorpedo then
					return true
				end
			end

			if var_100_0.attachment == ChapterConst.AttachStory then
				return true
			end
		end

		if arg_100_0:existVisibleChampion(arg_100_2, arg_100_3) then
			return true
		end
	elseif arg_100_1 == ChapterConst.SubjectChampion and arg_100_0:existFleet(FleetType.Normal, arg_100_2, arg_100_3) then
		return true
	end

	return false
end

function var_0_0.considerAsStayPoint(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_0:getChapterCell(arg_101_2, arg_101_3)

	if not var_101_0 or not var_101_0:IsWalkable() then
		return false
	end

	if arg_101_0:existBarrier(arg_101_2, arg_101_3) then
		return false
	end

	if arg_101_1 == ChapterConst.SubjectPlayer then
		if var_101_0.flag == ChapterConst.CellFlagActive and var_101_0.attachment == ChapterConst.AttachStory then
			return true
		end

		if var_101_0.attachment == ChapterConst.AttachLandbase and pg.land_based_template[var_101_0.attachmentId] and pg.land_based_template[var_101_0.attachmentId].type == ChapterConst.LBHarbor then
			return false
		end

		if arg_101_0:existFleet(FleetType.Normal, arg_101_2, arg_101_3) then
			return false
		end

		if arg_101_0:existOni(arg_101_2, arg_101_3) then
			return false
		end

		if arg_101_0:existBombEnemy(arg_101_2, arg_101_3) then
			return false
		end
	elseif arg_101_1 == ChapterConst.SubjectChampion then
		if var_101_0.flag ~= ChapterConst.CellFlagDisabled and var_101_0.attachment ~= ChapterConst.AttachNone then
			return false
		end

		local var_101_1 = arg_101_0:getChampion(arg_101_2, arg_101_3)

		if var_101_1 and var_101_1.flag ~= ChapterConst.CellFlagDisabled then
			return false
		end
	end

	return true
end

function var_0_0.existAny(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = arg_102_0:getChapterCell(arg_102_1, arg_102_2)

	if var_102_0.attachment ~= ChapterConst.AttachNone and var_102_0.flag == ChapterConst.CellFlagActive then
		return true
	end

	if arg_102_0:existFleet(nil, arg_102_1, arg_102_2) then
		return true
	end

	local var_102_1 = arg_102_0:getChampion(arg_102_1, arg_102_2)

	if var_102_1 and var_102_1.flag ~= ChapterConst.CellFlagDisabled then
		return true
	end
end

function var_0_0.existBarrier(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = arg_103_0:getChapterCell(arg_103_1, arg_103_2)

	if var_103_0.attachment == ChapterConst.AttachBox and var_103_0.flag == ChapterConst.CellFlagActive and pg.box_data_template[var_103_0.attachmentId].type == ChapterConst.BoxBarrier then
		return true
	end

	if var_103_0.attachment == ChapterConst.AttachStory and var_103_0.flag == ChapterConst.CellFlagTriggerActive and pg.map_event_template[var_103_0.attachmentId].type == ChapterConst.StoryObstacle then
		return true
	end

	local var_103_1 = arg_103_0:getChampion(arg_103_1, arg_103_2)

	if var_103_1 and var_103_1.flag ~= ChapterConst.CellFlagDisabled then
		local var_103_2 = pg.expedition_data_template[var_103_1.attachmentId]

		if var_103_2 and var_103_2.type == ChapterConst.ExpeditionTypeUnTouchable then
			return true
		end
	end

	return false
end

function var_0_0.GetEnemy(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_0:getChapterCell(arg_104_1, arg_104_2)

	if var_104_0 and var_104_0.flag == ChapterConst.CellFlagActive and ChapterConst.IsEnemyAttach(var_104_0.attachment) then
		return var_104_0
	end

	local var_104_1 = arg_104_0:getChampion(arg_104_1, arg_104_2)

	if var_104_1 and var_104_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_104_1
	end
end

function var_0_0.existEnemy(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	if arg_105_1 == ChapterConst.SubjectPlayer then
		local var_105_0 = arg_105_0:GetEnemy(arg_105_2, arg_105_3)

		if var_105_0 then
			local var_105_1

			if isa(var_105_0, ChapterCell) then
				var_105_1 = var_105_0.attachment
			else
				var_105_1 = ChapterConst.AttachChampion
			end

			return true, var_105_1
		end
	elseif arg_105_1 == ChapterConst.SubjectChampion and (arg_105_0:existFleet(FleetType.Normal, arg_105_2, arg_105_3) or arg_105_0:existFleet(FleetType.Transport, arg_105_2, arg_105_3)) then
		return true
	end
end

function var_0_0.existFleet(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	if _.any(arg_106_0.fleets, function(arg_107_0)
		return arg_107_0.line.row == arg_106_2 and arg_107_0.line.column == arg_106_3 and (not arg_106_1 or arg_107_0:getFleetType() == arg_106_1) and arg_107_0:isValid()
	end) then
		return true
	end
end

function var_0_0.existVisibleChampion(arg_108_0, arg_108_1, arg_108_2)
	local var_108_0 = arg_108_0:getChampion(arg_108_1, arg_108_2)

	return var_108_0 and arg_108_0:getChampionVisibility(var_108_0)
end

function var_0_0.existAlly(arg_109_0, arg_109_1)
	return _.any(arg_109_0.fleets, function(arg_110_0)
		return arg_110_0.id ~= arg_109_1.id and arg_110_0.line.row == arg_109_1.line.row and arg_110_0.line.column == arg_109_1.line.column and arg_110_0:isValid()
	end)
end

function var_0_0.existOni(arg_111_0, arg_111_1, arg_111_2)
	return _.any(arg_111_0.champions, function(arg_112_0)
		return arg_112_0.attachment == ChapterConst.AttachOni and arg_112_0.flag == ChapterConst.CellFlagActive and (not arg_111_1 or arg_111_1 == arg_112_0.row) and (not arg_111_2 or arg_111_2 == arg_112_0.column)
	end)
end

function var_0_0.existBombEnemy(arg_113_0, arg_113_1, arg_113_2)
	if arg_113_1 and arg_113_2 then
		local var_113_0 = arg_113_0:getChapterCell(arg_113_1, arg_113_2)

		return var_113_0.attachment == ChapterConst.AttachBomb_Enemy and var_113_0.flag == ChapterConst.CellFlagActive
	end

	for iter_113_0, iter_113_1 in pairs(arg_113_0.cells) do
		if iter_113_1.attachment == ChapterConst.AttachBomb_Enemy and iter_113_1.flag == ChapterConst.CellFlagActive and (not arg_113_1 or arg_113_1 == iter_113_1.row) and (not arg_113_2 or arg_113_2 == iter_113_1.column) then
			return true
		end
	end

	return false
end

function var_0_0.isPlayingWithBombEnemy(arg_114_0)
	for iter_114_0, iter_114_1 in pairs(arg_114_0.cells) do
		if iter_114_1.attachment == ChapterConst.AttachBomb_Enemy then
			return true
		end
	end

	return false
end

function var_0_0.existCoastalGunNoMatterLiveOrDead(arg_115_0)
	for iter_115_0, iter_115_1 in pairs(arg_115_0.cells) do
		if iter_115_1.attachment == ChapterConst.AttachLandbase then
			local var_115_0 = pg.land_based_template[iter_115_1.attachmentId]

			assert(var_115_0, "land_based_template not exist: " .. iter_115_1.attachmentId)

			if var_115_0.type == ChapterConst.LBCoastalGun then
				return true
			end
		end
	end

	return false
end

local var_0_1 = {
	{
		1,
		0
	},
	{
		-1,
		0
	},
	{
		0,
		1
	},
	{
		0,
		-1
	}
}

function var_0_0.calcWalkableCells(arg_116_0, arg_116_1, arg_116_2, arg_116_3, arg_116_4)
	local var_116_0 = {}

	for iter_116_0 = 0, ChapterConst.MaxRow - 1 do
		if not var_116_0[iter_116_0] then
			var_116_0[iter_116_0] = {}
		end

		for iter_116_1 = 0, ChapterConst.MaxColumn - 1 do
			local var_116_1 = ChapterCell.Line2Name(iter_116_0, iter_116_1)
			local var_116_2 = arg_116_0.cells[var_116_1]

			var_116_0[iter_116_0][iter_116_1] = var_116_2 and var_116_2:IsWalkable()
		end
	end

	local var_116_3 = {}

	if arg_116_1 == ChapterConst.SubjectPlayer then
		local var_116_4 = arg_116_0:getCoastalGunArea()

		for iter_116_2, iter_116_3 in ipairs(var_116_4) do
			var_116_3[iter_116_3.row .. "_" .. iter_116_3.column] = true
		end
	end

	local var_116_5 = {}
	local var_116_6 = arg_116_0:GetRawChapterCell(arg_116_2, arg_116_3)

	if not var_116_6 then
		return var_116_5
	end

	local var_116_7 = {
		{
			step = 0,
			row = arg_116_2,
			column = arg_116_3,
			forbiddens = var_116_6.forbiddenDirections
		}
	}
	local var_116_8 = {}

	while #var_116_7 > 0 do
		local var_116_9 = table.remove(var_116_7, 1)

		table.insert(var_116_8, var_116_9)
		_.each(var_0_1, function(arg_117_0)
			local var_117_0 = {
				row = var_116_9.row + arg_117_0[1],
				column = var_116_9.column + arg_117_0[2],
				step = var_116_9.step + 1
			}
			local var_117_1 = arg_116_0:GetRawChapterCell(var_117_0.row, var_117_0.column)

			if not var_117_1 then
				return
			end

			var_117_0.forbiddens = var_117_1.forbiddenDirections

			if var_117_0.step <= arg_116_4 and not OrientedPathFinding.IsDirectionForbidden(var_116_9, arg_117_0[1], arg_117_0[2]) and not (_.any(var_116_7, function(arg_118_0)
				return arg_118_0.row == var_117_0.row and arg_118_0.column == var_117_0.column
			end) or _.any(var_116_8, function(arg_119_0)
				return arg_119_0.row == var_117_0.row and arg_119_0.column == var_117_0.column
			end)) and var_116_0[var_117_0.row][var_117_0.column] then
				table.insert(var_116_5, var_117_0)

				if not arg_116_0:existEnemy(arg_116_1, var_117_0.row, var_117_0.column) and not arg_116_0:existBarrier(var_117_0.row, var_117_0.column) and not var_116_3[var_117_0.row .. "_" .. var_117_0.column] then
					table.insert(var_116_7, var_117_0)
				end
			end
		end)
	end

	var_116_5 = _.filter(var_116_5, function(arg_120_0)
		return arg_120_0.row == arg_116_2 and arg_120_0.column == arg_116_3 or arg_116_0:considerAsStayPoint(arg_116_1, arg_120_0.row, arg_120_0.column)
	end)

	return var_116_5
end

function var_0_0.calcAreaCells(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4)
	local var_121_0 = {}

	for iter_121_0 = 0, ChapterConst.MaxRow - 1 do
		if not var_121_0[iter_121_0] then
			var_121_0[iter_121_0] = {}
		end

		for iter_121_1 = 0, ChapterConst.MaxColumn - 1 do
			local var_121_1 = ChapterCell.Line2Name(iter_121_0, iter_121_1)
			local var_121_2 = arg_121_0.cells[var_121_1]

			var_121_0[iter_121_0][iter_121_1] = var_121_2 and var_121_2:IsWalkable()
		end
	end

	local var_121_3 = {}
	local var_121_4 = {
		{
			step = 0,
			row = arg_121_1,
			column = arg_121_2
		}
	}
	local var_121_5 = {}

	while #var_121_4 > 0 do
		local var_121_6 = table.remove(var_121_4, 1)

		table.insert(var_121_5, var_121_6)
		_.each(var_0_1, function(arg_122_0)
			local var_122_0 = {
				row = var_121_6.row + arg_122_0[1],
				column = var_121_6.column + arg_122_0[2],
				step = var_121_6.step + 1
			}

			if var_122_0.row >= 0 and var_122_0.row < ChapterConst.MaxRow and var_122_0.column >= 0 and var_122_0.column < ChapterConst.MaxColumn and var_122_0.step <= arg_121_4 and not (_.any(var_121_4, function(arg_123_0)
				return arg_123_0.row == var_122_0.row and arg_123_0.column == var_122_0.column
			end) or _.any(var_121_5, function(arg_124_0)
				return arg_124_0.row == var_122_0.row and arg_124_0.column == var_122_0.column
			end)) then
				table.insert(var_121_4, var_122_0)

				if var_121_0[var_122_0.row][var_122_0.column] and var_122_0.step >= arg_121_3 then
					table.insert(var_121_3, var_122_0)
				end
			end
		end)
	end

	return var_121_3
end

function var_0_0.calcSquareBarrierCells(arg_125_0, arg_125_1, arg_125_2, arg_125_3)
	local var_125_0 = {}

	for iter_125_0 = -arg_125_3, arg_125_3 do
		for iter_125_1 = -arg_125_3, arg_125_3 do
			local var_125_1 = arg_125_1 + iter_125_0
			local var_125_2 = arg_125_2 + iter_125_1
			local var_125_3 = arg_125_0:getChapterCell(var_125_1, var_125_2)

			if var_125_3 and var_125_3:IsWalkable() and (arg_125_0:existBarrier(var_125_1, var_125_2) or not arg_125_0:existAny(var_125_1, var_125_2)) then
				table.insert(var_125_0, {
					row = var_125_1,
					column = var_125_2
				})
			end
		end
	end

	return var_125_0
end

function var_0_0.checkAnyInteractive(arg_126_0)
	local var_126_0 = arg_126_0.fleet.line
	local var_126_1 = arg_126_0:getChapterCell(var_126_0.row, var_126_0.column)
	local var_126_2 = false

	if arg_126_0.fleet:getFleetType() == FleetType.Normal then
		if arg_126_0:existEnemy(ChapterConst.SubjectPlayer, var_126_1.row, var_126_1.column) then
			if arg_126_0:getRound() == ChapterConst.RoundPlayer then
				var_126_2 = true
			end
		elseif var_126_1.attachment == ChapterConst.AttachAmbush or var_126_1.attachment == ChapterConst.AttachBox then
			if var_126_1.flag ~= ChapterConst.CellFlagDisabled then
				var_126_2 = true
			end
		elseif var_126_1.attachment == ChapterConst.AttachStory then
			var_126_2 = var_126_1.flag == ChapterConst.CellFlagActive
		elseif var_126_1.attachment == ChapterConst.AttachSupply and var_126_1.attachmentId > 0 then
			local var_126_3, var_126_4 = arg_126_0:getFleetAmmo(arg_126_0.fleet)

			if var_126_4 < var_126_3 then
				var_126_2 = true
			end
		elseif var_126_1.attachment == ChapterConst.AttachBox and var_126_1.flag ~= ChapterConst.CellFlagDisabled then
			var_126_2 = true
		end
	end

	return var_126_2
end

function var_0_0.getQuadCellPic(arg_127_0, arg_127_1)
	local var_127_0

	if arg_127_1.trait == ChapterConst.TraitLurk then
		-- block empty
	elseif arg_127_1.flag == ChapterConst.CellFlagActive and ChapterConst.IsEnemyAttach(arg_127_1.attachment) and arg_127_1.flag == ChapterConst.CellFlagActive then
		var_127_0 = "cell_enemy"
	elseif arg_127_1.attachment == ChapterConst.AttachBox and arg_127_1.flag == ChapterConst.CellFlagActive then
		local var_127_1 = pg.box_data_template[arg_127_1.attachmentId]

		assert(var_127_1, "box_data_template not exist: " .. arg_127_1.attachmentId)

		if var_127_1.type == ChapterConst.BoxDrop or var_127_1.type == ChapterConst.BoxStrategy or var_127_1.type == ChapterConst.BoxSupply or var_127_1.type == ChapterConst.BoxEnemy then
			var_127_0 = "cell_box"
		elseif var_127_1.type == ChapterConst.BoxTorpedo then
			var_127_0 = "cell_enemy"
		elseif var_127_1.type == ChapterConst.BoxBarrier then
			var_127_0 = "cell_green"
		end
	elseif arg_127_1.attachment == ChapterConst.AttachStory then
		if arg_127_1.flag == ChapterConst.CellFlagTriggerActive then
			local var_127_2 = pg.map_event_template[arg_127_1.attachmentId].grid_color

			var_127_0 = var_127_2 and #var_127_2 > 0 and var_127_2 or nil
		end
	elseif arg_127_1.attachment == ChapterConst.AttachSupply and arg_127_1.attachmentId > 0 then
		var_127_0 = "cell_box"
	elseif arg_127_1.attachment == ChapterConst.AttachTransport_Target then
		var_127_0 = "cell_box"
	elseif arg_127_1.attachment == ChapterConst.AttachLandbase then
		local var_127_3 = pg.land_based_template[arg_127_1.attachmentId]

		if var_127_3 and (var_127_3.type == ChapterConst.LBHarbor or var_127_3.type == ChapterConst.LBDock) then
			var_127_0 = "cell_box"
		end
	end

	return var_127_0
end

function var_0_0.getMapShip(arg_128_0, arg_128_1)
	local var_128_0

	if arg_128_1:isValid() then
		var_128_0 = _.detect(arg_128_1:getShips(false), function(arg_129_0)
			return arg_129_0.isNpc and arg_129_0.hpRant > 0
		end)

		if not var_128_0 then
			local var_128_1 = arg_128_1:getFleetType()

			if var_128_1 == FleetType.Normal then
				var_128_0 = arg_128_1:getShipsByTeam(TeamType.Main, false)[1]
			elseif var_128_1 == FleetType.Submarine then
				var_128_0 = arg_128_1:getShipsByTeam(TeamType.Submarine, false)[1]
			end
		end
	end

	return var_128_0
end

function var_0_0.getStrikeAnimShip(arg_130_0, arg_130_1, arg_130_2)
	return underscore.detect(arg_130_1:getShips(false), function(arg_131_0)
		return arg_131_0:GetMapStrikeAnim() == arg_130_2
	end)
end

function var_0_0.GetSubmarineFleet(arg_132_0)
	return table.Find(arg_132_0.fleets, function(arg_133_0, arg_133_1)
		return arg_133_1:getFleetType() == FleetType.Submarine and arg_133_1:isValid()
	end)
end

function var_0_0.getStageCell(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = arg_134_0:getChampion(arg_134_1, arg_134_2)

	if var_134_0 and var_134_0.flag ~= ChapterConst.CellFlagDisabled then
		return var_134_0
	end

	local var_134_1 = arg_134_0:getChapterCell(arg_134_1, arg_134_2)

	if var_134_1 and var_134_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_134_1
	end
end

function var_0_0.getStageId(arg_135_0, arg_135_1, arg_135_2)
	local var_135_0 = arg_135_0:getChampion(arg_135_1, arg_135_2)

	if var_135_0 and var_135_0.flag ~= ChapterConst.CellFlagDisabled then
		return var_135_0.id
	end

	local var_135_1 = arg_135_0:getChapterCell(arg_135_1, arg_135_2)

	if var_135_1 and var_135_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_135_1.attachmentId
	end
end

function var_0_0.getStageExtraAwards(arg_136_0)
	return
end

function var_0_0.GetExtraCostRate(arg_137_0)
	local var_137_0 = 1
	local var_137_1 = {}

	for iter_137_0, iter_137_1 in ipairs(arg_137_0.operationBuffList) do
		local var_137_2 = pg.benefit_buff_template[iter_137_1]

		var_137_1[#var_137_1 + 1] = var_137_2

		if var_137_2.benefit_type == var_0_0.OPERATION_BUFF_TYPE_COST then
			var_137_0 = var_137_0 + var_137_2.benefit_effect * 0.01
		end
	end

	return math.max(1, var_137_0), var_137_1
end

function var_0_0.getFleetCost(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_0:getPlayType() == ChapterConst.TypeExtra then
		return {
			gold = 0,
			oil = 0
		}, {
			gold = 0,
			oil = 0
		}
	end

	local var_138_0, var_138_1 = arg_138_1:getCost()
	local var_138_2 = arg_138_0:GetLimitOilCost(arg_138_1:getFleetType() == FleetType.Submarine, arg_138_2)

	var_138_1.oil = math.clamp(var_138_2 - var_138_0.oil, 0, var_138_1.oil)

	local var_138_3 = arg_138_0:GetExtraCostRate()

	for iter_138_0, iter_138_1 in ipairs({
		var_138_0,
		var_138_1
	}) do
		for iter_138_2, iter_138_3 in pairs(iter_138_1) do
			iter_138_1[iter_138_2] = iter_138_1[iter_138_2] * var_138_3
		end
	end

	return var_138_0, var_138_1
end

function var_0_0.isOverFleetCost(arg_139_0, arg_139_1, arg_139_2)
	local var_139_0 = arg_139_0:GetLimitOilCost(arg_139_1:getFleetType() == FleetType.Submarine, arg_139_2)
	local var_139_1 = 0

	for iter_139_0, iter_139_1 in ipairs({
		arg_139_1:getCost()
	}) do
		var_139_1 = var_139_1 + iter_139_1.oil
	end

	local var_139_2 = arg_139_0:GetExtraCostRate()

	return var_139_0 < var_139_1, var_139_0 * var_139_2, var_139_1 * var_139_2
end

function var_0_0.writeBack(arg_140_0, arg_140_1, arg_140_2)
	local var_140_0 = arg_140_0.fleet

	local function var_140_1(arg_141_0)
		local var_141_0 = arg_140_2.statistics[arg_141_0.id]

		if not var_141_0 then
			return
		end

		arg_141_0.hpRant = var_141_0.bp
	end

	for iter_140_0, iter_140_1 in pairs(var_140_0.ships) do
		var_140_1(iter_140_1)
	end

	if not arg_140_2.skipAmmo then
		var_140_0.restAmmo = math.max(var_140_0.restAmmo - 1, 0)
	end

	local var_140_2 = _.filter(var_140_0:getStrategies(), function(arg_142_0)
		local var_142_0 = pg.strategy_data_template[arg_142_0.id]

		return var_142_0 and var_142_0.type == ChapterConst.StgTypeBindFleetPassive and arg_142_0.count > 0
	end)

	_.each(var_140_2, function(arg_143_0)
		var_140_0:consumeOneStrategy(arg_143_0.id)
	end)

	if arg_140_2.statistics.submarineAid then
		local var_140_3 = arg_140_0:GetSubmarineFleet()

		if var_140_3 and not var_140_3:inHuntingRange(var_140_0.line.row, var_140_0.line.column) then
			var_140_3:consumeOneStrategy(ChapterConst.StrategyCallSubOutofRange)
		end

		if var_140_3 then
			for iter_140_2, iter_140_3 in pairs(var_140_3.ships) do
				var_140_1(iter_140_3)
			end

			var_140_3.restAmmo = math.max(var_140_3.restAmmo - 1, 0)
		end
	end

	arg_140_0:UpdateComboHistory(arg_140_2.statistics._battleScore)

	if arg_140_1 then
		local var_140_4
		local var_140_5
		local var_140_6 = arg_140_0:getChampion(var_140_0.line.row, var_140_0.line.column)

		if var_140_6 then
			var_140_6:Iter()

			var_140_4 = var_140_6.attachment
			var_140_5 = var_140_6.attachmentId

			if var_140_6.flag == ChapterConst.CellFlagDisabled then
				arg_140_0:RemoveChampion(var_140_6)
			end
		else
			local var_140_7 = arg_140_0:getChapterCell(var_140_0.line.row, var_140_0.line.column)

			var_140_4 = var_140_7.attachment
			var_140_5 = var_140_7.attachmentId

			if var_140_4 == ChapterConst.AttachEnemy or var_140_4 == ChapterConst.AttachBoss then
				var_140_7.flag = ChapterConst.CellFlagDisabled

				arg_140_0:updateChapterCell(var_140_7)
			else
				arg_140_0:clearChapterCell(var_140_7.row, var_140_7.column)
			end
		end

		assert(var_140_4, "attachment can not be nil.")

		if var_140_4 == ChapterConst.AttachEnemy or var_140_4 == ChapterConst.AttachElite or var_140_4 == ChapterConst.AttachChampion then
			if not var_140_6 or var_140_6.flag == ChapterConst.CellFlagDisabled then
				local var_140_8 = _.detect(arg_140_0.achieves, function(arg_144_0)
					return arg_144_0.type == ChapterConst.AchieveType2
				end)

				if var_140_8 then
					var_140_8.count = var_140_8.count + 1
				end
			end
		elseif var_140_4 == ChapterConst.AttachBoss then
			local var_140_9 = _.detect(arg_140_0.achieves, function(arg_145_0)
				return arg_145_0.type == ChapterConst.AchieveType1
			end)

			if var_140_9 then
				var_140_9.count = var_140_9.count + 1
			end
		end

		if arg_140_0:CheckChapterWin() then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_KILL_BOSS)
		end

		if var_140_6 and var_140_6.flag == ChapterConst.CellFlagDisabled or not var_140_6 and var_140_4 ~= ChapterConst.AttachBox then
			var_140_0.defeatEnemies = var_140_0.defeatEnemies + 1
			arg_140_0.defeatEnemies = arg_140_0.defeatEnemies + 1

			local var_140_10 = pg.expedition_data_template[var_140_5]

			if not arg_140_0:isLoop() and var_140_10 and var_140_10.type == ChapterConst.ExpeditionTypeMulBoss then
				local var_140_11 = pg.chapter_model_multistageboss[arg_140_0.id].guild_buff
				local var_140_12 = var_140_0:GetStatusStrategy()

				_.each(var_140_11, function(arg_146_0)
					if not table.contains(var_140_12, arg_146_0) then
						table.insert(var_140_12, arg_146_0)
					end
				end)

				local var_140_13 = arg_140_0:getNextValidIndex()

				if var_140_13 > 0 then
					var_140_12 = arg_140_0.fleets[var_140_13]:GetStatusStrategy()

					_.each(var_140_11, function(arg_147_0)
						table.removebyvalue(var_140_12, arg_147_0)
					end)
				end
			end

			getProxy(ChapterProxy):RecordLastDefeatedEnemy(arg_140_0.id, {
				score = arg_140_2.statistics._battleScore,
				line = {
					row = var_140_0.line.row,
					column = var_140_0.line.column
				},
				attachment = var_140_4,
				attachmentId = var_140_5
			})
		end
	end
end

function var_0_0.CleanCurrentEnemy(arg_148_0)
	local var_148_0 = arg_148_0.fleet.line
	local var_148_1
	local var_148_2 = arg_148_0:getChampion(var_148_0.row, var_148_0.column)

	if var_148_2 then
		var_148_2:Iter()

		if var_148_2.flag == ChapterConst.CellFlagDisabled then
			arg_148_0:RemoveChampion(var_148_2)
		end

		return
	end

	if arg_148_0:getChapterCell(var_148_0.row, var_148_0.column).attachment == ChapterConst.AttachEnemy then
		arg_148_0:clearChapterCell(var_148_0.row, var_148_0.column)

		return
	end
end

function var_0_0.UpdateProgressAfterSkipBattle(arg_149_0)
	arg_149_0:writeBack(true, {
		skipAmmo = true,
		statistics = {
			_battleScore = ys.Battle.BattleConst.BattleScore.S
		}
	})
end

function var_0_0.UpdateProgressOnRetreat(arg_150_0)
	_.each(arg_150_0.achieves, function(arg_151_0)
		if arg_151_0.type == ChapterConst.AchieveType3 then
			if _.all(_.values(arg_150_0.cells), function(arg_152_0)
				if arg_152_0.attachment == ChapterConst.AttachEnemy or arg_152_0.attachment == ChapterConst.AttachElite or arg_152_0.attachment == ChapterConst.AttachBox and pg.box_data_template[arg_152_0.attachmentId].type == ChapterConst.BoxEnemy then
					return arg_152_0.flag == ChapterConst.CellFlagDisabled
				end

				return true
			end) and _.all(arg_150_0.champions, function(arg_153_0)
				return arg_153_0.flag == ChapterConst.CellFlagDisabled
			end) then
				arg_151_0.count = arg_151_0.count + 1
			end
		elseif arg_151_0.type == ChapterConst.AchieveType4 then
			if arg_150_0.orignalShipCount <= arg_151_0.config then
				arg_151_0.count = arg_151_0.count + 1
			end
		elseif arg_151_0.type == ChapterConst.AchieveType5 then
			if not _.any(arg_150_0:getShips(), function(arg_154_0)
				return arg_154_0:getShipType() == arg_151_0.config
			end) then
				arg_151_0.count = arg_151_0.count + 1
			end
		elseif arg_151_0.type == ChapterConst.AchieveType6 then
			local var_151_0 = (arg_150_0.scoreHistory[0] or 0) + (arg_150_0.scoreHistory[1] or 0)

			arg_151_0.count = math.max(var_151_0 <= 0 and arg_150_0.combo or 0, arg_151_0.count or 0)
		end
	end)

	if arg_150_0.progress == 100 then
		arg_150_0.passCount = arg_150_0.passCount + 1
	end

	local var_150_0 = arg_150_0.progress
	local var_150_1 = math.min(arg_150_0.progress + arg_150_0:getConfig("progress_boss"), 100)

	arg_150_0.progress = var_150_1

	if var_150_0 < 100 and var_150_1 >= 100 then
		getProxy(ChapterProxy):RecordJustClearChapters(arg_150_0.id, true)
	end

	arg_150_0.defeatCount = arg_150_0.defeatCount + 1

	local var_150_2 = getProxy(ChapterProxy):getMapById(arg_150_0:getConfig("map")):getMapType()

	if var_150_2 == Map.ELITE then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_HARD_CHAPTER, arg_150_0.id)
	elseif var_150_2 == Map.SCENARIO then
		if arg_150_0.progress == 100 and arg_150_0.passCount == 0 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_HIGHEST_CHAPTER, arg_150_0.id)
		end

		if arg_150_0.defeatCount == 1 then
			if arg_150_0.id == 304 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_3_4)
			elseif arg_150_0.id == 404 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_4_4)
			elseif arg_150_0.id == 504 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_5_4)
			elseif arg_150_0.id == 604 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_6_4)
			elseif arg_150_0.id == 1204 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_12_4)
			elseif arg_150_0.id == 1301 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_1)
			elseif arg_150_0.id == 1302 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_2)
			elseif arg_150_0.id == 1303 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_3)
			elseif arg_150_0.id == 1304 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_4)
			end
		end
	end
end

function var_0_0.UpdateComboHistory(arg_155_0, arg_155_1)
	getProxy(ChapterProxy):RecordComboHistory(arg_155_0.id, {
		scoreHistory = Clone(arg_155_0.scoreHistory),
		combo = Clone(arg_155_0.combo)
	})

	arg_155_0.scoreHistory = arg_155_0.scoreHistory or {}
	arg_155_0.scoreHistory[arg_155_1] = (arg_155_0.scoreHistory[arg_155_1] or 0) + 1

	if arg_155_1 <= ys.Battle.BattleConst.BattleScore.C then
		arg_155_0.combo = 0
	else
		arg_155_0.combo = (arg_155_0.combo or 0) + 1
	end
end

function var_0_0.GetWinConditions(arg_156_0)
	return arg_156_0.winConditions
end

function var_0_0.GetLoseConditions(arg_157_0)
	return arg_157_0.loseConditions
end

function var_0_0.CheckChapterWin(arg_158_0)
	local var_158_0 = arg_158_0:GetWinConditions()
	local var_158_1 = false
	local var_158_2 = ChapterConst.ReasonVictory

	for iter_158_0, iter_158_1 in pairs(var_158_0) do
		if iter_158_1.type == 1 then
			local var_158_3 = arg_158_0:findChapterCells(ChapterConst.AttachBoss)
			local var_158_4 = 0

			_.each(var_158_3, function(arg_159_0)
				if arg_159_0 and arg_159_0.flag == ChapterConst.CellFlagDisabled then
					var_158_4 = var_158_4 + 1
				end
			end)

			var_158_1 = var_158_1 or var_158_4 >= iter_158_1.param
		elseif iter_158_1.type == 2 then
			var_158_1 = var_158_1 or arg_158_0:GetDefeatCount() >= iter_158_1.param
		elseif iter_158_1.type == 3 then
			local var_158_5 = arg_158_0:CheckTransportState()

			var_158_1 = var_158_1 or var_158_5 == 1
		elseif iter_158_1.type == 4 then
			var_158_1 = var_158_1 or arg_158_0:getRoundNum() > iter_158_1.param
		elseif iter_158_1.type == 5 then
			local var_158_6 = iter_158_1.param
			local var_158_7 = _.any(arg_158_0.champions, function(arg_160_0)
				local var_160_0 = arg_160_0.attachmentId == var_158_6

				for iter_160_0, iter_160_1 in pairs(arg_160_0.idList) do
					var_160_0 = var_160_0 or iter_160_1 == var_158_6
				end

				return var_160_0 and arg_160_0.flag ~= ChapterConst.CellFlagDisabled
			end) or _.any(arg_158_0.cells, function(arg_161_0)
				return arg_161_0.attachmentId == var_158_6 and arg_161_0.flag ~= ChapterConst.CellFlagDisabled
			end)

			var_158_1 = var_158_1 or not var_158_7
		elseif iter_158_1.type == 6 then
			local var_158_8 = iter_158_1.param
			local var_158_9 = _.any(arg_158_0.fleets, function(arg_162_0)
				return arg_162_0:getFleetType() == FleetType.Normal and arg_162_0:isValid() and arg_162_0.line.row == var_158_8[1] and arg_162_0.line.column == var_158_8[2]
			end)

			var_158_1 = var_158_1 or var_158_9
		end

		if var_158_1 then
			break
		end
	end

	return var_158_1, var_158_2
end

function var_0_0.CheckChapterLose(arg_163_0)
	local var_163_0 = arg_163_0:GetLoseConditions()
	local var_163_1 = false
	local var_163_2 = ChapterConst.ReasonDefeat

	for iter_163_0, iter_163_1 in pairs(var_163_0) do
		if iter_163_1.type == 1 then
			local var_163_3 = _.any(arg_163_0.fleets, function(arg_164_0)
				return arg_164_0:getFleetType() == FleetType.Normal and arg_164_0:isValid()
			end)

			var_163_1 = var_163_1 or not var_163_3
		elseif iter_163_1.type == 2 then
			var_163_1 = var_163_1 or arg_163_0.BaseHP <= 0
			var_163_2 = var_163_1 and ChapterConst.ReasonDefeatDefense or var_163_2
		end

		if var_163_1 then
			break
		end
	end

	if arg_163_0:getPlayType() == ChapterConst.TypeTransport then
		local var_163_4 = arg_163_0:CheckTransportState()

		var_163_1 = var_163_1 or var_163_4 == -1
	end

	return var_163_1, var_163_2
end

function var_0_0.CheckChapterWillWin(arg_165_0)
	if arg_165_0:existOni() or arg_165_0:isPlayingWithBombEnemy() then
		return true
	end

	if arg_165_0:CheckChapterWin() then
		return true
	end
end

function var_0_0.triggerSkill(arg_166_0, arg_166_1, arg_166_2)
	local var_166_0 = _.filter(arg_166_1:findSkills(arg_166_2), function(arg_167_0)
		local var_167_0 = arg_167_0:GetTriggers()

		return _.any(var_167_0, function(arg_168_0)
			return arg_168_0[1] == FleetSkill.TriggerInSubTeam and arg_168_0[2] == 1
		end) == (arg_166_1:getFleetType() == FleetType.Submarine) and _.all(arg_167_0:GetTriggers(), function(arg_169_0)
			return arg_166_0:triggerCheck(arg_166_1, arg_167_0, arg_169_0)
		end)
	end)

	return _.reduce(var_166_0, nil, function(arg_170_0, arg_170_1)
		local var_170_0 = arg_170_1:GetType()
		local var_170_1 = arg_170_1:GetArgs()

		if var_170_0 == FleetSkill.TypeMoveSpeed or var_170_0 == FleetSkill.TypeHuntingLv or var_170_0 == FleetSkill.TypeTorpedoPowerUp then
			return (arg_170_0 or 0) + var_170_1[1]
		elseif var_170_0 == FleetSkill.TypeAmbushDodge or var_170_0 == FleetSkill.TypeAirStrikeDodge then
			return math.max(arg_170_0 or 0, var_170_1[1])
		elseif var_170_0 == FleetSkill.TypeAttack or var_170_0 == FleetSkill.TypeStrategy then
			arg_170_0 = arg_170_0 or {}

			table.insert(arg_170_0, var_170_1)

			return arg_170_0
		elseif var_170_0 == FleetSkill.TypeBattleBuff then
			arg_170_0 = arg_170_0 or {}

			table.insert(arg_170_0, var_170_1[1])

			return arg_170_0
		end
	end), var_166_0
end

function var_0_0.triggerCheck(arg_171_0, arg_171_1, arg_171_2, arg_171_3)
	local var_171_0 = arg_171_3[1]

	if var_171_0 == FleetSkill.TriggerDDHead then
		local var_171_1 = arg_171_1:getShipsByTeam(TeamType.Vanguard, false)

		return #var_171_1 > 0 and ShipType.IsTypeQuZhu(var_171_1[1]:getShipType())
	elseif var_171_0 == FleetSkill.TriggerVanCount then
		local var_171_2 = arg_171_1:getShipsByTeam(TeamType.Vanguard, false)

		return #var_171_2 >= arg_171_3[2] and #var_171_2 <= arg_171_3[3]
	elseif var_171_0 == FleetSkill.TriggerShipCount then
		local var_171_3 = _.filter(arg_171_1:getShips(false), function(arg_172_0)
			return table.contains(arg_171_3[2], arg_172_0:getShipType())
		end)

		return #var_171_3 >= arg_171_3[3] and #var_171_3 <= arg_171_3[4]
	elseif var_171_0 == FleetSkill.TriggerAroundEnemy then
		local var_171_4 = {
			row = arg_171_1.line.row,
			column = arg_171_1.line.column
		}

		return _.any(_.values(arg_171_0.cells), function(arg_173_0)
			local var_173_0 = arg_171_0:GetEnemy(arg_173_0.row, arg_173_0.column)

			if not var_173_0 then
				return
			end

			local var_173_1 = pg.expedition_data_template[var_173_0.attachmentId]

			if not var_173_1 then
				return
			end

			local var_173_2 = var_173_1.type

			return ManhattonDist(var_171_4, {
				row = arg_173_0.row,
				column = arg_173_0.column
			}) <= arg_171_3[2] and (type(arg_171_3[3]) == "number" and arg_171_3[3] == var_173_2 or type(arg_171_3[3]) == "table" and table.contains(arg_171_3[3], var_173_2))
		end)
	elseif var_171_0 == FleetSkill.TriggerNekoPos then
		local var_171_5 = arg_171_1:findCommanderBySkillId(arg_171_2.id)

		for iter_171_0, iter_171_1 in pairs(arg_171_1:getCommanders()) do
			if var_171_5.id == iter_171_1.id and iter_171_0 == arg_171_3[2] then
				return true
			end
		end
	elseif var_171_0 == FleetSkill.TriggerAroundLand then
		local var_171_6 = {
			row = arg_171_1.line.row,
			column = arg_171_1.line.column
		}

		return _.any(_.values(arg_171_0.cells), function(arg_174_0)
			return not arg_174_0:IsWalkable() and ManhattonDist(var_171_6, {
				row = arg_174_0.row,
				column = arg_174_0.column
			}) <= arg_171_3[2]
		end)
	elseif var_171_0 == FleetSkill.TriggerAroundCombatAlly then
		local var_171_7 = {
			row = arg_171_1.line.row,
			column = arg_171_1.line.column
		}

		return _.any(arg_171_0.fleets, function(arg_175_0)
			return arg_171_1.id ~= arg_175_0.id and arg_175_0:getFleetType() == FleetType.Normal and arg_171_0:existEnemy(ChapterConst.SubjectPlayer, arg_175_0.line.row, arg_175_0.line.column) and ManhattonDist(var_171_7, {
				row = arg_175_0.line.row,
				column = arg_175_0.line.column
			}) <= arg_171_3[2]
		end)
	elseif var_171_0 == FleetSkill.TriggerInSubTeam then
		return true
	else
		assert(false, "invalid trigger type: " .. var_171_0)
	end
end

local var_0_2 = {
	{
		1,
		0
	},
	{
		-1,
		0
	},
	{
		0,
		1
	},
	{
		0,
		-1
	}
}

function var_0_0.checkOniState(arg_176_0)
	local var_176_0 = arg_176_0:getOni()

	assert(var_176_0, "oni not exist.")

	if _.all(var_0_2, function(arg_177_0)
		local var_177_0 = {
			var_176_0.row + arg_177_0[1],
			var_176_0.column + arg_177_0[2]
		}

		if arg_176_0:existFleet(FleetType.Normal, var_177_0[1], var_177_0[2]) then
			return true
		end

		local var_177_1 = arg_176_0:getChapterCell(var_177_0[1], var_177_0[2])

		if not var_177_1 or not var_177_1:IsWalkable() then
			return true
		end

		if arg_176_0:existBarrier(var_177_1.row, var_177_1.column) then
			return true
		end
	end) then
		return 1
	end

	local var_176_1 = arg_176_0:getOniChapterInfo().escape_grids

	if _.any(var_176_1, function(arg_178_0)
		return arg_178_0[1] == var_176_0.row and arg_178_0[2] == var_176_0.column
	end) then
		return 2
	end
end

function var_0_0.onOniEnter(arg_179_0)
	for iter_179_0, iter_179_1 in pairs(arg_179_0.cells) do
		iter_179_1.attachment = ChapterConst.AttachNone
		iter_179_1.attachmentId = nil
		iter_179_1.flag = nil
		iter_179_1.data = nil
	end

	arg_179_0.champions = {}
	arg_179_0.modelCount = arg_179_0:getOniChapterInfo().special_item
	arg_179_0.roundIndex = 0
end

function var_0_0.onBombEnemyEnter(arg_180_0)
	for iter_180_0, iter_180_1 in pairs(arg_180_0.cells) do
		iter_180_1.attachment = ChapterConst.AttachNone
		iter_180_1.attachmentId = nil
		iter_180_1.flag = nil
		iter_180_1.data = nil
	end

	arg_180_0.champions = {}
	arg_180_0.modelCount = 0
	arg_180_0.roundIndex = 0
end

function var_0_0.clearSubmarineFleet(arg_181_0)
	for iter_181_0 = #arg_181_0.fleets, 1, -1 do
		if arg_181_0.fleets[iter_181_0]:getFleetType() == FleetType.Submarine then
			table.remove(arg_181_0.fleets, iter_181_0)
		end
	end
end

function var_0_0.getSpAppearStory(arg_182_0)
	if arg_182_0:existOni() then
		for iter_182_0, iter_182_1 in ipairs(arg_182_0.champions) do
			if iter_182_1.trait == ChapterConst.TraitLurk and iter_182_1.attachment == ChapterConst.AttachOni then
				local var_182_0 = iter_182_1:getConfig("appear_story")

				if var_182_0 and #var_182_0 > 0 then
					return var_182_0
				end
			end
		end
	elseif arg_182_0:isPlayingWithBombEnemy() then
		for iter_182_2, iter_182_3 in pairs(arg_182_0.cells) do
			if iter_182_3.attachment == ChapterConst.AttachBomb_Enemy and iter_182_3.trait == ChapterConst.TraitLurk then
				local var_182_1 = pg.specialunit_template[iter_182_3.attachmentId]

				if var_182_1.appear_story and #var_182_1.appear_story > 0 then
					return var_182_1.appear_story
				end
			end
		end
	end
end

function var_0_0.getSpAppearGuide(arg_183_0)
	if arg_183_0:existOni() then
		for iter_183_0, iter_183_1 in ipairs(arg_183_0.champions) do
			if iter_183_1.trait == ChapterConst.TraitLurk and iter_183_1.attachment == ChapterConst.AttachOni then
				local var_183_0 = iter_183_1:getConfig("appear_guide")

				if var_183_0 and #var_183_0 > 0 then
					return var_183_0
				end
			end
		end
	elseif arg_183_0:isPlayingWithBombEnemy() then
		for iter_183_2, iter_183_3 in pairs(arg_183_0.cells) do
			if iter_183_3.attachment == ChapterConst.AttachBomb_Enemy and iter_183_3.trait == ChapterConst.TraitLurk then
				local var_183_1 = pg.specialunit_template[iter_183_3.attachmentId]

				if var_183_1.appear_guide and #var_183_1.appear_guide > 0 then
					return var_183_1.appear_guide
				end
			end
		end
	end
end

function var_0_0.CheckTransportState(arg_184_0)
	local var_184_0 = _.detect(arg_184_0.fleets, function(arg_185_0)
		return arg_185_0:getFleetType() == FleetType.Transport
	end)

	if not var_184_0 then
		return -1
	end

	local var_184_1 = arg_184_0:findChapterCell(ChapterConst.AttachTransport_Target)

	assert(var_184_0, "transport fleet not exist.")
	assert(var_184_1, "transport target not exist.")

	if not var_184_0:isValid() then
		return -1
	elseif var_184_0.line.row == var_184_1.row and var_184_0.line.column == var_184_1.column and not arg_184_0:existEnemy(ChapterConst.SubjectPlayer, var_184_1.row, var_184_1.column) then
		return 1
	else
		return 0
	end
end

function var_0_0.getCoastalGunArea(arg_186_0)
	local var_186_0 = {}

	for iter_186_0, iter_186_1 in pairs(arg_186_0.cells) do
		if iter_186_1.attachment == ChapterConst.AttachLandbase and iter_186_1.flag ~= ChapterConst.CellFlagDisabled then
			local var_186_1 = pg.land_based_template[iter_186_1.attachmentId]

			if var_186_1.type == ChapterConst.LBCoastalGun then
				local var_186_2 = var_186_1.function_args
				local var_186_3 = {
					math.abs(var_186_2[1]),
					math.abs(var_186_2[2])
				}
				local var_186_4 = {
					Mathf.Sign(var_186_2[1]),
					Mathf.Sign(var_186_2[2])
				}
				local var_186_5 = math.max(var_186_3[1], var_186_3[2])

				for iter_186_2 = 1, var_186_5 do
					table.insert(var_186_0, {
						row = iter_186_1.row + math.min(var_186_3[1], iter_186_2) * var_186_4[1],
						column = iter_186_1.column + math.min(var_186_3[2], iter_186_2) * var_186_4[2]
					})
				end
			end
		end
	end

	return var_186_0
end

function var_0_0.GetAntiAirGunArea(arg_187_0)
	local var_187_0 = {}
	local var_187_1 = {}

	for iter_187_0, iter_187_1 in pairs(arg_187_0.cells) do
		if iter_187_1.attachment == ChapterConst.AttachLandbase and iter_187_1.flag ~= ChapterConst.CellFlagDisabled then
			local var_187_2 = pg.land_based_template[iter_187_1.attachmentId]

			if var_187_2.type == ChapterConst.LBAntiAir then
				local var_187_3 = var_187_2.function_args
				local var_187_4 = math.abs(var_187_3[1])

				local function var_187_5(arg_188_0, arg_188_1)
					return ChapterConst.MaxColumn * arg_188_0 + arg_188_1
				end

				local var_187_6 = {}
				local var_187_7 = {}

				if var_187_4 > 0 then
					var_187_6[var_187_5(iter_187_1.row, iter_187_1.column)] = iter_187_1
				end

				while next(var_187_6) do
					local var_187_8 = next(var_187_6)
					local var_187_9 = var_187_6[var_187_8]

					var_187_6[var_187_8] = nil

					if var_187_4 >= math.abs(var_187_9.row - iter_187_1.row) and var_187_4 >= math.abs(var_187_9.column - iter_187_1.column) then
						var_187_7[var_187_8] = var_187_9

						for iter_187_2 = 1, #var_0_2 do
							local var_187_10 = var_187_9.row + var_0_2[iter_187_2][1]
							local var_187_11 = var_187_9.column + var_0_2[iter_187_2][2]
							local var_187_12 = var_187_5(var_187_10, var_187_11)

							if not var_187_7[var_187_12] then
								var_187_6[var_187_12] = {
									row = var_187_10,
									column = var_187_11
								}
							end
						end
					end
				end

				for iter_187_3, iter_187_4 in pairs(var_187_7) do
					var_187_1[iter_187_3] = iter_187_4
				end
			end
		end
	end

	for iter_187_5, iter_187_6 in pairs(var_187_1) do
		table.insert(var_187_0, iter_187_6)
	end

	return var_187_0
end

function var_0_0.GetDefeatCount(arg_189_0)
	return arg_189_0.defeatEnemies
end

function var_0_0.ExistDivingChampion(arg_190_0)
	return _.any(arg_190_0.champions, function(arg_191_0)
		return arg_191_0.flag == ChapterConst.CellFlagDiving
	end)
end

function var_0_0.IsSkipPrecombat(arg_192_0)
	return arg_192_0:isLoop() and getProxy(ChapterProxy):GetSkipPrecombat()
end

function var_0_0.CanActivateAutoFight(arg_193_0)
	local var_193_0 = pg.chapter_template_loop[arg_193_0.id]

	return var_193_0 and var_193_0.fightauto == 1 and arg_193_0:isLoop() and AutoBotCommand.autoBotSatisfied() and not arg_193_0:existOni() and not arg_193_0:existBombEnemy()
end

function var_0_0.IsAutoFight(arg_194_0)
	return arg_194_0:CanActivateAutoFight() and getProxy(ChapterProxy):GetChapterAutoFlag(arg_194_0.id) == 1
end

function var_0_0.getOperationBuffDescStg(arg_195_0)
	for iter_195_0, iter_195_1 in ipairs(arg_195_0.operationBuffList) do
		if pg.benefit_buff_template[iter_195_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			return iter_195_1
		end
	end
end

function var_0_0.GetOperationDesc(arg_196_0)
	local var_196_0 = ""

	for iter_196_0, iter_196_1 in ipairs(arg_196_0.operationBuffList) do
		local var_196_1 = pg.benefit_buff_template[iter_196_1]

		if var_196_1.benefit_type == var_0_0.OPERATION_BUFF_TYPE_DESC then
			var_196_0 = var_196_1.desc

			break
		end
	end

	return var_196_0
end

function var_0_0.GetOperationBuffList(arg_197_0)
	return arg_197_0.operationBuffList
end

function var_0_0.GetAllEnemies(arg_198_0, arg_198_1)
	local var_198_0 = {}

	for iter_198_0, iter_198_1 in pairs(arg_198_0.cells) do
		if ChapterConst.IsEnemyAttach(iter_198_1.attachment) and (arg_198_1 or iter_198_1.flag ~= ChapterConst.CellFlagDisabled) then
			table.insert(var_198_0, iter_198_1)
		end
	end

	for iter_198_2, iter_198_3 in pairs(arg_198_0.champions) do
		if arg_198_1 or iter_198_3.flag ~= ChapterConst.CellFlagDisabled then
			table.insert(var_198_0, iter_198_3)
		end
	end

	return var_198_0
end

function var_0_0.GetFleetofDuty(arg_199_0, arg_199_1)
	local var_199_0

	for iter_199_0, iter_199_1 in ipairs(arg_199_0.fleets) do
		if iter_199_1:isValid() and iter_199_1:getFleetType() == FleetType.Normal then
			local var_199_1 = arg_199_0.duties[iter_199_1.id] or 0

			if var_199_1 == ChapterFleet.DUTY_KILLALL or arg_199_1 and var_199_1 == ChapterFleet.DUTY_KILLBOSS or not arg_199_1 and var_199_1 == ChapterFleet.DUTY_CLEANPATH then
				return iter_199_1
			end

			var_199_0 = iter_199_1
		end
	end

	return var_199_0
end

function var_0_0.GetBuffOfLinkAct(arg_200_0)
	if arg_200_0:getPlayType() == ChapterConst.TypeDOALink then
		local var_200_0 = pg.gameset.doa_fever_buff.description

		return _.detect(arg_200_0.buff_list, function(arg_201_0)
			return table.contains(var_200_0, arg_201_0)
		end)
	end
end

function var_0_0.GetAttachmentStories(arg_202_0)
	local var_202_0 = arg_202_0.cellAttachments
	local var_202_1 = 0
	local var_202_2

	for iter_202_0, iter_202_1 in pairs(var_202_0) do
		local var_202_3 = var_0_0.GetEventTemplateByKey("mult_story", iter_202_1.attachmentId)

		if var_202_3 then
			assert(not var_202_2 or table.equal(var_202_2, var_202_3[1]), "Not the same Config of Mult_story ID: " .. iter_202_1.attachmentId)

			var_202_2 = var_202_2 or var_202_3[1]

			local var_202_4 = arg_202_0.cells[iter_202_0]

			if var_202_4 and var_202_4.flag == ChapterConst.CellFlagDisabled then
				var_202_1 = var_202_1 + 1
			end
		end
	end

	return var_202_2, var_202_1
end

function var_0_0.GetWeather(arg_203_0, arg_203_1, arg_203_2)
	arg_203_1 = arg_203_1 or arg_203_0.fleet.line.row
	arg_203_2 = arg_203_2 or arg_203_0.fleet.line.column

	local var_203_0 = ChapterCell.Line2Name(arg_203_1, arg_203_2)
	local var_203_1 = arg_203_0.cells[var_203_0]

	return var_203_1 and var_203_1:GetWeatherFlagList() or {}
end

function var_0_0.getDisplayEnemyCount(arg_204_0)
	local var_204_0 = 0

	local function var_204_1(arg_205_0)
		if arg_205_0.flag ~= ChapterConst.CellFlagDisabled then
			var_204_0 = var_204_0 + 1
		end
	end

	local var_204_2 = {
		[ChapterConst.AttachEnemy] = var_204_1,
		[ChapterConst.AttachElite] = var_204_1,
		[ChapterConst.AttachBox] = function(arg_206_0)
			if pg.box_data_template[arg_206_0.attachmentId].type == ChapterConst.BoxEnemy then
				var_204_1(arg_206_0)
			end
		end
	}

	for iter_204_0, iter_204_1 in pairs(arg_204_0.cells) do
		switch(iter_204_1.attachment, var_204_2, nil, iter_204_1)
	end

	for iter_204_2, iter_204_3 in ipairs(arg_204_0.champions) do
		var_204_1(iter_204_3)
	end

	return var_204_0
end

function var_0_0.getNearestEnemyCell(arg_207_0)
	local function var_207_0(arg_208_0, arg_208_1)
		return (arg_208_0.row - arg_208_1.row) * (arg_208_0.row - arg_208_1.row) + (arg_208_0.column - arg_208_1.column) * (arg_208_0.column - arg_208_1.column)
	end

	local var_207_1

	local function var_207_2(arg_209_0)
		if arg_209_0.flag ~= ChapterConst.CellFlagDisabled and (not var_207_1 or var_207_0(arg_207_0.fleet.line, arg_209_0) < var_207_0(arg_207_0.fleet.line, var_207_1)) then
			var_207_1 = arg_209_0
		end
	end

	local var_207_3 = {
		[ChapterConst.AttachEnemy] = var_207_2,
		[ChapterConst.AttachElite] = var_207_2,
		[ChapterConst.AttachBox] = function(arg_210_0)
			if pg.box_data_template[arg_210_0.attachmentId].type == ChapterConst.BoxEnemy then
				var_207_2(arg_210_0)
			end
		end
	}

	for iter_207_0, iter_207_1 in pairs(arg_207_0.cells) do
		switch(iter_207_1.attachment, var_207_3, nil, iter_207_1)
	end

	for iter_207_2, iter_207_3 in ipairs(arg_207_0.champions) do
		var_207_2(iter_207_3)
	end

	return var_207_1
end

function var_0_0.GetRegularFleetIds(arg_211_0)
	return (_.map(_.filter(arg_211_0.fleets, function(arg_212_0)
		local var_212_0 = arg_212_0:getFleetType()

		return var_212_0 == FleetType.Normal or var_212_0 == FleetType.Submarine
	end), function(arg_213_0)
		return arg_213_0.fleetId
	end))
end

return var_0_0
