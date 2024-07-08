local var_0_0 = class("BaseFormation")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._mainTf = arg_1_1
	arg_1_0._heroContainer = arg_1_2
	arg_1_0._heroInfoTpl = arg_1_3
	arg_1_0._gridTFs = arg_1_4
	arg_1_0._widthRate = rtf(arg_1_0._mainTf).rect.width / UnityEngine.Screen.width
	arg_1_0._heightRate = rtf(arg_1_0._mainTf).rect.height / UnityEngine.Screen.height
	arg_1_0._halfWidth = rtf(arg_1_0._mainTf).rect.width / 2
	arg_1_0._halfHeight = rtf(arg_1_0._mainTf).rect.height / 2
	arg_1_0._offset = arg_1_0._heroContainer.localPosition
	arg_1_0._eventTriggers = {}

	pg.DelegateInfo.New(arg_1_0)
end

function var_0_0.SetFleetVO(arg_2_0, arg_2_1)
	arg_2_0._currentFleetVO = arg_2_1
end

function var_0_0.SetShipVOs(arg_3_0, arg_3_1)
	arg_3_0._shipVOs = arg_3_1
end

function var_0_0.DisableTip(arg_4_0)
	arg_4_0._disableTip = true
end

function var_0_0.ForceDropChar(arg_5_0)
	if arg_5_0._currentDragDelegate then
		arg_5_0._forceDropCharacter = true

		LuaHelper.triggerEndDrag(arg_5_0._currentDragDelegate)
	end
end

function var_0_0.AddHeroInfoModify(arg_6_0, arg_6_1)
	arg_6_0._heroInfoModifyCb = arg_6_1
end

function var_0_0.AddLongPress(arg_7_0, arg_7_1)
	arg_7_0._longPressCb = arg_7_1
end

function var_0_0.AddClick(arg_8_0, arg_8_1)
	arg_8_0._click = arg_8_1
end

function var_0_0.AddBeginDrag(arg_9_0, arg_9_1)
	arg_9_0._beginDrag = arg_9_1
end

function var_0_0.AddEndDrag(arg_10_0, arg_10_1)
	arg_10_0._endDrag = arg_10_1
end

function var_0_0.AddShiftOnly(arg_11_0, arg_11_1)
	arg_11_0._shiftOnly = arg_11_1
end

function var_0_0.AddRemoveShip(arg_12_0, arg_12_1)
	arg_12_0._removeShip = arg_12_1
end

function var_0_0.AddCheckRemove(arg_13_0, arg_13_1)
	arg_13_0._checkRemove = arg_13_1
end

function var_0_0.AddSwitchToDisplayMode(arg_14_0, arg_14_1)
	arg_14_0._switchToDisplayModeHandler = arg_14_1
end

function var_0_0.AddSwitchToShiftMode(arg_15_0, arg_15_1)
	arg_15_0._switchToShiftModeHandler = arg_15_1
end

function var_0_0.AddSwitchToPreviewMode(arg_16_0, arg_16_1)
	arg_16_0._swtichToPreviewModeHandler = arg_16_1
end

function var_0_0.AddGridTipClick(arg_17_0, arg_17_1)
	arg_17_0._gridTipClick = arg_17_1
end

function var_0_0.AddLoadComplete(arg_18_0, arg_18_1)
	arg_18_0._loadComplete = arg_18_1
end

function var_0_0.GenCharInfo(arg_19_0, arg_19_1, arg_19_2)
	return {
		heroInfoTF = arg_19_1,
		spineRole = arg_19_2
	}
end

function var_0_0.ClearHeroContainer(arg_20_0)
	if arg_20_0._characterList then
		arg_20_0:RecycleCharacterList(arg_20_0._currentFleetVO:getTeamByName(TeamType.Main), arg_20_0._characterList[TeamType.Main])
		arg_20_0:RecycleCharacterList(arg_20_0._currentFleetVO:getTeamByName(TeamType.Vanguard), arg_20_0._characterList[TeamType.Vanguard])
		arg_20_0:RecycleCharacterList(arg_20_0._currentFleetVO:getTeamByName(TeamType.Submarine), arg_20_0._characterList[TeamType.Submarine])
	end

	removeAllChildren(arg_20_0._heroContainer)
end

