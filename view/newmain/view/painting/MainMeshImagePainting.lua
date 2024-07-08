﻿local var_0_0 = class("MainMeshImagePainting", import(".MainBasePainting"))

var_0_0.DEFAULT_HEIGHT = -10
var_0_0.TOUCH_HEIGHT = 20
var_0_0.TOUCH_LOOP = 1
var_0_0.TOUCH_DURATION = 0.1
var_0_0.CHAT_HEIGHT = 15
var_0_0.CHAT_DURATION = 0.3
var_0_0.BREATH_HEIGHT = -20
var_0_0.BREATH_DURATION = 2.3
var_0_0.PAINTING_VARIANT_NORMAL = 0
var_0_0.PAINTING_VARIANT_EX = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
end

function var_0_0.StaticGetPaintingName(arg_2_0)
	local var_2_0 = arg_2_0

	if PathMgr.FileExists(PathMgr.getAssetBundle("painting/" .. var_2_0 .. "_n")) and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_2_0, 0) ~= 0 then
		var_2_0 = var_2_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_2_0
	end

	local var_2_1 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(arg_2_0) == var_0_0.PAINTING_VARIANT_EX

	if var_2_1 and not PathMgr.FileExists(PathMgr.getAssetBundle("painting/" .. var_2_0 .. "_ex")) then
		return var_2_0
	end

	return var_2_1 and var_2_0 .. "_ex" or var_2_0
end

function var_0_0.GetPaintingName(arg_3_0)
	return var_0_0.StaticGetPaintingName(arg_3_0.paintingName)
end

function var_0_0.OnLoad(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetPaintingName()

	LoadPaintingPrefabAsync(arg_4_0.container, arg_4_0.paintingName, var_4_0, "mainNormal", function()
		if arg_4_0:IsExited() then
			arg_4_0:UnLoad()

			return
		end

		arg_4_0.loadPaintingName = var_4_0

		local var_5_0 = arg_4_0:InitSpecialTouch()

		arg_4_0:InitSpecialDrag(var_5_0)

		if arg_4_0.expression then
			ShipExpressionHelper.UpdateExpression(findTF(arg_4_0.container, "fitter"):GetChild(0), arg_4_0.paintingName, arg_4_0.expression)
		end

		arg_4_1()
	end)
	arg_4_0:Breath()
end

function var_0_0.GetCenterPos(arg_6_0)
	if arg_6_0:IsLoaded() then
		local var_6_0 = arg_6_0.container:Find("fitter"):GetChild(0)
		local var_6_1 = (0.5 - var_6_0.pivot.x) * var_6_0.sizeDelta.x
		local var_6_2 = var_6_0.localPosition + Vector3(var_6_1, 0, 0)
		local var_6_3 = var_6_0:TransformPoint(var_6_2)

		return arg_6_0.chatTf.parent:InverseTransformPoint(var_6_3)
	else
		return var_0_0.super.GetCenterPos(arg_6_0)
	end
end

function var_0_0.InitSpecialTouch(arg_7_0)
	local var_7_0 = findTF(findTF(arg_7_0.container, "fitter"):GetChild(0), "Touch")

	if not var_7_0 then
		return
	end

	setActive(var_7_0, true)

	local var_7_1 = {}

	eachChild(var_7_0, function(arg_8_0)
		onButton(arg_7_0, arg_8_0, function()
			local var_9_0 = arg_7_0:GetSpecialTouchEvent(arg_8_0.name)

			arg_7_0:TriggerEvent(var_9_0)
			arg_7_0:TriggerPersonalTask(arg_7_0.ship.groupId)
		end)

		var_7_1[arg_8_0] = arg_8_0.rect
	end)

	return var_7_1
end

function var_0_0.InitSpecialDrag(arg_10_0, arg_10_1)
	local var_10_0 = findTF(findTF(arg_10_0.container, "fitter"):GetChild(0), "Drag")

	if not var_10_0 then
		return
	end

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		setActive(var_10_0, false)

		return
	end

	setActive(var_10_0, true)

	local var_10_1 = GetOrAddComponent(var_10_0, typeof(EventTriggerListener))
	local var_10_2 = Vector2(0, 0)

	arg_10_0.isDrag = false

	var_10_1:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		arg_10_0.isDrag = true
		var_10_2 = arg_11_1.position
	end)
	var_10_1:AddDragEndFunc(function(arg_12_0, arg_12_1)
		arg_10_0.isDrag = false

		local var_12_0 = arg_12_1.position - var_10_2

		if math.abs(var_12_0.x) > 50 or math.abs(var_12_0.y) > 50 then
			arg_10_0:SwitchToVariant(var_10_0)
		end
	end)

	if arg_10_1 and table.getCount(arg_10_1) > 0 then
		var_10_1:AddPointUpFunc(function(arg_13_0, arg_13_1)
			if arg_10_0.isDrag then
				return
			end

			local var_13_0

			for iter_13_0, iter_13_1 in pairs(arg_10_1) do
				local var_13_1 = LuaHelper.ScreenToLocal(iter_13_0, arg_13_1.position, arg_10_0.uiCamera)

				if iter_13_1:Contains(var_13_1) then
					var_13_0 = iter_13_0

					break
				end
			end

			if var_13_0 then
				triggerButton(var_13_0)
			else
				triggerButton(arg_10_0.container)
			end
		end)
	end

	local var_10_3 = GetOrAddComponent(var_10_0, "UILongPressTrigger").onLongPressed

	var_10_3:RemoveAllListeners()
	var_10_3:AddListener(function()
		arg_10_0:OnLongPress()
	end)
