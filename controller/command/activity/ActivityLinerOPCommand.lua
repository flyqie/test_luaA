slot0 = class("ActivityLinerOPCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot2 = slot1:getBody()
	slot3 = slot2.callback

	if not getProxy(ActivityProxy):getActivityById(slot2.activity_id) or slot5:isEnd() then
		return
	end

	slot6 = pg.ConnectionMgr.GetInstance()

	slot6:Send(11202, {
		activity_id = slot2.activity_id,
		cmd = slot2.cmd or 0,
		arg1 = slot2.arg1 or 0,
		arg2 = slot2.arg2 or 0,
		arg_list = {}
	}, 11203, function (slot0)
		if slot0.result == 0 then
			slot1 = {}
			slot1 = PlayerConst.addTranDrop(slot0.award_list)

			if uv0.cmd == 1 then
				switch(uv1:GetCurTime():GetType(), {
					[LinerTime.TYPE.TARGET] = function ()
					end,
					[LinerTime.TYPE.EXPLORE] = function ()
						uv0:AddExploredRoom(uv1.arg1)
					end,
					[LinerTime.TYPE.EVENT] = function ()
						uv0:AddEvent(uv1.arg1, uv1.arg2)
					end,
					[LinerTime.TYPE.STORY] = function ()
					end
				})

				if uv1:CheckTimeFinish() then
					uv1:UpdateTimeIdx()
					uv1:UpdateRoomIdx(true)
				end

				if uv1:CheckRoomFinish() then
					uv1:UpdateRoomIdx(false)
				end
			elseif uv0.cmd == 2 then
				uv1:AddTimeAwardFlag(uv0.arg1)
			elseif uv0.cmd == 3 then
				uv1:AddRoomAwardFlag(uv0.arg1)
			elseif uv0.cmd == 4 then
				uv1:AddEventAwardFlag(uv0.arg1, uv0.arg2)
			end

			uv2:updateActivity(uv1)

			if uv3 then
				uv3()
			end

			uv4:sendNotification(GAME.ACTIVITY_LINER_OP_DONE, {
				awards = slot1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[slot0.result] .. slot0.result)
		end
	end)
end

return slot0