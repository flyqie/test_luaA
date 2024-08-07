﻿local var_0_0 = class("SkinAtlasPreviewPage", import("....base.BaseSubView"))

var_0_0.ON_BG_SWITCH_DONE = "SkinAtlasScene:ON_BG_SWITCH_DONE"
var_0_0.ON_L2D_SWITCH_DONE = "SkinAtlasScene:ON_L2D_SWITCH_DONE"

function var_0_0.getUIName(arg_1_0)
	return "SkinAtlasPreviewPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.paintingTr = arg_2_0:findTF("paint")
	arg_2_0.live2dContainer = arg_2_0:findTF("paint/live2d")
	arg_2_0.mainImg = arg_2_0:findTF("main"):GetComponent(typeof(UnityEngine.UI.Graphic))
	arg_2_0.backBtn = arg_2_0:findTF("main/left/back")
	arg_2_0.nameTxt = arg_2_0:findTF("main/left/name_bg/skin_name"):GetComponent(typeof(Text))
	arg_2_0.shipnameTxt = arg_2_0:findTF("main/left/name_bg/name"):GetComponent(typeof(Text))
	arg_2_0.charParent = arg_2_0:findTF("main/right/char")
	arg_2_0.viewBtn = arg_2_0:findTF("main/right/view_btn")
	arg_2_0.changeBtn = arg_2_0:findTF("main/right/change_btn")
	arg_2_0.changeBtnDis = arg_2_0.changeBtn:Find("dis")
	arg_2_0.changeBtnEn = arg_2_0.changeBtn:Find("en")
	arg_2_0.obtainBtn = arg_2_0:findTF("main/right/obtain_btn")
	arg_2_0.bgFlag = true
	arg_2_0.l2dFlag = false

	local var_2_0 = arg_2_0:findTF("main/left/tpl")

	arg_2_0.btns = {
		ShipAtlasBgBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, arg_2_0.event, arg_2_0.bgFlag),
		ShipAtlasLive2dBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, arg_2_0.event, arg_2_0.l2dFlag)
	}
	arg_2_0.bgView = SkinAtlasBgView.New(arg_2_0:findTF("bg/bg"))
	arg_2_0.paintingView = SkinAtlasPaintingView.New(arg_2_0:findTF("paint"))
	arg_2_0.selectShipPage = ChangeShipSkinPage.New(arg_2_0._parentTf, arg_2_0.event)
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:Hide()
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.viewBtn, function()
		arg_3_0.mainImg.enabled = false

		arg_3_0.paintingView:Enter()

		if arg_3_0.live2d then
			arg_3_0.live2d:OpenClick()
		end
	end, SFX_PANEL)

	local var_3_0 = arg_3_0._tf:GetComponent(typeof(PinchZoom))

	onButton(arg_3_0, arg_3_0._tf, function()
		if var_3_0.processing then
			return
		end

		arg_3_0.mainImg.enabled = true

		arg_3_0.paintingView:Exit()

		if arg_3_0.live2d then
			arg_3_0.live2d:CloseClick()
		end
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.changeBtn, function()
		if arg_3_0.skin:CantUse() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_ship_to_wear"))

			return
		end

		arg_3_0.selectShipPage:ExecuteAction("Show", arg_3_0.skin)
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.obtainBtn, function()
		local var_8_0 = arg_3_0.skin:getConfig("ship_group")
		local var_8_1 = ShipGroup.New({
			id = var_8_0
		})
		local var_8_2 = {
			type = MSGBOX_TYPE_OBTAIN,
			shipId = var_8_1:getShipConfigId(),
			list = var_8_1.groupConfig.description,
			mediatorName = SkinAtlasMediator.__cname
		}

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_8_2)
	end, SFX_PANEL)
	arg_3_0:bind(var_0_0.ON_BG_SWITCH_DONE, function(arg_9_0, arg_9_1)
		arg_3_0.bgFlag = arg_9_1

		arg_3_0.bgView:Init(arg_3_0.ship, arg_3_0.bgFlag)
	end)
	arg_3_0:bind(var_0_0.ON_L2D_SWITCH_DONE, function(arg_10_0, arg_10_1)
		arg_3_0.l2dFlag = arg_10_1

		arg_3_0:UpdatePainting(arg_3_0.ship)
	end)
	addSlip(SLIP_TYPE_HRZ, arg_3_0:findTF("main"), function()
		arg_3_0:OnPrev()
	end, function()
		arg_3_0:OnNext()
	end)
end

function var_0_0.OnNext(arg_13_0)
	if arg_13_0.loading then
		return
	end

	arg_13_0:emit(SkinAtlasScene.ON_NEXT_SKIN, arg_13_0.index)
end

function var_0_0.OnPrev(arg_14_0)
	if arg_14_0.loading then
		return
	end

	arg_14_0:emit(SkinAtlasScene.ON_PREV_SKIN, arg_14_0.index)
end

