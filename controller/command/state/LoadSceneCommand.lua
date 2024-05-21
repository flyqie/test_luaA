slot0 = class("LoadSceneCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot2 = slot1:getBody()
	slot2.type = LOAD_TYPE_SCENE

	if not slot2.isReload then
		slot2.prevContext = slot2.prevContext or getProxy(ContextProxy):getCurrentContext()
	end

	SCENE.CheckPreloadData(slot2, function ()
		uv0:sendNotification(GAME.LOAD_CONTEXT, uv1)
	end)
end

return slot0
