ys = ys or {}
slot0 = ys
slot0.Battle.BattleStrayBulletUnit = class("BattleStrayBulletUnit", slot0.Battle.BattleBulletUnit)
slot0.Battle.BattleStrayBulletUnit.__name = "BattleStrayBulletUnit"
slot1 = slot0.Battle.BattleStrayBulletUnit

slot1.Ctor = function(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)
end

slot1.SetExplodePosition = function(slot0, slot1)
	slot0._explodePos = slot1
end

slot1.GetExplodePostion = function(slot0)
	return slot0._explodePos
end
