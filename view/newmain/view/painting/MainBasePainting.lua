local var_0_0 = class("MainBasePainting")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.container = arg_1_1
	arg_1_0.chatTf = arg_1_2
	arg_1_0.chatText = arg_1_2:Find("Text")
	arg_1_0.chatTextBg = arg_1_2:Find("chatbgtop")
	arg_1_0.initChatBgH = arg_1_0.chatTextBg.sizeDelta.y
	arg_1_0.state = var_0_1
	var_0_5 = pg.AssistantInfo
	arg_1_0.cvLoader = MainCVLoader.New()
	arg_1_0.longPressEvent = arg_1_1:GetComponent("UILongPressTrigger").onLongPressed
end

function var_0_0.GetCenterPos(arg_2_0)
	local var_2_0 = arg_2_0.container

	return (arg_2_0.chatTf.parent:InverseTransformPoint(var_2_0.position))
end

function var_0_0.IsLoading(arg_3_0)
	return arg_3_0.state == var_0_2
end

function var_0_0.IsLoaded(arg_4_0)
	return arg_4_0.state == var_0_3
end

function var_0_0.Load(arg_5_0, arg_5_1)
	arg_5_0.isPuase = false
	arg_5_0.isExited = false
	arg_5_0.state = var_0_2
	arg_5_0.ship = arg_5_1
	arg_5_0.paintingName = arg_5_1:getPainting()

	arg_5_0:OnLoad(function()
		arg_5_0.state = var_0_3

		if arg_5_0.triggerWhenLoaded then
			arg_5_0:TriggerEventAtFirstTime()
		end

		arg_5_0:InitClickEvent()
	end)
end

function var_0_0.Unload(arg_7_0)
	arg_7_0.state = var_0_4

	removeOnButton(arg_7_0.container)
	arg_7_0.longPressEvent:RemoveAllListeners()
	arg_7_0:StopChatAnimtion()
	arg_7_0.cvLoader:Stop()
	arg_7_0:RemoveTimer()
	arg_7_0:OnUnload()

	arg_7_0.paintingName = nil
end

function var_0_0.UnloadOnlyPainting(arg_8_0)
	arg_8_0.state = var_0_4

	removeOnButton(arg_8_0.container)
	arg_8_0.longPressEvent:RemoveAllListeners()
	arg_8_0:RemoveTimer()
	arg_8_0:OnUnload()

	arg_8_0.paintingName = nil
end

function var_0_0.InitClickEvent(arg_9_0)
	onButton(arg_9_0, arg_9_0.container, function()
		arg_9_0:OnClick()
		arg_9_0:TriggerPersonalTask(arg_9_0.ship.groupId)
	end)
	arg_9_0.longPressEvent:RemoveAllListeners()
	arg_9_0.longPressEvent:AddListener(function()
		if getProxy(ContextProxy):getCurrentContext().viewComponent.__cname == "NewMainScene" then
			arg_9_0:OnLongPress()
		end
	end)
end

function var_0_0.TriggerPersonalTask(arg_12_0, arg_12_1)
	if arg_12_0.isFoldState then
		return
	end

	local var_12_0 = getProxy(TaskProxy)
	local var_12_1 = var_12_0:GetFlagShipInterActionTaskList()

	if var_12_1 and #var_12_1 > 0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
				taskId = iter_12_1.id
			})
		end
	end

	for iter_12_2, iter_12_3 in ipairs(pg.task_data_trigger.all) do
		local var_12_2 = pg.task_data_trigger[iter_12_3]

		if var_12_2.group_id == arg_12_1 then
			local var_12_3 = var_12_2.task_id

			if not var_12_0:getFinishTaskById(var_12_3) then
				arg_12_0:CheckStoryDownload(var_12_3, function()
					pg.m02:sendNotification(GAME.TRIGGER_TASK, var_12_3)
				end)

				break
			end
		end
	end
end

function var_0_0.CheckStoryDownload(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = arg_14_1

	while true do
		local var_14_2 = pg.task_data_template[var_14_1]

		if var_14_2.story_id ~= "" then
			table.insert(var_14_0, var_14_2.story_id)
		end

		if var_14_2.next_task == "" or var_14_2.next_task == "0" then
			break
		end

		var_14_1 = var_14_1 + 1
	end

	local var_14_3 = pg.NewStoryMgr.GetInstance():GetStoryPaintingsByNameList(var_14_0)
	local var_14_4 = _.map(var_14_3, function(arg_15_0)
		return "painting/" .. arg_15_0
	end)

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_14_4,
		finishFunc = arg_14_2
	})
