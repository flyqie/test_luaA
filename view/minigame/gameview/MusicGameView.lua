local var_0_0 = class("MusicGameView", import("..BaseMiniGameView"))

var_0_0.loadMusicFlag = 0

local var_0_1 = 1
local var_0_2 = 3
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 2

function var_0_0.getUIName(arg_1_0)
	return "MusicGameUI"
end

function var_0_0.MyGetRuntimeData(arg_2_0)
	local var_2_0 = getProxy(PlayerProxy):getData().id

	arg_2_0.achieve_times = checkExist(arg_2_0:GetMGData():GetRuntimeData("elements"), {
		1
	}) or 0
	arg_2_0.isFirstgame = PlayerPrefs.GetInt("musicgame_first_" .. var_2_0)
	arg_2_0.bestScorelist = {}

	for iter_2_0 = 1, arg_2_0.music_amount * 2 do
		arg_2_0.bestScorelist[iter_2_0] = checkExist(arg_2_0:GetMGData():GetRuntimeData("elements"), {
			iter_2_0 + 2
		}) or 0
	end

	arg_2_0:updatSelectview()
end

function var_0_0.MyStoreDataToServer(arg_3_0)
	local var_3_0 = getProxy(PlayerProxy):getData().id
	local var_3_1 = {
		arg_3_0.achieve_times,
		1
	}

	PlayerPrefs.SetInt("musicgame_first_" .. var_3_0, 1)

	for iter_3_0 = 1, arg_3_0.music_amount * 2 do
		table.insert(var_3_1, iter_3_0 + 2, arg_3_0.bestScorelist[iter_3_0])
	end

	arg_3_0:StoreDataToServer(var_3_1)
end

function var_0_0.init(arg_4_0)
	arg_4_0.UIMgr = pg.UIMgr.GetInstance()
	arg_4_0.useGetKey_flag = true
	arg_4_0.game_playingflag = false
	arg_4_0.countingfive_flag = false
	arg_4_0.downingleft_flag = false
	arg_4_0.downingright_flag = false
	arg_4_0.downingright_lastflag = false
	arg_4_0.downingleft_lastflag = false
	arg_4_0.nowS_flag = false
	arg_4_0.firstview_timerRunflag = false
	arg_4_0.ahead_timeflag = false
	arg_4_0.ahead_timerPauseFlag = false
	arg_4_0.changeLocalposTimerflag = false
	arg_4_0.piecelist_rf = {}
	arg_4_0.piecelist_rf[0] = 0
	arg_4_0.piecelist_lf = {}
	arg_4_0.piecelist_lf[0] = 0
	arg_4_0.piece_nowl = {}
	arg_4_0.piece_nowr = {}
	arg_4_0.piece_nowl_downflag = false
	arg_4_0.piece_nowr_downflag = false
	arg_4_0.piece_nowl_aloneflag = false
	arg_4_0.piece_nowr_aloneflag = false
	arg_4_0.SDmodel = {}
	arg_4_0.SDmodel_idolflag = false
	arg_4_0.musicgame_nowtime = 0
	arg_4_0.musicgame_lasttime = 0
	arg_4_0.time_interval = 0.01666
	arg_4_0.music_amount = 10
	arg_4_0.music_amount_middle = 5
	arg_4_0.game_speed = PlayerPrefs.GetInt("musicgame_idol_speed") > 0 and PlayerPrefs.GetInt("musicgame_idol_speed") or 1
	arg_4_0.game_dgree = 1

	arg_4_0:updateMusic(var_0_1)

	arg_4_0.BG = arg_4_0:findTF("BG")
	arg_4_0.top = arg_4_0:findTF("top")
	arg_4_0.btn_pause = arg_4_0.top:Find("pause")
	arg_4_0.score = arg_4_0.top:Find("score")
	arg_4_0.game_content = arg_4_0:findTF("GameContent")
	arg_4_0.pauseview = arg_4_0:findTF("Pauseview")
	arg_4_0.selectview = arg_4_0:findTF("Selectview")

	local var_4_0 = findTF(arg_4_0.selectview, "bg")

	LoadSpriteAsync("ui/minigameui/musicgameother/selectbg", function(arg_5_0)
		GetComponent(var_4_0, typeof(Image)).sprite = arg_5_0

		setActive(var_4_0, true)
	end)

	arg_4_0.firstview = arg_4_0:findTF("firstview")
	arg_4_0.scoreview = arg_4_0:findTF("ScoreView")

	setActive(arg_4_0.scoreview, false)

	arg_4_0.scoreview_flag = false
	arg_4_0.fullComboEffect = arg_4_0.game_content:Find("yinyue20_Fullcombo")
	arg_4_0.liveClearEffect = arg_4_0.game_content:Find("yinyue20_LiveClear")
	arg_4_0.bg = findTF(arg_4_0._tf, "bg")

	pg.CriMgr.GetInstance():StopBGM()
end

function var_0_0.didEnter(arg_6_0)
	local var_6_0 = 0

	local function var_6_1()
		var_6_0 = var_6_0 + arg_6_0.time_interval

		if var_6_0 == arg_6_0.time_interval then
			arg_6_0:MyGetRuntimeData()
			arg_6_0:showSelevtView()
		elseif var_6_0 == arg_6_0.time_interval * 2 then
			arg_6_0:updatSelectview()
			arg_6_0.Getdata_timer:Stop()
		end
	end

	LeanTween.delayedCall(go(arg_6_0.selectview), 2, System.Action(function()
		arg_6_0:MyGetRuntimeData()
	end))

	arg_6_0.Getdata_timer = Timer.New(var_6_1, arg_6_0.time_interval, -1)

	arg_6_0.Getdata_timer:Start()

	arg_6_0.score_number = 0
	arg_6_0.combo_link = 0
	arg_6_0.combo_number = 0
	arg_6_0.perfect_number = 0
	arg_6_0.good_number = 0
	arg_6_0.miss_number = 0

	local var_6_2 = arg_6_0:GetMGData():getConfig("simple_config_data")

	arg_6_0.piecelist_speed = var_6_2.speed
	arg_6_0.piecelist_speedmin = var_6_2.speed_min
	arg_6_0.piecelist_speedmax = var_6_2.speed_max
	arg_6_0.score_blist = var_6_2.Blist
	arg_6_0.score_alist = var_6_2.Alist
	arg_6_0.score_slist = var_6_2.Slist
	arg_6_0.score_sslist = var_6_2.SSlist
	arg_6_0.specialcombo_number = var_6_2.special_combo
	arg_6_0.specialscore_number = var_6_2.special_score
	arg_6_0.score_perfect = var_6_2.perfect
	arg_6_0.score_good = var_6_2.good
	arg_6_0.score_miss = var_6_2.miss
	arg_6_0.score_combo = var_6_2.combo
	arg_6_0.time_perfect = var_6_2.perfecttime
	arg_6_0.time_good = var_6_2.goodtime
	arg_6_0.time_miss = var_6_2.misstime
	arg_6_0.time_laterperfect = var_6_2.laterperfecttime
	arg_6_0.time_latergood = var_6_2.latergoodtime
	arg_6_0.combo_interval = var_6_2.combo_interval
	arg_6_0.leftBtmBg = arg_6_0.game_content:Find("bottomList2/bottom_leftbg")
	arg_6_0.rightBtmBg = arg_6_0.game_content:Find("bottomList2/bottom_rightbg")

	setActive(arg_6_0.leftBtmBg, false)
	setActive(arg_6_0.rightBtmBg, false)

	arg_6_0.BtnRightDelegate = GetOrAddComponent(arg_6_0.game_content:Find("btn_right"), "EventTriggerListener")

	arg_6_0.BtnRightDelegate:AddPointDownFunc(function()
		arg_6_0.mousedowningright_flag = true

		setActive(arg_6_0.rightBtmBg, true)
	end)
	arg_6_0.BtnRightDelegate:AddPointUpFunc(function()
		arg_6_0.mousedowningright_flag = false

		setActive(arg_6_0.rightBtmBg, false)
	end)

	arg_6_0.BtnLeftDelegate = GetOrAddComponent(arg_6_0.game_content:Find("btn_left"), "EventTriggerListener")

	arg_6_0.BtnLeftDelegate:AddPointDownFunc(function()
		arg_6_0.mousedowningleft_flag = true

		setActive(arg_6_0.leftBtmBg, true)
	end)
	arg_6_0.BtnLeftDelegate:AddPointUpFunc(function()
		arg_6_0.mousedowningleft_flag = false

		setActive(arg_6_0.leftBtmBg, false)
	end)
	onButton(arg_6_0, arg_6_0.top:Find("pause"), function()
		arg_6_0.UIMgr:BlurPanel(arg_6_0.pauseview)
		setActive(arg_6_0.pauseview, true)

		arg_6_0.game_playingflag = false

		arg_6_0:effect_play("nothing")

		arg_6_0.pauseview:Find("bottom/song"):GetComponent(typeof(Image)).sprite = arg_6_0.selectview:Find("Main/MusicList/img/" .. arg_6_0.musicData.img):GetComponent(typeof(Image)).sprite

		if not arg_6_0.ahead_timeflag then
			arg_6_0:pauseBgm()

			local var_13_0 = arg_6_0:getStampTime()
			local var_13_1 = arg_6_0.song_Tlength

			if var_13_0 < 0 then
				var_13_0 = 0
			end

			if var_13_0 >= 0 and var_13_1 > 0 then
				local function var_13_2(arg_14_0)
					if arg_14_0 < 10 then
						return "0" .. arg_14_0
					else
						return arg_14_0
					end
				end

				local var_13_3 = var_13_2(math.floor(var_13_0 % 60000 / 1000))
				local var_13_4 = var_13_2(math.floor(var_13_0 / 60000))

				setText(arg_6_0.pauseview:Find("bottom/now"), var_13_4 .. ":" .. var_13_3)

				local var_13_5 = var_13_2(math.floor(var_13_1 % 60000 / 1000))
				local var_13_6 = var_13_2(math.floor(var_13_1 / 60000))

				setText(arg_6_0.pauseview:Find("bottom/total"), var_13_6 .. ":" .. var_13_5)
				setActive(arg_6_0.pauseview:Find("bottom/triangle"), true)
				setActive(arg_6_0.pauseview:Find("bottom/TimeSlider"), true)
				setActive(arg_6_0.pauseview:Find("bottom/now"), true)
				setActive(arg_6_0.pauseview:Find("bottom/total"), true)
				setSlider(arg_6_0.pauseview:Find("bottom/TimeSlider"), 0, 1, var_13_0 / var_13_1)

				local var_13_7 = arg_6_0.pauseview:Find("bottom/triangle/min").localPosition.x
				local var_13_8 = arg_6_0.pauseview:Find("bottom/triangle/max").localPosition.x
				local var_13_9 = arg_6_0.pauseview:Find("bottom/triangle/now").localPosition

				arg_6_0.pauseview:Find("bottom/triangle/now").localPosition = Vector3(var_13_7 + var_13_0 / var_13_1 * (var_13_8 - var_13_7), var_13_9.y, var_13_9.z)

				arg_6_0:setActionSDmodel("stand2")
			end
		else
			setActive(arg_6_0.pauseview:Find("bottom/triangle"), false)
			setActive(arg_6_0.pauseview:Find("bottom/TimeSlider"), false)
			setActive(arg_6_0.pauseview:Find("bottom/now"), false)
			setActive(arg_6_0.pauseview:Find("bottom/total"), false)

			arg_6_0.ahead_timerPauseFlag = true
		end
	end, SFX_UI_CLICK)
	onButton(arg_6_0, arg_6_0.pauseview:Find("bottom/back"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("reselect_music_game"),
			onYes = function()
				arg_6_0.UIMgr:UnblurPanel(arg_6_0.pauseview, arg_6_0._tf)
				setActive(arg_6_0.pauseview, false)
				arg_6_0:stopTimer()

				if arg_6_0.ahead_timer then
					arg_6_0.ahead_timer:Stop()

					arg_6_0.ahead_timeflag = false
				end

				arg_6_0:piecelistALLTtoF()
				setActive(arg_6_0.selectview, true)

				GetOrAddComponent(arg_6_0.selectview, "CanvasGroup").blocksRaycasts = true

				arg_6_0.song_btns[arg_6_0.game_music]:GetComponent(typeof(Animator)):Play("plate_out")

				arg_6_0.game_playingflag = false

				arg_6_0:loadAndPlayMusic()
				arg_6_0:rec_scorce()
			end
		})
	end, SFX_UI_CLICK)
	onButton(arg_6_0, arg_6_0.pauseview:Find("bottom/restart"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("restart_music_game"),
			onYes = function()
				arg_6_0.UIMgr:UnblurPanel(arg_6_0.pauseview, arg_6_0._tf)
				setActive(arg_6_0.pauseview, false)
				arg_6_0:stopTimer()

				if arg_6_0.ahead_timer then
					arg_6_0.ahead_timer:Stop()

					arg_6_0.ahead_timeflag = false
				end

				arg_6_0:piecelistALLTtoF()
				arg_6_0:rec_scorce()
				arg_6_0:game_start()
				arg_6_0:effect_play("prepare")
			end
		})
	end, SFX_UI_CLICK)
	onButton(arg_6_0, arg_6_0.pauseview:Find("bottom/resume"), function()
		arg_6_0.UIMgr:UnblurPanel(arg_6_0.pauseview, arg_6_0._tf)
		setActive(arg_6_0.pauseview, false)
		arg_6_0:effect_play("prepare")

		if not arg_6_0.ahead_timeflag then
			local function var_19_0()
				arg_6_0:resumeBgm()

				arg_6_0.game_playingflag = true
			end

			arg_6_0:count_five(var_19_0)
		else
			local function var_19_1()
				arg_6_0.ahead_timerPauseFlag = false
				arg_6_0.game_playingflag = true

				setActive(arg_6_0.pauseview:Find("bottom/triangle"), true)
				setActive(arg_6_0.pauseview:Find("bottom/TimeSlider"), true)
				setActive(arg_6_0.pauseview:Find("bottom/now"), true)
				setActive(arg_6_0.pauseview:Find("bottom/total"), true)
			end

			arg_6_0:count_five(var_19_1)
		end
	end, SFX_UI_CLICK)
	arg_6_0:addRingDragListenter()
	setActive(arg_6_0.selectview, true)

	GetOrAddComponent(arg_6_0.selectview, "CanvasGroup").blocksRaycasts = true

	local var_6_3 = arg_6_0.top:Find("ScoreSlider")
	local var_6_4 = arg_6_0.top:Find("ScoreSlider/B")
	local var_6_5 = arg_6_0.top:Find("ScoreSlider/A")
	local var_6_6 = arg_6_0.top:Find("ScoreSlider/S")

	var_6_4.anchoredPosition = Vector3(var_6_3.rect.width * 0.53, var_6_4.anchoredPosition.y, var_6_4.anchoredPosition.z)
	var_6_5.anchoredPosition = Vector3(var_6_3.rect.width * 0.72, var_6_4.anchoredPosition.y, var_6_4.anchoredPosition.z)
	var_6_6.anchoredPosition = Vector3(var_6_3.rect.width * 0.885, var_6_4.anchoredPosition.y, var_6_4.anchoredPosition.z)