function var_0_0.Show(arg_15_0, arg_15_1, arg_15_2)
	var_0_0.super.Show(arg_15_0)

	arg_15_0.index = arg_15_2
	arg_15_0.skin = arg_15_1
	arg_15_0.bgFlag = true
	arg_15_0.l2dFlag = false

	local var_15_0 = arg_15_0.skin:ToShip()

	assert(var_15_0)

	arg_15_0.ship = var_15_0

	arg_15_0:UpdateMain(var_15_0)

	local var_15_1 = arg_15_0.skin:CantUse()

	setActive(arg_15_0.changeBtnDis, var_15_1)
	setActive(arg_15_0.changeBtnEn, not var_15_1)
	setActive(arg_15_0.obtainBtn, not arg_15_0.skin:OwnShip())
end

function var_0_0.Flush(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:Clear()
	arg_16_0:Show(arg_16_1, arg_16_2)
end

function var_0_0.UpdateMain(arg_17_0, arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.btns) do
		local var_17_1 = iter_17_1:IsActive(arg_17_1)

		if var_17_1 then
			var_17_0 = var_17_0 + 1
		end

		iter_17_1:Update(var_17_1, var_17_0, arg_17_1)
	end

	arg_17_0.nameTxt.text = arg_17_0.skin:getConfig("name")
	arg_17_0.shipnameTxt.text = arg_17_1:getName()
	arg_17_0.loading = true

	parallelAsync({
		function(arg_18_0)
			arg_17_0.bgView:Init(arg_17_1, arg_17_0.bgFlag, arg_18_0)
		end,
		function(arg_19_0)
			arg_17_0:UpdatePainting(arg_17_1, arg_19_0)
		end,
		function(arg_20_0)
			arg_17_0:UpdateChar(arg_17_1, arg_20_0)
		end
	}, function()
		arg_17_0.loading = false
	end)
end

function var_0_0.UpdatePainting(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.l2dFlag then
		arg_22_0:InitL2D(arg_22_1, arg_22_2)
	else
		arg_22_0:InitPainting(arg_22_1, arg_22_2)
	end
end

function var_0_0.InitPainting(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:ClearPainting(arg_23_1)
	setActive(arg_23_0.live2dContainer, false)

	arg_23_0.painting = arg_23_1:getPainting()

	setPaintingPrefabAsync(arg_23_0.paintingTr, arg_23_0.painting, "chuanwu", arg_23_2)
end

function var_0_0.InitL2D(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:ClearPainting(arg_24_1)

	arg_24_0.live2d = SkinAtlasLive2dView.New(arg_24_1, arg_24_0.live2dContainer, arg_24_2)

	arg_24_0.live2d.live2dChar:changeTriggerFlag(false)
end

function var_0_0.UpdateChar(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:getPrefab()

	PoolMgr.GetInstance():GetSpineChar(var_25_0, true, function(arg_26_0)
		arg_25_0.modelTf = tf(arg_26_0)
		arg_25_0.modelTf.localScale = Vector3(0.9, 0.9, 1)
		arg_25_0.modelTf.localPosition = Vector3(0, -135, 0)

		pg.ViewUtils.SetLayer(arg_25_0.modelTf, Layer.UI)
		setParent(arg_25_0.modelTf, arg_25_0.charParent)
		arg_26_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		arg_25_2()
	end)
end

function var_0_0.ClearPainting(arg_27_0, arg_27_1)
	if arg_27_0.live2d then
		arg_27_0.live2d:Dispose()

		arg_27_0.live2d = nil
	elseif arg_27_0.painting then
		retPaintingPrefab(arg_27_0.paintingTr, arg_27_0.painting)

		arg_27_0.painting = nil
	end
end

function var_0_0.ClearChar(arg_28_0, arg_28_1)
	if arg_28_0.modelTf then
		PoolMgr.GetInstance():ReturnSpineChar(arg_28_1:getPrefab(), arg_28_0.modelTf.gameObject)

		arg_28_0.modelTf = nil
	end
end

function var_0_0.Clear(arg_29_0)
	local var_29_0 = arg_29_0.ship

	if var_29_0 then
		arg_29_0:ClearPainting(var_29_0)
		arg_29_0:ClearChar(var_29_0)

		arg_29_0.ship = nil
	end
end

function var_0_0.Hide(arg_30_0)
	var_0_0.super.Hide(arg_30_0)
	arg_30_0:Clear()

	arg_30_0.skin = nil

	arg_30_0.bgView:Clear()

	if arg_30_0.paintingView:IsEnter() then
		arg_30_0.paintingView:Exit()
	end
end

function var_0_0.IsShowSelectShipView(arg_31_0)
	return arg_31_0.selectShipPage and arg_31_0.selectShipPage:GetLoaded() and arg_31_0.selectShipPage:isShowing()
end

function var_0_0.CloseSelectShipView(arg_32_0)
	arg_32_0.selectShipPage:Hide()
end

function var_0_0.OnDestroy(arg_33_0)
	if arg_33_0:isShowing() then
		arg_33_0:Hide()
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.btns) do
		iter_33_1:Dispose()
	end

	arg_33_0.btns = nil

	arg_33_0.bgView:Dispose()

	arg_33_0.bgView = nil

	arg_33_0.selectShipPage:Destroy()

	arg_33_0.selectShipPage = nil

	arg_33_0.paintingView:Dispose()

	arg_33_0.paintingView = nil
end

return var_0_0
