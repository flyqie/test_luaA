ys.Battle.BattleFormulas = ys.Battle.BattleFormulas or {}

local var_0_0 = ys.Battle.BattleFormulas
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = pg.gameset
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleConfig.AnitAirRepeaterConfig
local var_0_6 = pg.bfConsts
local var_0_7 = var_0_6.SECONDs / var_0_4.viewFPS * var_0_4.BulletSpeedConvertConst
local var_0_8 = var_0_6.SECONDs / var_0_4.calcFPS * var_0_4.ShipSpeedConvertConst
local var_0_9 = var_0_6.SECONDs / var_0_4.viewFPS * var_0_4.AircraftSpeedConvertConst
local var_0_10 = var_0_4.AIR_ASSIST_RELOAD_RATIO * var_0_6.PERCENT
local var_0_11 = var_0_4.DAMAGE_ENHANCE_FROM_SHIP_TYPE
local var_0_12 = var_0_4.AMMO_DAMAGE_ENHANCE
local var_0_13 = var_0_4.AMMO_DAMAGE_REDUCE
local var_0_14 = var_0_4.SHIP_TYPE_ACCURACY_ENHANCE

function var_0_0.GetFleetTotalHP(arg_1_0)
	local var_1_0 = arg_1_0:GetFlagShip()
	local var_1_1 = arg_1_0:GetUnitList()
	local var_1_2 = var_0_6.NUM0

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if iter_1_1 == var_1_0 then
			var_1_2 = var_1_2 + var_0_3.GetCurrent(iter_1_1, "maxHP") * var_0_6.HP_CONST
		else
			var_1_2 = var_1_2 + var_0_3.GetCurrent(iter_1_1, "maxHP")
		end
	end

	return var_1_2
end

function var_0_0.GetFleetVelocity(arg_2_0)
	local var_2_0 = arg_2_0[1]

	if var_2_0 then
		local var_2_1 = var_0_3.GetCurrent(var_2_0, "fleetVelocity")

		if var_2_1 > var_0_6.NUM0 then
			return var_2_1 * var_0_6.PERCENT
		end
	end

	local var_2_2 = var_0_6.NUM0
	local var_2_3 = #arg_2_0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		var_2_2 = var_2_2 + iter_2_1:GetAttrByName("velocity")
	end

	local var_2_4 = var_0_6.NUM1 - var_0_6.SPEED_CONST * (var_2_3 - var_0_6.NUM1)

	return var_2_2 / var_2_3 * var_2_4
end

function var_0_0.GetFleetReload(arg_3_0)
	local var_3_0 = var_0_6.NUM0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0 = var_3_0 + iter_3_1:GetReload()
	end

	return var_3_0
end

function var_0_0.GetFleetTorpedoPower(arg_4_0)
	local var_4_0 = var_0_6.NUM0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_4_0 = var_4_0 + iter_4_1:GetTorpedoPower()
	end

	return var_4_0
end

function var_0_0.AttrFixer(arg_5_0, arg_5_1)
	if arg_5_0 == SYSTEM_DUEL then
		local var_5_0 = arg_5_1.level
		local var_5_1 = arg_5_1.durability
		local var_5_2, var_5_3 = ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_5_0, var_5_0)

		arg_5_1.durability = var_5_1 * var_5_2 + var_5_3
	end
end

function var_0_0.HealFixer(arg_6_0, arg_6_1)
	local var_6_0 = 1

	if arg_6_0 == SYSTEM_DUEL then
		local var_6_1 = arg_6_1.level

		var_6_0 = ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0.ConvertShipSpeed(arg_7_0)
	return arg_7_0 * var_0_8
end

function var_0_0.ConvertAircraftSpeed(arg_8_0)
	if arg_8_0 then
		return arg_8_0 * var_0_9
	else
		return nil
	end
end

function var_0_0.ConvertBulletSpeed(arg_9_0)
	return arg_9_0 * var_0_7
end

function var_0_0.ConvertBulletDataSpeed(arg_10_0)
	return arg_10_0 / var_0_7
end