end

function var_0_0.updateMusicPiece(arg_22_0)
	arg_22_0.music_piece = arg_22_0.game_content:Find("MusicPiece" .. arg_22_0.musicData.music_piece)

	for iter_22_0 = 1, var_0_5 do
		setActive(findTF(arg_22_0.game_content, "MusicPiece" .. iter_22_0), iter_22_0 == arg_22_0.musicData.music_piece)
	end
end

function var_0_0.updateBg(arg_23_0)
	if arg_23_0.isLoading then
		arg_23_0:dynamicBgHandler(arg_23_0.bgGo, function()
			setParent(arg_23_0.bgGo, arg_23_0.bg)
			setActive(arg_23_0.bgGo, true)
		end)

		return
	end

	if arg_23_0.bgGo and arg_23_0.bgName then
		arg_23_0:dynamicBgHandler(arg_23_0.bgGo)
		PoolMgr.GetInstance():ReturnUI(arg_23_0.bgName, arg_23_0.bgGo)
	end

	arg_23_0.bgName = "musicgamebg" .. arg_23_0.musicBg
	arg_23_0.isLoading = true

	local var_23_0 = arg_23_0.bgName

	PoolMgr.GetInstance():GetUI(var_23_0, true, function(arg_25_0)
		arg_23_0.bgGo = arg_25_0

		if arg_23_0.isLoading == false then
			arg_23_0:dynamicBgHandler(arg_23_0.bgGo)
			PoolMgr.GetInstance():ReturnUI(var_23_0, arg_23_0.bgGo)
		else
			arg_23_0.isLoading = false

			setParent(arg_23_0.bgGo, arg_23_0.bg)
			setActive(arg_23_0.bgGo, true)
		end
	end)
end

function var_0_0.dynamicBgHandler(arg_26_0, arg_26_1, arg_26_2)
	if IsNil(arg_26_1) then
		return
	end

	if arg_26_2 ~= nil then
		arg_26_2()
	end
end

function var_0_0.onBackPressed(arg_27_0)
	if not arg_27_0.countingfive_flag and not arg_27_0.firstview_timerRunflag then
		if arg_27_0.game_playingflag then
			if not isActive(arg_27_0.top:Find("pause_above")) then
				triggerButton(arg_27_0.top:Find("pause"))
			end
		elseif isActive(arg_27_0.selectview) and MusicGameView.loadMusicFlag == 0 then
			arg_27_0:emit(var_0_0.ON_BACK)
		end
	end
end

function var_0_0.OnApplicationPaused(arg_28_0, arg_28_1)
	if arg_28_1 and not arg_28_0.countingfive_flag and not arg_28_0.firstview_timerRunflag and arg_28_0.game_playingflag and not isActive(arg_28_0.top:Find("pause_above")) then
		triggerButton(arg_28_0.top:Find("pause"))
	end
end

function var_0_0.willExit(arg_29_0)
	arg_29_0.isLoading = false

	if arg_29_0.bgGo and arg_29_0.bgName then
		arg_29_0:dynamicBgHandler(arg_29_0.bgGo)
		PoolMgr.GetInstance():ReturnUI(arg_29_0.bgName, arg_29_0.bgGo)
	end

	if arg_29_0.timer then
		if arg_29_0.timer.running then
			arg_29_0.timer:Stop()
		end

		arg_29_0.timer = nil
	end

	if arg_29_0.ahead_timer then
		if arg_29_0.ahead_timer.running then
			arg_29_0.ahead_timer:Stop()
		end

		arg_29_0.ahead_timer = nil
	end

	if arg_29_0.firstview_timer then
		if arg_29_0.firstview_timer.running then
			arg_29_0.firstview_timer:Stop()
		end

		arg_29_0.firstview_timer = nil
	end

	if arg_29_0.changeLocalpos_timer then
		if arg_29_0.changeLocalpos_timer.running then
			arg_29_0.changeLocalpos_timer:Stop()
		end

		arg_29_0.changeLocalpos_timer = nil
	end

	if arg_29_0.count_timer then
		if arg_29_0.count_timer.running then
			arg_29_0.count_timer:Stop()
		end

		arg_29_0.count_timer = nil
	end

	if arg_29_0.Scoceview_timer then
		if arg_29_0.Scoceview_timer.running then
			arg_29_0.Scoceview_timer:Stop()
		end

		arg_29_0.Scoceview_timer = nil
	end

	if arg_29_0.Getdata_timer then
		if arg_29_0.Getdata_timer.running then
			arg_29_0.Getdata_timer:Stop()
		end

		arg_29_0.Getdata_timer = nil
	end

	arg_29_0:clearSDModel()

	arg_29_0.piecelist_lt = {}
	arg_29_0.piecelist_lf = {}
	arg_29_0.musictable_l = {}
	arg_29_0.piece_nowl = {}
	arg_29_0.piecelist_rt = {}
	arg_29_0.piecelist_rf = {}
	arg_29_0.musictable_r = {}
	arg_29_0.piece_nowr = {}

	if arg_29_0.painting then
		retPaintingPrefab(arg_29_0.scoreview:Find("paint"), arg_29_0.painting)

		arg_29_0.painting = nil
	end

	if arg_29_0.criInfo then
		arg_29_0.criInfo:PlaybackStop()
		arg_29_0.criInfo:SetStartTimeAndPlay(0)
		pg.CriMgr.GetInstance():UnloadCueSheet("bgm-song" .. arg_29_0.musicData.bgm)

		arg_29_0.criInfo = nil
	end

	if LeanTween.isTweening(go(arg_29_0.selectview)) then
		LeanTween.cancel(go(arg_29_0.selectview))
	end

	if LeanTween.isTweening(go(arg_29_0.BG)) then
		LeanTween.cancel(go(arg_29_0.BG))
	end

	if LeanTween.isTweening(go(arg_29_0.scoreview)) then
		LeanTween.cancel(go(arg_29_0.scoreview))
	end

	if LeanTween.isTweening(go(arg_29_0.game_content)) then
		LeanTween.cancel(go(arg_29_0.game_content))
	end
end

function var_0_0.clearSDModel(arg_30_0)
	if not arg_30_0.SDmodel or not arg_30_0.SDname then
		return
	end

	for iter_30_0 = 1, #arg_30_0.SDmodel do
		if arg_30_0.SDmodel[iter_30_0] then
			PoolMgr.GetInstance():ReturnSpineChar(arg_30_0.SDname[iter_30_0], arg_30_0.SDmodel[iter_30_0])
		end
	end

	arg_30_0.SDmodel = {}
end

function var_0_0.list_push(arg_31_0, arg_31_1, arg_31_2)
	arg_31_1[arg_31_1[0] + 1] = arg_31_2
	arg_31_1[0] = arg_31_1[0] + 1
end

function var_0_0.list_pop(arg_32_0, arg_32_1)
	if arg_32_1[0] == 0 then
		return
	end

	local var_32_0 = arg_32_1[1]

	for iter_32_0 = 1, arg_32_1[0] - 1 do
		arg_32_1[iter_32_0] = arg_32_1[iter_32_0 + 1]
	end

	arg_32_1[0] = arg_32_1[0] - 1

	return var_32_0
end

function var_0_0.game_start(arg_33_0)
	arg_33_0:game_before()
	arg_33_0:effect_play("prepare")

	arg_33_0.game_playingflag = true
	arg_33_0.SDmodel_jumpcount = 0
	arg_33_0.gotspecialcombo_flag = false

	arg_33_0:updateBg()

	arg_33_0.song_Tlength = false

	arg_33_0:effect_play("nothing")
	arg_33_0:effect_play("prepare")

	if arg_33_0.isFirstgame == 0 then
		arg_33_0:Firstshow(arg_33_0.firstview, function()
			arg_33_0:gameStart()
		end, 2)
		arg_33_0:MyStoreDataToServer()
	else
		arg_33_0:gameStart()
	end
end

function var_0_0.game_before(arg_35_0)
	arg_35_0:effect_play("nothing")

	arg_35_0.nowS_flag = false

	setActive(arg_35_0.top:Find("ScoreSlider/House/yinyue20_S"), false)

	arg_35_0.scoreSFlag = false

	setImageColor(arg_35_0.top:Find("ScoreSlider/House"), Color(1, 1, 1, 1))

	local var_35_0 = arg_35_0.game_content:Find("evaluate")

	for iter_35_0 = 1, 3 do
		setActive(var_35_0:GetChild(iter_35_0 - 1), false)
	end

	arg_35_0:clearSDModel()

	for iter_35_1 = 1, #arg_35_0.SDname do
		arg_35_0:loadSDModel(iter_35_1)
	end

	arg_35_0:setActionSDmodel("stand2")
	setActive(arg_35_0.game_content:Find("combo"), false)
	setActive(arg_35_0.game_content:Find("combo_n"), false)
	setActive(arg_35_0.game_content:Find("MusicStar"), false)
	setActive(arg_35_0.game_content, true)
	setActive(arg_35_0._tf:Find("Spinelist"), true)
	setActive(arg_35_0._tf:Find("lightList"), true)
	setActive(arg_35_0._tf:Find("shadowlist"), true)
	setActive(arg_35_0.top, true)
	setActive(arg_35_0.fullComboEffect, false)
	setActive(arg_35_0.liveClearEffect, false)

	local var_35_1 = require("view/miniGame/gameView/musicGame/bgm_song" .. arg_35_0.musicData.pu .. "_" .. arg_35_0.game_dgree)

	arg_35_0.leftPu = {}
	arg_35_0.rightPu = {}

	for iter_35_2, iter_35_3 in ipairs(var_35_1.left_track) do
		table.insert(arg_35_0.leftPu, iter_35_3)
	end

	for iter_35_4, iter_35_5 in ipairs(var_35_1.right_track) do
		table.insert(arg_35_0.rightPu, iter_35_5)
	end

	if not arg_35_0.gameNoteLeft then
		arg_35_0.gameNoteLeft = MusicGameNote.New(findTF(arg_35_0.game_content, "MusicPieceLeft"), MusicGameNote.type_left)
	end

	if not arg_35_0.gameNoteRight then
		arg_35_0.gameNoteRight = MusicGameNote.New(findTF(arg_35_0.game_content, "MusicPieceRight"), MusicGameNote.type_right)
	end

	arg_35_0.gameNoteLeft:setStartData(arg_35_0.leftPu, arg_35_0.game_speed, arg_35_0.game_dgree)
	arg_35_0.gameNoteLeft:setStateCallback(function(arg_36_0)
		arg_35_0:onStateCallback(arg_36_0)
	end)
	arg_35_0.gameNoteLeft:setLongTimeCallback(function(arg_37_0)
		arg_35_0:onLongTimeCallback(arg_37_0)
	end)
	arg_35_0.gameNoteRight:setStartData(arg_35_0.rightPu, arg_35_0.game_speed, arg_35_0.game_dgree)
	arg_35_0.gameNoteRight:setStateCallback(function(arg_38_0)
		arg_35_0:onStateCallback(arg_38_0)
	end)
	arg_35_0.gameNoteRight:setLongTimeCallback(function(arg_39_0)
		arg_35_0:onLongTimeCallback(arg_39_0)
	end)

	arg_35_0.gameStepTime = 0
	arg_35_0.musictable_l = {}
	arg_35_0.musictable_l[0] = 0
	arg_35_0.musictable_r = {}
	arg_35_0.musictable_r[0] = 0
	arg_35_0.nowmusic_l = nil
	arg_35_0.nowmusic_r = nil
	arg_35_0.musicpu = require("view/miniGame/gameView/musicGame/bgm_song" .. arg_35_0.musicData.pu .. "_" .. arg_35_0.game_dgree)

	for iter_35_6, iter_35_7 in ipairs(arg_35_0.musicpu.left_track) do
		arg_35_0:list_push(arg_35_0.musictable_l, iter_35_7)
	end

	for iter_35_8, iter_35_9 in ipairs(arg_35_0.musicpu.right_track) do
		arg_35_0:list_push(arg_35_0.musictable_r, iter_35_9)
	end

	arg_35_0.piecelist = {}
	arg_35_0.piece_n = 0
	arg_35_0.piecelist_lt = {}
	arg_35_0.piecelist_lt[0] = 0
	arg_35_0.piecelist_rt = {}
	arg_35_0.piecelist_rt[0] = 0
	arg_35_0.pieceinit_xyz = {}
	arg_35_0.pieceinit_xyz.left = arg_35_0.music_piece:Find("piece_left").localPosition
	arg_35_0.pieceinit_xyz.right = arg_35_0.music_piece:Find("piece_right").localPosition
end

function var_0_0.stopTimer(arg_40_0)
	if arg_40_0.timer.running then
		arg_40_0.timer:Stop()
	end
end

function var_0_0.startTimer(arg_41_0)
	if not arg_41_0.timer.running then
		arg_41_0.timer:Start()
	end
end

function var_0_0.loadSDModel(arg_42_0, arg_42_1)
	if not arg_42_0.SDname[arg_42_1] then
		arg_42_0.SDmodel[arg_42_1] = false

		setActive(findTF(arg_42_0._tf, "shadowlist/" .. arg_42_1), false)
		setActive(findTF(arg_42_0._tf, "lightList/" .. arg_42_1), false)

		return
	end

	setActive(findTF(arg_42_0._tf, "lightList/" .. arg_42_1), true)

	if arg_42_0.musicLight then
		setActive(findTF(arg_42_0._tf, "shadowlist/" .. arg_42_1), true)
	else
		setActive(findTF(arg_42_0._tf, "shadowlist/" .. arg_42_1), false)
	end

	for iter_42_0 = 1, var_0_3 do
		setActive(findTF(arg_42_0._tf, "lightList/" .. arg_42_1 .. "/" .. iter_42_0), iter_42_0 == arg_42_0.musicLight)
	end

	PoolMgr.GetInstance():GetSpineChar(arg_42_0.SDname[arg_42_1], true, function(arg_43_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_42_0.SDmodel[arg_42_1] = arg_43_0
		tf(arg_43_0).localScale = Vector3(1, 1, 1)

		arg_43_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_43_0, arg_42_0._tf:Find("Spinelist/" .. arg_42_1))
	end)