end

function var_0_0.SwitchToVariant(arg_15_0, arg_15_1)
	pg.UIMgr.GetInstance():LoadingOn(false)
	getProxy(SettingsProxy):SwitchMainPaintingVariantFlag(arg_15_0.paintingName)
	seriesAsync({
		function(arg_16_0)
			local var_16_0 = arg_15_0:GetPaintingName()

			PoolMgr.GetInstance():PreloadPainting(var_16_0, arg_16_0)
		end,
		function(arg_17_0)
			arg_15_0:PlayVariantEffect(arg_15_1, arg_17_0)
		end,
		function(arg_18_0)
			onDelayTick(arg_18_0, 0.5)
		end,
		function(arg_19_0)
			arg_15_0:UnloadOnlyPainting()
			arg_15_0:Load(arg_15_0.ship, true)
			onDelayTick(arg_19_0, 1)
		end
	}, function()
		arg_15_0:ClearEffect()
		pg.UIMgr.GetInstance():LoadingOff()
	end)
end

function var_0_0.PlayVariantEffect(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(arg_21_0.paintingName) == var_0_0.PAINTING_VARIANT_EX
	local var_21_1 = var_21_0 and "lihui_qiehuan01" or "lihui_qiehuan02"

	pg.PoolMgr.GetInstance():GetPrefab("ui/" .. var_21_1, "", true, function(arg_22_0)
		pg.ViewUtils.SetLayer(arg_22_0.transform, Layer.UI)

		arg_21_0.effectGo = arg_22_0
		arg_21_0.effectGo.name = var_21_1

		if arg_21_0:IsExited() then
			arg_21_0:ClearEffect()

			return
		end

		setParent(arg_22_0, arg_21_0.container)

		arg_21_0.effectGo.transform.position = arg_21_1.position

		if var_21_0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_EXPLOSIVE_SKIN)
		else
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_ANTI_EXPLOSIVE_SKIN)
		end

		arg_21_2()
	end)
end

function var_0_0.ClearEffect(arg_23_0)
	if arg_23_0.effectTimer then
		arg_23_0.effectTimer:Stop()

		arg_23_0.effectTimer = nil
	end

	if arg_23_0.effectGo then
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_23_0.effectGo.name, "", arg_23_0.effectGo)

		arg_23_0.effectGo = nil
	end
end

function var_0_0.ClearSpecialDrag(arg_24_0)
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		return
	end

	local var_24_0 = findTF(findTF(arg_24_0.container, "fitter"):GetChild(0), "Drag")

	if not var_24_0 then
		return
	end

	local var_24_1 = GetOrAddComponent(var_24_0, typeof(EventTriggerListener))

	var_24_1:AddBeginDragFunc(nil)
	var_24_1:AddDragEndFunc(nil)
	var_24_1:AddPointUpFunc(nil)
	GetOrAddComponent(var_24_0, "UILongPressTrigger").onLongPressed:RemoveAllListeners()
