local var_0_0 = class("Live2D")

var_0_0.STATE_LOADING = 0
var_0_0.STATE_INITED = 1
var_0_0.STATE_DISPOSE = 2

local var_0_1
local var_0_2 = 5
local var_0_3 = 3
local var_0_4 = 0.3

var_0_0.DRAG_TIME_ACTION = 1
var_0_0.DRAG_CLICK_ACTION = 2
var_0_0.DRAG_DOWN_ACTION = 3
var_0_0.DRAG_RELATION_XY = 4
var_0_0.DRAG_RELATION_IDLE = 5
var_0_0.EVENT_ACTION_APPLY = "event action apply"
var_0_0.EVENT_ACTION_ABLE = "event action able"
var_0_0.EVENT_ADD_PARAMETER_COM = "event add parameter com "
var_0_0.EVENT_REMOVE_PARAMETER_COM = "event remove parameter com "

local var_0_5 = {
	CubismParameterBlendMode.Override,
	CubismParameterBlendMode.Additive,
	CubismParameterBlendMode.Multiply
}

function var_0_0.GenerateData(arg_1_0)
	local var_1_0 = {
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent
			arg_2_0.scale = arg_2_1.scale

			local var_2_0 = arg_2_0:GetShipSkinConfig().live2d_offset

			arg_2_0.gyro = arg_2_0:GetShipSkinConfig().gyro or 0
			arg_2_0.shipL2dId = arg_2_0:GetShipSkinConfig().ship_l2d_id
			arg_2_0.skinId = arg_2_0:GetShipSkinConfig().id
			arg_2_0.spineUseLive2d = false

			if arg_2_0.skinId then
				arg_2_0.spineUseLive2d = pg.ship_skin_template[arg_2_0.skinId].spine_use_live2d == 1
			end

			arg_2_0.position = arg_2_1.position + BuildVector3(var_2_0)
			arg_2_0.l2dDragRate = arg_2_0:GetShipSkinConfig().l2d_drag_rate
			arg_2_0.loadPrefs = arg_2_1.loadPrefs
		end,
		GetShipName = function(arg_3_0)
			return arg_3_0.ship:getPainting()
		end,
		GetShipSkinConfig = function(arg_4_0)
			return arg_4_0.ship:GetSkinConfig()
		end,
		isEmpty = function(arg_5_0)
			return arg_5_0.ship == nil
		end,
		Clear = function(arg_6_0)
			arg_6_0.ship = nil
			arg_6_0.parent = nil
			arg_6_0.scale = nil
			arg_6_0.position = nil
		end
	}

	var_1_0:SetData(arg_1_0)

	return var_1_0
end

local function var_0_6(arg_7_0)
	local var_7_0 = arg_7_0.live2dData:GetShipSkinConfig()
	local var_7_1 = var_7_0.lip_sync_gain
	local var_7_2 = var_7_0.lip_smoothing

	if var_7_1 and var_7_1 ~= 0 then
		arg_7_0._go:GetComponent("CubismCriSrcMouthInput").Gain = var_7_1
	end

	if var_7_2 and var_7_2 ~= 0 then
		arg_7_0._go:GetComponent("CubismCriSrcMouthInput").Smoothing = var_7_2
	end
end

local function var_0_7(arg_8_0)
	local var_8_0 = arg_8_0.live2dData:GetShipSkinConfig().l2d_para_range

	if var_8_0 ~= nil and type(var_8_0) == "table" then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			arg_8_0.liveCom:SetParaRange(iter_8_0, iter_8_1)
		end
	end
end

local function var_0_8(arg_9_0, arg_9_1)
	if arg_9_0.enablePlayActions and #arg_9_0.enablePlayActions > 0 and not table.contains(arg_9_0.enablePlayActions, arg_9_1) then
		warning(tostring(arg_9_1) .. "不在白名单中,不播放该动作")

		return false
	end

	if arg_9_0.ignorePlayActions and #arg_9_0.ignorePlayActions > 0 and table.contains(arg_9_0.ignorePlayActions, arg_9_1) then
		warning(tostring(arg_9_1) .. "在黑名单中，不播放该动作")

		return false
	end

	if arg_9_0._readlyToStop then
		print("l2d即将停止，不播放该动作")

		return false
	end

	return true
end