end

function var_0_0.SDmodeljump_btnup(arg_44_0)
	if arg_44_0.downingright_flag or arg_44_0.downingleft_flag then
		arg_44_0.SDmodel_jumpcount = arg_44_0.SDmodel_jumpcount + arg_44_0.time_interval
		arg_44_0.SDmodel_jumpcount = arg_44_0.SDmodel_jumpcount > 1 and 1 or arg_44_0.SDmodel_jumpcount
	else
		if arg_44_0.SDmodel_jumpcount == 1 then
			arg_44_0:setActionSDmodel("jump")

			arg_44_0.SDmodel_idolflag = false
		end

		if arg_44_0.SDmodel_jumpcount > 0 then
			arg_44_0.SDmodel_jumpcount = arg_44_0.SDmodel_jumpcount - arg_44_0.time_interval
			arg_44_0.SDmodel_jumpcount = arg_44_0.SDmodel_jumpcount < 0 and 0 or arg_44_0.SDmodel_jumpcount
		end

		if arg_44_0.SDmodel_jumpcount == 0 and not arg_44_0.SDmodel_idolflag then
			arg_44_0.SDmodel_idolflag = true

			arg_44_0:setActionSDmodel("idol")
		end
	end
end

function var_0_0.setActionSDmodel(arg_45_0, arg_45_1, arg_45_2)
	arg_45_2 = arg_45_2 or 0

	for iter_45_0 = 1, #arg_45_0.SDmodel do
		if arg_45_0.SDmodel[iter_45_0] then
			arg_45_0.SDmodel[iter_45_0]:GetComponent("SpineAnimUI"):SetAction(arg_45_1, arg_45_2)
		end
	end
end

function var_0_0.loadAndPlayMusic(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0
	local var_46_1 = arg_46_0.musicData.bgm
	local var_46_2 = "bgm-song" .. var_46_1

	MusicGameView.loadMusicFlag = MusicGameView.loadMusicFlag + 1

	CriWareMgr.Inst:PlayBGM(var_46_2, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_47_0)
		if arg_47_0 == nil then
			warning("Missing BGM :" .. (var_46_2 or "NIL"))
		else
			print("加载完毕,开始播放音乐")

			if arg_46_0.countingfive_flag then
				return
			end

			arg_46_0.criInfo = arg_47_0
			arg_46_0.song_Tlength = arg_47_0:GetLength()

			arg_47_0:PlaybackStop()
			arg_47_0:SetStartTimeAndPlay(arg_46_2 and arg_46_2 >= 0 and arg_46_2 or 0)

			MusicGameView.loadMusicFlag = MusicGameView.loadMusicFlag - 1

			if arg_46_1 then
				arg_46_1()
			end
		end
	end)
end

function var_0_0.getStampTime(arg_48_0)
	if arg_48_0.aheadtime_count then
		return (arg_48_0.aheadtime_count - 2) * 1000
	elseif arg_48_0.criInfo then
		return arg_48_0.criInfo:GetTime()
	end

	return nil
end

function var_0_0.pauseBgm(arg_49_0)
	if arg_49_0.criInfo then
		arg_49_0.pauseTime = arg_49_0.criInfo:GetTime()

		arg_49_0.criInfo:PlaybackStop()
	end

	if arg_49_0.timer and arg_49_0.timer.running then
		arg_49_0.timer:Stop()
	end
end

function var_0_0.resumeBgm(arg_50_0)
	if not arg_50_0.timer.running then
		arg_50_0.timer:Start()
	end

	arg_50_0:loadAndPlayMusic(function()
		return
	end, arg_50_0.pauseTime)
end

function var_0_0.rec_scorce(arg_52_0)
	arg_52_0.score_number = 0
	arg_52_0.combo_link = 0
	arg_52_0.combo_number = 0
	arg_52_0.perfect_number = 0
	arg_52_0.good_number = 0
	arg_52_0.miss_number = 0
	arg_52_0.gotspecialcombo_flag = false

	setActive(arg_52_0.top:Find("ScoreSlider/B/bl"), false)
	setActive(arg_52_0.top:Find("ScoreSlider/A/al"), false)
	setActive(arg_52_0.top:Find("ScoreSlider/S/sl"), false)
	setSlider(arg_52_0.top:Find("ScoreSlider"), 0, 1, 0)
	setSlider(arg_52_0.top:Find("ScoreSlider"), 0, 1, 0)
	setText(arg_52_0.top:Find("score"), 0)
	setText(arg_52_0.game_content:Find("combo_n"), 0)
end

function var_0_0.effect_play(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_1 == "nothing" then
		setActive(arg_53_0.game_content:Find("yinyue_perfect_loop02"), false)
		setActive(arg_53_0.top:Find("ScoreSlider/S/liubianxing"), false)
		setActive(arg_53_0.game_content:Find("yinyue_good"), false)
		setActive(arg_53_0.game_content:Find("yinyue_perfect"), false)
		setActive(arg_53_0.game_content:Find("MusicStar"), false)
		SetActive(arg_53_0.game_content:Find("yinyue_comboeffect"), false)
	elseif arg_53_1 == "prepare" then
		-- block empty
	elseif arg_53_1 == "good" then
		setActive(arg_53_0.game_content:Find("yinyue_good"), false)
		setActive(arg_53_0.game_content:Find("yinyue_good"), true)
	elseif arg_53_1 == "perfect" then
		setActive(arg_53_0.game_content:Find("yinyue_perfect"), false)
		setActive(arg_53_0.game_content:Find("yinyue_perfect"), true)
	elseif arg_53_1 == "perfect_loop02" then
		if arg_53_2 then
			if not isActive(arg_53_0.game_content:Find("yinyue_perfect_loop02")) then
				setActive(arg_53_0.game_content:Find("yinyue_perfect_loop02"), true)
			end
		else
			setActive(arg_53_0.game_content:Find("yinyue_perfect_loop02"), false)
		end
	elseif arg_53_1 == "S" then
		if arg_53_2 then
			setActive(arg_53_0.top:Find("ScoreSlider/House/yinyue20_S"), true)
			setActive(arg_53_0.top:Find("ScoreSlider/S/liubianxing"), true)
		else
			setActive(arg_53_0.top:Find("ScoreSlider/House/yinyue20_S"), false)
			setActive(arg_53_0.top:Find("ScoreSlider/S/liubianxing"), false)
		end
	end
end

function var_0_0.scoresliderAcombo_update(arg_54_0)
	local var_54_0 = arg_54_0.score_number
	local var_54_1 = 0

	setText(arg_54_0.top:Find("score"), arg_54_0.score_number)

	local var_54_2 = arg_54_0.game_music
	local var_54_3 = arg_54_0.game_dgree

	if var_54_0 < arg_54_0.score_blist[var_54_2][var_54_3] then
		var_54_1 = var_54_0 / arg_54_0.score_blist[var_54_2][var_54_3] * 0.53
	elseif var_54_0 >= arg_54_0.score_blist[var_54_2][var_54_3] and var_54_0 < arg_54_0.score_alist[var_54_2][var_54_3] then
		var_54_1 = 0.53 + (var_54_0 - arg_54_0.score_blist[var_54_2][var_54_3]) / (arg_54_0.score_alist[var_54_2][var_54_3] - arg_54_0.score_blist[var_54_2][var_54_3]) * 0.19
	elseif var_54_0 >= arg_54_0.score_alist[var_54_2][var_54_3] and var_54_0 < arg_54_0.score_slist[var_54_2][var_54_3] then
		var_54_1 = 0.72 + (var_54_0 - arg_54_0.score_alist[var_54_2][var_54_3]) / (arg_54_0.score_slist[var_54_2][var_54_3] - arg_54_0.score_alist[var_54_2][var_54_3]) * 0.155
	else
		var_54_1 = 0.885 + (var_54_0 - arg_54_0.score_slist[var_54_2][var_54_3]) / (arg_54_0.score_sslist[var_54_2][var_54_3] - arg_54_0.score_slist[var_54_2][var_54_3]) * 0.115
	end

	setSlider(arg_54_0.top:Find("ScoreSlider"), 0, 1, var_54_1)

	if var_54_1 < 0.53 then
		setActive(arg_54_0.top:Find("ScoreSlider/B/bl"), false)
		setActive(arg_54_0.top:Find("ScoreSlider/A/al"), false)
		setActive(arg_54_0.top:Find("ScoreSlider/S/sl"), false)
	elseif var_54_1 >= 0.53 then
		setActive(arg_54_0.top:Find("ScoreSlider/B/bl"), true)

		if var_54_1 >= 0.72 then
			setActive(arg_54_0.top:Find("ScoreSlider/A/al"), true)

			if var_54_1 >= 0.885 then
				if not arg_54_0.nowS_flag then
					arg_54_0.nowS_flag = true

					arg_54_0:effect_play("S", true)
				end

				setActive(arg_54_0.top:Find("ScoreSlider/S/sl"), true)
				setImageColor(arg_54_0.top:Find("ScoreSlider/House"), Color(1, 1, 1, 0))
			end
		end
	end

	setText(arg_54_0.game_content:Find("combo_n"), arg_54_0.combo_link)
end

function var_0_0.piecelistALLTtoF(arg_55_0)
	local var_55_0 = arg_55_0.piecelist_lt[0]

	for iter_55_0 = 1, var_55_0 do
		local var_55_1 = arg_55_0:list_pop(arg_55_0.piecelist_lt)

		var_55_1.ob.localPosition = arg_55_0.pieceinit_xyz.left

		setActive(var_55_1.ob, false)
		arg_55_0:list_push(arg_55_0.piecelist_lf, var_55_1.ob)
	end

	if arg_55_0.piece_nowl.ob then
		arg_55_0.piece_nowl.ob.localPosition = arg_55_0.pieceinit_xyz.left

		setActive(arg_55_0.piece_nowl.ob, false)
		arg_55_0:list_push(arg_55_0.piecelist_lf, arg_55_0.piece_nowl.ob)

		arg_55_0.piece_nowl.ob = false
	end

	local var_55_2 = arg_55_0.piecelist_rt[0]

	for iter_55_1 = 1, var_55_2 do
		local var_55_3 = arg_55_0:list_pop(arg_55_0.piecelist_rt)

		var_55_3.ob.localPosition = arg_55_0.pieceinit_xyz.right

		setActive(var_55_3.ob, false)
		arg_55_0:list_push(arg_55_0.piecelist_rf, var_55_3.ob)
	end

	if arg_55_0.piece_nowr.ob then
		arg_55_0.piece_nowr.ob.localPosition = arg_55_0.pieceinit_xyz.right

		setActive(arg_55_0.piece_nowr.ob, false)
		arg_55_0:list_push(arg_55_0.piecelist_rf, arg_55_0.piece_nowr.ob)

		arg_55_0.piece_nowr.ob = false
	end
end

function var_0_0.score_update(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.game_content:Find("evaluate")

	for iter_56_0 = 1, 3 do
		setActive(var_56_0:GetChild(iter_56_0 - 1), false)
	end

	setActive(var_56_0:GetChild(arg_56_1), true)

	if arg_56_1 == 0 then
		arg_56_0.combo_link = 0
		arg_56_0.score_number = arg_56_0.score_number + arg_56_0.score_miss
		arg_56_0.miss_number = arg_56_0.miss_number + 1

		setActive(arg_56_0.game_content:Find("combo"), false)
		setActive(arg_56_0.game_content:Find("combo_n"), false)
	else
		arg_56_0.combo_link = arg_56_0.combo_link + 1
		arg_56_0.combo_number = arg_56_0.combo_number > arg_56_0.combo_link and arg_56_0.combo_number or arg_56_0.combo_link

		if arg_56_0.combo_link > 1 then
			setActive(arg_56_0.game_content:Find("combo"), true)
			setActive(arg_56_0.game_content:Find("combo_n"), true)
			arg_56_0.game_content:Find("combo"):GetComponent(typeof(Animation)):Play()
			arg_56_0.game_content:Find("combo_n"):GetComponent(typeof(Animation)):Play()
		else
			setActive(arg_56_0.game_content:Find("combo"), false)
			setActive(arg_56_0.game_content:Find("combo_n"), false)
		end

		pg.CriMgr.GetInstance():PlaySE_V3("ui-maoudamashii")
	end

	local var_56_1 = 0

	for iter_56_1 = 1, #arg_56_0.combo_interval do
		if arg_56_0.combo_link > arg_56_0.combo_interval[iter_56_1] then
			var_56_1 = var_56_1 + 1
		else
			break
		end
	end

	if arg_56_1 == 1 then
		arg_56_0.score_number = arg_56_0.score_number + arg_56_0.score_good + var_56_1 * arg_56_0.score_combo
		arg_56_0.good_number = arg_56_0.good_number + 1

		arg_56_0:effect_play("good")
	elseif arg_56_1 == 2 then
		arg_56_0.score_number = arg_56_0.score_number + arg_56_0.score_perfect + var_56_1 * arg_56_0.score_combo
		arg_56_0.perfect_number = arg_56_0.perfect_number + 1

		arg_56_0:effect_play("perfect")
	end

	if arg_56_0.gameNoteLeft:loopTime() or arg_56_0.gameNoteRight:loopTime() then
		arg_56_0:effect_play("perfect_loop02", true)
	else
		arg_56_0:effect_play("perfect_loop02", false)
	end

	local var_56_2 = arg_56_0.game_content:Find("yinyue_comboeffect")

	if arg_56_0.game_dgree == 2 and arg_56_0.combo_link > 50 or arg_56_0.game_dgree == 1 and arg_56_0.combo_link > 20 then
		if not isActive(var_56_2) then
			SetActive(var_56_2, true)
			setActive(arg_56_0.game_content:Find("MusicStar"), true)
		end
	else
		SetActive(var_56_2, false)
		setActive(arg_56_0.game_content:Find("MusicStar"), false)
	end
end

function var_0_0.count_five(arg_57_0, arg_57_1)
	arg_57_0.countingfive_flag = true

	setActive(arg_57_0.BG, true)
	arg_57_0:setActionSDmodel("stand2")

	local var_57_0 = var_0_2

	setText(arg_57_0.BG:Find("num"), var_57_0)

	local var_57_1 = findTF(arg_57_0.BG, "num")
	local var_57_2 = findTF(arg_57_0.BG, "ready")
	local var_57_3 = findTF(arg_57_0.BG, "ready/ready_triangle")

	setActive(var_57_2, false)
	setActive(var_57_1, true)

	arg_57_0.count_timer = Timer.New(function()
		if arg_57_0.criInfo and arg_57_0.criInfo:GetTime() > 0 then
			arg_57_0:pauseBgm()
		end

		var_57_0 = var_57_0 - 1

		setText(arg_57_0.BG:Find("num"), var_57_0)

		if var_57_0 == 0 then
			setActive(var_57_1, false)
			setActive(var_57_2, true)
			LeanTween.value(go(arg_57_0.BG), 0, 2, 2):setOnUpdate(System.Action_float(function(arg_59_0)
				local var_59_0

				if arg_59_0 <= 0.25 then
					local var_59_1 = arg_59_0 * 4

					var_57_2.localScale = Vector3(var_59_1, var_59_1, var_59_1)

					setImageAlpha(findTF(var_57_2, "img"), var_59_1)
					setLocalScale(var_57_3, Vector3(var_59_1, var_59_1, var_59_1))
				elseif arg_59_0 >= 1.8 then
					local var_59_2 = (2 - arg_59_0) * 4

					var_57_2.localScale = Vector3(var_59_2, var_59_2, var_59_2)

					setLocalScale(var_57_3, Vector3(var_59_2, var_59_2, var_59_2))
					setImageAlpha(findTF(var_57_2, "img"), var_59_2)
				end
			end)):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				var_57_2.localScale = Vector3(1, 1, 1, 1)

				setLocalScale(var_57_3, Vector3(1, 1, 1, 1))
				setImageAlpha(findTF(var_57_2, "img"), 1)
				setActive(var_57_2, false)
				arg_57_0.count_timer:Stop()

				arg_57_0.countingfive_flag = false

				setActive(arg_57_0.BG, false)
				arg_57_0:setActionSDmodel("idol")
				arg_57_1()
			end))
		end
	end, 1, -1)

	arg_57_0.count_timer:Start()