function var_0_0.LoadAllCharacter(arg_21_0)
	arg_21_0:ClearHeroContainer()

	arg_21_0._characterList = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}

	local function var_21_0(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		if arg_21_0._exited then
			return
		end

		local var_22_0 = arg_21_0._shipVOs[arg_22_1]
		local var_22_1 = tf(Instantiate(arg_21_0._heroInfoTpl))

		var_22_1:SetParent(arg_21_0._heroContainer, false)
		SetActive(var_22_1, true)
		arg_22_0:SetParent(var_22_1)
		arg_22_0:SetRaycastTarget(false)
		arg_22_0:SetLocalScale(Vector3(0.8, 0.8, 1))
		arg_22_0:SetLayer(Layer.UI)
		arg_22_0.modelRoot.transform:SetAsFirstSibling()

		if arg_21_0._heroInfoModifyCb ~= nil then
			arg_21_0._heroInfoModifyCb(var_22_1, var_22_0, arg_22_0)
		end

		local var_22_2 = arg_21_0:GenCharInfo(var_22_1, arg_22_0)
		local var_22_3 = arg_21_0._characterList[arg_22_2]

		var_22_3[arg_22_3] = var_22_2

		local var_22_4, var_22_5, var_22_6 = arg_22_0:CreateInterface()

		arg_21_0._eventTriggers[var_22_6] = true

		pg.DelegateInfo.Add(arg_21_0, var_22_5.onLongPressed)

		var_22_5.longPressThreshold = 1

		var_22_5.onLongPressed:RemoveAllListeners()
		var_22_5.onLongPressed:AddListener(function()
			if arg_21_0._longPressCb ~= nil then
				arg_21_0._longPressCb(var_22_1, var_22_0, arg_21_0._currentFleetVO, arg_22_2)
			end
		end)
		pg.DelegateInfo.Add(arg_21_0, var_22_4.onModelClick)
		var_22_4.onModelClick:AddListener(function()
			if arg_21_0._click ~= nil then
				arg_21_0._click(var_22_0, arg_22_2, arg_21_0._currentFleetVO)
			end
		end)
		var_22_6:AddBeginDragFunc(function()
			if arg_21_0._modelDrag then
				return
			end

			arg_21_0._modelDrag = arg_22_0.modelRoot
			arg_21_0._currentDragDelegate = var_22_6

			LeanTween.cancel(arg_22_0.modelRoot)
			var_22_1:SetAsLastSibling()
			arg_21_0:SwitchToShiftMode(var_22_1, arg_22_2)
			arg_22_0:SetAction("tuozhuai")

			if arg_21_0._beginDrag then
				arg_21_0._beginDrag(var_22_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_DRAG)
		end)
		var_22_6:AddDragFunc(function(arg_26_0, arg_26_1)
			if arg_21_0._modelDrag ~= arg_22_0.modelRoot then
				return
			end

			var_22_1.localPosition = Vector3(arg_26_1.position.x * arg_21_0._widthRate - arg_21_0._halfWidth - arg_21_0._offset.x, arg_26_1.position.y * arg_21_0._heightRate - arg_21_0._halfHeight - arg_21_0._offset.y, -22)
		end)
		var_22_6:AddDragEndFunc(function(arg_27_0, arg_27_1)
			if arg_21_0._modelDrag ~= arg_22_0.modelRoot then
				return
			end

			arg_21_0._modelDrag = false

			local var_27_0 = arg_21_0._forceDropCharacter

			arg_21_0._forceDropCharacter = nil
			arg_21_0._currentDragDelegate = nil

			arg_22_0:SetAction("stand")

			local function var_27_1()
				arg_21_0:SwitchToDisplayMode()
				arg_21_0:SortSiblingIndex()

				if arg_21_0._shiftOnly ~= nil then
					arg_21_0._shiftOnly(arg_21_0._currentFleetVO)
				end
			end

			if var_27_0 then
				var_27_1()

				return
			end

			local function var_27_2()
				for iter_29_0, iter_29_1 in ipairs(var_22_3) do
					if iter_29_1.heroInfoTF == var_22_1 then
						iter_29_1.spineRole:Dispose()
						var_22_1.gameObject:Destroy()
						table.remove(var_22_3, iter_29_0)

						break
					end
				end

				arg_21_0:SwitchToDisplayMode()
				arg_21_0:SortSiblingIndex()

				if arg_21_0._removeShip ~= nil then
					arg_21_0._removeShip(var_22_0, arg_21_0._currentFleetVO)
				end
			end

			local var_27_3, var_27_4 = arg_21_0:GetShipPos(arg_21_0._currentFleetVO, var_22_0)

			if arg_27_1.position.x < UnityEngine.Screen.width * 0.15 or arg_27_1.position.x > UnityEngine.Screen.width * 0.87 or arg_27_1.position.y < UnityEngine.Screen.height * 0.18 or arg_27_1.position.y > UnityEngine.Screen.height * 0.7 then
				if arg_21_0._checkRemove ~= nil then
					arg_21_0._checkRemove(var_27_1, var_27_2, var_22_0, arg_21_0._currentFleetVO, var_27_4)
				end
			else
				var_27_1()
			end

			if arg_21_0._endDrag ~= nil then
				arg_21_0._endDrag(var_22_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_PUT)
		end)
		arg_21_0:SetCharacterPos(arg_22_2, arg_22_3, var_22_2)
	end

	local var_21_1 = {}

	local function var_21_2(arg_30_0, arg_30_1)
		for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
			table.insert(var_21_1, function(arg_31_0)
				local var_31_0 = SpineRole.New(arg_21_0._shipVOs[iter_30_1])

				var_31_0:Load(function()
					var_21_0(var_31_0, iter_30_1, arg_30_1, iter_30_0)
					arg_31_0()
				end)
			end)
		end
	end

	local var_21_3 = arg_21_0._currentFleetVO:getFleetType()

	if var_21_3 == FleetType.Normal then
		var_21_2(arg_21_0._currentFleetVO:getTeamByName(TeamType.Vanguard), TeamType.Vanguard)
		var_21_2(arg_21_0._currentFleetVO:getTeamByName(TeamType.Main), TeamType.Main)
	elseif var_21_3 == FleetType.Submarine then
		var_21_2(arg_21_0._currentFleetVO:getTeamByName(TeamType.Submarine), TeamType.Submarine)
	end

	pg.UIMgr.GetInstance():LoadingOn()
	parallelAsync(var_21_1, function(arg_33_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_21_0._exited then
			return
		end

		arg_21_0:SortSiblingIndex()

		if arg_21_0._loadComplete then
			arg_21_0._loadComplete()
		end
	end)
end

function var_0_0.GetShipPos(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_2 then
		return
	end

	local var_34_0 = arg_34_2:getTeamType()
	local var_34_1 = arg_34_1:getTeamByName(var_34_0)

	return table.indexof(var_34_1, arg_34_2.id) or -1, var_34_0
end

function var_0_0.SetAllCharacterPos(arg_35_0)
	local var_35_0 = {
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}

	_.each(var_35_0, function(arg_36_0)
		for iter_36_0, iter_36_1 in ipairs(arg_35_0._characterList[arg_36_0]) do
			arg_35_0:SetCharacterPos(arg_36_0, iter_36_0, iter_36_1)
		end
	end)
end

function var_0_0.SetCharacterPos(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	assert(arg_37_0._gridTFs[arg_37_1], "没有找到编队显示对象_teamType:" .. tostring(arg_37_1))

	local var_37_0 = arg_37_3.heroInfoTF
	local var_37_1 = arg_37_3.spineRole
	local var_37_2 = var_37_1.modelRoot
	local var_37_3 = arg_37_0._gridTFs[arg_37_1][arg_37_2]
	local var_37_4 = var_37_3.localPosition

	LeanTween.cancel(var_37_2)

	var_37_0.localPosition = Vector3(var_37_4.x, var_37_4.y, -15 + var_37_4.z + arg_37_2)
	var_37_2.transform.localPosition = Vector3(0, 20, 0)

	LeanTween.moveY(rtf(var_37_2), 0, 0.5):setDelay(0.5)
	SetActive(var_37_3:Find("shadow"), true)
	var_37_1:SetAction("stand")
end

function var_0_0.ResetGrid(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0._gridTFs[arg_38_1] then
		return
	end

	local var_38_0 = arg_38_0._currentFleetVO:getTeamByName(arg_38_1)

	assert(var_38_0, arg_38_1)

	local var_38_1 = arg_38_0._gridTFs[arg_38_1]

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		SetActive(iter_38_1:Find("shadow"), false)
		SetActive(iter_38_1:Find("tip"), false)
	end

	if arg_38_1 == TeamType.Main and #arg_38_0._currentFleetVO:getTeamByName(TeamType.Vanguard) == 0 then
		return
	end

	local var_38_2 = #var_38_0

	if var_38_2 < 3 then
		local var_38_3 = var_38_1[var_38_2 + 1]:Find("tip")

		var_38_3:GetComponent("Button").enabled = true

		onButton(arg_38_0, var_38_3, function()
			if arg_38_0._gridTipClick then
				arg_38_0._gridTipClick(arg_38_1, arg_38_0._currentFleetVO)
			end
		end, SFX_PANEL)

		var_38_3.localScale = Vector3(0, 0, 1)

		if not arg_38_0._disableTip then
			SetActive(var_38_3, not arg_38_2)
		end

		LeanTween.value(go(var_38_3), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_40_0)
			var_38_3.localScale = Vector3(arg_40_0, arg_40_0, 1)
		end)):setEase(LeanTweenType.easeOutBack)
	end
end

function var_0_0.SwitchToShiftMode(arg_41_0, arg_41_1, arg_41_2)
	assert(arg_41_0._gridTFs[arg_41_2], "没有找到编队显示对象_teamType:" .. tostring(arg_41_2))

	if arg_41_0._switchToShiftModeHandler then
		arg_41_0._switchToShiftModeHandler()
	end

	for iter_41_0 = 1, 3 do
		local var_41_0 = {
			TeamType.Vanguard,
			TeamType.Main,
			TeamType.Submarine
		}

		_.each(var_41_0, function(arg_42_0)
			if arg_41_0._gridTFs[arg_42_0] and arg_41_0._gridTFs[arg_42_0][iter_41_0] then
				setActive(arg_41_0._gridTFs[arg_42_0][iter_41_0]:Find("tip"), false)
			end
		end)
		setActive(arg_41_0._gridTFs[arg_41_2][iter_41_0]:Find("shadow"), false)
	end

	local var_41_1 = arg_41_0._characterList[arg_41_2]

	for iter_41_1, iter_41_2 in ipairs(var_41_1) do
		local var_41_2 = iter_41_2.heroInfoTF
		local var_41_3 = iter_41_2.spineRole
		local var_41_4 = var_41_3.modelRoot

		if var_41_2 ~= arg_41_1 then
			LeanTween.moveY(rtf(var_41_4), var_41_4.transform.localPosition.y + 20, 0.5)

			local var_41_5, var_41_6, var_41_7 = var_41_3:GetInterface()

			arg_41_0._eventTriggers[var_41_7] = true

			var_41_7:AddPointEnterFunc(function()
				for iter_43_0, iter_43_1 in ipairs(var_41_1) do
					if iter_43_1.heroInfoTF == var_41_2 then
						arg_41_0:Shift(arg_41_0._shiftIndex, iter_43_0, arg_41_2)

						break
					end
				end
			end)
		else
			arg_41_0._shiftIndex = iter_41_1

			var_41_3:DisableInterface()
		end

		var_41_3:SetAction("normal")
	end
end

function var_0_0.SwitchToDisplayMode(arg_44_0)
	if arg_44_0._switchToDisplayModeHandler then
		arg_44_0._switchToDisplayModeHandler()
	end

	local function var_44_0(arg_45_0)
		for iter_45_0, iter_45_1 in ipairs(arg_45_0) do
			local var_45_0 = iter_45_1.heroInfoTF
			local var_45_1 = iter_45_1.spineRole
			local var_45_2 = var_45_1.modelRoot
			local var_45_3, var_45_4, var_45_5 = var_45_1:GetInterface()

			if var_45_5 then
				arg_44_0._eventTriggers[var_45_5] = true

				if var_45_5 then
					var_45_5:RemovePointEnterFunc()
				end
			end
		end
	end

	arg_44_0:TurnOffPreviewMode()
	var_44_0(arg_44_0._characterList[TeamType.Vanguard])
	var_44_0(arg_44_0._characterList[TeamType.Main])
	var_44_0(arg_44_0._characterList[TeamType.Submarine])

	arg_44_0._shiftIndex = nil
end

function var_0_0.SwitchToPreviewMode(arg_46_0)
	if arg_46_0._swtichToPreviewModeHandler then
		arg_46_0._swtichToPreviewModeHandler()
	end

	arg_46_0:ResetGrid(TeamType.Vanguard, true)
	arg_46_0:ResetGrid(TeamType.Main, true)
	arg_46_0:ResetGrid(TeamType.Submarine, true)
	arg_46_0:SetAllCharacterPos()
	arg_46_0:SetEnableForSpineInterface(false)
end

function var_0_0.TurnOffPreviewMode(arg_47_0)
	arg_47_0:ResetGrid(TeamType.Vanguard)
	arg_47_0:ResetGrid(TeamType.Main)
	arg_47_0:ResetGrid(TeamType.Submarine)
	arg_47_0:SetAllCharacterPos()
	arg_47_0:SetEnableForSpineInterface(true)
end

function var_0_0.SetEnableForSpineInterface(arg_48_0, arg_48_1)
	local var_48_0 = {
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}

	_.each(var_48_0, function(arg_49_0)
		for iter_49_0, iter_49_1 in ipairs(arg_48_0._characterList[arg_49_0]) do
			if arg_48_1 then
				iter_49_1.spineRole:EnableInterface()
			else
				iter_49_1.spineRole:DisableInterface()
			end
		end
	end)
end

function var_0_0.Shift(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	assert(arg_50_0._gridTFs[arg_50_3], "没有找到编队显示对象_teamType:" .. tostring(arg_50_3))

	local var_50_0 = arg_50_0._characterList[arg_50_3]
	local var_50_1 = arg_50_0._gridTFs[arg_50_3]
	local var_50_2 = var_50_0[arg_50_2]
	local var_50_3 = var_50_2.heroInfoTF
	local var_50_4 = var_50_2.spineRole.modelRoot
	local var_50_5 = var_50_1[arg_50_1].localPosition

	var_50_3.localPosition = Vector3(var_50_5.x, var_50_5.y + 20, -15 + var_50_5.z + arg_50_1)

	local var_50_6 = var_50_0[arg_50_1].spineRole.ship.id
	local var_50_7 = var_50_0[arg_50_2].spineRole.ship.id

	LeanTween.cancel(var_50_4)

	var_50_0[arg_50_1], var_50_0[arg_50_2] = var_50_0[arg_50_2], var_50_0[arg_50_1]

	arg_50_0._currentFleetVO:switchShip(arg_50_3, arg_50_1, arg_50_2, var_50_6, var_50_7)

	arg_50_0._shiftIndex = arg_50_2
end

function var_0_0.SortSiblingIndex(arg_51_0)
	local var_51_0 = 0
	local var_51_1 = {
		2,
		1,
		3
	}

	for iter_51_0, iter_51_1 in ipairs(var_51_1) do
		local var_51_2 = arg_51_0._characterList[TeamType.Main][iter_51_1]

		if var_51_2 then
			local var_51_3 = var_51_2.heroInfoTF

			tf(var_51_3):SetSiblingIndex(var_51_0)

			var_51_0 = var_51_0 + 1
		end
	end

	local var_51_4 = 3

	while var_51_4 > 0 do
		local var_51_5 = arg_51_0._characterList[TeamType.Vanguard][var_51_4]

		if var_51_5 then
			local var_51_6 = var_51_5.heroInfoTF

			tf(var_51_6):SetSiblingIndex(var_51_0)

			var_51_0 = var_51_0 + 1
		end

		var_51_4 = var_51_4 - 1
	end

	local var_51_7 = 3

	while var_51_7 > 0 do
		local var_51_8 = arg_51_0._characterList[TeamType.Submarine][var_51_7]

		if var_51_8 then
			local var_51_9 = var_51_8.heroInfoTF

			tf(var_51_9):SetSiblingIndex(var_51_0)

			var_51_0 = var_51_0 + 1
		end

		var_51_7 = var_51_7 - 1
	end
end

function var_0_0.UpdateGridVisibility(arg_52_0)
	local var_52_0 = arg_52_0._currentFleetVO:getFleetType()

	_.each(arg_52_0._gridTFs[TeamType.Main], function(arg_53_0)
		setActive(arg_53_0, var_52_0 == FleetType.Normal)
	end)
	_.each(arg_52_0._gridTFs[TeamType.Vanguard], function(arg_54_0)
		setActive(arg_54_0, var_52_0 == FleetType.Normal)
	end)
	_.each(arg_52_0._gridTFs[TeamType.Submarine], function(arg_55_0)
		setActive(arg_55_0, var_52_0 == FleetType.Submarine)
	end)
end

function var_0_0.RecycleCharacterList(arg_56_0, arg_56_1, arg_56_2)
	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		local var_56_0 = arg_56_2[iter_56_0]

		if var_56_0 then
			var_56_0.spineRole:Dispose()

			arg_56_2[iter_56_0] = nil
		end
	end
end

function var_0_0.Destroy(arg_57_0)
	arg_57_0._exited = true

	arg_57_0:RecycleCharacterList(arg_57_0._currentFleetVO:getTeamByName(TeamType.Main), arg_57_0._characterList[TeamType.Main])
	arg_57_0:RecycleCharacterList(arg_57_0._currentFleetVO:getTeamByName(TeamType.Vanguard), arg_57_0._characterList[TeamType.Vanguard])
	arg_57_0:RecycleCharacterList(arg_57_0._currentFleetVO:getTeamByName(TeamType.Submarine), arg_57_0._characterList[TeamType.Submarine])

	if arg_57_0._eventTriggers then
		for iter_57_0, iter_57_1 in pairs(arg_57_0._eventTriggers) do
			ClearEventTrigger(iter_57_0)
		end

		arg_57_0._eventTriggers = nil
	end
end

return var_0_0