local function var_0_9(arg_10_0, arg_10_1, arg_10_2)
	if not var_0_8(arg_10_0, arg_10_1) then
		return false
	end

	if arg_10_0.updateAtom then
		arg_10_0:AtomSouceFresh()
	end

	if arg_10_0.animationClipNames then
		local var_10_0 = table.indexof(arg_10_0.animationClipNames, arg_10_1)

		if (not var_10_0 or var_10_0 == false) and string.find(arg_10_1, "main_") then
			arg_10_1 = "main_3"
		end
	end

	if not arg_10_0.isPlaying or arg_10_2 then
		local var_10_1 = var_0_1.action2Id[arg_10_1]

		if var_10_1 then
			arg_10_0.playActionName = arg_10_1

			arg_10_0.liveCom:SetAction(var_10_1)
			arg_10_0:live2dActionChange(true)

			return true
		else
			print(tostring(arg_10_1) .. " action is not exist")
		end
	end

	return false
end

local function var_0_10(arg_11_0, arg_11_1)
	arg_11_0.liveCom:SetCenterPart("Drawables/TouchHead", Vector3.zero)

	arg_11_0.liveCom.DampingTime = 0.3
end

local function var_0_11(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == Live2D.EVENT_ACTION_APPLY then
		local var_12_0 = arg_12_2.id
		local var_12_1 = arg_12_2.action
		local var_12_2 = arg_12_2.callback
		local var_12_3 = arg_12_2.activeData
		local var_12_4 = arg_12_2.focus
		local var_12_5 = arg_12_2.react

		if not var_0_8(arg_12_0, var_12_1) then
			return
		end

		arg_12_0:setReactPos(tobool(var_12_5))

		if var_12_1 then
			var_0_9(arg_12_0, var_12_1, var_12_4 or false)
		end

		arg_12_0:applyActiveData(arg_12_2, var_12_3)

		if var_12_2 then
			var_12_2()
		end
	elseif arg_12_1 == Live2D.EVENT_ACTION_ABLE then
		if arg_12_0.ableFlag ~= arg_12_2.ableFlag then
			arg_12_0.ableFlag = arg_12_2.ableFlag

			if arg_12_2.ableFlag then
				arg_12_0.tempEnable = arg_12_0.enablePlayActions
				arg_12_0.enablePlayActions = {
					"none action apply"
				}
			else
				arg_12_0.enablePlayActions = arg_12_0.tempEnable
			end
		else
			print("able flag 相同，不执行操作")
		end

		if arg_12_2.callback then
			arg_12_2.callback()
		end
	elseif arg_12_1 == Live2D.EVENT_ADD_PARAMETER_COM then
		arg_12_0.liveCom:AddParameterValue(arg_12_2.com, arg_12_2.start, var_0_5[arg_12_2.mode])
	elseif arg_12_1 == Live2D.EVENT_REMOVE_PARAMETER_COM then
		arg_12_0.liveCom:removeParameterValue(arg_12_2.com)
	end
end

local function var_0_12(arg_13_0)
	if not arg_13_0._l2dCharEnable then
		return
	end

	if arg_13_0._readlyToStop then
		return
	end

	local var_13_0 = false
	local var_13_1 = ReflectionHelp.RefGetField(typeof(Live2dChar), "reactPos", arg_13_0.liveCom)

	for iter_13_0 = 1, #arg_13_0.drags do
		arg_13_0.drags[iter_13_0]:changeReactValue(var_13_1)
		arg_13_0.drags[iter_13_0]:stepParameter()

		if (arg_13_0.drags[iter_13_0]:getParameToTargetFlag() or arg_13_0.drags[iter_13_0]:getActive()) and arg_13_0.drags[iter_13_0]:getIgnoreReact() then
			var_13_0 = true
		end

		local var_13_2 = arg_13_0.drags[iter_13_0]:getParameter()
		local var_13_3 = arg_13_0.drags[iter_13_0]:getParameterUpdateFlag()

		if var_13_2 and var_13_3 then
			local var_13_4 = arg_13_0.drags[iter_13_0]:getParameterCom()

			if var_13_4 then
				arg_13_0.liveCom:ChangeParameterData(var_13_4, var_13_2)
			end
		end

		local var_13_5 = arg_13_0.drags[iter_13_0]:getRelationParameterList()

		for iter_13_1, iter_13_2 in ipairs(var_13_5) do
			if iter_13_2.enable then
				arg_13_0.liveCom:ChangeParameterData(iter_13_2.com, iter_13_2.value)
			end
		end
	end

	if var_13_0 == arg_13_0.ignoreReact or not var_13_0 and (arg_13_0.mouseInputDown or arg_13_0.isPlaying) then
		-- block empty
	else
		arg_13_0:setReactPos(var_13_0)
	end
end

local function var_0_13(arg_14_0)
	arg_14_0.drags = {}
	arg_14_0.dragParts = {}

	for iter_14_0 = 1, #var_0_1.assistantTouchParts do
		table.insert(arg_14_0.dragParts, var_0_1.assistantTouchParts[iter_14_0])
	end

	arg_14_0._l2dCharEnable = true
	arg_14_0._shopPreView = arg_14_0.live2dData.shopPreView

	for iter_14_1, iter_14_2 in ipairs(arg_14_0.live2dData.shipL2dId) do
		local var_14_0 = pg.ship_l2d[iter_14_2]

		if var_14_0 and arg_14_0:getDragEnable(var_14_0) then
			local var_14_1 = Live2dDrag.New(var_14_0, arg_14_0.live2dData)
			local var_14_2 = arg_14_0.liveCom:GetCubismParameter(var_14_0.parameter)

			var_14_1:setParameterCom(var_14_2)
			var_14_1:setEventCallback(function(arg_15_0, arg_15_1)
				var_0_11(arg_14_0, arg_15_0, arg_15_1)
			end)
			arg_14_0.liveCom:AddParameterValue(var_14_1.parameterName, var_14_1.startValue, var_0_5[var_14_0.mode])

			if var_14_0.relation_parameter and var_14_0.relation_parameter.list then
				local var_14_3 = var_14_0.relation_parameter.list

				for iter_14_3, iter_14_4 in ipairs(var_14_3) do
					local var_14_4 = arg_14_0.liveCom:GetCubismParameter(iter_14_4.name)

					if var_14_4 then
						var_14_1:addRelationComData(var_14_4, iter_14_4)
						arg_14_0.liveCom:AddParameterValue(iter_14_4.name, iter_14_4.start or var_14_1.startValue or 0, var_0_5[var_14_0.mode])
					end
				end
			end

			table.insert(arg_14_0.drags, var_14_1)

			if not table.contains(arg_14_0.dragParts, var_14_1.drawAbleName) then
				table.insert(arg_14_0.dragParts, var_14_1.drawAbleName)
			end
		end
	end

	arg_14_0.liveCom:SetDragParts(arg_14_0.dragParts)

	arg_14_0.eventTrigger = GetOrAddComponent(arg_14_0.liveCom.transform.parent, typeof(EventTriggerListener))

	arg_14_0.eventTrigger:AddPointDownFunc(function()
		if arg_14_0.useEventTriggerFlag then
			arg_14_0:onPointDown()
		end
	end)
	arg_14_0.eventTrigger:AddPointUpFunc(function()
		if arg_14_0.useEventTriggerFlag then
			arg_14_0:onPointUp()
		end
	end)
	arg_14_0.liveCom:SetMouseInputActions(System.Action(function()
		if not arg_14_0.useEventTriggerFlag then
			arg_14_0:onPointDown()
		end
	end), System.Action(function()
		if not arg_14_0.useEventTriggerFlag then
			arg_14_0:onPointUp()
		end
	end))

	arg_14_0.paraRanges = ReflectionHelp.RefGetField(typeof(Live2dChar), "paraRanges", arg_14_0.liveCom)
	arg_14_0.destinations = {}

	local var_14_5 = ReflectionHelp.RefGetProperty(typeof(Live2dChar), "Destinations", arg_14_0.liveCom)

	for iter_14_5 = 0, var_14_5.Length - 1 do
		local var_14_6 = var_14_5[iter_14_5]

		table.insert(arg_14_0.destinations, var_14_5[iter_14_5])
	end

	arg_14_0.timer = Timer.New(function()
		var_0_12(arg_14_0)
	end, 0.03333333333333333, -1)

	arg_14_0.timer:Start()
	var_0_12(arg_14_0)
end

function var_0_0.onPointDown(arg_21_0)
	if not arg_21_0._l2dCharEnable then
		return
	end

	arg_21_0.mouseInputDown = true

	if #arg_21_0.drags > 0 and arg_21_0.liveCom:GetDragPart() > 0 then
		local var_21_0 = arg_21_0.liveCom:GetDragPart()
		local var_21_1 = arg_21_0.dragParts[var_21_0]

		if var_21_0 > 0 and var_21_1 then
			for iter_21_0, iter_21_1 in ipairs(arg_21_0.drags) do
				if iter_21_1.drawAbleName == var_21_1 then
					iter_21_1:startDrag()
				end
			end
		end
	end
end

function var_0_0.onPointUp(arg_22_0)
	if not arg_22_0._l2dCharEnable then
		return
	end

	arg_22_0.mouseInputDown = false

	if arg_22_0.drags and #arg_22_0.drags > 0 then
		local var_22_0 = arg_22_0.liveCom:GetDragPart()

		if var_22_0 > 0 then
			local var_22_1 = arg_22_0.dragParts[var_22_0]
		end

		for iter_22_0 = 1, #arg_22_0.drags do
			arg_22_0.drags[iter_22_0]:stopDrag()
		end
	end
end

function var_0_0.changeTriggerFlag(arg_23_0, arg_23_1)
	arg_23_0.useEventTriggerFlag = arg_23_1
end

local function var_0_14(arg_24_0, arg_24_1)
	arg_24_0._go = arg_24_1
	arg_24_0._tf = tf(arg_24_1)

	UIUtil.SetLayerRecursively(arg_24_0._go, LayerMask.NameToLayer("UI"))
	arg_24_0._tf:SetParent(arg_24_0.live2dData.parent, true)

	arg_24_0._tf.localScale = arg_24_0.live2dData.scale
	arg_24_0._tf.localPosition = arg_24_0.live2dData.position
	arg_24_0.liveCom = arg_24_1:GetComponent(typeof(Live2dChar))
	arg_24_0._animator = arg_24_1:GetComponent(typeof(Animator))
	arg_24_0.animationClipNames = {}

	if arg_24_0._animator and arg_24_0._animator.runtimeAnimatorController then
		local var_24_0 = arg_24_0._animator.runtimeAnimatorController.animationClips
		local var_24_1 = var_24_0.Length

		for iter_24_0 = 0, var_24_1 - 1 do
			table.insert(arg_24_0.animationClipNames, var_24_0[iter_24_0].name)
		end
	end

	local var_24_2 = var_0_1.action2Id.idle

	arg_24_0.liveCom:SetReactMotions(var_0_1.idleActions)
	arg_24_0.liveCom:SetAction(var_24_2)

	function arg_24_0.liveCom.FinishAction(arg_25_0)
		arg_24_0:live2dActionChange(false)

		if arg_24_0.finishActionCB then
			arg_24_0.finishActionCB()

			arg_24_0.finishActionCB = nil
		end

		arg_24_0.liveCom:SetAction(var_0_1.idleActions[math.ceil(math.random(#var_0_1.idleActions))])
	end

	function arg_24_0.liveCom.EventAction(arg_26_0)
		if arg_24_0.animEventCB then
			arg_24_0.animEventCB(arg_26_0)

			arg_24_0.animEventCB = nil
		end
	end

	arg_24_0.liveCom:SetTouchParts(var_0_1.assistantTouchParts)

	if arg_24_0.live2dData and arg_24_0.live2dData.ship and arg_24_0.live2dData.ship.propose then
		arg_24_0:changeParamaterValue("Paramring", 1)
	else
		arg_24_0:changeParamaterValue("Paramring", 0)
	end

	if arg_24_0.live2dData.l2dDragRate and #arg_24_0.live2dData.l2dDragRate > 0 then
		arg_24_0.liveCom.DragRateX = arg_24_0.live2dData.l2dDragRate[1] * var_0_2
		arg_24_0.liveCom.DragRateY = arg_24_0.live2dData.l2dDragRate[2] * var_0_3
		arg_24_0.liveCom.DampingTime = arg_24_0.live2dData.l2dDragRate[3] * var_0_4
	end

	var_0_6(arg_24_0)
	var_0_7(arg_24_0)
	var_0_10(arg_24_0)

	if arg_24_0.live2dData.shipL2dId and #arg_24_0.live2dData.shipL2dId > 0 then
		var_0_13(arg_24_0)
	end

	arg_24_0.state = var_0_0.STATE_INITED

	if arg_24_0.delayChangeParamater and #arg_24_0.delayChangeParamater > 0 then
		for iter_24_1 = 1, #arg_24_0.delayChangeParamater do
			local var_24_3 = arg_24_0.delayChangeParamater[iter_24_1]

			arg_24_0:changeParamaterValue(var_24_3[1], var_24_3[2])
		end

		arg_24_0.delayChangeParamater = nil
	end

	arg_24_0.enablePlayActions = {}
	arg_24_0.ignorePlayActions = {}

	arg_24_0:changeIdleIndex(0)
	arg_24_0:loadLive2dData()
end

function var_0_0.Ctor(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.state = var_0_0.STATE_LOADING
	arg_27_0.live2dData = arg_27_1
	var_0_1 = pg.AssistantInfo

	assert(not arg_27_0.live2dData:isEmpty())

	local var_27_0 = arg_27_0.live2dData:GetShipName()

	local function var_27_1(arg_28_0)
		var_0_14(arg_27_0, arg_28_0)

		if arg_27_2 then
			arg_27_2(arg_27_0)
		end
	end

	arg_27_0.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(var_27_0, var_27_1)
	Input.gyro.enabled = arg_27_0.live2dData.gyro == 1 and PlayerPrefs.GetInt(GYRO_ENABLE, 1) == 1
	arg_27_0.useEventTriggerFlag = true
end

function var_0_0.SetVisible(arg_29_0, arg_29_1)
	if not arg_29_0:IsLoaded() then
		return
	end

	Input.gyro.enabled = PlayerPrefs.GetInt(GYRO_ENABLE, 1) == 1

	arg_29_0:setReactPos(true)
	arg_29_0:Reset()

	if arg_29_1 then
		arg_29_0._readlyToStop = false

		onDelayTick(function()
			if not arg_29_0._readlyToStop then
				arg_29_0:setReactPos(false)
			end
		end, 1)
	else
		var_0_9(arg_29_0, "idle", true)

		arg_29_0._readlyToStop = true

		onDelayTick(function()
			if arg_29_0._readlyToStop then
				arg_29_0._animator.speed = 0
			end
		end, 3)
	end

	if arg_29_1 then
		arg_29_0:loadLive2dData()
	else
		arg_29_0:saveLive2dData()
	end

	arg_29_0._animator.speed = 1
end

function var_0_0.loadLive2dData(arg_32_0)
	if not arg_32_0.live2dData.loadPrefs then
		return
	end

	if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and not arg_32_0.live2dData.spineUseLive2d then
		if arg_32_0.drags then
			for iter_32_0 = 1, #arg_32_0.drags do
				arg_32_0.drags[iter_32_0]:clearData()
			end
		end

		arg_32_0:changeIdleIndex(0)
		arg_32_0._animator:Play("idle")

		arg_32_0.saveActionAbleId = nil

		var_0_12(arg_32_0)

		return
	end

	local var_32_0, var_32_1 = Live2dConst.GetL2dSaveData(arg_32_0.live2dData:GetShipSkinConfig().id, arg_32_0.live2dData.ship.id)

	if var_32_0 then
		arg_32_0:changeIdleIndex(var_32_0)

		if var_32_0 == 0 then
			arg_32_0._animator:Play("idle")
		else
			arg_32_0._animator:Play("idle" .. var_32_0)
		end
	end

	arg_32_0.saveActionAbleId = var_32_1

	if var_32_1 and var_32_1 > 0 then
		if pg.ship_l2d[var_32_1] then
			local var_32_2 = pg.ship_l2d[var_32_1].action_trigger_active

			arg_32_0.enablePlayActions = var_32_2.enable
			arg_32_0.ignorePlayActions = var_32_2.ignore
		end
	else
		arg_32_0.enablePlayActions = {}
		arg_32_0.ignorePlayActions = {}
	end

	if arg_32_0.drags then
		for iter_32_1 = 1, #arg_32_0.drags do
			arg_32_0.drags[iter_32_1]:loadData()
		end
	end

	var_0_12(arg_32_0)
end

function var_0_0.saveLive2dData(arg_33_0)
	if not arg_33_0.live2dData.loadPrefs then
		return
	end

	if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and not arg_33_0.live2dData.spineUseLive2d then
		return
	end

	if arg_33_0.idleIndex then
		Live2dConst.SaveL2dIdle(arg_33_0.live2dData:GetShipSkinConfig().id, arg_33_0.live2dData.ship.id, arg_33_0.idleIndex)
	end

	if arg_33_0.saveActionAbleId then
		if arg_33_0.idleIndex == 0 then
			Live2dConst.SaveL2dAction(arg_33_0.live2dData:GetShipSkinConfig().id, arg_33_0.live2dData.ship.id, 0)
		else
			Live2dConst.SaveL2dAction(arg_33_0.live2dData:GetShipSkinConfig().id, arg_33_0.live2dData.ship.id, arg_33_0.saveActionAbleId)
		end
	end

	if arg_33_0.drags then
		for iter_33_0 = 1, #arg_33_0.drags do
			arg_33_0.drags[iter_33_0]:saveData()
		end
	end
end

function var_0_0.enablePlayAction(arg_34_0, arg_34_1)
	return var_0_8(arg_34_0, arg_34_1)
end

function var_0_0.IgonreReactPos(arg_35_0, arg_35_1)
	arg_35_0:setReactPos(arg_35_1)
end

function var_0_0.setReactPos(arg_36_0, arg_36_1)
	if arg_36_0.liveCom then
		arg_36_0.ignoreReact = arg_36_1

		arg_36_0.liveCom:IgonreReactPos(arg_36_1)

		if arg_36_1 then
			ReflectionHelp.RefSetField(typeof(Live2dChar), "inDrag", arg_36_0.liveCom, false)
		end

		ReflectionHelp.RefSetField(typeof(Live2dChar), "reactPos", arg_36_0.liveCom, Vector3(0, 0, 0))
		arg_36_0:updateDragsSateData()
	end
end

function var_0_0.l2dCharEnable(arg_37_0, arg_37_1)
	arg_37_0._l2dCharEnable = arg_37_1
end

function var_0_0.inShopPreView(arg_38_0, arg_38_1)
	arg_38_0._shopPreView = arg_38_1
end

function var_0_0.getDragEnable(arg_39_0, arg_39_1)
	if arg_39_0._shopPreView and arg_39_1.shop_action == 0 then
		return false
	end

	return true
end

function var_0_0.updateShip(arg_40_0, arg_40_1)
	if arg_40_1 and arg_40_0.live2dData and arg_40_0.live2dData.ship then
		arg_40_0.live2dData.ship = arg_40_1

		if arg_40_0.live2dData and arg_40_0.live2dData.ship and arg_40_0.live2dData.ship.propose then
			arg_40_0:changeParamaterValue("Paramring", 1)
		else
			arg_40_0:changeParamaterValue("Paramring", 0)
		end
	end
end

function var_0_0.IsLoaded(arg_41_0)
	return arg_41_0.state == var_0_0.STATE_INITED
end

function var_0_0.GetTouchPart(arg_42_0)
	return arg_42_0.liveCom:GetTouchPart()
end

function var_0_0.TriggerAction(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	arg_43_0:CheckStopDrag()

	arg_43_0.finishActionCB = arg_43_2
	arg_43_0.animEventCB = arg_43_4

	if not var_0_9(arg_43_0, arg_43_1, arg_43_3) and arg_43_0.animEventCB then
		arg_43_0.animEventCB(false)
	end
end

function var_0_0.Reset(arg_44_0)
	arg_44_0:live2dActionChange(false)

	arg_44_0.enablePlayActions = {}
	arg_44_0.ignorePlayActions = {}
	arg_44_0.ableFlag = nil
end

function var_0_0.applyActiveData(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_2.enable
	local var_45_1 = arg_45_2.ignore
	local var_45_2 = arg_45_2.idle
	local var_45_3 = arg_45_2.repeatFlag

	if var_45_0 and #var_45_0 >= 0 then
		arg_45_0.enablePlayActions = var_45_0
	end

	if var_45_1 and #var_45_1 >= 0 then
		arg_45_0.ignorePlayActions = var_45_1
	end

	if var_45_2 ~= arg_45_0.indexIndex then
		arg_45_0.saveActionAbleId = arg_45_1.id
	end

	if var_45_2 then
		local var_45_4

		if type(var_45_2) == "number" and var_45_2 >= 0 then
			var_45_4 = var_45_2
		elseif type(var_45_2) == "table" then
			local var_45_5 = {}

			for iter_45_0, iter_45_1 in ipairs(var_45_2) do
				if iter_45_1 == arg_45_0.idleIndex then
					if var_45_3 then
						table.insert(var_45_5, iter_45_1)
					end
				else
					table.insert(var_45_5, iter_45_1)
				end
			end

			var_45_4 = var_45_5[math.random(1, #var_45_5)]
		end

		if var_45_4 then
			arg_45_0:changeIdleIndex(var_45_4)
		end

		arg_45_0:saveLive2dData()
	end
end

function var_0_0.changeIdleIndex(arg_46_0, arg_46_1)
	if arg_46_0.idleIndex ~= arg_46_1 then
		arg_46_0._animator:SetInteger("idle", arg_46_1)
	end

	print("now idle index is " .. arg_46_1)

	arg_46_0.idleIndex = arg_46_1

	arg_46_0:updateDragsSateData()
end

function var_0_0.live2dActionChange(arg_47_0, arg_47_1)
	arg_47_0.isPlaying = arg_47_1

	arg_47_0:updateDragsSateData()
end

function var_0_0.updateDragsSateData(arg_48_0)
	local var_48_0 = {
		idleIndex = arg_48_0.idleIndex,
		isPlaying = arg_48_0.isPlaying,
		ignoreReact = arg_48_0.ignoreReact,
		actionName = arg_48_0.playActionName
	}

	if arg_48_0.drags then
		for iter_48_0 = 1, #arg_48_0.drags do
			arg_48_0.drags[iter_48_0]:updateStateData(var_48_0)
		end
	end
end

function var_0_0.CheckStopDrag(arg_49_0)
	local var_49_0 = arg_49_0.live2dData:GetShipSkinConfig()

	if var_49_0.l2d_ignore_drag and var_49_0.l2d_ignore_drag == 1 then
		arg_49_0.liveCom.ResponseClick = false

		ReflectionHelp.RefSetField(typeof(Live2dChar), "inDrag", arg_49_0.liveCom, false)
	end
end

function var_0_0.changeParamaterValue(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_0:IsLoaded() then
		if not arg_50_1 or string.len(arg_50_1) == 0 then
			return
		end

		local var_50_0 = arg_50_0.liveCom:GetCubismParameter(arg_50_1)

		if not var_50_0 then
			return
		end

		arg_50_0.liveCom:AddParameterValue(var_50_0, arg_50_2, var_0_5[1])
	else
		if not arg_50_0.delayChangeParamater then
			arg_50_0.delayChangeParamater = {}
		end

		table.insert(arg_50_0.delayChangeParamater, {
			arg_50_1,
			arg_50_2
		})
	end
end

function var_0_0.Dispose(arg_51_0)
	if arg_51_0.state == var_0_0.STATE_INITED then
		Destroy(arg_51_0._go)

		arg_51_0.liveCom.FinishAction = nil
		arg_51_0.liveCom.EventAction = nil
	end

	arg_51_0:saveLive2dData()
	arg_51_0.liveCom:SetMouseInputActions(nil, nil)

	arg_51_0._readlyToStop = false
	arg_51_0.state = var_0_0.STATE_DISPOSE

	pg.Live2DMgr.GetInstance():StopLoadingLive2d(arg_51_0.live2dRequestId)

	arg_51_0.live2dRequestId = nil

	if arg_51_0.drags then
		for iter_51_0 = 1, #arg_51_0.drags do
			arg_51_0.drags[iter_51_0]:dispose()
		end

		arg_51_0.drags = {}
	end

	if arg_51_0.live2dData.gyro == 1 then
		Input.gyro.enabled = false
	end

	if arg_51_0.live2dData then
		arg_51_0.live2dData:Clear()

		arg_51_0.live2dData = nil
	end

	arg_51_0:live2dActionChange(false)

	if arg_51_0.timer then
		arg_51_0.timer:Stop()

		arg_51_0.timer = nil
	end
end

function var_0_0.UpdateAtomSource(arg_52_0)
	arg_52_0.updateAtom = true
end

function var_0_0.AtomSouceFresh(arg_53_0)
	local var_53_0 = pg.CriMgr.GetInstance():getAtomSource(pg.CriMgr.C_VOICE)
	local var_53_1 = arg_53_0._go:GetComponent("CubismCriSrcMouthInput")
	local var_53_2 = ReflectionHelp.RefGetField(typeof("Live2D.Cubism.Framework.MouthMovement.CubismCriSrcMouthInput"), "Analyzer", var_53_1)

	var_53_0:AttachToAnalyzer(var_53_2)

	if arg_53_0.updateAtom then
		arg_53_0.updateAtom = false
	end
end

return var_0_0
