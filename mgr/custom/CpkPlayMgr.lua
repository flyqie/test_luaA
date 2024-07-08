﻿pg = pg or {}
pg.CpkPlayMgr = singletonClass("CpkPlayMgr")
this = pg.CpkPlayMgr

function this.Ctor(arg_1_0)
	arg_1_0._onPlaying = false
	arg_1_0._mainTF = nil
	arg_1_0._closeLimit = nil
	arg_1_0._animator = nil
	arg_1_0._timer = nil
	arg_1_0._criUsm = nil
	arg_1_0._criCpk = nil
	arg_1_0._stopGameBGM = false
end

function this.Reset(arg_2_0)
	arg_2_0._onPlaying = false
	arg_2_0._mainTF = nil
	arg_2_0._closeLimit = nil
	arg_2_0._animator = nil
	arg_2_0._criUsm = nil
	arg_2_0._criCpk = nil
	arg_2_0._stopGameBGM = false
	arg_2_0._timer = nil
end

function this.OnPlaying(arg_3_0)
	return arg_3_0._onPlaying
end

function this.PlayCpkMovie(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8, arg_4_9)
	pg.DelegateInfo.New(arg_4_0)

	arg_4_0._onPlaying = true
	arg_4_0._stopGameBGM = arg_4_6

	pg.UIMgr.GetInstance():LoadingOn()

	local function var_4_0()
		if not arg_4_0._mainTF then
			return
		end

		if not arg_4_9 and Time.realtimeSinceStartup < arg_4_0._closeLimit then
			return
		end

		setActive(arg_4_0._mainTF, false)
		arg_4_0:DisposeCpkMovie()

		if arg_4_2 then
			arg_4_2()
		end
	end

	local function var_4_1()
		onButton(arg_4_0, arg_4_0._mainTF, function()
			if arg_4_5 then
				var_4_0()
			end
		end)

		if arg_4_0._criUsm then
			arg_4_0._criUsm.player:SetVolume(PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME))
			arg_4_0._criUsm.player:SetShaderDispatchCallback(function(arg_8_0, arg_8_1)
				arg_4_0:checkBgmStop(arg_8_0)

				return nil
			end)
		end

		if arg_4_0._criCpk then
			arg_4_0._criCpk.player:SetVolume(PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME))
			arg_4_0._criCpk.player:SetShaderDispatchCallback(function(arg_9_0, arg_9_1)
				arg_4_0:checkBgmStop(arg_9_0)

				return nil
			end)
		end

		if arg_4_0._animator ~= nil then
			arg_4_0._animator.enabled = true

			local var_6_0 = arg_4_0._mainTF:GetComponent("DftAniEvent")

			var_6_0:SetStartEvent(function(arg_10_0)
				if arg_4_0._criUsm then
					arg_4_0._criUsm:Play()
				end
			end)
			var_6_0:SetEndEvent(function(arg_11_0)
				var_4_0()
			end)
		else
			arg_4_0._timer = Timer.New(var_4_0, arg_4_8)

			arg_4_0._timer:Start()
		end

		setActive(arg_4_0._mainTF, true)

		if arg_4_0._stopGameBGM then
			pg.BgmMgr.GetInstance():StopPlay()
		end

		if arg_4_1 then
			arg_4_1()
		end
	end

	if IsNil(arg_4_0._mainTF) then
		LoadAndInstantiateAsync(arg_4_3, arg_4_4, function(arg_12_0)
			pg.UIMgr.GetInstance():LoadingOff()

			arg_4_0._closeLimit = Time.realtimeSinceStartup + 1

			if not arg_4_0._onPlaying then
				Destroy(arg_12_0)

				return
			end

			arg_4_0._parentTF = arg_4_0._parentTF or GameObject.Find("UICamera/Canvas")

			setParent(arg_12_0, arg_4_0._parentTF)

			arg_4_0._mainTF = arg_12_0

			pg.UIMgr.GetInstance():OverlayPanel(arg_4_0._mainTF.transform, arg_4_7)

			arg_4_0._criUsm = tf(arg_4_0._mainTF):Find("usm"):GetComponent("CriManaEffectUI")
			arg_4_0._criCpk = tf(arg_4_0._mainTF):Find("usm"):GetComponent("CriManaCpkUI")
			arg_4_0._animator = arg_4_0._mainTF:GetComponent("Animator")

			var_4_1()
		end)
	else
		var_4_1()
	end
end

function this.checkBgmStop(arg_13_0, arg_13_1)
	if arg_13_0._onPlaying then
		local var_13_0 = arg_13_1.numAudioStreams

		if var_13_0 and var_13_0 > 0 then
			pg.BgmMgr.GetInstance():StopPlay()

			arg_13_0._stopGameBGM = true
		end
	end
end

function this.DisposeCpkMovie(arg_14_0)
	if arg_14_0._onPlaying then
		if arg_14_0._mainTF then
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._mainTF.transform, arg_14_0._tf)
			Destroy(arg_14_0._mainTF)

			if arg_14_0._animator ~= nil then
				arg_14_0._animator.enabled = false
			end

			if arg_14_0._timer ~= nil then
				arg_14_0._timer:Stop()

				arg_14_0._timer = nil
			end

			if arg_14_0._criUsm then
				arg_14_0._criUsm:Stop()
			end

			if arg_14_0._stopGameBGM then
				pg.BgmMgr.GetInstance():ContinuePlay()
			end

			arg_14_0._onPlaying = false

			pg.DelegateInfo.Dispose(arg_14_0)
		end

		arg_14_0:Reset()
	end
end
