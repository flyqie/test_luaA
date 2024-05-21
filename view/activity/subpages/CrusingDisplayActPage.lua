slot0 = class("CrusingDisplayActPage", import("view.base.BaseActivityPage"))

slot0.OnInit = function(slot0)
	slot0.bgBase = slot0._tf:Find("bg_base")
	slot0.bgPay = slot0._tf:Find("bg_pay")
	slot0.btnGoBase = slot0._tf:Find("AD/btn_go_base")

	onButton(slot0, slot0.btnGoBase, function ()
		uv0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)
	end, SFX_CONFIRM)

	slot0.btnGoPay = slot0._tf:Find("AD/btn_go_pay")

	onButton(slot0, slot0.btnGoPay, function ()
		uv0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)
	end, SFX_CONFIRM)

	slot1 = slot0._tf:Find("AD/info_panel")
	slot0.toggleBase = slot1:Find("toggle_base")

	onToggle(slot0, slot0.toggleBase, function (slot0)
		if uv0.LTBase then
			LeanTween.cancel(uv0.LTBase)
		end

		uv0.LTBase = LeanTween.alpha(uv0.bgBase, slot0 and 1 or 0, 0.5).uniqueId
	end, SFX_PANEL)

	slot0.togglePay = slot1:Find("toggle_pay")

	onToggle(slot0, slot0.togglePay, function (slot0)
		if uv0.LTPay then
			LeanTween.cancel(uv0.LTPay)
		end

		uv0.LTPay = LeanTween.alpha(uv0.bgPay, slot0 and 1 or 0, 0.5).uniqueId
	end, SFX_PANEL)

	slot0.btnPay = slot1:Find("unlock_panel/btn_unlock")

	onButton(slot0, slot0.btnPay, function ()
		uv0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_GIFT
		})
	end, SFX_CONFIRM)

	slot0.markPay = slot1:Find("unlock_panel/mark_unlocked")
	slot0.textPay = slot1:Find("text_pay")
end

slot0.OnDataSetting = function(slot0)
	slot0.isPay = slot0.activity.data2 == 1
end

slot0.OnUpdateFlush = function(slot0)
	setActive(slot0.textPay:Find("before"), not slot0.isPay)
	setActive(slot0.textPay:Find("after"), slot0.isPay)
	setActive(slot0.btnPay, not slot0.isPay)
	setActive(slot0.markPay, slot0.isPay)

	slot1 = #slot0.activity:GetCrusingUnreceiveAward() > 0

	setActive(slot0.btnGoBase:Find("tip"), slot1)
	setActive(slot0.btnGoPay:Find("tip"), slot1)
	onNextTick(function ()
		if uv0.isPay then
			triggerToggle(uv0.togglePay, true)
		else
			triggerToggle(uv0.toggleBase, true)

			if PlayerPrefs.GetInt("first_crusing_page_display:" .. uv0.activity.id, 0) == 0 then
				PlayerPrefs.SetInt("first_crusing_page_display:" .. uv0.activity.id, 1)

				uv0.LTFirst = LeanTween.delayedCall(3, System.Action(function ()
					triggerToggle(uv0.togglePay, true)

					uv0.LTFirst = LeanTween.delayedCall(3, System.Action(function ()
						triggerToggle(uv0.toggleBase, true)
					end)).uniqueId
				end)).uniqueId
			end
		end
	end)
end

slot0.OnHideFlush = function(slot0)
	if slot0.LTFirst then
		LeanTween.cancel(slot0.LTFirst)

		slot0.LTFirst = nil
	end
end

slot0.OnDestroy = function(slot0)
	if slot0.LTFirst then
		LeanTween.cancel(slot0.LTFirst)

		slot0.LTFirst = nil
	end

	if slot0.LTBase then
		LeanTween.cancel(slot0.LTBase)

		slot0.LTBase = nil
	end

	if slot0.LTPay then
		LeanTween.cancel(slot0.LTPay)

		slot0.LTPay = nil
	end
end

return slot0