end

function var_0_0.showSelevtView(arg_61_0)
	if arg_61_0.isFirstgame == 0 then
		arg_61_0:Firstshow(arg_61_0.firstview, function()
			return
		end, 1)
	end

	local var_61_0 = arg_61_0.selectview:Find("Main")
	local var_61_1 = var_61_0:Find("Start_btn")
	local var_61_2 = var_61_0:Find("DgreeList")
	local var_61_3 = var_61_0:Find("MusicList")
	local var_61_4 = var_61_0:Find("namelist")
	local var_61_5 = arg_61_0.selectview:Find("top")
	local var_61_6 = var_61_5:Find("Speedlist")
	local var_61_7 = var_61_5:Find("help_btn")
	local var_61_8 = var_61_5:Find("back")
	local var_61_9 = arg_61_0.selectview:GetComponent("Animator")

	arg_61_0.selectview:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_63_0)
		setActive(arg_61_0.selectview, false)
	end)
	onButton(arg_61_0, var_61_7, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_music_game.tip
		})
	end, SFX_PANEL)
	onButton(arg_61_0, var_61_8, function()
		if MusicGameView.loadMusicFlag == 0 then
			arg_61_0:emit(var_0_0.ON_BACK)
		end
	end, SFX_PANEL)
	onButton(arg_61_0, var_61_1, function()
		if MusicGameView.loadMusicFlag == 0 then
			var_61_9:Play("selectExitAnim")
			arg_61_0:clearSDModel()
			arg_61_0:updateMusic(arg_61_0.musicData.music_id)
			arg_61_0:game_start()

			GetOrAddComponent(arg_61_0.selectview, "CanvasGroup").blocksRaycasts = false
		else
			arg_61_0.startBtnReady = true
		end
	end, SFX_UI_CONFIRM)
	onButton(arg_61_0, var_61_2:Find("easy"), function()
		arg_61_0.game_dgree = 1

		setActive(var_61_2:Find("hard/frame"), false)
		setActive(var_61_2:Find("easy/frame"), true)
		arg_61_0:updatSelectview()
	end, SFX_UI_CLICK)
	onButton(arg_61_0, var_61_2:Find("hard"), function()
		arg_61_0.game_dgree = 2

		setActive(var_61_2:Find("easy/frame"), false)
		setActive(var_61_2:Find("hard/frame"), true)
		arg_61_0:updatSelectview()
	end, SFX_UI_CLICK)
	onButton(arg_61_0, var_61_6, function()
		setActive(var_61_6:Find("x" .. arg_61_0.game_speed), false)

		arg_61_0.game_speed = arg_61_0.game_speed + 1 > 4 and 1 or arg_61_0.game_speed + 1

		PlayerPrefs.SetInt("musicgame_idol_speed", arg_61_0.game_speed)
		setActive(var_61_6:Find("x" .. arg_61_0.game_speed), true)
	end, SFX_UI_CLICK)

	arg_61_0.song_btn = var_61_3:Find("song")

	setActive(arg_61_0.song_btn, false)

	arg_61_0.song_btns = {}

	local var_61_10 = arg_61_0.gameMusicIndex

	for iter_61_0 = 1, arg_61_0.music_amount do
		arg_61_0.song_btns[iter_61_0] = cloneTplTo(arg_61_0.song_btn, var_61_3, "music" .. iter_61_0)

		local var_61_11 = MusicGameConst.music_game_data[iter_61_0]

		setActive(arg_61_0.song_btns[iter_61_0], true)

		local var_61_12 = arg_61_0.song_btn.localPosition
		local var_61_13 = math.abs(iter_61_0 - var_61_10)
		local var_61_14 = iter_61_0 - var_61_10 < arg_61_0.music_amount_middle and var_61_13 or iter_61_0 - arg_61_0.music_amount_middle * 2

		arg_61_0.song_btns[iter_61_0].localPosition = Vector3(var_61_12.x + var_61_14 * 1022, var_61_12.y, var_61_12.z)

		local var_61_15 = arg_61_0.song_btn.localScale

		arg_61_0.song_btns[iter_61_0].localScale = Vector3(var_61_15.x - math.abs(var_61_14) * 0.2, var_61_15.y - math.abs(var_61_14) * 0.2, var_61_15.z - math.abs(var_61_14) * 0.2)

		local var_61_16 = arg_61_0.song_btns[iter_61_0]:Find("song"):GetComponent(typeof(Image))

		var_61_16.sprite = var_61_3:Find("img/" .. var_61_11.img):GetComponent(typeof(Image)).sprite
		arg_61_0.song_btns[iter_61_0]:Find("zhuanji3/zhuanji2_5"):GetComponent(typeof(Image)).sprite = var_61_3:Find("img/" .. var_61_11.img .. "_1"):GetComponent(typeof(Image)).sprite
		var_61_16.color = Color.New(1, 1, 1, 1 - math.abs(var_61_14) * 0.6)

		onButton(arg_61_0, arg_61_0.song_btns[iter_61_0], function()
			arg_61_0:clickSongBtns(var_61_4, iter_61_0)
		end, SFX_UI_CLICK)

		if iter_61_0 == var_61_10 then
			arg_61_0.song_btns[iter_61_0]:GetComponent(typeof(Animator)):Play("plate_out")

			arg_61_0.song_btns[iter_61_0]:GetComponent(typeof(Button)).interactable = false
		end
	end

	arg_61_0:clickSongBtns(var_61_4, 1)
end

function var_0_0.updateMusic(arg_71_0, arg_71_1)
	arg_71_0.musicData = MusicGameConst.music_game_data[arg_71_1]
	arg_71_0.game_music = arg_71_0.musicData.music_id

	if arg_71_0.musicData.ships then
		arg_71_0.musicShips = arg_71_0.musicData.ships
		arg_71_0.settlementPainting = arg_71_0.musicData.settlement_painting
		arg_71_0.musicLight = arg_71_0.musicData.light
		arg_71_0.musicBg = arg_71_0.musicData.bg
	else
		local var_71_0 = MusicGameConst.getRandomBand()

		arg_71_0.musicShips = var_71_0.ships
		arg_71_0.settlementPainting = var_71_0.settlement_painting
		arg_71_0.musicLight = var_71_0.light
		arg_71_0.musicBg = var_71_0.bg
	end

	arg_71_0.gameMusicIndex = var_0_1
	arg_71_0.SDname = arg_71_0.musicShips
end

function var_0_0.clickSongBtns(arg_72_0, arg_72_1, arg_72_2)
	if MusicGameView.loadMusicFlag > 0 then
		return
	end

	setActive(arg_72_1:Find("song" .. arg_72_0.musicData.img), false)
	arg_72_0:MyGetRuntimeData()
	arg_72_0:clearSDModel()
	arg_72_0:updateMusic(arg_72_2)
	arg_72_0:loadAndPlayMusic()
	arg_72_0:updatSelectview()
	arg_72_0:changeLocalpos(arg_72_2)
	setActive(arg_72_1:Find("song" .. arg_72_0.musicData.img), true)
	arg_72_0:updateMusicPiece()
end

