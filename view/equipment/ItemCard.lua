slot0 = class("ItemCard")

slot0.Ctor = function(slot0, slot1)
	slot0.go = slot1
	slot0.bg = findTF(slot1, "bg")
	slot0.countTF = findTF(slot1, "bg/icon_bg/count"):GetComponent(typeof(Text))
	slot0.nameTF = findTF(slot1, "bg/name"):GetComponent(typeof(Text))
	slot0.timeLimitTag = findTF(slot1, "bg/timeline")

	ClearTweenItemAlphaAndWhite(slot0.go)
end

slot0.update = function(slot0, slot1)
	slot0.itemVO = slot1

	if not IsNil(slot0.timeLimitTag) then
		setActive(slot0.timeLimitTag, slot1:getConfig("time_limit") == 1 or Item.InTimeLimitSkinAssigned(slot1.id))
	end

	updateItem(rtf(slot0.bg), slot1)
	TweenItemAlphaAndWhite(slot0.go)

	slot0.countTF.text = slot1.count > 0 and slot1.count or ""
	slot0.nameTF.text = slot0:ShortenString(slot1:getConfig("name"), 6)
end

slot0.ShortenString = function(slot0, slot1, slot2)
	slot3 = 1
	slot4 = 0
	slot5 = 0
	slot6 = #slot1
	slot7 = false

	while slot3 <= slot6 do
		slot9, slot10 = GetPerceptualSize(string.byte(slot1, slot3))
		slot3 = slot3 + slot9

		if math.ceil(slot4 + slot10) == slot2 - 1 then
			slot5 = slot3
		elseif slot2 < slot11 then
			slot7 = true

			break
		end
	end

	if slot5 == 0 or slot6 < slot5 or not slot7 then
		return slot1
	end

	return string.sub(slot1, 1, slot5 - 1) .. ".."
end

slot0.clear = function(slot0)
	ClearTweenItemAlphaAndWhite(slot0.go)
end

slot0.dispose = function(slot0)
end

return slot0