function var_0_0.CreateContextCalculateDamage(arg_11_0)
	return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = var_0_6.NUM1
		local var_12_1 = var_0_6.NUM0
		local var_12_2 = var_0_6.NUM10000
		local var_12_3 = var_0_6.DRATE
		local var_12_4 = var_0_6.ACCURACY
		local var_12_5 = arg_12_0:GetWeaponHostAttr()
		local var_12_6 = arg_12_0:GetWeapon()
		local var_12_7 = arg_12_0:GetWeaponTempData()
		local var_12_8 = var_12_7.type
		local var_12_9 = var_12_7.attack_attribute
		local var_12_10 = var_12_6:GetConvertedAtkAttr()
		local var_12_11 = arg_12_0:GetTemplate()
		local var_12_12 = var_12_11.damage_type
		local var_12_13 = var_12_11.random_damage_rate
		local var_12_14 = arg_12_1._attr
		local var_12_15 = arg_12_3 or var_12_0

		arg_12_2 = arg_12_2 or var_12_1

		local var_12_16 = var_12_14.armorType
		local var_12_17 = var_12_5.formulaLevel - var_12_14.formulaLevel
		local var_12_18 = var_12_0
		local var_12_19 = false
		local var_12_20 = false
		local var_12_21 = var_12_0
		local var_12_22 = arg_12_0:GetCorrectedDMG()
		local var_12_23 = (var_12_0 + arg_12_0:GetWeaponAtkAttr() * var_12_10) * var_12_22

		if var_12_9 == var_0_1.WeaponDamageAttr.CANNON then
			var_12_15 = var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByCannon") + var_0_3.GetCurrent(arg_12_0, "damageRatioByCannon")
		elseif var_12_9 == var_0_1.WeaponDamageAttr.TORPEDO then
			var_12_15 = var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByBulletTorpedo") + var_0_3.GetCurrent(arg_12_0, "damageRatioByBulletTorpedo")
		elseif var_12_9 == var_0_1.WeaponDamageAttr.AIR then
			local var_12_24 = var_0_3.GetCurrent(arg_12_0, "airResistPierceActive") == 1 and var_0_3.GetCurrent(arg_12_0, "airResistPierce") or 0

			var_12_15 = var_12_15 * math.min(var_12_3[7] / (var_12_14.antiAirPower + var_12_3[7]) + var_12_24, 1) * (var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByAir") + var_0_3.GetCurrent(arg_12_0, "damageRatioByAir"))
		elseif var_12_9 == var_0_1.WeaponDamageAttr.ANTI_AIR then
			-- block empty
		elseif var_12_9 == var_0_1.WeaponDamageAttr.ANIT_SUB then
			-- block empty
		end

		local var_12_25 = var_12_5.luck - var_12_14.luck
		local var_12_26 = var_0_3.GetCurrent(arg_12_1, "perfectDodge")
		local var_12_27 = math.max(var_12_5.attackRating, 0)
		local var_12_28

		if var_12_26 == 1 then
			var_12_28 = true
		else
			local var_12_29 = var_12_4[1] + var_12_27 / (var_12_27 + var_12_14.dodgeRate + var_12_4[2]) + (var_12_25 + var_12_17) * var_0_6.PERCENT1
			local var_12_30 = var_0_3.GetCurrent(arg_12_1, "accuracyRateExtra")
			local var_12_31 = var_0_3.GetCurrent(arg_12_0, var_0_14[arg_12_1:GetTemplate().type])
			local var_12_32 = var_0_3.GetCurrent(arg_12_1, "dodgeRateExtra")
			local var_12_33 = math.max(var_12_3[5], math.min(var_12_0, var_12_29 + var_12_30 + var_12_31 - var_12_32))

			var_12_28 = not var_0_0.IsHappen(var_12_33 * var_12_2)
		end

		if not var_12_28 then
			local var_12_34
			local var_12_35 = var_0_3.GetCurrent(arg_12_0, "GCT") == 1 and 1 or var_0_6.DFT_CRIT_RATE + var_12_27 / (var_12_27 + var_12_14.dodgeRate + var_12_3[4]) + (var_12_25 + var_12_17) * var_12_3[3] + var_0_3.GetCurrent(arg_12_0, "cri") + var_0_3.GetTagAttrCri(arg_12_0, arg_12_1)

			var_12_21 = math.random(var_0_4.RANDOM_DAMAGE_MIN, var_0_4.RANDOM_DAMAGE_MAX) + var_12_23

			if var_0_0.IsHappen(var_12_35 * var_12_2) then
				var_12_20 = true

				local var_12_36 = var_0_6.DFT_CRIT_EFFECT + var_0_3.GetTagAttrCriDmg(arg_12_0, arg_12_1) + var_0_3.GetCurrent(arg_12_0, "criDamage") - var_0_3.GetCurrent(arg_12_1, "criDamageResist")

				var_12_18 = math.max(1, var_12_36)
			else
				var_12_20 = false
			end
		else
			var_12_21 = var_12_1

			local var_12_37 = {
				isMiss = true,
				isDamagePrevent = false,
				isCri = var_12_20
			}

			return var_12_21, var_12_37
		end

		local var_12_38 = var_0_6.NUM1
		local var_12_39 = var_0_3.GetCurrent(arg_12_0, "damageRatioBullet")
		local var_12_40 = var_0_3.GetTagAttr(arg_12_0, arg_12_1, arg_11_0)
		local var_12_41 = var_0_3.GetCurrent(arg_12_1, "injureRatio")
		local var_12_42 = (var_12_6:GetFixAmmo() or var_12_12[var_12_16] or var_12_38) + var_0_3.GetCurrent(arg_12_0, var_0_4.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE[var_12_16])
		local var_12_43 = var_0_3.GetCurrent(arg_12_0, var_0_4.DAMAGE_TO_ARMOR_RATE_ENHANCE[var_12_16])
		local var_12_44 = var_0_3.GetCurrent(arg_12_0, var_0_12[var_12_11.ammo_type])
		local var_12_45 = var_0_3.GetCurrent(arg_12_1, var_0_13[var_12_11.ammo_type])
		local var_12_46 = var_0_3.GetCurrent(arg_12_0, "comboTag")
		local var_12_47 = var_0_3.GetCurrent(arg_12_1, var_12_46)
		local var_12_48 = math.max(var_12_38, math.floor(var_12_21 * var_12_15 * (var_12_38 - arg_12_2) * var_12_42 * (var_12_38 + var_12_43) * var_12_18 * (var_12_38 + var_12_39) * var_12_40 * (var_12_38 + var_12_41) * (var_12_38 + var_12_44 - var_12_45) * (var_12_38 + var_12_47) * (var_12_38 + math.min(var_12_3[1], math.max(-var_12_3[1], var_12_17)) * var_12_3[2])))

		if arg_12_1:GetCurrentOxyState() == var_0_1.OXY_STATE.DIVE then
			var_12_48 = math.floor(var_12_48 * var_12_11.antisub_enhancement)
		end

		local var_12_49 = {
			isMiss = var_12_28,
			isCri = var_12_20,
			damageAttr = var_12_9
		}
		local var_12_50 = arg_12_0:GetDamageEnhance()

		if var_12_50 ~= 1 then
			var_12_48 = math.floor(var_12_48 * var_12_50)
		end

		local var_12_51 = var_12_48 * var_12_14.repressReduce

		if var_12_13 ~= 0 then
			var_12_51 = var_12_51 * (Mathf.RandomFloat(var_12_13) + 1)
		end

		local var_12_52 = var_0_3.GetCurrent(arg_12_0, "damageEnhanceProjectile")
		local var_12_53 = math.max(0, var_12_51 + var_12_52)

		if arg_11_0 then
			var_12_53 = var_12_53 * (var_0_6.NUM1 + var_0_3.GetCurrent(arg_12_0, "worldBuffResistance"))
		end

		local var_12_54 = math.floor(var_12_53)
		local var_12_55 = var_12_11.DMG_font[var_12_16]

		if var_12_52 < 0 then
			var_12_55 = var_0_4.BULLET_DECREASE_DMG_FONT
		end

		return var_12_54, var_12_49, var_12_55
	end
end

function var_0_0.CalculateIgniteDamage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._attr

	return arg_13_0:GetWeapon():GetCorrectedDMG() * (1 + var_13_0[arg_13_1] * var_0_6.PERCENT) * arg_13_2
end

function var_0_0.WeaponDamagePreCorrection(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetTemplateData()
	local var_14_1 = arg_14_1 or var_14_0.damage
	local var_14_2 = var_14_0.corrected

	return var_14_1 * arg_14_0:GetPotential() * var_14_2 * var_0_6.PERCENT
end

function var_0_0.WeaponAtkAttrPreRatio(arg_15_0)
	return arg_15_0:GetTemplateData().attack_attribute_ratio * var_0_6.PERCENT2
end

function var_0_0.GetMeteoDamageRatio(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = var_0_6.METEO_RATE
	local var_16_2 = var_16_1[1]

	if arg_16_0 >= var_16_1[2] then
		for iter_16_0 = 1, arg_16_0 + 1 do
			var_16_0[iter_16_0] = var_16_2
		end

		return var_16_0
	else
		local var_16_3 = 1 - var_16_2 * arg_16_0

		for iter_16_1 = 1, arg_16_0 do
			local var_16_4 = math.random() * var_16_3 * (var_16_1[3] + var_16_1[4] * (iter_16_1 - 1) / arg_16_0)

			var_16_0[iter_16_1] = var_16_4 + var_16_2
			var_16_3 = math.max(0, var_16_3 - var_16_4)
		end

		var_16_0[arg_16_0 + 1] = var_16_3

		return var_16_0
	end
end

function var_0_0.CalculateFleetAntiAirTotalDamage(arg_17_0)
	local var_17_0 = arg_17_0:GetCrewUnitList()
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_2 = var_0_3.GetCurrent(iter_17_0, "antiAirPower")

		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			local var_17_3 = iter_17_3:GetConvertedAtkAttr()
			local var_17_4 = iter_17_3:GetCorrectedDMG()

			var_17_1 = var_17_1 + math.max(1, (var_17_2 * var_17_3 + 1) * var_17_4)
		end
	end

	return var_17_1
end

function var_0_0.CalculateRepaterAnitiAirTotalDamage(arg_18_0)
	local var_18_0 = arg_18_0:GetHost()
	local var_18_1 = arg_18_0:GetConvertedAtkAttr()
	local var_18_2 = arg_18_0:GetCorrectedDMG()
	local var_18_3 = var_0_3.GetCurrent(var_18_0, "antiAirPower")

	return (math.max(1, (var_18_3 * var_18_1 + 1) * var_18_2))
end

function var_0_0.RollRepeaterHitDice(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetHost()
	local var_19_1 = var_0_3.GetCurrent(var_19_0, "antiAirPower")
	local var_19_2 = math.max(var_0_3.GetCurrent(var_19_0, "attackRating"), 0)
	local var_19_3 = var_0_3.GetCurrent(arg_19_1, "airPower")
	local var_19_4 = var_0_3.GetCurrent(arg_19_1, "dodgeLimit")
	local var_19_5 = var_0_3.GetCurrent(arg_19_1, "dodge")
	local var_19_6 = var_19_3 / var_0_5.const_A + var_0_5.const_B
	local var_19_7 = var_19_6 / (var_19_1 * var_19_5 + var_19_6 + var_0_5.const_C)
	local var_19_8 = math.min(var_19_4, var_19_7)

	return var_0_0.IsHappen(var_19_8 * var_0_6.NUM10000)
end

function var_0_0.AntiAirPowerWeight(arg_20_0)
	return arg_20_0 * arg_20_0
end

function var_0_0.CalculateDamageFromAircraftToMainShip(arg_21_0, arg_21_1)
	local var_21_0 = var_0_3.GetCurrent(arg_21_0, "airPower")
	local var_21_1 = var_0_3.GetCurrent(arg_21_1, "antiAirPower")
	local var_21_2 = var_0_3.GetCurrent(arg_21_0, "crashDMG")
	local var_21_3 = arg_21_0:GetHPRate()
	local var_21_4 = var_0_3.GetCurrent(arg_21_0, "formulaLevel")
	local var_21_5 = var_0_3.GetCurrent(arg_21_1, "formulaLevel")
	local var_21_6 = var_0_3.GetCurrent(arg_21_1, "injureRatio")
	local var_21_7 = var_0_3.GetCurrent(arg_21_1, "injureRatioByAir")
	local var_21_8 = var_0_6.PLANE_LEAK_RATE
	local var_21_9 = math.max(var_21_8[1], math.floor((var_21_2 * (var_21_8[2] + var_21_0 * var_21_8[3]) + var_21_4 * var_21_8[4]) * (var_21_3 * var_21_8[5] + var_21_8[6]) * (var_21_8[7] + (var_21_4 - var_21_5) * var_21_8[8]) * (var_21_8[9] / (var_21_1 + var_21_8[10])) * (var_21_8[11] + var_21_6) * (var_21_8[12] + var_21_7)))

	return (math.floor(var_21_9 * var_0_3.GetCurrent(arg_21_1, "repressReduce")))
end

function var_0_0.CalculateDamageFromShipToMainShip(arg_22_0, arg_22_1)
	local var_22_0 = var_0_3.GetCurrent(arg_22_0, "cannonPower")
	local var_22_1 = var_0_3.GetCurrent(arg_22_0, "torpedoPower")
	local var_22_2 = arg_22_0:GetHPRate()
	local var_22_3 = var_0_3.GetCurrent(arg_22_0, "formulaLevel")
	local var_22_4 = var_0_3.GetCurrent(arg_22_1, "formulaLevel")
	local var_22_5 = var_0_3.GetCurrent(arg_22_1, "injureRatio")
	local var_22_6 = var_0_6.LEAK_RATE
	local var_22_7 = math.max(var_22_6[1], math.floor(((var_22_0 + var_22_1) * var_22_6[2] + var_22_3 * var_22_6[7]) * (var_22_6[5] + var_22_5) * (var_22_2 * var_22_6[3] + var_22_6[4]) * (var_22_6[5] + (var_22_3 - var_22_4) * var_22_6[6])))

	return (math.floor(var_22_7 * var_0_3.GetCurrent(arg_22_1, "repressReduce")))
end

function var_0_0.CalculateDamageFromSubmarinToMainShip(arg_23_0, arg_23_1)
	local var_23_0 = var_0_3.GetCurrent(arg_23_0, "torpedoPower")
	local var_23_1 = arg_23_0:GetHPRate()
	local var_23_2 = var_0_3.GetCurrent(arg_23_0, "formulaLevel")
	local var_23_3 = var_0_3.GetCurrent(arg_23_1, "formulaLevel")
	local var_23_4 = var_0_3.GetCurrent(arg_23_1, "injureRatio")
	local var_23_5 = var_0_6.SUBMARINE_KAMIKAZE

	return (math.max(var_23_5[1], math.floor((var_23_0 * var_23_5[2] + var_23_2 * var_23_5[3]) * (var_23_5[4] + var_23_4) * (var_23_1 * var_23_5[5] + var_23_5[6]) * (var_23_5[7] + (var_23_2 - var_23_3) * var_23_5[8]))))
end

function var_0_0.RollSubmarineDualDice(arg_24_0)
	local var_24_0 = var_0_3.GetCurrent(arg_24_0, "dodgeRate")
	local var_24_1 = var_24_0 / (var_24_0 + var_0_4.MONSTER_SUB_KAMIKAZE_DUAL_K) * var_0_4.MONSTER_SUB_KAMIKAZE_DUAL_P

	return var_0_0.IsHappen(var_24_1 * var_0_6.NUM10000)
end

function var_0_0.CalculateCrashDamage(arg_25_0, arg_25_1)
	local var_25_0 = var_0_3.GetCurrent(arg_25_0, "maxHP")
	local var_25_1 = var_0_3.GetCurrent(arg_25_1, "maxHP")
	local var_25_2 = var_25_0 * var_0_6.CRASH_RATE[1]
	local var_25_3 = var_25_1 * var_0_6.CRASH_RATE[1]
	local var_25_4 = var_0_3.GetCurrent(arg_25_0, "hammerDamageRatio")
	local var_25_5 = var_0_3.GetCurrent(arg_25_1, "hammerDamageRatio")
	local var_25_6 = var_0_3.GetCurrent(arg_25_0, "hammerDamagePrevent")
	local var_25_7 = var_0_3.GetCurrent(arg_25_1, "hammerDamagePrevent")
	local var_25_8 = math.min(var_25_6, var_0_4.HammerCFG.PreventUpperBound)
	local var_25_9 = math.min(var_25_7, var_0_4.HammerCFG.PreventUpperBound)
	local var_25_10 = math.sqrt(var_25_0 * var_25_1) * var_0_6.CRASH_RATE[2]
	local var_25_11 = math.min(var_25_2, var_25_10)
	local var_25_12 = math.min(var_25_3, var_25_10)
	local var_25_13 = math.floor(var_25_11 * (1 + var_25_5) * (1 - var_25_8))
	local var_25_14 = math.floor(var_25_13 * var_0_3.GetCurrent(arg_25_0, "repressReduce"))
	local var_25_15 = math.floor(var_25_12 * (1 + var_25_4) * (1 - var_25_9))
	local var_25_16 = math.floor(var_25_15 * var_0_3.GetCurrent(arg_25_1, "repressReduce"))

	return var_25_14, var_25_16
end

function var_0_0.CalculateFleetDamage(arg_26_0)
	return arg_26_0 * var_0_6.SCORE_RATE[1]
end

function var_0_0.CalculateFleetOverDamage(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0:GetFlagShip() then
		return var_0_3.GetCurrent(arg_27_1, "maxHP") * var_0_6.SCORE_RATE[2]
	else
		return var_0_3.GetCurrent(arg_27_1, "maxHP") * var_0_6.SCORE_RATE[3]
	end
end

function var_0_0.CalculateReloadTime(arg_28_0, arg_28_1)
	return arg_28_0 / var_0_4.K1 / math.sqrt((arg_28_1 + var_0_4.K2) * var_0_4.K3)
end

function var_0_0.CaclulateReloaded(arg_29_0, arg_29_1)
	return math.sqrt((arg_29_1 + var_0_4.K2) * var_0_4.K3) * arg_29_0 * var_0_4.K1
end

function var_0_0.CaclulateReloadAttr(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0 / var_0_4.K1 / arg_30_1

	return math.max(var_30_0 * var_30_0 / var_0_4.K3 - var_0_4.K2, 0)
end

function var_0_0.CaclulateAirAssistReloadMax(arg_31_0)
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		var_31_0 = var_31_0 + iter_31_1:GetTemplateData().reload_max
	end

	return var_31_0 / #arg_31_0 * var_0_10
end

function var_0_0.CaclulateDOTPlace(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_1.arg_list
	local var_32_1 = var_0_4.DOT_CONFIG[var_32_0.dotType]
	local var_32_2 = arg_32_2 and arg_32_2:GetAttrByName(var_32_1.hit) or var_0_6.NUM0
	local var_32_3 = arg_32_3 and arg_32_3:GetAttrByName(var_32_1.resist) or var_0_6.NUM0

	return var_0_0.IsHappen(arg_32_0 * (var_0_6.NUM1 + var_32_2) * (var_0_6.NUM1 - var_32_3))
end

function var_0_0.CaclulateDOTDuration(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.arg_list
	local var_33_1 = var_0_4.DOT_CONFIG[var_33_0.dotType]

	return (arg_33_1 and arg_33_1:GetAttrByName(var_33_1.prolong) or var_0_6.NUM0) - (arg_33_2 and arg_33_2:GetAttrByName(var_33_1.shorten) or var_0_6.NUM0)
end

function var_0_0.CaclulateDOTDamageEnhanceRate(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.arg_list
	local var_34_1 = var_0_4.DOT_CONFIG[var_34_0.dotType]

	return ((arg_34_1 and arg_34_1:GetAttrByName(var_34_1.enhance) or var_0_6.NUM0) - (arg_34_2 and arg_34_2:GetAttrByName(var_34_1.reduce) or var_0_6.NUM0)) * var_0_6.PERCENT2
end

function var_0_0.CalculateMaxAimBiasRange(arg_35_0)
	local var_35_0 = var_0_4.AIM_BIAS_FLEET_RANGE_MOD
	local var_35_1

	if #arg_35_0 == 1 then
		local var_35_2 = arg_35_0[1]

		var_35_1 = var_0_3.GetCurrent(arg_35_0[1], "dodgeRate") * var_35_0
	else
		local var_35_3 = {}

		for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
			table.insert(var_35_3, var_0_3.GetCurrent(iter_35_1, "dodgeRate"))
		end

		table.sort(var_35_3, function(arg_36_0, arg_36_1)
			return arg_36_1 < arg_36_0
		end)

		var_35_1 = (var_35_3[1] + var_35_3[2] * 0.6 + (var_35_3[3] or 0) * 0.3) / #var_35_3 * var_35_0
	end

	return (math.min(var_35_1, var_0_4.AIM_BIAS_MAX_RANGE_SCOUT))
end

function var_0_0.CalculateMaxAimBiasRangeSub(arg_37_0)
	local var_37_0 = var_0_3.GetCurrent(arg_37_0[1], "dodgeRate") * var_0_4.AIM_BIAS_SUB_RANGE_MOD

	return (math.min(var_37_0, var_0_4.AIM_BIAS_MAX_RANGE_SUB))
end

function var_0_0.CalculateMaxAimBiasRangeMonster(arg_38_0)
	local var_38_0 = var_0_3.GetCurrent(arg_38_0[1], "dodgeRate") * var_0_4.AIM_BIAS_MONSTER_RANGE_MOD

	return (math.min(var_38_0, var_0_4.AIM_BIAS_MAX_RANGE_MONSTER))
end

function var_0_0.CalculateBiasDecay(arg_39_0)
	local var_39_0 = arg_39_0 * var_0_4.AIM_BIAS_DECAY_MOD_MONSTER

	return (math.min(var_39_0, var_0_4.AIM_BIAS_DECAY_SPEED_MAX_SCOUT))
end

function var_0_0.CalculateBiasDecayMonster(arg_40_0)
	local var_40_0 = arg_40_0 * var_0_4.AIM_BIAS_DECAY_MOD

	return (math.min(var_40_0, var_0_4.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function var_0_0.CalculateBiasDecayMonsterInSmoke(arg_41_0)
	local var_41_0 = arg_41_0 * var_0_4.AIM_BIAS_DECAY_MOD * var_0_4.AIM_BIAS_DECAY_SMOKE

	return (math.min(var_41_0, var_0_4.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function var_0_0.CalculateBiasDecayDiving(arg_42_0)
	local var_42_0 = math.max(0, arg_42_0 - var_0_4.AIM_BIAS_DECAY_SUB_CONST) * var_0_4.AIM_BIAS_DECAY_MOD

	return (math.min(var_42_0, var_0_4.AIM_BIAS_DECAY_SPEED_MAX_SUB))
end

function var_0_0.WorldEnemyAttrEnhance(arg_43_0, arg_43_1)
	return 1 + arg_43_0 / (1 + var_0_4.WORLD_ENEMY_ENHANCEMENT_CONST_C^(var_0_4.WORLD_ENEMY_ENHANCEMENT_CONST_B - arg_43_1))
end

local var_0_15 = setmetatable({}, {
	__index = function(arg_44_0, arg_44_1)
		return 0
	end
})

function var_0_0.WorldMapRewardAttrEnhance(arg_45_0, arg_45_1)
	arg_45_0 = arg_45_0 or var_0_15
	arg_45_1 = arg_45_1 or var_0_15

	local var_45_0
	local var_45_1
	local var_45_2
	local var_45_3 = {
		{
			var_0_2.attr_world_value_X1.key_value / 10000,
			var_0_2.attr_world_value_X2.key_value / 10000
		},
		{
			var_0_2.attr_world_value_Y1.key_value / 10000,
			var_0_2.attr_world_value_Y2.key_value / 10000
		},
		{
			var_0_2.attr_world_value_Z1.key_value / 10000,
			var_0_2.attr_world_value_Z2.key_value / 10000
		}
	}
	local var_45_4 = var_0_2.attr_world_damage_fix.key_value / 10000
	local var_45_5

	if arg_45_0[1] == 0 then
		var_45_5 = var_45_3[1][2]
	else
		var_45_5 = arg_45_1[1] / arg_45_0[1]
	end

	local var_45_6 = 1 - math.clamp(var_45_5, var_45_3[1][1], var_45_3[1][2])

	if arg_45_0[2] == 0 then
		var_45_5 = var_45_3[2][2]
	else
		var_45_5 = arg_45_1[2] / arg_45_0[2]
	end

	local var_45_7 = 1 - math.clamp(var_45_5, var_45_3[2][1], var_45_3[2][2])

	if arg_45_0[3] == 0 then
		var_45_5 = var_45_3[3][2]
	else
		var_45_5 = arg_45_1[3] / arg_45_0[3]
	end

	local var_45_8 = math.max(1 - math.clamp(var_45_5, var_45_3[3][1], var_45_3[3][2]), -var_45_4)

	return var_45_6, var_45_7, var_45_8
end

function var_0_0.WorldMapRewardHealingRate(arg_46_0, arg_46_1)
	local var_46_0 = {
		var_0_2.attr_world_value_H1.key_value / 10000,
		var_0_2.attr_world_value_H2.key_value / 10000
	}

	arg_46_0 = arg_46_0 or var_0_15
	arg_46_1 = arg_46_1 or var_0_15

	local var_46_1

	if arg_46_0[3] == 0 then
		var_46_1 = var_46_0[2]
	else
		var_46_1 = arg_46_1[3] / arg_46_0[3]
	end

	return math.clamp(var_46_1, var_46_0[1], var_46_0[2])
end

function var_0_0.CalcDamageLock()
	return 0, {
		false,
		true,
		false
	}
end

function var_0_0.CalcDamageLockA2M()
	return 0
end

function var_0_0.CalcDamageLockS2M()
	return 0
end

function var_0_0.CalcDamageLockCrush()
	return 0, 0
end

function var_0_0.UnilateralCrush()
	return 0, 100000
end

function var_0_0.FriendInvincibleDamage(arg_52_0, arg_52_1, ...)
	local var_52_0 = arg_52_1:GetIFF()

	if var_52_0 == ys.Battle.BattleConfig.FRIENDLY_CODE then
		return 1, {
			isMiss = false,
			isCri = false,
			isDamagePrevent = false
		}
	elseif var_52_0 == ys.Battle.BattleConfig.FOE_CODE then
		return var_0_0.CalculateDamage(arg_52_0, arg_52_1, ...)
	end
end

function var_0_0.FriendInvincibleCrashDamage(arg_53_0, arg_53_1)
	local var_53_0, var_53_1 = var_0_0.CalculateCrashDamage(arg_53_0, arg_53_1)
	local var_53_2 = 1

	var_53_1 = arg_53_1:GetIFF() == ys.Battle.BattleConfig.FRIENDLY_CODE and 1 or var_53_1

	return var_53_2, var_53_1
end

function var_0_0.ChapterRepressReduce(arg_54_0)
	return 1 - arg_54_0 * 0.01
end

function var_0_0.IsHappen(arg_55_0)
	if arg_55_0 <= 0 then
		return false
	elseif arg_55_0 >= 10000 then
		return true
	else
		return arg_55_0 >= math.random(10000)
	end
end

function var_0_0.WeightRandom(arg_56_0)
	local var_56_0, var_56_1 = var_0_0.GenerateWeightList(arg_56_0)

	return (var_0_0.WeightListRandom(var_56_0, var_56_1))
end

function var_0_0.WeightListRandom(arg_57_0, arg_57_1)
	local var_57_0 = math.random(0, arg_57_1)

	for iter_57_0, iter_57_1 in pairs(arg_57_0) do
		local var_57_1 = iter_57_0.min
		local var_57_2 = iter_57_0.max

		if var_57_1 <= var_57_0 and var_57_0 <= var_57_2 then
			return iter_57_1
		end
	end
end

function var_0_0.GenerateWeightList(arg_58_0)
	local var_58_0 = {}
	local var_58_1 = -1

	for iter_58_0, iter_58_1 in ipairs(arg_58_0) do
		local var_58_2 = iter_58_1.weight
		local var_58_3 = iter_58_1.rst
		local var_58_4 = var_58_1 + 1
		local var_58_5

		var_58_1 = var_58_1 + var_58_2

		local var_58_6 = var_58_1

		var_58_0[{
			min = var_58_4,
			max = var_58_6
		}] = var_58_3
	end

	return var_58_0, var_58_1
end

function var_0_0.IsListHappen(arg_59_0)
	for iter_59_0, iter_59_1 in ipairs(arg_59_0) do
		if var_0_0.IsHappen(iter_59_1[1]) then
			return true, iter_59_1[2]
		end
	end

	return false, nil
end

function var_0_0.BulletYAngle(arg_60_0, arg_60_1)
	return math.rad2Deg * math.atan2(arg_60_1.z - arg_60_0.z, arg_60_1.x - arg_60_0.x)
end

function var_0_0.RandomPosNull(arg_61_0, arg_61_1)
	arg_61_1 = arg_61_1 or 10

	local var_61_0 = arg_61_0.distance or 10
	local var_61_1 = var_61_0 * var_61_0
	local var_61_2 = ys.Battle.BattleTargetChoise.TargetAll()
	local var_61_3
	local var_61_4

	for iter_61_0 = 1, arg_61_1 do
		local var_61_5 = true
		local var_61_6 = var_0_0.RandomPos(arg_61_0)

		for iter_61_1, iter_61_2 in pairs(var_61_2) do
			local var_61_7 = iter_61_2:GetPosition()

			if var_61_1 > Vector3.SqrDistance(var_61_6, var_61_7) then
				var_61_5 = false

				break
			end
		end

		if var_61_5 then
			return var_61_6
		end
	end

	return nil
end

function var_0_0.RandomPos(arg_62_0)
	local var_62_0 = arg_62_0[1] or 0
	local var_62_1 = arg_62_0[2] or 0
	local var_62_2 = arg_62_0[3] or 0

	if arg_62_0.rangeX or arg_62_0.rangeY or arg_62_0.rangeZ then
		local var_62_3 = var_0_0.RandomDelta(arg_62_0.rangeX)
		local var_62_4 = var_0_0.RandomDelta(arg_62_0.rangeY)
		local var_62_5 = var_0_0.RandomDelta(arg_62_0.rangeZ)

		return Vector3(var_62_0 + var_62_3, var_62_1 + var_62_4, var_62_2 + var_62_5)
	else
		local var_62_6 = var_0_0.RandomPosXYZ(arg_62_0, "X1", "X2")
		local var_62_7 = var_0_0.RandomPosXYZ(arg_62_0, "Y1", "Y2")
		local var_62_8 = var_0_0.RandomPosXYZ(arg_62_0, "Z1", "Z2")

		return Vector3(var_62_0 + var_62_6, var_62_1 + var_62_7, var_62_2 + var_62_8)
	end
end

function var_0_0.RandomPosXYZ(arg_63_0, arg_63_1, arg_63_2)
	arg_63_1 = arg_63_0[arg_63_1]
	arg_63_2 = arg_63_0[arg_63_2]

	if arg_63_1 and arg_63_2 then
		return math.random(arg_63_1, arg_63_2)
	else
		return 0
	end
end

function var_0_0.RandomPosCenterRange(arg_64_0)
	local var_64_0 = var_0_0.RandomDelta(arg_64_0.rangeX)
	local var_64_1 = var_0_0.RandomDelta(arg_64_0.rangeY)
	local var_64_2 = var_0_0.RandomDelta(arg_64_0.rangeZ)

	return Vector3(var_64_0, var_64_1, var_64_2)
end

function var_0_0.RandomDelta(arg_65_0)
	if arg_65_0 and arg_65_0 > 0 then
		return math.random(arg_65_0 + arg_65_0) - arg_65_0
	else
		return 0
	end
end

function var_0_0.simpleCompare(arg_66_0, arg_66_1)
	local var_66_0, var_66_1 = string.find(arg_66_0, "%p+")
	local var_66_2 = string.sub(arg_66_0, var_66_0, var_66_1)
	local var_66_3 = string.sub(arg_66_0, var_66_1 + 1, #arg_66_0)
	local var_66_4 = getCompareFuncByPunctuation(var_66_2)
	local var_66_5 = tonumber(var_66_3)

	return var_66_4(arg_66_1, var_66_5)
end

function var_0_0.parseCompareUnitAttr(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0, var_67_1 = string.find(arg_67_0, "%p+")
	local var_67_2 = string.sub(arg_67_0, var_67_0, var_67_1)
	local var_67_3 = string.sub(arg_67_0, 1, var_67_0 - 1)
	local var_67_4 = string.sub(arg_67_0, var_67_1 + 1, #arg_67_0)
	local var_67_5 = getCompareFuncByPunctuation(var_67_2)
	local var_67_6 = tonumber(var_67_3) or arg_67_1:GetAttrByName(var_67_3)
	local var_67_7 = tonumber(var_67_4) or arg_67_2:GetAttrByName(var_67_4)

	return var_67_5(var_67_6, var_67_7)
end

function var_0_0.parseCompareUnitTemplate(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0, var_68_1 = string.find(arg_68_0, "%p+")
	local var_68_2 = string.sub(arg_68_0, var_68_0, var_68_1)
	local var_68_3 = string.sub(arg_68_0, 1, var_68_0 - 1)
	local var_68_4 = string.sub(arg_68_0, var_68_1 + 1, #arg_68_0)
	local var_68_5 = getCompareFuncByPunctuation(var_68_2)
	local var_68_6 = tonumber(var_68_3) or arg_68_1:GetTemplateValue(var_68_3)
	local var_68_7 = tonumber(var_68_4) or arg_68_2:GetTemplateValue(var_68_4)

	return var_68_5(var_68_6, var_68_7)
end

function var_0_0.parseCompare(arg_69_0, arg_69_1)
	local var_69_0, var_69_1 = string.find(arg_69_0, "%p+")
	local var_69_2 = string.sub(arg_69_0, var_69_0, var_69_1)
	local var_69_3 = string.sub(arg_69_0, 1, var_69_0 - 1)
	local var_69_4 = string.sub(arg_69_0, var_69_1 + 1, #arg_69_0)
	local var_69_5 = getCompareFuncByPunctuation(var_69_2)
	local var_69_6 = tonumber(var_69_3) or arg_69_1:GetCurrent(var_69_3)
	local var_69_7 = tonumber(var_69_4) or arg_69_1:GetCurrent(var_69_4)

	return var_69_5(var_69_6, var_69_7)
end

function var_0_0.parseFormula(arg_70_0, arg_70_1)
	local var_70_0 = {}
	local var_70_1 = {}

	for iter_70_0 in string.gmatch(arg_70_0, "%w+%.?%w*") do
		table.insert(var_70_0, iter_70_0)
	end

	for iter_70_1 in string.gmatch(arg_70_0, "[^%w%.]") do
		table.insert(var_70_1, iter_70_1)
	end

	local var_70_2 = {}
	local var_70_3 = {}
	local var_70_4 = 1
	local var_70_5 = var_70_0[1]

	var_70_5 = tonumber(var_70_5) or arg_70_1:GetCurrent(var_70_5)

	for iter_70_2, iter_70_3 in ipairs(var_70_1) do
		var_70_4 = var_70_4 + 1

		local var_70_6 = tonumber(var_70_0[var_70_4]) or arg_70_1:GetCurrent(var_70_0[var_70_4])

		if iter_70_3 == "+" or iter_70_3 == "-" then
			table.insert(var_70_3, var_70_5)

			var_70_5 = var_70_6

			table.insert(var_70_2, iter_70_3)
		elseif iter_70_3 == "*" or iter_70_3 == "/" then
			var_70_5 = getArithmeticFuncByOperator(iter_70_3)(var_70_5, var_70_6)
		end
	end

	table.insert(var_70_3, var_70_5)

	local var_70_7 = 1
	local var_70_8 = var_70_3[var_70_7]

	while var_70_7 < #var_70_3 do
		local var_70_9 = getArithmeticFuncByOperator(var_70_2[var_70_7])

		var_70_7 = var_70_7 + 1
		var_70_8 = var_70_9(var_70_8, var_70_3[var_70_7])
	end

	return var_70_8
end
