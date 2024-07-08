pg = pg or {}
pg.SceneAnimMgr = singletonClass("SceneAnimMgr")

local var_0_0 = pg.SceneAnimMgr

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	print("initializing sceneanim manager...")
	PoolMgr.GetInstance():GetUI("SceneAnimUI", true, function(arg_3_0)
		arg_2_0._go = arg_3_0

		arg_2_0._go:SetActive(false)

		arg_2_0._tf = arg_2_0._go.transform

		arg_2_0._tf:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_2_0.container = arg_2_0._tf:Find("container")

		if arg_2_1 then
			arg_2_1()
		end
	end)
end

function var_0_0.SixthAnniversaryJPCoverGoScene(arg_4_0, arg_4_1)
	arg_4_0.playing = true

	setActive(arg_4_0._tf, true)

	local var_4_0 = "SixthAnniversaryJPCoverUI"

	PoolMgr.GetInstance():GetUI(var_4_0, true, function(arg_5_0)
		local var_5_0 = arg_5_0.transform

		setParent(var_5_0, arg_4_0.container, false)

		local var_5_1 = var_5_0:Find("houshanyunwu"):GetComponent(typeof(SpineAnimUI))

		var_5_1:SetActionCallBack(function(arg_6_0)
			if arg_6_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_4_0, arg_5_0)

				arg_4_0.playing = nil

				setActive(arg_4_0._tf, false)
			elseif arg_6_0 == "action" then
				pg.m02:sendNotification(GAME.GO_SCENE, arg_4_1)
			end
		end)
		var_5_1:SetAction("action", 0)
	end)
end

function var_0_0.Dorm3DSceneChange(arg_7_0, arg_7_1)
	setActive(arg_7_0._tf, true)

	local var_7_0 = "SixthAnniversaryJPCoverUI"

	PoolMgr.GetInstance():GetUI(var_7_0, true, function(arg_8_0)
		local var_8_0 = arg_8_0.transform

		setParent(var_8_0, arg_7_0.container, false)

		local var_8_1 = var_8_0:Find("houshanyunwu"):GetComponent(typeof(SpineAnimUI))

		var_8_1:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "action" then
				var_8_1:Pause()
				arg_7_1(function()
					var_8_1:Resume()
				end)
			elseif arg_9_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_7_0, arg_8_0)

				arg_7_0.playing = nil

				setActive(arg_7_0._tf, false)
			end
		end)
		var_8_1:SetAction("action", 0)
	end)
end

function var_0_0.IsPlaying(arg_11_0)
	return arg_11_0.playing
end

function var_0_0.Dispose(arg_12_0)
	setActive(arg_12_0._tf, false)

	arg_12_0.playing = nil
end
