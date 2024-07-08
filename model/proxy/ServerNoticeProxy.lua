local var_0_0 = class("ServerNoticeProxy", import(".NetProxy"))

var_0_0.SERVER_NOTICES_UPDATE = "server notices update"
var_0_0.KEY_NEWLY_ID = "server_notice.newly_id"
var_0_0.KEY_STOP_REMIND = "server_notice.dont_remind"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:on(11300, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.notice_list) do
			local var_2_0 = false

			for iter_2_2 = 1, #arg_1_0.data do
				if arg_1_0.data[iter_2_2].id == iter_2_1.id then
					arg_1_0.data[iter_2_2] = ServerNotice.New(iter_2_1)
					var_2_0 = true

					break
				end
			end

			if not var_2_0 then
				if #arg_2_0.notice_list == 1 then
					table.insert(arg_1_0.data, 1, ServerNotice.New(iter_2_1))
				else
					table.insert(arg_1_0.data, ServerNotice.New(iter_2_1))
				end
			end
		end

		arg_1_0:sendNotification(var_0_0.SERVER_NOTICES_UPDATE)
	end)
end

function var_0_0.getServerNotices(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.data) do
		if not arg_3_1 or not iter_3_1.isRead then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.needAutoOpen(arg_4_0)
	local var_4_0 = true

	if PlayerPrefs.HasKey(var_0_0.KEY_STOP_REMIND) then
		local var_4_1 = PlayerPrefs.GetInt(var_0_0.KEY_STOP_REMIND)
		local var_4_2 = pg.TimeMgr.GetInstance()

		if not arg_4_0:hasNewNotice() and var_4_2:IsSameDay(var_4_1, var_4_2:GetServerTime()) then
			var_4_0 = false
		end
	elseif arg_4_0.runtimeUniqueCode and arg_4_0.runtimeUniqueCode == arg_4_0:getUniqueCode() then
		var_4_0 = false
	end

	arg_4_0.runtimeUniqueCode = arg_4_0:getUniqueCode()

	return var_4_0
end

function var_0_0.setStopRemind(arg_5_0, arg_5_1)
	if arg_5_1 then
		PlayerPrefs.SetInt(var_0_0.KEY_STOP_REMIND, pg.TimeMgr.GetInstance():GetServerTime())
	else
		PlayerPrefs.DeleteKey(var_0_0.KEY_STOP_REMIND)
	end

	PlayerPrefs.Save()
end

function var_0_0.getStopRemind(arg_6_0)
	return PlayerPrefs.HasKey(var_0_0.KEY_STOP_REMIND)
end

function var_0_0.setStopNewTip(arg_7_0)
	PlayerPrefs.SetInt(var_0_0.KEY_NEWLY_ID, arg_7_0:getUniqueCode())
	PlayerPrefs.Save()
	arg_7_0:sendNotification(var_0_0.SERVER_NOTICES_UPDATE)
end

function var_0_0.hasNewNotice(arg_8_0)
	if PlayerPrefs.HasKey(var_0_0.KEY_NEWLY_ID) and PlayerPrefs.GetInt(var_0_0.KEY_NEWLY_ID) == arg_8_0:getUniqueCode() then
		return false
	end

	return true
end

function var_0_0.getUniqueCode(arg_9_0)
	return _.reduce(arg_9_0.data, 0, function(arg_10_0, arg_10_1)
		return arg_10_0 + arg_10_1:getUniqueCode()
	end)
end

return var_0_0
