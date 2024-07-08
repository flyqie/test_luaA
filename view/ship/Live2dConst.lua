local var_0_0 = class("Live2dConst")

function var_0_0.SaveL2dIdle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.GetL2dIdleSaveName(arg_1_0, arg_1_1)

	PlayerPrefs.SetInt(var_1_0, arg_1_2)
end

function var_0_0.SaveL2dAction(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.GetL2dActionSaveName(arg_2_0, arg_2_1)

	PlayerPrefs.SetInt(var_2_0, arg_2_2)
end

function var_0_0.GetL2dIdleSaveName(arg_3_0, arg_3_1)
	return "l2d_" .. tostring(arg_3_0) .. "_" .. tostring(arg_3_1) .. "_idle_index"
end

function var_0_0.GetL2dActionSaveName(arg_4_0, arg_4_1)
	return "l2d_" .. tostring(arg_4_0) .. "_" .. tostring(arg_4_1) .. "_action_id"
end

function var_0_0.GetL2dSaveData(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetL2dIdleSaveName(arg_5_0, arg_5_1)
	local var_5_1 = var_0_0.GetL2dActionSaveName(arg_5_0, arg_5_1)

	return PlayerPrefs.GetInt(var_5_0), PlayerPrefs.GetInt(var_5_1)
end

function var_0_0.SaveDragData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = var_0_0.GetDragSaveName(arg_6_0, arg_6_1, arg_6_2)

	PlayerPrefs.SetFloat(var_6_0, arg_6_3)
end

function var_0_0.GetDragData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_0.GetDragSaveName(arg_7_0, arg_7_1, arg_7_2)

	return PlayerPrefs.GetFloat(var_7_0)
end

function var_0_0.GetDragSaveName(arg_8_0, arg_8_1, arg_8_2)
	return "l2d_drag_" .. tostring(arg_8_0) .. "_" .. tostring(arg_8_1) .. "_" .. tostring(arg_8_2) .. "_target"
end

function var_0_0.ClearLive2dSave(arg_9_0, arg_9_1)
	if not arg_9_0 or not arg_9_1 then
		warning("skinId 或 shipId 不能为空")

		return
	end

	if not pg.ship_skin_template[arg_9_0] then
		warning("找不到skinId" .. tostring(arg_9_0) .. " 清理失败")

		return
	end

	local var_9_0 = pg.ship_skin_template[arg_9_0].ship_l2d_id

	if var_9_0 and #var_9_0 > 0 then
		Live2dConst.SaveL2dIdle(arg_9_0, arg_9_1, 0)
		Live2dConst.SaveL2dAction(arg_9_0, arg_9_1, 0)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if pg.ship_l2d[iter_9_1] then
				local var_9_1 = pg.ship_l2d[iter_9_1].start_value or 0

				Live2dConst.SaveDragData(iter_9_1, arg_9_0, arg_9_1, var_9_1)
			else
				warning(tostring(iter_9_1) .. "不存在，不清理该dragid")
			end
		end
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("live2d_reset_desc"))
end

return var_0_0
