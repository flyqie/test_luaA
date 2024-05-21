slot0 = class("LinerTime", import("model.vo.BaseVO"))
slot0.TYPE = {
	TARGET = 1,
	EXPLORE = 2,
	STORY = 4,
	EVENT = 3
}
slot0.EVENT_SUB_TYPE = {
	STORY = 2,
	CLUE = 1
}
slot0.BG_TYPE = {
	DAY = "day",
	DUSK = "dusk",
	AURORA = "aurora",
	NIGTH = "night"
}

slot0.Ctor = function(slot0, slot1)
	slot0.id = slot1
	slot0.configId = slot0.id
end

slot0.bindConfigTable = function(slot0)
	return pg.activity_liner_time
end

slot0.GetTime = function(slot0)
	return slot0:getConfig("time")
end

slot0.GetStartTimeDesc = function(slot0)
	return slot0:GetTime()[1] <= 12 and slot1 .. ":00 AM" or slot1 - 12 .. ":00 PM"
end

slot0.GetEndTimeDesc = function(slot0)
	return slot0:GetTime()[2] <= 12 and slot1 .. ":00 AM" or slot1 - 12 .. ":00 PM"
end

slot0.GetLogDesc = function(slot0)
	slot2 = slot0:GetTime()[2] - 1

	return string.format("%d:00 %s~%d:59 %s", slot1 < 12 and slot1 or slot1 - 12, slot0:GetTime()[1] <= 12 and "AM" or "PM", slot2 < 12 and slot2 or slot2 - 12, slot2 <= 12 and "AM" or "PM")
end

slot0.GetType = function(slot0)
	return slot0:getConfig("type")
end

slot0.GetEventSubType = function(slot0, slot1)
	assert(slot0:GetType() == uv0.TYPE.EVENT, "error type")

	slot2 = underscore.detect(slot0:GetParamInfo(), function (slot0)
		return slot0[1] == uv0
	end)

	assert(slot2, "error roomId")

	return slot2[2]
end

slot0.GetParamInfo = function(slot0)
	return slot0:getConfig("param")
end

slot0.GetTargetRoomIds = function(slot0)
	switch(slot0:GetType(), {
		[uv0.TYPE.TARGET] = function ()
			table.insert(uv0, tonumber(uv1:GetParamInfo()[1]))
		end,
		[uv0.TYPE.EXPLORE] = function ()
		end,
		[uv0.TYPE.EVENT] = function ()
			for slot3, slot4 in ipairs(uv0:GetParamInfo()) do
				table.insert(uv1, slot4[1])
			end
		end,
		[uv0.TYPE.STORY] = function ()
			table.insert(uv0, tonumber(uv1:GetParamInfo()[1]))
		end
	})

	return {}
end

slot0.GetExploreCnt = function(slot0)
	if slot0:GetType() ~= uv0.TYPE.EXPLORE then
		return 0
	end

	return tonumber(slot0:GetParamInfo())
end

slot0.GetEventIds = function(slot0)
	if slot0:GetType() ~= uv0.TYPE.EVENT then
		return {}
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0:GetParamInfo()) do
		slot1 = table.mergeArray(slot1, slot6[4], true)
	end

	return slot1
end

slot0.GetStory = function(slot0, slot1)
	switch(slot0:GetType(), {
		[uv0.TYPE.TARGET] = function ()
			uv0 = uv1:GetParamInfo()[2]
		end,
		[uv0.TYPE.EXPLORE] = function ()
		end,
		[uv0.TYPE.EVENT] = function ()
			slot1 = uv0

			if underscore.detect(slot1:GetParamInfo(), function (slot0)
				return slot0[1] == uv0
			end) and slot0[2] == uv2.EVENT_SUB_TYPE.STORY then
				uv3 = slot0[3]
			end
		end,
		[uv0.TYPE.STORY] = function ()
			uv0 = uv1:GetParamInfo()[2]
		end
	})

	return ""
end

slot0.GetBeforDesc = function(slot0, slot1)
	if type(slot0:getConfig("desc_before")) == "table" then
		return HXSet.hxLan(slot2[slot1][1])
	else
		return HXSet.hxLan(slot2)
	end
end

slot0.GetAfterDesc = function(slot0, slot1)
	if type(slot0:getConfig("desc_after")) == "table" then
		return HXSet.hxLan(slot2[slot1][1])
	else
		return HXSet.hxLan(slot2)
	end
end

slot0.GetBgType = function(slot0)
	return slot0:getConfig("bg_name")
end

slot0.GetBgm = function(slot0, slot1)
	switch(slot1 or slot0:GetBgType(), {
		[uv0.BG_TYPE.DAY] = function ()
			uv0 = "story-niceship-soft"
		end,
		[uv0.BG_TYPE.DUSK] = function ()
			uv0 = "story-richang-5"
		end,
		[uv0.BG_TYPE.NIGTH] = function ()
			uv0 = "story-richang-10"
		end,
		[uv0.BG_TYPE.AURORA] = function ()
			uv0 = "story-richang-quiet"
		end
	})

	return "story-niceship-soft"
end

return slot0