end

function var_0_0.TriggerEventAtFirstTime(arg_16_0)
	if not arg_16_0:IsLoaded() then
		arg_16_0.triggerWhenLoaded = true

		return
	end

	arg_16_0.triggerWhenLoaded = false

	arg_16_0:OnFirstTimeTriggerEvent()
end

function var_0_0.OnFirstTimeTriggerEvent(arg_17_0)
	local function var_17_0(arg_18_0)
		arg_17_0:_TriggerEvent(arg_18_0)
	end

	if arg_17_0.ship:GetSkinConfig().spine_use_live2d == 1 and arg_17_0.live2dChar then
		return
	end

	if getProxy(PlayerProxy):getFlag("login") then
		getProxy(PlayerProxy):setFlag("login", nil)
		var_17_0("event_login")
	elseif getProxy(PlayerProxy):getFlag("battle") then
		getProxy(PlayerProxy):setFlag("battle", nil)
		var_17_0("home")
	else
		arg_17_0:TriggerNextEventAuto()
	end
end

function var_0_0._TriggerEvent(arg_19_0, arg_19_1)
	local var_19_0 = var_0_5.assistantEvents[arg_19_1]

	if var_19_0.dialog ~= "" then
		arg_19_0:DisplayWord(var_19_0.dialog)
	else
		arg_19_0:TriggerNextEventAuto()
	end
end

function var_0_0.TriggerEvent(arg_20_0, arg_20_1)
	if arg_20_0.isDragAndZoomState then
		return
	end

	if arg_20_0.chatting then
		return
	end

	arg_20_0:RemoveTimer()
	arg_20_0:_TriggerEvent(arg_20_1)
	arg_20_0:OnTriggerEvent()
end