function var_0_0.changeLocalpos(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.music_amount_middle
	local var_73_1 = var_73_0 - arg_73_1
	local var_73_2 = 0.5
	local var_73_3 = {}

	for iter_73_0 = 1, arg_73_0.music_amount do
		var_73_3[iter_73_0] = arg_73_0.song_btns[iter_73_0].localPosition
	end

	local var_73_4 = {}

	for iter_73_1 = 1, arg_73_0.music_amount do
		var_73_4[iter_73_1] = arg_73_0.song_btns[iter_73_1].localScale
	end

	arg_73_0.changeLocalpos_timer = Timer.New(function()
		var_73_2 = var_73_2 - arg_73_0.time_interval
		arg_73_0.changeLocalposTimerflag = true

		for iter_74_0 = 1, arg_73_0.music_amount do
			local var_74_0 = iter_74_0 + var_73_1

			if iter_74_0 + var_73_1 > arg_73_0.music_amount then
				var_74_0 = iter_74_0 + var_73_1 - arg_73_0.music_amount
			end

			if iter_74_0 + var_73_1 < 1 then
				var_74_0 = iter_74_0 + var_73_1 + arg_73_0.music_amount
			end

			if var_73_2 <= 0 then
				if var_74_0 == var_73_0 then
					arg_73_0.song_btns[iter_74_0]:GetComponent(typeof(Animator)):Play("plate_out")
				else
					arg_73_0.song_btns[iter_74_0]:GetComponent(typeof(Animator)):Play("plate_static")

					arg_73_0.song_btns[iter_74_0]:GetComponent(typeof(Button)).interactable = true
				end
			else
				arg_73_0.song_btns[iter_74_0]:GetComponent(typeof(Animator)):Play("plate_static")

				arg_73_0.song_btns[iter_74_0]:GetComponent(typeof(Button)).interactable = false
			end

			local var_74_1 = arg_73_0.song_btn.localPosition
			local var_74_2 = math.abs(var_74_0 - var_73_0)
			local var_74_3 = (var_74_1.x + (var_74_0 - var_73_0 > 0 and 1 or -1) * var_74_2 * 1022) * (1 - var_73_2 * 2) + var_73_3[iter_74_0].x * var_73_2 * 2

			arg_73_0.song_btns[iter_74_0].localPosition = Vector3(var_74_3, var_74_1.y, var_74_1.z)

			local var_74_4 = arg_73_0.song_btns[iter_74_0].localScale
			local var_74_5 = (1 - var_74_2 * 0.2) * (1 - var_73_2 * 2) + var_73_4[iter_74_0].x * var_73_2 * 2

			arg_73_0.song_btns[iter_74_0].localScale = Vector3(var_74_5, var_74_5, var_74_5)

			local var_74_6 = arg_73_0.song_btns[iter_74_0]:Find("song"):GetComponent(typeof(Image))
			local var_74_7 = (1 - var_74_2 * 0.6) * (1 - var_73_2 * 2) + var_74_6.color.a * var_73_2 * 2

			var_74_6.color = Color.New(1, 1, 1, 1 - var_74_2 * 0.6)
		end

		if var_73_2 <= 0 then
			arg_73_0.changeLocalposTimerflag = false

			arg_73_0.changeLocalpos_timer:Stop()
		end
	end, arg_73_0.time_interval, -1)

	arg_73_0.changeLocalpos_timer:Start()
end

function var_0_0.addRingDragListenter(arg_75_0)
	local var_75_0 = GetOrAddComponent(arg_75_0.selectview, "EventTriggerListener")
	local var_75_1
	local var_75_2 = 0
	local var_75_3

	var_75_0:AddBeginDragFunc(function()
		var_75_2 = 0
		var_75_1 = nil
	end)
	var_75_0:AddDragFunc(function(arg_77_0, arg_77_1)
		if not arg_75_0.inPaintingView then
			local var_77_0 = arg_77_1.position

			if not var_75_1 then
				var_75_1 = var_77_0
			end

			var_75_2 = var_77_0.x - var_75_1.x
		end
	end)
	var_75_0:AddDragEndFunc(function(arg_78_0, arg_78_1)
		if not arg_75_0.inPaintingView and not arg_75_0.changeLocalposTimerflag then
			if var_75_2 < -50 then
				if arg_75_0.game_music < arg_75_0.music_amount then
					triggerButton(arg_75_0.song_btns[arg_75_0.game_music + 1])
				else
					triggerButton(arg_75_0.song_btns[1])
				end
			elseif var_75_2 > 50 then
				if arg_75_0.game_music > 1 then
					triggerButton(arg_75_0.song_btns[arg_75_0.game_music - 1])
				else
					triggerButton(arg_75_0.song_btns[arg_75_0.music_amount])
				end
			end
		end
	end)
end

function var_0_0.Firstshow(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	arg_79_0.count = 0

	setActive(arg_79_1, true)
	LoadSpriteAsync("ui/minigameui/musicgameother/help1", function(arg_80_0)
		GetComponent(findTF(arg_79_0.firstview, "num/img1"), typeof(Image)).sprite = arg_80_0
	end)
	LoadSpriteAsync("ui/minigameui/musicgameother/help2", function(arg_81_0)
		GetComponent(findTF(arg_79_0.firstview, "num/img2"), typeof(Image)).sprite = arg_81_0
	end)

	for iter_79_0 = 1, 2 do
		local var_79_0 = findTF(arg_79_1, "num/img" .. iter_79_0)

		setActive(var_79_0, iter_79_0 == arg_79_3 and true or false)
	end

	if arg_79_0.firstview_timer then
		if arg_79_0.firstview_timer.running then
			arg_79_0.firstview_timer:Stop()
		end

		arg_79_0.firstview_timer = nil
	end

	arg_79_0.firstview_timerRunflag = true
	arg_79_0.firstview_timer = Timer.New(function()
		arg_79_0.count = arg_79_0.count + 1

		if arg_79_0.count > 3 then
			onButton(arg_79_0, arg_79_0.firstview, function()
				if arg_79_2 then
					arg_79_2()
				end

				arg_79_0.firstview_timer:Stop()
				setActive(arg_79_1, false)

				arg_79_0.firstview_timerRunflag = false

				removeOnButton(arg_79_0.firstview)
			end)
		end
	end, 1, -1)

	arg_79_0.firstview_timer:Start()
end

function var_0_0.updatSelectview(arg_84_0)
	if not arg_84_0.song_btns or #arg_84_0.song_btns <= 0 or not arg_84_0.selectview then
		return
	end

	setActive(arg_84_0.selectview:Find("top/Speedlist/x" .. arg_84_0.game_speed), true)

	for iter_84_0 = 1, arg_84_0.music_amount do
		local var_84_0 = MusicGameConst.music_game_data[iter_84_0].music_id

		setActive(arg_84_0.song_btns[var_84_0]:Find("song/best"), false)
		arg_84_0:setSelectview_pj("e", var_84_0)
	end

	local var_84_1 = arg_84_0.game_dgree
	local var_84_2 = arg_84_0.game_music
	local var_84_3 = arg_84_0.bestScorelist[var_84_2 + (var_84_1 - 1) * arg_84_0.music_amount]

	if arg_84_0.song_btns[var_84_2] and var_84_3 > 0 then
		setActive(arg_84_0.song_btns[var_84_2]:Find("song/best"), true)

		local var_84_4 = arg_84_0.song_btns[var_84_2]:Find("song/best/score")

		setText(var_84_4, var_84_3)
		arg_84_0:setSelectview_pj("e", var_84_2)

		if var_84_3 < arg_84_0.score_blist[var_84_2][var_84_1] then
			arg_84_0:setSelectview_pj("c", var_84_2)
		elseif var_84_3 >= arg_84_0.score_blist[var_84_2][var_84_1] and var_84_3 < arg_84_0.score_alist[var_84_2][var_84_1] then
			arg_84_0:setSelectview_pj("b", var_84_2)
		elseif var_84_3 >= arg_84_0.score_alist[var_84_2][var_84_1] and var_84_3 < arg_84_0.score_slist[var_84_2][var_84_1] then
			arg_84_0:setSelectview_pj("a", var_84_2)
		else
			arg_84_0:setSelectview_pj("s", var_84_2)
		end
	end
end

function var_0_0.setSelectview_pj(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_1 == "e" then
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/c"), false)
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/b"), false)
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/a"), false)
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/s"), false)
	elseif arg_85_1 == "c" then
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/c"), true)
	elseif arg_85_1 == "b" then
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/b"), true)
	elseif arg_85_1 == "a" then
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/a"), true)
	elseif arg_85_1 == "s" then
		setActive(arg_85_0.song_btns[arg_85_2]:Find("song/s"), true)
	end
end

function var_0_0.locadScoreView(arg_86_0)
	arg_86_0:effect_play("nothing")

	arg_86_0.game_playingflag = false

	setActive(arg_86_0.scoreview, true)

	arg_86_0.scoreview_flag = true

	local var_86_0 = findTF(arg_86_0.scoreview, "bg")

	setImageColor(var_86_0, Color(0, 0, 0))
	LoadSpriteAsync("ui/minigameui/musicgameother/scoreBg" .. arg_86_0.musicBg, function(arg_87_0)
		if var_86_0 then
			GetComponent(var_86_0, typeof(Image)).sprite = arg_87_0

			setImageColor(var_86_0, Color(1, 1, 1))
			setActive(var_86_0, true)
		end
	end)
	setActive(arg_86_0.game_content:Find("combo"), false)
	setActive(arg_86_0.game_content:Find("MusicStar"), false)
	setActive(arg_86_0.game_content:Find("combo_n"), false)
	setActive(arg_86_0.game_content, false)
	setActive(arg_86_0.top, false)
	setActive(arg_86_0._tf:Find("Spinelist"), false)
	setActive(arg_86_0._tf:Find("lightList"), false)
	setActive(arg_86_0._tf:Find("shadowlist"), false)

	for iter_86_0 = 1, var_0_4 do
		setActive(arg_86_0.scoreview:Find("maskBg/bg" .. iter_86_0), iter_86_0 == arg_86_0.musicBg)
	end

	local var_86_1 = arg_86_0.game_dgree
	local var_86_2 = arg_86_0.game_music

	if arg_86_0.painting then
		retPaintingPrefab(arg_86_0.scoreview:Find("paint"), arg_86_0.painting)
	end

	arg_86_0.painting = arg_86_0.settlementPainting[math.random(1, #arg_86_0.settlementPainting)]

	setPaintingPrefabAsync(arg_86_0.scoreview:Find("paint"), arg_86_0.painting, "mainNormal")
	setActive(arg_86_0.scoreview:Find("img_list/square/easy"), var_86_1 == 1)
	setActive(arg_86_0.scoreview:Find("img_list/square/hard"), var_86_1 == 2)
	setActive(arg_86_0.scoreview:Find("scorelist/fullCombo"), arg_86_0.miss_number == 0)
	setActive(arg_86_0.scoreview:Find("img_list/perfect/noMiss"), arg_86_0.miss_number == 0 and arg_86_0.good_number == 0)

	local function var_86_3(arg_88_0, arg_88_1, arg_88_2)
		LeanTween.value(go(arg_86_0.scoreview), 0, arg_88_1, 0.6):setOnUpdate(System.Action_float(function(arg_89_0)
			setText(arg_88_0, math.round(arg_89_0))
		end)):setOnComplete(System.Action(function()
			arg_88_2()
		end))
	end

	seriesAsync({
		function(arg_91_0)
			var_86_3(arg_86_0.scoreview:Find("scorelist/perfect"), arg_86_0.perfect_number, arg_91_0)
		end,
		function(arg_92_0)
			var_86_3(arg_86_0.scoreview:Find("scorelist/good"), arg_86_0.good_number, arg_92_0)
		end,
		function(arg_93_0)
			var_86_3(arg_86_0.scoreview:Find("scorelist/miss"), arg_86_0.miss_number, arg_93_0)
		end,
		function(arg_94_0)
			var_86_3(arg_86_0.scoreview:Find("scorelist/combo"), arg_86_0.combo_number, arg_94_0)
		end,
		function(arg_95_0)
			local var_95_0 = arg_86_0.bestScorelist[var_86_2 + (var_86_1 - 1) * arg_86_0.music_amount]

			if not var_95_0 or var_95_0 == 0 then
				var_95_0 = arg_86_0.score_number
			end

			if arg_86_0.score_number > arg_86_0.bestScorelist[var_86_2 + (var_86_1 - 1) * arg_86_0.music_amount] then
				setActive(arg_86_0.scoreview:Find("img_list/square/newScore"), true)

				arg_86_0.bestScorelist[var_86_2 + (var_86_1 - 1) * arg_86_0.music_amount] = arg_86_0.score_number
			else
				setActive(arg_86_0.scoreview:Find("img_list/square/newScore"), false)
			end

			var_86_3(arg_86_0.scoreview:Find("img_list/square/bestscore"), var_95_0, arg_95_0)
			var_86_3(arg_86_0.scoreview:Find("img_list/square/score"), arg_86_0.score_number, function()
				return
			end)
			arg_86_0:MyStoreDataToServer()
			arg_86_0:MyGetRuntimeData()
		end,
		function(arg_97_0)
			local var_97_0

			if arg_86_0.score_number < arg_86_0.score_blist[var_86_2][var_86_1] then
				function var_97_0()
					arg_86_0:setScoceview_pj("c")
				end
			elseif arg_86_0.score_number >= arg_86_0.score_blist[var_86_2][var_86_1] and arg_86_0.score_number < arg_86_0.score_alist[var_86_2][var_86_1] then
				function var_97_0()
					arg_86_0:setScoceview_pj("b")
					arg_86_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)
				end
			elseif arg_86_0.score_number >= arg_86_0.score_alist[var_86_2][var_86_1] and arg_86_0.score_number < arg_86_0.score_slist[var_86_2][var_86_1] then
				function var_97_0()
					arg_86_0:setScoceview_pj("a")
					arg_86_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)
				end
			else
				function var_97_0()
					arg_86_0:setScoceview_pj("s")
					arg_86_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)
				end
			end

			local var_97_1 = arg_86_0:GetMGHubData()
			local var_97_2 = pg.NewStoryMgr.GetInstance()
			local var_97_3 = arg_86_0:GetMGData():getConfig("simple_config_data").story
			local var_97_4 = var_97_3[var_97_1.usedtime + 1] and var_97_3[var_97_1.usedtime + 1][1] or nil

			if var_97_1.count > 0 and var_97_4 and not var_97_2:IsPlayed(var_97_4) and arg_86_0.score_number >= arg_86_0.score_blist[var_86_2][var_86_1] then
				var_97_2:Play(var_97_4, var_97_0)
			else
				var_97_0()
			end

			arg_97_0()
		end
	}, function()
		return
	end)

	local var_86_4 = arg_86_0.scoreview:Find("img_list/square/name"):GetComponent(typeof(Image))

	var_86_4.sprite = arg_86_0.selectview:Find("Main/namelist/song" .. arg_86_0.musicData.img):GetComponent(typeof(Image)).sprite

	var_86_4:SetNativeSize()

	arg_86_0.scoreview:Find("img_list/square/song"):GetComponent(typeof(Image)).sprite = arg_86_0.selectview:Find("Main/MusicList/img/" .. arg_86_0.musicData.img):GetComponent(typeof(Image)).sprite

	onButton(arg_86_0, arg_86_0.scoreview:Find("btnlist/share"), function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSummary)
	end, SFX_PANEL)
	onButton(arg_86_0, arg_86_0.scoreview:Find("btnlist/restart"), function()
		setActive(arg_86_0.scoreview, false)

		arg_86_0.scoreview_flag = false

		arg_86_0:stopTimer()
		arg_86_0:piecelistALLTtoF()
		arg_86_0:rec_scorce()
		arg_86_0:game_start()
		arg_86_0:setScoceview_pj("e")

		if arg_86_0.painting then
			retPaintingPrefab(arg_86_0.scoreview:Find("paint"), arg_86_0.painting)

			arg_86_0.painting = nil
		end
	end, SFX_UI_CLICK)
	onButton(arg_86_0, arg_86_0.scoreview:Find("btnlist/reselect"), function()
		arg_86_0:dynamicBgHandler(arg_86_0.bgGo)
		setActive(arg_86_0.scoreview, false)

		arg_86_0.scoreview_flag = false

		arg_86_0:stopTimer()
		arg_86_0:piecelistALLTtoF()
		setActive(arg_86_0.selectview, true)

		GetOrAddComponent(arg_86_0.selectview, "CanvasGroup").blocksRaycasts = true

		arg_86_0:updatSelectview()
		arg_86_0.song_btns[arg_86_0.game_music]:GetComponent(typeof(Animator)):Play("plate_out")
		arg_86_0:loadAndPlayMusic()
		arg_86_0:rec_scorce()
		arg_86_0:setScoceview_pj("e")

		if arg_86_0.painting then
			retPaintingPrefab(arg_86_0.scoreview:Find("paint"), arg_86_0.painting)

			arg_86_0.painting = nil
		end
	end, SFX_UI_CLICK)
end

function var_0_0.setScoceview_pj(arg_106_0, arg_106_1)
	if arg_106_1 == "e" then
		setActive(arg_106_0.scoreview:Find("img_list/square/c"), false)
		setActive(arg_106_0.scoreview:Find("img_list/square/b"), false)
		setActive(arg_106_0.scoreview:Find("img_list/square/a"), false)
		setActive(arg_106_0.scoreview:Find("img_list/square/s"), false)
	elseif arg_106_1 == "c" then
		setActive(arg_106_0.scoreview:Find("img_list/square/c"), true)
	elseif arg_106_1 == "b" then
		setActive(arg_106_0.scoreview:Find("img_list/square/b"), true)
	elseif arg_106_1 == "a" then
		setActive(arg_106_0.scoreview:Find("img_list/square/a"), true)
	elseif arg_106_1 == "s" then
		setActive(arg_106_0.scoreview:Find("img_list/square/s"), true)
	end
end

function var_0_0.Scoceview_ani(arg_107_0)
	local var_107_0 = 0

	setActive(arg_107_0.scoreview:Find("btnlist/reselect"), false)
	setActive(arg_107_0.scoreview:Find("btnlist/restart"), false)
	setActive(arg_107_0.scoreview:Find("btnlist/share"), false)

	local function var_107_1()
		var_107_0 = var_107_0 + arg_107_0.time_interval

		if var_107_0 >= 0.99 then
			setActive(arg_107_0.scoreview:Find("btnlist/reselect"), true)
			setActive(arg_107_0.scoreview:Find("btnlist/restart"), true)
			setActive(arg_107_0.scoreview:Find("btnlist/share"), true)
			setText(arg_107_0.scoreview:Find("scorelist/perfect"), arg_107_0.perfect_number)
			setText(arg_107_0.scoreview:Find("scorelist/good"), arg_107_0.good_number)
			setText(arg_107_0.scoreview:Find("scorelist/miss"), arg_107_0.miss_number)
			setText(arg_107_0.scoreview:Find("scorelist/combo"), arg_107_0.combo_number)
			setText(arg_107_0.scoreview:Find("img_list/square/bestscore"), arg_107_0.score_number)
		else
			setText(arg_107_0.scoreview:Find("scorelist/perfect"), math.floor(arg_107_0.perfect_number * var_107_0))
			setText(arg_107_0.scoreview:Find("scorelist/good"), math.floor(arg_107_0.good_number * var_107_0))
			setText(arg_107_0.scoreview:Find("scorelist/miss"), math.floor(arg_107_0.miss_number * var_107_0))
			setText(arg_107_0.scoreview:Find("scorelist/combo"), math.floor(arg_107_0.combo_number * var_107_0))
			setText(arg_107_0.scoreview:Find("img_list/square/bestscore"), math.floor(arg_107_0.score_number * var_107_0))
		end

		if var_107_0 >= 1.03 then
			arg_107_0.Scoceview_timer:Stop()
		end
	end

	arg_107_0.Scoceview_timer = Timer.New(var_107_1, arg_107_0.time_interval, -1)

	arg_107_0.Scoceview_timer:Start()
end

function var_0_0.gameStart(arg_109_0)
	if not arg_109_0.timer then
		arg_109_0.timer = Timer.New(function()
			arg_109_0:gameStepNew()
		end, arg_109_0.time_interval, -1)
	end

	arg_109_0.aheadtime_count = 0

	local var_109_0 = 2

	arg_109_0.ahead_timerPauseFlag = false

	local function var_109_1()
		arg_109_0.ahead_timeflag = true

		if not arg_109_0.timer.running then
			arg_109_0:startTimer()
		end

		if not arg_109_0.ahead_timerPauseFlag then
			arg_109_0.aheadtime_count = arg_109_0.aheadtime_count + arg_109_0.time_interval

			if arg_109_0.aheadtime_count > var_109_0 then
				arg_109_0.aheadtime_count = nil
				arg_109_0.ahead_timeflag = false
				arg_109_0.gotspecialcombo_flag = false

				arg_109_0.ahead_timer:Stop()
				arg_109_0:loadAndPlayMusic(function()
					return
				end)
			end
		end
	end

	CriWareMgr.Inst:UnloadCueSheet("bgm-song" .. arg_109_0.musicData.bgm)

	arg_109_0.ahead_timer = Timer.New(var_109_1, arg_109_0.time_interval, -1)

	arg_109_0:count_five(function()
		arg_109_0.ahead_timer:Start()
	end)
end

function var_0_0.gameStepNew(arg_114_0)
	local var_114_0 = arg_114_0.game_dgree

	arg_114_0.gameStepTime = arg_114_0:getStampTime()
	arg_114_0.downingright_lastflag = arg_114_0.downingright_flag
	arg_114_0.downingleft_lastflag = arg_114_0.downingleft_flag

	if IsUnityEditor then
		if var_114_0 == 2 then
			arg_114_0.downingright_flag = Input.GetKey(KeyCode.J)
			arg_114_0.downingleft_flag = Input.GetKey(KeyCode.F)
		elseif var_114_0 == 1 then
			if Input.GetKey(KeyCode.J) or Input.GetKey(KeyCode.F) then
				arg_114_0.downingright_flag = true
				arg_114_0.downingleft_flag = true
			else
				arg_114_0.downingright_flag = false
				arg_114_0.downingleft_flag = false
			end
		end
	elseif var_114_0 == 2 then
		arg_114_0.downingright_flag = arg_114_0.mousedowningright_flag
		arg_114_0.downingleft_flag = arg_114_0.mousedowningleft_flag
	elseif var_114_0 == 1 then
		if arg_114_0.mousedowningright_flag or arg_114_0.mousedowningleft_flag then
			arg_114_0.downingright_flag = true
			arg_114_0.downingleft_flag = true
		else
			arg_114_0.downingright_flag = false
			arg_114_0.downingleft_flag = false
		end
	end

	if var_114_0 == 2 then
		if not arg_114_0.downingleft_lastflag and arg_114_0.downingleft_flag then
			arg_114_0.gameNoteLeft:onKeyDown()

			arg_114_0.leftDownStepTime = arg_114_0.gameStepTime

			if arg_114_0.rightDownStepTime and math.abs(arg_114_0.leftDownStepTime - arg_114_0.rightDownStepTime) < 100 then
				arg_114_0.gameNoteLeft:bothDown()
				arg_114_0.gameNoteRight:bothDown()
			end
		elseif arg_114_0.downingleft_lastflag and not arg_114_0.downingleft_flag then
			arg_114_0.leftUpStepTime = arg_114_0.gameStepTime

			arg_114_0.gameNoteLeft:onKeyUp()

			if arg_114_0.rightUpStepTime and math.abs(arg_114_0.leftUpStepTime - arg_114_0.rightUpStepTime) < 100 then
				arg_114_0.gameNoteLeft:bothUp()
				arg_114_0.gameNoteRight:bothUp()
			end
		end

		if not arg_114_0.downingright_lastflag and arg_114_0.downingright_flag then
			arg_114_0.gameNoteRight:onKeyDown()

			arg_114_0.rightDownStepTime = arg_114_0.gameStepTime

			if arg_114_0.leftDownStepTime and math.abs(arg_114_0.leftDownStepTime - arg_114_0.rightDownStepTime) < 200 then
				arg_114_0.gameNoteLeft:bothDown()
				arg_114_0.gameNoteRight:bothDown()
			end
		elseif arg_114_0.downingright_lastflag and not arg_114_0.downingright_flag then
			arg_114_0.rightUpStepTime = arg_114_0.gameStepTime

			arg_114_0.gameNoteRight:onKeyUp()

			if arg_114_0.leftUpStepTime and math.abs(arg_114_0.leftUpStepTime - arg_114_0.rightUpStepTime) < 200 then
				arg_114_0.gameNoteLeft:bothUp()
				arg_114_0.gameNoteRight:bothUp()
			end
		end
	elseif not arg_114_0.downingright_lastflag and arg_114_0.downingright_flag then
		arg_114_0.gameNoteLeft:onKeyDown()
		arg_114_0.gameNoteRight:onKeyDown()
	elseif arg_114_0.downingleft_lastflag and not arg_114_0.downingleft_flag then
		arg_114_0.gameNoteLeft:onKeyUp()
		arg_114_0.gameNoteRight:onKeyUp()
	end

	arg_114_0.musicgame_lasttime = arg_114_0.musicgame_nowtime or 0

	if arg_114_0.criInfo then
		arg_114_0.musicgame_nowtime = arg_114_0:getStampTime() / 1000
	else
		arg_114_0.musicgame_nowtime = 0
	end

	if arg_114_0.song_Tlength and not arg_114_0.scoreview_flag and long2int(arg_114_0.song_Tlength) / 1000 - arg_114_0.musicgame_nowtime <= 0.01666 then
		print("歌曲播放结束")
		arg_114_0:pauseBgm()

		arg_114_0.game_playingflag = false

		local function var_114_1()
			arg_114_0:locadScoreView()
		end

		if arg_114_0.perfect_number > 0 and arg_114_0.good_number == 0 and arg_114_0.miss_number == 0 then
			setActive(arg_114_0.fullComboEffect, true)

			if not arg_114_0.gotspecialcombo_flag then
				arg_114_0.score_number = arg_114_0.score_number + arg_114_0.specialscore_number
				arg_114_0.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(arg_114_0.fullComboEffect), 2, System.Action(function()
				var_114_1()
			end))
		elseif (arg_114_0.good_number > 0 or arg_114_0.perfect_number > 0) and arg_114_0.miss_number <= 0 then
			setActive(arg_114_0.fullComboEffect, true)

			if not arg_114_0.gotspecialcombo_flag then
				arg_114_0.score_number = arg_114_0.score_number + arg_114_0.specialscore_number
				arg_114_0.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(arg_114_0.fullComboEffect), 2, System.Action(function()
				var_114_1()
			end))
		else
			setActive(arg_114_0.liveClearEffect, true)
			LeanTween.delayedCall(go(arg_114_0.liveClearEffect), 2, System.Action(function()
				var_114_1()
			end))
		end

		return
	end

	arg_114_0.gameNoteLeft:step(arg_114_0.gameStepTime)
	arg_114_0.gameNoteRight:step(arg_114_0.gameStepTime)
	arg_114_0:scoresliderAcombo_update()

	if arg_114_0.drumpFlag and not arg_114_0.gameNoteLeft:loopTime() and not arg_114_0.gameNoteRight:loopTime() then
		arg_114_0.drumpFlag = false
		arg_114_0.drupTime = Time.realtimeSinceStartup

		arg_114_0:setActionSDmodel("jump")
		LeanTween.delayedCall(go(arg_114_0.game_content), 1, System.Action(function()
			arg_114_0:setActionSDmodel("idol")
		end))
	end