end

function var_0_0.OnClick(arg_25_0)
	local var_25_0 = arg_25_0:CollectTouchEvents()
	local var_25_1 = var_25_0[math.ceil(math.random(#var_25_0))]

	arg_25_0:TriggerEvent(var_25_1)
end

function var_0_0.OnLongPress(arg_26_0)
	if arg_26_0.isFoldState then
		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
		shipId = arg_26_0.ship.id
	})
end

function var_0_0.OnDisplayWorld(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.ship:getCVIntimacy()
	local var_27_1, var_27_2 = ShipExpressionHelper.SetExpression(findTF(arg_27_0.container, "fitter"):GetChild(0), arg_27_0.paintingName, arg_27_1, var_27_0, arg_27_0.ship.skinId)

	arg_27_0.expression = var_27_2
end

function var_0_0.OnTriggerEvent(arg_28_0)
	arg_28_0:Shake(var_0_0.TOUCH_HEIGHT, var_0_0.TOUCH_DURATION, var_0_0.TOUCH_LOOP)
end

function var_0_0.OnTriggerEventAuto(arg_29_0)
	arg_29_0:Shake(var_0_0.CHAT_HEIGHT, var_0_0.CHAT_DURATION)
end

function var_0_0.Shake(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0, var_30_1, var_30_2 = getProxy(SettingsProxy):getSkinPosSetting(arg_30_0.ship)
	local var_30_3 = arg_30_1

	if var_30_1 then
		var_30_3 = arg_30_1 - var_0_0.DEFAULT_HEIGHT + var_30_1
	end

	arg_30_3 = arg_30_3 or math.random(3) - 1

	if arg_30_3 == 0 then
		return
	end

	LeanTween.cancel(go(arg_30_0.container))
	LeanTween.moveY(rtf(arg_30_0.container), var_30_3, 0.1):setLoopPingPong(arg_30_3):setOnComplete(System.Action(function()
		arg_30_0:Breath()
	end))
end

function var_0_0.Breath(arg_32_0)
	local var_32_0, var_32_1, var_32_2 = getProxy(SettingsProxy):getSkinPosSetting(arg_32_0.ship)
	local var_32_3 = var_32_1 or var_0_0.BREATH_HEIGHT
	local var_32_4 = var_32_1 and var_32_1 - 10 or var_0_0.DEFAULT_HEIGHT

	LeanTween.cancel(go(arg_32_0.container))
	LeanTween.moveY(rtf(arg_32_0.container), var_32_4, var_0_0.BREATH_DURATION):setLoopPingPong():setEase(LeanTweenType.easeInOutCubic):setFrom(var_32_3)
end

function var_0_0.StopBreath(arg_33_0)
	LeanTween.cancel(go(arg_33_0.container))
end

function var_0_0.OnEnableOrDisableDragAndZoom(arg_34_0, arg_34_1)
	if arg_34_1 then
		arg_34_0:StopBreath()
	else
		arg_34_0:Breath()
	end
end

function var_0_0.OnFold(arg_35_0, arg_35_1)
	if not arg_35_1 then
		arg_35_0:Breath()
	end
end

function var_0_0.OnPuase(arg_36_0)
	arg_36_0:StopBreath()
end

function var_0_0.OnResume(arg_37_0)
	checkCullResume(arg_37_0.container:Find("fitter"):GetChild(0))
	arg_37_0:Breath()
end

function var_0_0.Unload(arg_38_0)
	var_0_0.super.Unload(arg_38_0)

	arg_38_0.expression = nil
end

function var_0_0.OnUnload(arg_39_0)
	if LeanTween.isTweening(go(arg_39_0.container)) then
		LeanTween.cancel(go(arg_39_0.container))
	end

	arg_39_0:ClearSpecialDrag()

	if arg_39_0.loadPaintingName then
		retPaintingPrefab(arg_39_0.container, arg_39_0.loadPaintingName)

		arg_39_0.loadPaintingName = nil
	end
end

function var_0_0.OnPuase(arg_40_0)
	arg_40_0:ClearEffect()
end

function var_0_0.Dispose(arg_41_0)
	var_0_0.super.Dispose(arg_41_0)
	arg_41_0:ClearEffect()
end

return var_0_0