function var_0_0.TriggerNextEventAuto(arg_21_0)
	if arg_21_0.isPuase or arg_21_0.isExited then
		return
	end

	arg_21_0:OnEndChatting()
	arg_21_0:RemoveTimer()

	arg_21_0.timer = Timer.New(function()
		local var_22_0 = arg_21_0:CollectIdleEvents(arg_21_0.lastChatEvent)

		arg_21_0.lastChatEvent = var_22_0[math.ceil(math.random(#var_22_0))]

		arg_21_0:_TriggerEvent(arg_21_0.lastChatEvent)
		arg_21_0:OnTriggerEventAuto()
		arg_21_0:RemoveTimer()
	end, 30, 1, true)

	arg_21_0.timer:Start()
end

function var_0_0.OnStartChatting(arg_23_0)
	arg_23_0.chatting = true
end

function var_0_0.OnEndChatting(arg_24_0)
	arg_24_0.chatting = false
end

function var_0_0.GetWordAndCv(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1, var_25_2, var_25_3, var_25_4, var_25_5 = ShipWordHelper.GetCvDataForShip(arg_25_0.ship, arg_25_2)

	return var_25_0, var_25_1, var_25_2, var_25_3, var_25_4, var_25_5
end

function var_0_0.DisplayWord(arg_26_0, arg_26_1)
	arg_26_0:OnStartChatting()

	local var_26_0, var_26_1, var_26_2, var_26_3, var_26_4, var_26_5 = arg_26_0:GetWordAndCv(arg_26_0.ship, arg_26_1)

	if not var_26_2 or var_26_2 == nil or var_26_2 == "" or var_26_2 == "nil" then
		arg_26_0:OnEndChatting()

		return
	end

	if PLATFORM_CODE == PLATFORM_US then
		setTextEN(arg_26_0.chatText, var_26_2)
	else
		setText(arg_26_0.chatText, SwitchSpecialChar(var_26_2))
	end

	arg_26_0:AdjustChatPosition()
	arg_26_0:OnDisplayWorld(arg_26_1)
	arg_26_0:RegisterChatSkipAction(arg_26_1)
	arg_26_0:PlayCvAndAnimation(var_26_4, var_26_3, var_26_1)
end

function var_0_0.RegisterChatSkipAction(arg_27_0, arg_27_1)
	removeOnButton(arg_27_0.chatTf)
	onButton(arg_27_0, arg_27_0.chatTf, function()
		if arg_27_1 == "mission_complete" or arg_27_1 == "mission" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TASK)
		elseif arg_27_1 == "collection" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		elseif arg_27_1 == "event_complete" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end
	end)
end

function var_0_0.PlayCvAndAnimation(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if getProxy(ContextProxy):getContextByMediator(NewShipMediator) then
		arg_29_0:OnEndChatting()

		return
	end

	local var_29_0 = -1

	seriesAsync({
		function(arg_30_0)
			if not arg_29_3 or not not pg.NewStoryMgr.GetInstance():IsRunning() then
				arg_30_0()

				return
			end

			arg_29_0:PlayCV(arg_29_1, arg_29_2, arg_29_3, function(arg_31_0)
				var_29_0 = arg_31_0

				arg_30_0()
			end)
		end,
		function(arg_32_0)
			arg_29_0:StartChatAnimtion(var_29_0, arg_32_0)
		end
	}, function()
		arg_29_0:OnDisplayWordEnd()
	end)
end

function var_0_0.OnDisplayWordEnd(arg_34_0)
	arg_34_0:TriggerNextEventAuto()
end

function var_0_0.PlayCV(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = ShipWordHelper.RawGetCVKey(arg_35_0.ship.skinId)
	local var_35_1 = pg.CriMgr.GetCVBankName(var_35_0)

	arg_35_0.cvLoader:Load(var_35_1, arg_35_3, 0, arg_35_4)
end

function var_0_0.AdjustChatPosition(arg_36_0)
	local var_36_0 = arg_36_0.chatText:GetComponent(typeof(Text))

	if #var_36_0.text > CHAT_POP_STR_LEN then
		var_36_0.alignment = TextAnchor.MiddleLeft
	else
		var_36_0.alignment = TextAnchor.MiddleCenter
	end

	local var_36_1 = var_36_0.preferredHeight + 26

	if var_36_1 > arg_36_0.initChatBgH then
		arg_36_0.chatTextBg.sizeDelta = Vector2.New(arg_36_0.chatTextBg.sizeDelta.x, var_36_1)
	else
		arg_36_0.chatTextBg.sizeDelta = Vector2.New(arg_36_0.chatTextBg.sizeDelta.x, arg_36_0.initChatBgH)
	end

	if arg_36_0.isFoldState then
		local var_36_2 = arg_36_0:GetCenterPos()

		arg_36_0.chatTf.localPosition = Vector3(var_36_2.x, -190, 0)
	end
end

function var_0_0.StartChatAnimtion(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = getProxy(SettingsProxy):ShouldShipMainSceneWord() and 1 or 0
	local var_37_1 = 0.3
	local var_37_2 = arg_37_1 > 0 and arg_37_1 or 3

	LeanTween.scale(rtf(arg_37_0.chatTf.gameObject), Vector3.New(var_37_0, var_37_0, 1), var_37_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_37_0.chatTf.gameObject), Vector3.New(0, 0, 1), var_37_1):setEase(LeanTweenType.easeInBack):setDelay(var_37_1 + var_37_2):setOnComplete(System.Action(arg_37_2))
	end))
end

function var_0_0.StopChatAnimtion(arg_39_0)
	if LeanTween.isTweening(arg_39_0.chatTf.gameObject) then
		LeanTween.cancel(arg_39_0.chatTf.gameObject)
	end

	arg_39_0.chatTf.localScale = Vector3.zero

	arg_39_0:OnEndChatting()
end

function var_0_0.OnStopVoice(arg_40_0)
	arg_40_0.cvLoader:Stop()
end

function var_0_0.CollectIdleEvents(arg_41_0, arg_41_1)
	local var_41_0 = {}

	if getProxy(EventProxy):hasFinishState() and arg_41_1 ~= "event_complete" then
		table.insert(var_41_0, "event_complete")
	else
		if getProxy(TaskProxy):getCanReceiveCount() > 0 and arg_41_1 ~= "mission_complete" then
			table.insert(var_41_0, "mission_complete")
		end

		if getProxy(MailProxy):GetAttachmentCount() > 0 and arg_41_1 ~= "mail" then
			table.insert(var_41_0, "mail")
		end

		if #var_41_0 == 0 then
			local var_41_1 = arg_41_0.ship:getCVIntimacy()

			var_41_0 = var_0_5.filterAssistantEvents(Clone(var_0_5.IdleEvents), arg_41_0.ship.skinId, var_41_1)

			if getProxy(TaskProxy):getNotFinishCount() and getProxy(TaskProxy):getNotFinishCount() > 0 and arg_41_1 ~= "mission" then
				table.insert(var_41_0, "mission")
			end
		end
	end

	return var_41_0
end

function var_0_0.CollectTouchEvents(arg_42_0)
	local var_42_0 = arg_42_0.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.PaintingTouchEvents, arg_42_0.ship.skinId, var_42_0))
end

function var_0_0.GetTouchEvent(arg_43_0, arg_43_1)
	return (var_0_5.filterAssistantEvents(var_0_5.getAssistantTouchEvents(arg_43_1, arg_43_0.ship.skinId), arg_43_0.ship.skinId, 0))
end

function var_0_0.GetIdleEvents(arg_44_0)
	return (var_0_5.filterAssistantEvents(var_0_5.IdleEvents, arg_44_0.ship.skinId, 0))
end

function var_0_0.GetEventConfig(arg_45_0, arg_45_1)
	return var_0_5.assistantEvents[arg_45_1]
end

function var_0_0.GetSpecialTouchEvent(arg_46_0, arg_46_1)
	return var_0_5.getPaintingTouchEvents(arg_46_1)
end

function var_0_0.RemoveTimer(arg_47_0)
	if arg_47_0.timer then
		arg_47_0.timer:Stop()

		arg_47_0.timer = nil
	end
end

function var_0_0.IsExited(arg_48_0)
	return arg_48_0.isExited
end

function var_0_0.Fold(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.isFoldState = arg_49_1

	arg_49_0:RemoveMoveTimer()

	if arg_49_1 and arg_49_2 > 0 then
		LeanTween.value(arg_49_0.container.gameObject, 0, 1, arg_49_2):setOnUpdate(System.Action_float(function(arg_50_0)
			local var_50_0 = arg_49_0:GetCenterPos()

			arg_49_0.chatTf.localPosition = Vector3(var_50_0.x, -190, 0)
		end))
	end

	arg_49_0:OnFold(arg_49_1)
end

function var_0_0.RemoveMoveTimer(arg_51_0)
	if arg_51_0.moveTimer then
		arg_51_0.moveTimer:Stop()

		arg_51_0.moveTimer = nil
	end
end

function var_0_0.EnableOrDisableMove(arg_52_0, arg_52_1)
	arg_52_0.isDragAndZoomState = arg_52_1

	arg_52_0:RemoveMoveTimer()

	if arg_52_1 then
		arg_52_0:StopChatAnimtion()
		arg_52_0:RemoveTimer()
		arg_52_0.cvLoader:Stop()
	else
		arg_52_0:TriggerNextEventAuto()
	end

	arg_52_0:OnEnableOrDisableDragAndZoom(arg_52_1)
end

function var_0_0.GetOffset(arg_53_0)
	return 0
end

function var_0_0.IslimitYPos(arg_54_0)
	return false
end

function var_0_0.Puase(arg_55_0)
	arg_55_0.isPuase = true

	arg_55_0:RemoveMoveTimer()
	arg_55_0:StopChatAnimtion()
	arg_55_0:RemoveTimer()
	arg_55_0.cvLoader:Stop()
	arg_55_0:OnPuase()
end

function var_0_0.Resume(arg_56_0)
	arg_56_0.isPuase = false

	arg_56_0:TriggerNextEventAuto()
	arg_56_0:OnResume()
end

function var_0_0.updateShip(arg_57_0, arg_57_1)
	arg_57_0:OnUpdateShip(arg_57_1)
end

function var_0_0.OnUpdateShip(arg_58_0, arg_58_1)
	return
end

function var_0_0.Dispose(arg_59_0)
	arg_59_0.isExited = true

	pg.DelegateInfo.Dispose(arg_59_0)

	if arg_59_0.state == var_0_3 then
		arg_59_0:UnLoad()
	end

	arg_59_0.cvLoader:Dispose()

	arg_59_0.cvLoader = nil
	arg_59_0.triggerWhenLoaded = false

	arg_59_0:RemoveTimer()
	arg_59_0:RemoveMoveTimer()
end

function var_0_0.OnLoad(arg_60_0, arg_60_1)
	arg_60_1()
end

function var_0_0.OnUnload(arg_61_0)
	return
end

function var_0_0.OnClick(arg_62_0)
	return
end

function var_0_0.OnLongPress(arg_63_0)
	return
end

function var_0_0.OnTriggerEvent(arg_64_0)
	return
end

function var_0_0.OnTriggerEventAuto(arg_65_0)
	return
end

function var_0_0.OnDisplayWorld(arg_66_0, arg_66_1)
	return
end

function var_0_0.OnFold(arg_67_0, arg_67_1)
	return
end

function var_0_0.OnEnableOrDisableDragAndZoom(arg_68_0, arg_68_1)
	return
end

function var_0_0.OnPuase(arg_69_0)
	return
end

function var_0_0.OnResume(arg_70_0)
	return
end

return var_0_0