end

function var_0_0.onStateCallback(arg_120_0, arg_120_1)
	arg_120_0:score_update(arg_120_1)
end

function var_0_0.onLongTimeCallback(arg_121_0, arg_121_1)
	if arg_121_0.drupTime and Time.realtimeSinceStartup - arg_121_0.drupTime < 2 then
		return
	end

	if arg_121_1 > 0.5 then
		arg_121_0.drumpFlag = true
	end
end

function var_0_0.gameStep(arg_122_0)
	arg_122_0.downingright_lastflag = arg_122_0.downingright_flag
	arg_122_0.downingleft_lastflag = arg_122_0.downingleft_flag

	local var_122_0 = arg_122_0.game_dgree

	if IsUnityEditor then
		if var_122_0 == 2 then
			arg_122_0.downingright_flag = Input.GetKey(KeyCode.J)
			arg_122_0.downingleft_flag = Input.GetKey(KeyCode.F)
		elseif var_122_0 == 1 then
			if Input.GetKey(KeyCode.J) or Input.GetKey(KeyCode.F) then
				arg_122_0.downingright_flag = true
				arg_122_0.downingleft_flag = true
			else
				arg_122_0.downingright_flag = false
				arg_122_0.downingleft_flag = false
			end
		end
	elseif var_122_0 == 2 then
		arg_122_0.downingright_flag = arg_122_0.mousedowningright_flag
		arg_122_0.downingleft_flag = arg_122_0.mousedowningleft_flag
	elseif var_122_0 == 1 then
		if arg_122_0.mousedowningright_flag or arg_122_0.mousedowningleft_flag then
			arg_122_0.downingright_flag = true
			arg_122_0.downingleft_flag = true
		else
			arg_122_0.downingright_flag = false
			arg_122_0.downingleft_flag = false
		end
	end

	arg_122_0:SDmodeljump_btnup()

	local var_122_1 = arg_122_0.piecelist_speedmin + (arg_122_0.piecelist_speedmax - arg_122_0.piecelist_speedmin) * arg_122_0.game_speed * 5
	local var_122_2 = arg_122_0.pieceinit_xyz.right.x / var_122_1
	local var_122_3 = -arg_122_0.pieceinit_xyz.left.x / var_122_1

	arg_122_0.musicgame_lasttime = arg_122_0.musicgame_nowtime or 0

	if arg_122_0.criInfo then
		arg_122_0.musicgame_nowtime = arg_122_0:getStampTime() / 1000
	else
		arg_122_0.musicgame_nowtime = 0
	end

	if arg_122_0.song_Tlength and not arg_122_0.scoreview_flag and long2int(arg_122_0.song_Tlength) / 1000 - arg_122_0.musicgame_nowtime <= 0.01666 then
		arg_122_0:pauseBgm()

		arg_122_0.game_playingflag = false

		if arg_122_0.perfect_number > 0 and arg_122_0.good_number == 0 and arg_122_0.miss_number == 0 then
			setActive(arg_122_0.game_content:Find("yinyue20_Fullcombo"), true)

			if not arg_122_0.gotspecialcombo_flag then
				arg_122_0.score_number = arg_122_0.score_number + arg_122_0.specialscore_number
				arg_122_0.gotspecialcombo_flag = true
			end

			local function var_122_4()
				return
			end

			arg_122_0:locadScoreView()
			arg_122_0.game_content:Find("yinyue20_Fullcombo"):GetComponent(typeof(ParticleSystemEvent)):SetEndEvent(var_122_4)
		elseif (arg_122_0.good_number > 0 or arg_122_0.perfect_number > 0) and arg_122_0.miss_number <= 0 then
			setActive(arg_122_0.game_content:Find("yinyue20_Fullcombo"), true)

			if not arg_122_0.gotspecialcombo_flag then
				arg_122_0.score_number = arg_122_0.score_number + arg_122_0.specialscore_number
				arg_122_0.gotspecialcombo_flag = true
			end

			local function var_122_5()
				arg_122_0:locadScoreView()
			end

			arg_122_0.game_content:Find("yinyue20_Fullcombo"):GetComponent(typeof(ParticleSystemEvent)):SetEndEvent(var_122_5)
		else
			arg_122_0:locadScoreView()
		end

		return
	end

	if arg_122_0.nowmusic_l == nil and arg_122_0.musictable_l[0] ~= 0 then
		arg_122_0.nowmusic_l = arg_122_0:list_pop(arg_122_0.musictable_l)
	end

	if arg_122_0.nowmusic_r == nil and arg_122_0.musictable_r[0] ~= 0 then
		arg_122_0.nowmusic_r = arg_122_0:list_pop(arg_122_0.musictable_r)
	end

	if arg_122_0.musictable_l[0] == 0 and arg_122_0.musictable_r[0] == 0 then
		setActive(arg_122_0.top:Find("pause_above"), true)
	else
		setActive(arg_122_0.top:Find("pause_above"), false)
		setActive(arg_122_0.game_content:Find("yinyue20_Fullcombo"), false)
	end

	local function var_122_6(arg_125_0, arg_125_1, arg_125_2, arg_125_3, arg_125_4)
		if arg_125_1 and arg_125_1.begin_time - arg_125_2 <= arg_122_0.musicgame_nowtime then
			local var_125_0 = arg_122_0:list_pop(arg_125_3)

			if not var_125_0 then
				arg_122_0.piece_n = arg_122_0.piece_n + 1
				var_125_0 = cloneTplTo(arg_122_0.music_piece:Find("piece_" .. arg_125_0), arg_122_0.music_piece, arg_122_0.piece_n)
			end

			setActive(var_125_0, true)

			local var_125_1 = {
				ob = var_125_0,
				begin_time = arg_125_1.begin_time,
				end_time = arg_125_1.end_time,
				key_flag = arg_125_1.key_flag
			}

			arg_122_0:list_push(arg_125_4, var_125_1)
			var_125_0:GetComponent(typeof(Transform)):SetAsFirstSibling()

			local var_125_2 = arg_122_0.game_dgree

			if var_125_2 == 1 then
				setActive(var_125_0:Find("1"), true)
				setActive(var_125_0:Find("2"), false)
			elseif var_125_2 == 2 then
				setActive(var_125_0:Find("1"), false)
				setActive(var_125_0:Find("2"), true)
			end

			if arg_125_1.begin_time == arg_125_1.end_time then
				if arg_125_1.key_flag == "K_BOTH" then
					setActive(var_125_0:Find(var_125_2 .. "/note_2"), true)

					var_125_0:Find(var_125_2 .. "/note_2/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

					setActive(var_125_0:Find(var_125_2 .. "/notelong_2"), false)
					setActive(var_125_0:Find(var_125_2 .. "/note_1"), false)
					setActive(var_125_0:Find(var_125_2 .. "/notelong_1"), false)
				else
					setActive(var_125_0:Find(var_125_2 .. "/note_1"), true)

					var_125_0:Find(var_125_2 .. "/note_1/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

					setActive(var_125_0:Find(var_125_2 .. "/notelong_1"), false)
					setActive(var_125_0:Find(var_125_2 .. "/note_2"), false)
					setActive(var_125_0:Find(var_125_2 .. "/notelong_2"), false)
				end
			elseif arg_125_1.key_flag == "K_BOTH" then
				setActive(var_125_0:Find(var_125_2 .. "/note_2"), false)
				setActive(var_125_0:Find(var_125_2 .. "/notelong_2"), true)
				setActive(var_125_0:Find(var_125_2 .. "/note_1"), false)
				setActive(var_125_0:Find(var_125_2 .. "/notelong_1"), false)

				var_125_0:Find(var_125_2 .. "/notelong_2/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)
				var_125_0:Find(var_125_2 .. "/notelong_2/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

				local var_125_3 = var_125_0:Find(var_125_2 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMin
				local var_125_4 = var_125_0:Find(var_125_2 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMax
				local var_125_5 = 274 - 1142 / var_122_3 * (arg_125_1.end_time - arg_125_1.begin_time)

				var_125_5 = var_125_5 < 274 and var_125_5 or 274

				if arg_125_0 == "left" then
					var_125_0:Find(var_125_2 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMin = Vector2(var_125_5, var_125_3.y)
				elseif arg_125_0 == "right" then
					var_125_0:Find(var_125_2 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMax = Vector2(-var_125_5, var_125_4.y)
				end
			else
				setActive(var_125_0:Find(var_125_2 .. "/note_1"), false)
				setActive(var_125_0:Find(var_125_2 .. "/notelong_1"), true)
				setActive(var_125_0:Find(var_125_2 .. "/note_2"), false)
				setActive(var_125_0:Find(var_125_2 .. "/notelong_2"), false)

				var_125_0:Find(var_125_2 .. "/notelong_1/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)
				var_125_0:Find(var_125_2 .. "/notelong_1/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

				local var_125_6 = var_125_0:Find(var_125_2 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMin
				local var_125_7 = var_125_0:Find(var_125_2 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMax
				local var_125_8 = 274 - 1142 / var_122_3 * (arg_125_1.end_time - arg_125_1.begin_time)

				var_125_8 = var_125_8 < 274 and var_125_8 or 274

				if arg_125_0 == "left" then
					var_125_0:Find(var_125_2 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMin = Vector2(var_125_8, var_125_6.y)
				elseif arg_125_0 == "right" then
					var_125_0:Find(var_125_2 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMax = Vector2(-var_125_8, var_125_7.y)
				end
			end

			return nil
		end

		return arg_125_1
	end

	arg_122_0.nowmusic_l = var_122_6("left", arg_122_0.nowmusic_l, var_122_3, arg_122_0.piecelist_lf, arg_122_0.piecelist_lt)
	arg_122_0.nowmusic_r = var_122_6("right", arg_122_0.nowmusic_r, var_122_2, arg_122_0.piecelist_rf, arg_122_0.piecelist_rt)

	local function var_122_7(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
		if arg_122_0.game_dgree == 1 then
			if arg_126_0 == "left" and (arg_122_0.piece_nowl.ob or arg_122_0.piece_nowr.ob) and arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag and not arg_122_0.piece_nowl_aloneflag then
				if arg_122_0.piece_nowl.ob and arg_122_0.piece_nowr.ob then
					if arg_122_0.piece_nowl.begin_time - arg_122_0.piece_nowr.begin_time < 0 then
						if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time < arg_122_0.time_laterperfect then
							arg_122_0:score_update(2)
						else
							arg_122_0:score_update(1)
						end

						arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

						setActive(arg_122_0.piece_nowl.ob, false)
						arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0.piece_nowl.ob)

						arg_122_0.piece_nowl.ob = false
					else
						if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time < arg_122_0.time_laterperfect then
							arg_122_0:score_update(2)
						else
							arg_122_0:score_update(1)
						end

						arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

						setActive(arg_122_0.piece_nowr.ob, false)
						arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0.piece_nowr.ob)

						arg_122_0.piece_nowr.ob = false
					end
				elseif arg_122_0.piece_nowl.ob and not arg_122_0.piece_nowr.ob then
					if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time < arg_122_0.time_laterperfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end

					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false
				elseif not arg_122_0.piece_nowl.ob and arg_122_0.piece_nowr.ob then
					if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time < arg_122_0.time_laterperfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end

					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false
				end

				arg_122_0.piece_nowl_aloneflag = true
			elseif arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time == arg_122_0.piece_nowl.end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			elseif arg_126_0 == "left" and (arg_122_0.piecelist_lt[0] ~= 0 and arg_122_0.piecelist_lt[1] and arg_122_0.piecelist_lt[1].ob or arg_122_0.piecelist_rt[0] ~= 0 and arg_122_0.piecelist_rt[1].ob) and arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag then
				if arg_122_0.piecelist_lt[0] ~= 0 and arg_122_0.piecelist_lt[1].ob and arg_122_0.piecelist_rt[0] ~= 0 and arg_122_0.piecelist_rt[1].ob then
					if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.piecelist_rt[1].begin_time < 0 then
						if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
							if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
								if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
									arg_122_0:score_update(2)
								else
									arg_122_0:score_update(1)
								end
							else
								arg_122_0:score_update(0)
							end

							arg_122_0.piecelist_lt[1].ob.localPosition = arg_122_0.pieceinit_xyz.left

							setActive(arg_122_0.piecelist_lt[1].ob, false)
							arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0:list_pop(arg_122_0.piecelist_lt).ob)
						end
					elseif arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
						if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
							if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
								arg_122_0:score_update(2)
							else
								arg_122_0:score_update(1)
							end
						else
							arg_122_0:score_update(0)
						end

						arg_122_0.piecelist_rt[1].ob.localPosition = arg_122_0.pieceinit_xyz.right

						setActive(arg_122_0.piecelist_rt[1].ob, false)
						arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0:list_pop(arg_122_0.piecelist_rt).ob)
					end
				elseif arg_122_0.piecelist_lt[0] ~= 0 and arg_122_0.piecelist_lt[1].ob and (arg_122_0.piecelist_rt[0] == 0 or not arg_122_0.piecelist_rt[1].ob) then
					if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
						if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
							if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
								arg_122_0:score_update(2)
							else
								arg_122_0:score_update(1)
							end
						else
							arg_122_0:score_update(0)
						end

						arg_122_0.piecelist_lt[1].ob.localPosition = arg_122_0.pieceinit_xyz.left

						setActive(arg_122_0.piecelist_lt[1].ob, false)
						arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0:list_pop(arg_122_0.piecelist_lt).ob)
					end
				elseif (arg_122_0.piecelist_lt[0] == 0 or not arg_122_0.piecelist_lt[1].ob) and arg_122_0.piecelist_rt[0] ~= 0 and arg_122_0.piecelist_rt[1].ob and arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
					if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
						if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
							arg_122_0:score_update(2)
						else
							arg_122_0:score_update(1)
						end
					else
						arg_122_0:score_update(0)
					end

					arg_122_0.piecelist_rt[1].ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piecelist_rt[1].ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0:list_pop(arg_122_0.piecelist_rt).ob)
				end

				arg_122_0.piece_nowl_aloneflag = true
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time == arg_126_2[1].end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			elseif not arg_122_0.downingleft_flag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			end
		end

		if arg_122_0.game_dgree == 2 then
			local function var_126_0()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time < arg_122_0.time_laterperfect then
					arg_122_0:score_update(2)
				elseif arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time < arg_122_0.time_latergood then
					arg_122_0:score_update(1)
				end

				arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

				setActive(arg_122_0.piece_nowl.ob, false)
				arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0.piece_nowl.ob)

				arg_122_0.piece_nowl.ob = false
				arg_122_0.piece_nowl_aloneflag = true
			end

			local function var_126_1()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time < arg_122_0.time_laterperfect then
					arg_122_0:score_update(2)
				elseif arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time < arg_122_0.time_latergood then
					arg_122_0:score_update(1)
				end

				arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

				setActive(arg_122_0.piece_nowr.ob, false)
				arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0.piece_nowr.ob)

				arg_122_0.piece_nowr.ob = false
				arg_122_0.piece_nowr_aloneflag = true
			end

			local function var_126_2()
				if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
					if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
						if arg_122_0.piecelist_lt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
							arg_122_0:score_update(2)
						else
							arg_122_0:score_update(1)
						end
					else
						arg_122_0:score_update(0)
					end

					arg_122_0.piecelist_lt[1].ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piecelist_lt[1].ob, false)

					local var_129_0 = arg_122_0:list_pop(arg_122_0.piecelist_lt)

					if var_129_0 and var_129_0.ob then
						arg_122_0:list_push(arg_122_0.piecelist_lf, var_129_0.ob)
					end

					arg_122_0.piece_nowl_aloneflag = true
				end
			end

			local function var_126_3()
				if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
					if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good then
						if arg_122_0.piecelist_rt[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect then
							arg_122_0:score_update(2)
						else
							arg_122_0:score_update(1)
						end
					else
						arg_122_0:score_update(0)
					end

					arg_122_0.piecelist_rt[1].ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piecelist_rt[1].ob, false)

					local var_130_0 = arg_122_0:list_pop(arg_122_0.piecelist_rt)

					if var_130_0 and var_130_0.ob then
						arg_122_0:list_push(arg_122_0.piecelist_rf, var_130_0.ob)
					end

					arg_122_0.piece_nowr_aloneflag = true
				end
			end

			local function var_126_4()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time <= arg_122_0.time_laterperfect then
					if not arg_122_0.piece_nowl_downflag then
						arg_122_0.piece_nowl_downflag = true

						arg_122_0:score_update(2)
					end
				elseif arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time <= arg_122_0.time_latergood and not arg_122_0.piece_nowl_downflag then
					arg_122_0.piece_nowl_downflag = true

					arg_122_0:score_update(1)
				end

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.end_time > arg_122_0.time_latergood - arg_122_0.time_interval and arg_122_0.piece_nowl_downflag then
					arg_122_0.piece_nowl_downflag = false

					arg_122_0:score_update(0)
				end
			end

			local function var_126_5()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time <= arg_122_0.time_laterperfect then
					if not arg_122_0.piece_nowr_downflag then
						arg_122_0.piece_nowr_downflag = true

						arg_122_0:score_update(2)
					end
				elseif arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time <= arg_122_0.time_latergood and not arg_122_0.piece_nowr_downflag then
					arg_122_0.piece_nowr_downflag = true

					arg_122_0:score_update(1)
				end

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.end_time > arg_122_0.time_latergood - arg_122_0.time_interval and arg_122_0.piece_nowr_downflag then
					arg_122_0.piece_nowr_downflag = false

					arg_122_0:score_update(0)
				end
			end

			local function var_126_6()
				if arg_122_0.piece_nowl.end_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good and arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.end_time < arg_122_0.time_latergood then
					if arg_122_0.piece_nowl.end_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect and arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.end_time < arg_122_0.time_laterperfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end
				else
					arg_122_0:score_update(0)
				end

				arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

				setActive(arg_122_0.piece_nowl.ob, false)
				arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0.piece_nowl.ob)

				arg_122_0.piece_nowl.ob = false
				arg_122_0.piece_nowl_downflag = false
				arg_122_0.piece_nowl_aloneflag = false
			end

			local function var_126_7()
				if arg_122_0.piece_nowr.end_time - arg_122_0.musicgame_nowtime < arg_122_0.time_good and arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.end_time < arg_122_0.time_latergood then
					if arg_122_0.piece_nowr.end_time - arg_122_0.musicgame_nowtime < arg_122_0.time_perfect and arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.end_time < arg_122_0.time_laterperfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end
				else
					arg_122_0:score_update(0)
				end

				arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

				setActive(arg_122_0.piece_nowr.ob, false)
				arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0.piece_nowr.ob)

				arg_122_0.piece_nowr.ob = false
				arg_122_0.piece_nowr_downflag = false
				arg_122_0.piece_nowr_aloneflag = false
			end

			local function var_126_8()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.begin_time > arg_122_0.time_latergood - arg_122_0.time_interval then
					arg_122_0.piece_nowl_downflag = false
					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end
			end

			local function var_126_9()
				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.begin_time > arg_122_0.time_latergood - arg_122_0.time_interval then
					arg_122_0.piece_nowr_downflag = false
					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end
			end

			local function var_126_10()
				if arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime > arg_122_0.time_good and arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
					arg_126_2[1].ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_126_2[1].ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0:list_pop(arg_126_2).ob)

					arg_122_0.piece_nowl_downflag = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end
			end

			local function var_126_11()
				if arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime > arg_122_0.time_good and arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime < arg_122_0.time_miss then
					arg_126_2[1].ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_126_2[1].ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0:list_pop(arg_126_2).ob)

					arg_122_0.piece_nowr_downflag = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end
			end

			local function var_126_12()
				if not arg_122_0.piece_nowl_aloneflag and arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime <= arg_122_0.time_good and not arg_122_0.piece_nowl_downflag then
					arg_122_0.piece_nowl_downflag = true

					if arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime <= arg_122_0.time_perfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end
				end
			end

			local function var_126_13()
				if not arg_122_0.piece_nowr_aloneflag and arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime <= arg_122_0.time_good and not arg_122_0.piece_nowr_downflag then
					arg_122_0.piece_nowr_downflag = true

					if arg_126_2[1].begin_time - arg_122_0.musicgame_nowtime <= arg_122_0.time_perfect then
						arg_122_0:score_update(2)
					else
						arg_122_0:score_update(1)
					end
				end
			end

			local function var_126_14()
				if not arg_122_0.piece_nowl_aloneflag and arg_122_0.piece_nowl_downflag then
					arg_126_2[1].ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_126_2[1].ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_lf, arg_122_0:list_pop(arg_126_2).ob)

					arg_122_0.piece_nowl_downflag = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end

				arg_122_0.piece_nowl_aloneflag = false
			end

			local function var_126_15()
				if not arg_122_0.piece_nowr_aloneflag and arg_122_0.piece_nowr_downflag then
					arg_126_2[1].ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_126_2[1].ob, false)
					arg_122_0:list_push(arg_122_0.piecelist_rf, arg_122_0:list_pop(arg_126_2).ob)

					arg_122_0.piece_nowr_downflag = false

					arg_122_0:score_update(0)
					arg_122_0:score_update(0)
				end

				arg_122_0.piece_nowr_aloneflag = false
			end

			if arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time == arg_122_0.piece_nowl.end_time and arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag then
				if arg_122_0.piece_nowl.key_flag ~= "K_BOTH" and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_0()
				elseif arg_122_0.piece_nowr.key_flag == "K_BOTH" and arg_122_0.piece_nowr.ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_0()
					var_126_1()
				end
			elseif arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time == arg_122_0.piece_nowl.end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			elseif arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time ~= arg_122_0.piece_nowl.end_time and arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag and not arg_122_0.piece_nowl_aloneflag then
				if arg_122_0.piece_nowl.key_flag ~= "K_BOTH" and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_4()
				elseif arg_122_0.piece_nowr.key_flag == "K_BOTH" and arg_122_0.piece_nowr.ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_4()
					var_126_5()
				end
			elseif arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time ~= arg_122_0.piece_nowl.end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				if arg_122_0.piece_nowl.key_flag ~= "K_BOTH" and arg_122_0.piece_nowl_downflag then
					var_126_6()
				elseif arg_122_0.piece_nowr.key_flag == "K_BOTH" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowl_downflag and not arg_122_0.downingright_flag then
					var_126_6()
					var_126_7()
				end
			elseif arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time ~= arg_122_0.piece_nowl.end_time and (not arg_122_0.downingleft_flag or not arg_122_0.downingleft_lastflag) and arg_122_0.piece_nowl.key_flag ~= "K_BOTH" then
				var_126_8()
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time == arg_126_2[1].end_time and arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_2()
				elseif arg_122_0.piecelist_rt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_rt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_2()
					var_126_3()
				end
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time == arg_126_2[1].end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag and arg_126_2[1].key_flag ~= "K_BOTH" then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_10()
				elseif arg_122_0.piecelist_rt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_rt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_10()
					var_126_11()
				end
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag and not arg_122_0.piece_nowl_aloneflag and arg_126_2[1].key_flag ~= "K_BOTH" then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_12()
				elseif arg_122_0.piecelist_rt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_rt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_12()
					var_126_13()
				end
			elseif arg_126_0 == "left" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and not arg_122_0.downingleft_flag and arg_122_0.downingleft_lastflag then
				if arg_126_2[1].key_flag ~= "K_BOTH" and arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_14()
				elseif arg_122_0.piecelist_rt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_rt[1].ob and arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag and arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_14()
					var_126_15()
				end
			elseif not arg_122_0.downingleft_flag and not arg_122_0.downingleft_lastflag then
				arg_122_0.piece_nowl_aloneflag = false
				arg_122_0.piece_nowl_downflag = false
			end

			if arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time == arg_122_0.piece_nowr.end_time and arg_122_0.downingright_flag and not arg_122_0.downingright_lastflag then
				if arg_122_0.piece_nowr.key_flag ~= "K_BOTH" and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_1()
				elseif arg_122_0.piece_nowl.key_flag == "K_BOTH" and arg_122_0.piece_nowl.ob and arg_122_0.downingleft_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_1()
					var_126_0()
				end
			elseif arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time == arg_122_0.piece_nowr.end_time and not arg_122_0.downingright_flag and arg_122_0.downingright_lastflag then
				arg_122_0.piece_nowr_aloneflag = false
				arg_122_0.piece_nowr_downflag = false
			elseif arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time ~= arg_122_0.piece_nowr.end_time and arg_122_0.downingright_flag and arg_122_0.downingright_lastflag and not arg_122_0.piece_nowr_aloneflag then
				if arg_122_0.piece_nowr.key_flag ~= "K_BOTH" and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_5()
				elseif arg_122_0.piece_nowl.key_flag == "K_BOTH" and arg_122_0.piece_nowl.ob and arg_122_0.downingleft_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_5()
					var_126_4()
				end
			elseif arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time ~= arg_122_0.piece_nowr.end_time and not arg_122_0.downingright_flag and arg_122_0.downingright_lastflag and arg_122_0.piece_nowr.key_flag ~= "K_BOTH" then
				if arg_122_0.piece_nowr.key_flag ~= "K_BOTH" and arg_122_0.piece_nowr_downflag then
					var_126_7()
				elseif arg_122_0.piece_nowl.key_flag == "K_BOTH" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowr_downflag and not arg_122_0.downingleft_flag then
					var_126_7()
					var_126_6()
				end
			elseif arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time ~= arg_122_0.piece_nowr.end_time and (not arg_122_0.downingright_flag or not arg_122_0.downingright_lastflag) and arg_122_0.piece_nowr.key_flag ~= "K_BOTH" then
				var_126_9()
			elseif arg_126_0 == "right" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time == arg_126_2[1].end_time and arg_122_0.downingright_flag and not arg_122_0.downingright_lastflag then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_3()
				elseif arg_122_0.piecelist_lt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_lt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_3()
					var_126_2()
				end
			elseif arg_126_0 == "right" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time == arg_126_2[1].end_time and arg_122_0.downingright_flag and not arg_122_0.downingright_lastflag then
				arg_122_0.piece_nowr_aloneflag = false
				arg_122_0.piece_nowr_downflag = false
			elseif arg_126_0 == "right" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and arg_122_0.downingright_flag and not arg_122_0.downingright_lastflag and arg_126_2[1].key_flag ~= "K_BOTH" then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_11()
				elseif arg_122_0.piecelist_lt[1] and arg_122_0.piecelist_lt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_lt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_11()
					var_126_10()
				end
			elseif arg_126_0 == "right" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and arg_122_0.downingright_flag and arg_122_0.downingright_lastflag and not arg_122_0.piece_nowr_aloneflag and arg_126_2[1].key_flag ~= "K_BOTH" then
				if arg_126_2[1].key_flag ~= "K_BOTH" and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_13()
				elseif arg_122_0.piecelist_lt[1] and arg_122_0.piecelist_lt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_lt[1].ob and arg_122_0.downingright_flag and not arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.downingleft_flag and not arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_13()
					var_126_12()
				end
			elseif arg_126_0 == "right" and arg_126_2[0] ~= 0 and arg_126_2[1].ob and arg_126_2[1].begin_time ~= arg_126_2[1].end_time and not arg_122_0.downingright_flag and arg_122_0.downingright_lastflag and arg_126_2[1].key_flag ~= "K_BOTH" then
				if arg_126_2[1].key_flag ~= "K_BOTH" and arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag then
					var_126_15()
				elseif arg_122_0.piecelist_lt[1] and arg_122_0.piecelist_lt[1].key_flag == "K_BOTH" and arg_122_0.piecelist_lt[1].ob and arg_122_0.piece_nowr_downflag and not arg_122_0.piece_nowr_aloneflag and arg_122_0.piece_nowl_downflag and not arg_122_0.piece_nowl_aloneflag then
					var_126_15()
					var_126_14()
				end
			elseif not arg_122_0.downingright_flag and not arg_122_0.downingright_lastflag then
				arg_122_0.piece_nowr_aloneflag = false
				arg_122_0.piece_nowr_downflag = false
			end
		end

		local var_126_16 = arg_126_2[0]

		for iter_126_0 = 1, var_126_16 do
			local var_126_17 = arg_122_0:list_pop(arg_126_2)
			local var_126_18 = var_126_17.ob.localPosition
			local var_126_19 = (arg_122_0.musicgame_nowtime - var_126_17.begin_time + arg_126_1) * var_122_1

			if arg_126_0 == "left" then
				var_126_17.ob.localPosition = Vector3(arg_122_0.pieceinit_xyz[arg_126_0].x + var_126_19, var_126_18.y, var_126_18.z)

				if var_126_17.ob.localPosition.x < 0 then
					arg_122_0:list_push(arg_126_2, var_126_17)
				else
					var_126_17.ob.localPosition = Vector3(0, var_126_18.y, var_126_18.z)

					if arg_122_0.piece_nowl.ob then
						arg_122_0.piece_nowl.ob.localPosition = Vector3(arg_122_0.pieceinit_xyz.left.x, var_126_18.y, var_126_18.z)

						setActive(arg_122_0.piece_nowl.ob, false)
						arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowl.ob)
					end

					arg_122_0.piece_nowl.ob = var_126_17.ob
					arg_122_0.piece_nowl.begin_time = var_126_17.begin_time
					arg_122_0.piece_nowl.end_time = var_126_17.end_time
					arg_122_0.piece_nowl.key_flag = var_126_17.key_flag

					arg_122_0.piece_nowl.ob:GetComponent(typeof(Transform)):SetAsFirstSibling()
				end
			elseif arg_126_0 == "right" then
				var_126_17.ob.localPosition = Vector3(arg_122_0.pieceinit_xyz[arg_126_0].x - var_126_19, var_126_18.y, var_126_18.z)

				if var_126_17.ob.localPosition.x > 0 then
					arg_122_0:list_push(arg_126_2, var_126_17)
				else
					var_126_17.ob.localPosition = Vector3(0, var_126_18.y, var_126_18.z)

					if arg_122_0.piece_nowr.ob then
						arg_122_0.piece_nowr.ob.localPosition = Vector3(arg_122_0.pieceinit_xyz.right.x, var_126_18.y, var_126_18.z)

						setActive(arg_122_0.piece_nowr.ob, false)
						arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowr.ob)
					end

					arg_122_0.piece_nowr.ob = var_126_17.ob
					arg_122_0.piece_nowr.begin_time = var_126_17.begin_time
					arg_122_0.piece_nowr.end_time = var_126_17.end_time
					arg_122_0.piece_nowr.key_flag = var_126_17.key_flag

					arg_122_0.piece_nowr.ob:GetComponent(typeof(Transform)):SetAsFirstSibling()
				end
			end
		end

		local var_126_20 = arg_122_0.game_dgree

		if arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time == arg_122_0.piece_nowl.end_time then
			if arg_122_0.piece_nowl.key_flag == "K_BOTH" then
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color.a - (arg_122_0.musicgame_nowtime - arg_122_0.musicgame_lasttime) / arg_122_0.time_latergood)

				if arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color.a <= 0 then
					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false

					arg_122_0:score_update(0)
				end
			else
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color.a - (arg_122_0.musicgame_nowtime - arg_122_0.musicgame_lasttime) / arg_122_0.time_latergood)

				if arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color.a <= 0 then
					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false

					arg_122_0:score_update(0)
				end
			end
		end

		if arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time == arg_122_0.piece_nowr.end_time then
			if arg_122_0.piece_nowl.key_flag == "K_BOTH" then
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color.a - (arg_122_0.musicgame_nowtime - arg_122_0.musicgame_lasttime) / arg_122_0.time_latergood)

				if arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_2/img"):GetComponent(typeof(Image)).color.a <= 0 then
					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false

					arg_122_0:score_update(0)
				end
			else
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color.a - (arg_122_0.musicgame_nowtime - arg_122_0.musicgame_lasttime) / arg_122_0.time_latergood)

				if arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/note_1/img"):GetComponent(typeof(Image)).color.a <= 0 then
					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false

					arg_122_0:score_update(0)
				end
			end
		end

		if arg_126_0 == "left" and arg_122_0.piece_nowl.ob and arg_122_0.piece_nowl.begin_time ~= arg_122_0.piece_nowl.end_time then
			if arg_122_0.piece_nowl.key_flag == "K_BOTH" then
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_2/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl_downflag and 1 or 0.4)
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_2/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl_downflag and 1 or 0.8)

				local var_126_21 = arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMin
				local var_126_22 = 274 - 1142 / var_122_3 * (arg_122_0.piece_nowl.end_time - arg_122_0.musicgame_nowtime)

				var_126_22 = var_126_22 < 274 and var_126_22 or 274
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMin = Vector2(var_126_22, var_126_21.y)

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.end_time > arg_122_0.time_latergood then
					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false
					arg_122_0.piece_nowl_downflag = false

					arg_122_0:score_update(0)
				end
			else
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_1/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl_downflag and 1 or 0.4)
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_1/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowl_downflag and 1 or 0.8)

				local var_126_23 = arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMin
				local var_126_24 = 274 - 1142 / var_122_3 * (arg_122_0.piece_nowl.end_time - arg_122_0.musicgame_nowtime)

				var_126_24 = var_126_24 < 274 and var_126_24 or 274
				arg_122_0.piece_nowl.ob:Find(var_126_20 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMin = Vector2(var_126_24, var_126_23.y)

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowl.end_time > arg_122_0.time_latergood then
					arg_122_0.piece_nowl.ob.localPosition = arg_122_0.pieceinit_xyz.left

					setActive(arg_122_0.piece_nowl.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowl.ob)

					arg_122_0.piece_nowl.ob = false
					arg_122_0.piece_nowl_downflag = false

					arg_122_0:score_update(0)
				end
			end
		end

		if arg_126_0 == "right" and arg_122_0.piece_nowr.ob and arg_122_0.piece_nowr.begin_time ~= arg_122_0.piece_nowr.end_time then
			if arg_122_0.piece_nowl.key_flag == "K_BOTH" then
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_2/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr_downflag and 1 or 0.4)
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_2/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr_downflag and 1 or 0.8)

				local var_126_25 = arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMax
				local var_126_26 = 274 - 1142 / var_122_3 * (arg_122_0.piece_nowr.end_time - arg_122_0.musicgame_nowtime)

				var_126_26 = var_126_26 < 274 and var_126_26 or 274
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_2/note_above"):GetComponent(typeof(RectTransform)).offsetMax = Vector2(-var_126_26, var_126_25.y)

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.end_time > arg_122_0.time_latergood then
					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false
					arg_122_0.piece_nowr_downflag = false

					arg_122_0:score_update(0)
				end
			else
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_1/note_above/below"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr_downflag and 1 or 0.4)
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_1/note_above/above"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, arg_122_0.piece_nowr_downflag and 1 or 0.8)

				local var_126_27 = arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMax
				local var_126_28 = 274 - 1142 / var_122_3 * (arg_122_0.piece_nowr.end_time - arg_122_0.musicgame_nowtime)

				var_126_28 = var_126_28 < 274 and var_126_28 or 274
				arg_122_0.piece_nowr.ob:Find(var_126_20 .. "/notelong_1/note_above"):GetComponent(typeof(RectTransform)).offsetMax = Vector2(-var_126_28, var_126_27.y)

				if arg_122_0.musicgame_nowtime - arg_122_0.piece_nowr.end_time > arg_122_0.time_latergood then
					arg_122_0.piece_nowr.ob.localPosition = arg_122_0.pieceinit_xyz.right

					setActive(arg_122_0.piece_nowr.ob, false)
					arg_122_0:list_push(arg_126_3, arg_122_0.piece_nowr.ob)

					arg_122_0.piece_nowr.ob = false
					arg_122_0.piece_nowr_downflag = false

					arg_122_0:score_update(0)
				end
			end
		end
	end

	var_122_7("left", var_122_3, arg_122_0.piecelist_lt, arg_122_0.piecelist_lf)
	var_122_7("right", var_122_2, arg_122_0.piecelist_rt, arg_122_0.piecelist_rf)

	if arg_122_0.piece_nowr_downflag or arg_122_0.piece_nowl_downflag and arg_122_0.game_playingflag then
		arg_122_0:effect_play("perfect_loop02", true)
	else
		arg_122_0:effect_play("perfect_loop02", false)
	end

	arg_122_0:scoresliderAcombo_update()
end

return var_0_0
