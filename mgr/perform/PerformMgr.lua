pg = pg or {}

local var_0_0 = singletonClass("PerformMgr")

pg.PerformMgr = var_0_0

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = 0
local var_0_9 = 1
local var_0_10 = 2

require("Mgr/Perform/Include")

local var_0_11 = true

local function var_0_12(...)
	if var_0_11 and IsUnityEditor then
		originalPrint(...)
	end
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.status = var_0_1
	arg_2_0.playedList = {}
	arg_2_0.playQueue = {}

	PoolMgr.GetInstance():GetUI("PerformUI", true, function(arg_3_0)
		arg_2_0._go = arg_3_0
		arg_2_0._tf = tf(arg_2_0._go)
		arg_2_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_2_0._go.transform:SetParent(arg_2_0.UIOverlay.transform, false)

		arg_2_0.cpkPlayer = CpkPerformPlayer.New(findTF(arg_2_0._tf, "window_cpk"))
		arg_2_0.dialoguePlayer = DialoguePerformPlayer.New(findTF(arg_2_0._tf, "window_dialogue"))
		arg_2_0.picturePlayer = PictruePerformPlayer.New(findTF(arg_2_0._tf, "window_picture"))
		arg_2_0.storyPlayer = StoryPerformPlayer.New(findTF(arg_2_0._tf, "window_story"))

		setActive(arg_2_0._go, false)

		arg_2_0.status = var_0_2

		if arg_2_1 then
			arg_2_1()
		end
	end)
end

function var_0_0.PlayOne(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert(pg.child_performance[arg_4_1], "child_performance not exist id: " .. arg_4_1)

	if not arg_4_0:CheckState() then
		var_0_12("perform state error" .. arg_4_0.status)

		return nil
	end

	var_0_12("OnlyOne Play")
	arg_4_0:Show()

	local function var_4_0()
		arg_4_0:Hide()

		if arg_4_2 then
			arg_4_2()
		end
	end

	arg_4_0:play(arg_4_1, var_4_0, arg_4_3, arg_4_4)
end

function var_0_0.PlayGroup(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(var_6_0, function(arg_7_0)
			arg_6_0:play(iter_6_1, arg_7_0, arg_6_3, arg_6_4)
		end)
	end

	arg_6_0:Show()
	seriesAsync(var_6_0, function(arg_8_0)
		arg_6_0:Hide()

		if arg_6_2 then
			arg_6_2()
		end
	end)
end

function var_0_0.play(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	assert(pg.child_performance[arg_9_1], "child_performance not exist id: " .. arg_9_1)

	if not arg_9_0:CheckState() then
		var_0_12("perform state error" .. arg_9_0.status)

		return nil
	end

	var_0_12("Play Perform:", arg_9_1)
	arg_9_0:addTaskProgress(arg_9_1)

	arg_9_0.status = var_0_4

	local function var_9_0()
		arg_9_0.status = var_0_5

		if arg_9_2 then
			arg_9_2()
		end
	end

	local var_9_1 = pg.child_performance[arg_9_1]

	arg_9_0:setWindowStatus(var_9_1)
	switch(var_9_1.type, {
		[EducateConst.PERFORM_TYPE_ANIM] = function()
			arg_9_0.cpkPlayer:Play(var_9_1, var_9_0, arg_9_4)
		end,
		[EducateConst.PERFORM_TYPE_WORD] = function()
			local var_12_0 = setmetatable({
				drops = arg_9_3 or {}
			}, {
				__index = var_9_1
			})

			arg_9_0.dialoguePlayer:Play(var_12_0, var_9_0)
		end,
		[EducateConst.PERFORM_TYPE_STORY] = function()
			arg_9_0.storyPlayer:Play(var_9_1, var_9_0)
		end,
		[EducateConst.PERFORM_TYPE_PICTURE] = function()
			arg_9_0.picturePlayer:Play(var_9_1, var_9_0, arg_9_4)
		end
	})
end

function var_0_0.addTaskProgress(arg_15_0, arg_15_1)
	local var_15_0 = getProxy(EducateProxy):GetTaskProxy():GetPerformAddTasks(arg_15_1)
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1:IsMind() then
			table.insert(var_15_1, {
				progress = 1,
				task_id = iter_15_1.id
			})
		end

		if iter_15_1:IsTarget() then
			table.insert(var_15_2, {
				progress = 1,
				task_id = iter_15_1.id
			})
		end

		if iter_15_1:IsMain() then
			table.insert(var_15_3, {
				progress = 1,
				task_id = iter_15_1.id
			})
		end
	end

	if #var_15_1 > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_MIND,
			progresses = var_15_1
		})
	end

	if #var_15_2 > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_TARGET,
			progresses = var_15_2
		})
	end

	if #var_15_3 > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.STSTEM_TYPE_MAIN,
			progresses = var_15_3
		})
	end
end

function var_0_0.PlayGroupNoHide(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		table.insert(var_16_0, function(arg_17_0)
			arg_16_0:play(iter_16_1, arg_17_0, arg_16_3, arg_16_4)
		end)
	end

	seriesAsync(var_16_0, arg_16_2)
end

function var_0_0.setWindowStatus(arg_18_0, arg_18_1)
	setActive(arg_18_0.cpkPlayer._tf, arg_18_1.cpk_status == var_0_10)
	setActive(arg_18_0.dialoguePlayer._tf, arg_18_1.dialogue_status == var_0_10)
	setActive(arg_18_0.picturePlayer._tf, arg_18_1.picture_status == var_0_10)
	setActive(arg_18_0.storyPlayer._tf, arg_18_1.story_status == var_0_10)
end

function var_0_0.CheckState(arg_19_0)
	if arg_19_0.status == var_0_1 then
		return false
	end

	return true
end

function var_0_0.IsRunning(arg_20_0)
	return arg_20_0.status == var_0_3 or arg_20_0.status == var_0_4 or arg_20_0.status == var_0_5
end

function var_0_0.Show(arg_21_0)
	arg_21_0.status = var_0_3

	setActive(arg_21_0._go, true)
	arg_21_0._tf:SetAsLastSibling()
end

function var_0_0.Clear(arg_22_0)
	arg_22_0.cpkPlayer:Clear()
	arg_22_0.dialoguePlayer:Clear()
	arg_22_0.picturePlayer:Clear()
	arg_22_0.storyPlayer:Clear()
end

function var_0_0.Hide(arg_23_0)
	arg_23_0:Clear()
	setActive(arg_23_0._go, false)

	arg_23_0.status = var_0_6
end

function var_0_0.Quit(arg_24_0)
	arg_24_0.status = var_0_7
end

function var_0_0.SetParamForUI(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.UI_PARAM[arg_25_1] or var_0_0.UI_PARAM.Default

	arg_25_0.cpkPlayer:SetUIParam(var_25_0)
end

var_0_0.UI_PARAM = {
	Default = {
		showCpkBg = true,
		sliderPos = {
			x = 0,
			y = 358
		},
		cpkPos = {
			x = 0,
			y = -25
		},
		cpkCoverPos = {
			x = 0,
			y = -380
		}
	},
	EducateSchedulePerformLayer = {
		showCpkBg = false,
		sliderPos = {
			x = 144,
			y = 344
		},
		cpkPos = {
			x = 144,
			y = -25
		},
		cpkCoverPos = {
			x = 144,
			y = -383
		}
	}
}
