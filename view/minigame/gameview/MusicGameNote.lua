local var_0_0 = class("MusicGameNote")

var_0_0.easyTriggerStepTime = nil
var_0_0.type_left = 1
var_0_0.type_right = 2
var_0_0.type_pu_normal = 1
var_0_0.type_pu_both = 2
var_0_0.type_dgree_easy = 1
var_0_0.type_dgree_hard = 2

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 4
local var_0_6 = 0
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = {
	500,
	800,
	1250,
	1450
}
local var_0_10 = {
	0.26,
	0.2,
	0.15,
	0.13
}
local var_0_11 = 3
local var_0_12
local var_0_13 = false

local function var_0_14(arg_1_0)
	local var_1_0 = {
		_tf = arg_1_0
	}

	var_1_0.type = nil
	var_1_0.beginTime = nil
	var_1_0.endTime = nil
	var_1_0.longFlag = nil
	var_1_0.removeTime = nil
	var_1_0.speedOffsetX = nil
	var_1_0.longTime = 0
	var_1_0.triggerDown = nil
	var_1_0.triggerUp = nil

	function var_1_0.Ctor(arg_2_0)
		arg_2_0.longTf = findTF(arg_2_0._tf, "longNote")
		arg_2_0.singleTf = findTF(arg_2_0._tf, "singleNote")
	end

	function var_1_0.stepUpdate(arg_3_0, arg_3_1)
		if not isActive(arg_3_0._tf) then
			arg_3_0:changeActive(true)
		end

		local var_3_0 = (arg_3_1 - arg_3_0.beginTime) * arg_3_0.speedOffsetX

		if var_3_0 > 0 then
			var_3_0 = 0
		end

		arg_3_0._tf.localPosition = Vector3(var_3_0, 0, 0)

		if arg_3_0.longFlag then
			local var_3_1

			if var_3_0 == 0 then
				var_3_1 = (arg_3_0.endTime - arg_3_1) * arg_3_0.speedOffsetX

				if not arg_3_0.triggerDown and not arg_3_0.removeTime then
					arg_3_0.removeTime = arg_3_1 + var_0_12
				end
			else
				var_3_1 = (arg_3_0.endTime - arg_3_0.beginTime) * arg_3_0.speedOffsetX
			end

			if var_3_1 < 0 then
				var_3_1 = 0
			end

			arg_3_0.longTf.sizeDelta = Vector2(var_3_1, arg_3_0.longTf.sizeDelta.y)

			if var_3_1 == 0 and not arg_3_0.triggerUp and not arg_3_0.removeTime then
				arg_3_0.removeTime = arg_3_1 + var_0_12
			end
		elseif var_3_0 == 0 and not arg_3_0.removeTime then
			arg_3_0.removeTime = arg_3_1 + var_0_12
		end
	end

	function var_1_0.setNoteData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_4_0.removeTime = nil
		arg_4_0.triggerDown = nil
		arg_4_0.triggerUp = nil
		arg_4_0.keyType = arg_4_1.key_flag == "K_BOTH" and MusicGameNote.type_pu_both or MusicGameNote.type_pu_normal
		arg_4_0.beginTime = tonumber(arg_4_1.begin_time)
		arg_4_0.endTime = tonumber(arg_4_1.end_time)
		arg_4_0.longTime = arg_4_0.endTime - arg_4_0.beginTime
		arg_4_0.longFlag = arg_4_1.begin_time ~= arg_4_1.end_time
		arg_4_0.speedOffsetX = arg_4_2
		arg_4_0.dgree = arg_4_3
		arg_4_0.directType = arg_4_4
		arg_4_0.imgType = arg_4_0:getImageType()
		arg_4_0._tf.localPosition = Vector3(0, 0, 0)
		arg_4_0._tf.name = "beginTime" .. arg_4_0.beginTime

		arg_4_0:updateNoteTf()
	end

	function var_1_0.updateNoteTf(arg_5_0)
		setActive(findTF(arg_5_0._tf, "singleNote"), false)
		setActive(findTF(arg_5_0._tf, "longNote"), false)

		if arg_5_0.longFlag then
			setActive(findTF(arg_5_0._tf, "longNote"), true)

			for iter_5_0 = 1, var_0_5 do
				setActive(findTF(arg_5_0._tf, "longNote/note/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)
				setActive(findTF(arg_5_0._tf, "longNote/long/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)
			end
		else
			setActive(findTF(arg_5_0._tf, "singleNote"), true)

			for iter_5_1 = 1, var_0_5 do
				setActive(findTF(arg_5_0._tf, "singleNote/note/img" .. iter_5_1), iter_5_1 == arg_5_0.imgType)
			end
		end
	end

	function var_1_0.getImageType(arg_6_0)
		if arg_6_0.dgree == MusicGameNote.type_dgree_easy then
			return var_0_1
		elseif arg_6_0.keyType == MusicGameNote.type_pu_both then
			return var_0_4
		elseif arg_6_0.directType == MusicGameNote.type_left then
			return var_0_2
		elseif arg_6_0.directType == MusicGameNote.type_right then
			return var_0_3
		end

		return var_0_1
	end

	function var_1_0.getRemoveTime(arg_7_0)
		return arg_7_0.removeTime
	end

	function var_1_0.triggerScore(arg_8_0)
		if arg_8_0.removeTime then
			arg_8_0.removeTime = nil
		end
	end

	function var_1_0.changeActive(arg_9_0, arg_9_1)
		setActive(arg_9_0._tf, arg_9_1)
	end

	var_1_0:Ctor()

	return var_1_0
end

function var_0_0.Ctor(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._tf = arg_10_1
	arg_10_0.directType = arg_10_2
	arg_10_0.noteStateCallback = nil
	arg_10_0.tplNote = findTF(arg_10_0._tf, "tplNote")
	arg_10_0.notePool = {}
	arg_10_0.noteList = {}
end

function var_0_0.setStateCallback(arg_11_0, arg_11_1)
	arg_11_0.noteStateCallback = arg_11_1
end

function var_0_0.setLongTimeCallback(arg_12_0, arg_12_1)
	arg_12_0.longNoteCallback = arg_12_1
end

function var_0_0.setStartData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	var_0_12 = var_0_10[arg_13_2]
	arg_13_0.puList = arg_13_1
	arg_13_0.speedLevel = arg_13_2
	arg_13_0.dgree = arg_13_3
	arg_13_0.speedOffsetX = var_0_9[arg_13_2]

	arg_13_0:clearNote()
end

function var_0_0.step(arg_14_0, arg_14_1)
	arg_14_0.stepTime = arg_14_1 / 1000

	if #arg_14_0.noteList > 0 then
		local var_14_0 = arg_14_0.noteList[1]
		local var_14_1 = arg_14_0:checkScoreType(var_14_0)

		if var_14_1 then
			var_14_0:triggerScore()
			arg_14_0.noteStateCallback(var_14_1)

			if not var_14_0.longFlag or var_14_1 == var_0_6 then
				arg_14_0:returnNote(table.remove(arg_14_0.noteList, 1))
			elseif var_14_0.longFlag and var_14_0.triggerUp then
				arg_14_0:returnNote(table.remove(arg_14_0.noteList, 1))

				if arg_14_0.longNoteCallback then
					arg_14_0.longNoteCallback(var_14_0.longTime)
				end
			end
		end
	end

	for iter_14_0 = #arg_14_0.noteList, 1, -1 do
		local var_14_2 = arg_14_0.noteList[iter_14_0]:getRemoveTime()

		if var_14_2 and var_14_2 < arg_14_0.stepTime then
			if arg_14_0.noteStateCallback then
				if not var_0_13 then
					arg_14_0.noteStateCallback(var_0_6)
				else
					arg_14_0.noteStateCallback(var_0_8)
				end
			end

			if arg_14_0.loopFlag then
				arg_14_0.loopFlag = false
			end

			arg_14_0:returnNote(table.remove(arg_14_0.noteList, iter_14_0))
		end
	end

	for iter_14_1 = #arg_14_0.noteList, 1, -1 do
		arg_14_0.noteList[iter_14_1]:stepUpdate(arg_14_0.stepTime)
	end

	if arg_14_0.puList and #arg_14_0.puList > 0 then
		local var_14_3 = arg_14_0.puList[1]

		if arg_14_0:checkPuShow(var_14_3) then
			arg_14_0:pushNoteToList(arg_14_0:getNote(var_14_3))
			table.remove(arg_14_0.puList, 1)
		end
	end
end

function var_0_0.checkScoreType(arg_15_0, arg_15_1)
	if arg_15_0.dgree == MusicGameNote.type_dgree_easy and arg_15_0.keyDownStepTime and arg_15_0.keyDownStepTime and arg_15_0.keyDownStepTime == MusicGameNote.easyTriggerStepTime then
		arg_15_0.keyDownTrigger = true
	end

	local var_15_0
	local var_15_1

	if not arg_15_1.longFlag then
		local var_15_2 = arg_15_1.beginTime

		if arg_15_0.keyDownStepTime and not arg_15_0.keyDownTrigger then
			local var_15_3 = math.abs(arg_15_0.keyDownStepTime - var_15_2)

			if arg_15_1.keyType == MusicGameNote.type_pu_both then
				if arg_15_0.keyBothDown then
					var_15_0 = arg_15_0:getScoreType(var_15_3)
				end
			else
				var_15_0 = arg_15_0:getScoreType(var_15_3)
			end

			if var_15_0 then
				arg_15_1.triggerDown = true
				arg_15_0.keyDownTrigger = true

				if arg_15_0.dgree == MusicGameNote.type_dgree_easy then
					MusicGameNote.easyTriggerStepTime = arg_15_0.keyDownStepTime
				end
			end
		end
	elseif not arg_15_1.triggerDown then
		local var_15_4 = arg_15_1.beginTime

		if arg_15_0.keyDownStepTime and not arg_15_0.keyDownTrigger then
			local var_15_5 = math.abs(arg_15_0.keyDownStepTime - var_15_4)

			if arg_15_1.keyType == MusicGameNote.type_pu_both then
				if arg_15_0.keyBothDown then
					var_15_0 = arg_15_0:getScoreType(var_15_5)
				end
			else
				var_15_0 = arg_15_0:getScoreType(var_15_5)
			end

			if var_15_0 then
				arg_15_1.triggerDown = true
				arg_15_0.keyDownTrigger = true
				arg_15_0.loopFlag = true
			end
		end
	else
		local var_15_6 = arg_15_1.endTime
		local var_15_7 = arg_15_0.stepTime < var_15_6 - var_0_12

		if not arg_15_0.keyDown and var_15_7 then
			if arg_15_0.loopFlag then
				arg_15_0.loopFlag = false
			end

			var_15_0 = var_0_6
		elseif arg_15_0.keyUpStepTime and not arg_15_0.keyUpTrigger then
			local var_15_8 = math.abs(arg_15_0.keyUpStepTime - var_15_6)

			if arg_15_1.keyType == MusicGameNote.type_pu_both then
				if arg_15_0.keyBothUp then
					var_15_0 = arg_15_0:getScoreType(var_15_8)
				end
			else
				var_15_0 = arg_15_0:getScoreType(var_15_8)
			end

			if var_15_0 then
				if arg_15_0.loopFlag then
					arg_15_0.loopFlag = false
				end

				arg_15_1.triggerUp = true
				arg_15_0.keyUpTrigger = true
			end
		end
	end

	return var_15_0
end

function var_0_0.loopTime(arg_16_0)
	return arg_16_0.loopFlag
end

function var_0_0.getScoreType(arg_17_0, arg_17_1)
	if arg_17_1 < var_0_12 / 2 then
		return var_0_8
	elseif arg_17_1 < var_0_12 then
		return var_0_7
	end

	return nil
end

function var_0_0.pushNoteToList(arg_18_0, arg_18_1)
	table.insert(arg_18_0.noteList, arg_18_1)
end

function var_0_0.checkPuShow(arg_19_0, arg_19_1)
	if arg_19_1.begin_time - arg_19_0.stepTime <= var_0_11 then
		return true
	end

	return false
end

function var_0_0.clearNote(arg_20_0)
	for iter_20_0 = #arg_20_0.noteList, 1, -1 do
		local var_20_0 = table.remove(arg_20_0.noteList, iter_20_0)

		arg_20_0:returnNote(var_20_0)
	end
end

function var_0_0.getNote(arg_21_0, arg_21_1)
	if #arg_21_0.notePool == 0 then
		local var_21_0 = arg_21_0:createNote()

		table.insert(arg_21_0.notePool, var_21_0)
	end

	local var_21_1 = table.remove(arg_21_0.notePool, 1)

	var_21_1:setNoteData(arg_21_1, arg_21_0.speedOffsetX, arg_21_0.dgree, arg_21_0.directType)

	return var_21_1
end

function var_0_0.returnNote(arg_22_0, arg_22_1)
	arg_22_1:changeActive(false)
	table.insert(arg_22_0.notePool, arg_22_1)
end

function var_0_0.createNote(arg_23_0)
	local var_23_0 = tf(instantiate(arg_23_0.tplNote))

	setActive(var_23_0, false)

	local var_23_1 = var_0_14(var_23_0)

	setParent(var_23_0, arg_23_0._tf)

	return var_0_14(var_23_0)
end

function var_0_0.onKeyDown(arg_24_0)
	arg_24_0.keyDown = true
	arg_24_0.keyUp = false
	arg_24_0.keyDownStepTime = arg_24_0.stepTime
	arg_24_0.keyDownTrigger = false
	arg_24_0.keyBothDown = false
end

function var_0_0.onKeyUp(arg_25_0)
	arg_25_0.keyUp = true
	arg_25_0.keyDown = false
	arg_25_0.keyUpStepTime = arg_25_0.stepTime
	arg_25_0.keyUpTrigger = false
	arg_25_0.keyBothUp = false
end

function var_0_0.bothDown(arg_26_0)
	arg_26_0.keyDownStepTime = arg_26_0.stepTime
	arg_26_0.keyBothDown = true
	arg_26_0.keyBothUp = false
end

function var_0_0.bothUp(arg_27_0)
	arg_27_0.keyBothUp = true
	arg_27_0.keyBothDown = false
	arg_27_0.keyUpStepTime = arg_27_0.stepTime
end

return var_0_0
