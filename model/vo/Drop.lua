local var_0_0 = class("Drop", import(".BaseVO"))

function var_0_0.Create(arg_1_0)
	local var_1_0 = {}

	var_1_0.type, var_1_0.id, var_1_0.count = unpack(arg_1_0)

	return var_0_0.New(var_1_0)
end

function var_0_0.Change(arg_2_0)
	if not getmetatable(arg_2_0) then
		warning("no change drop")
		setmetatable(arg_2_0, var_0_0)

		arg_2_0.class = var_0_0

		arg_2_0:InitConfig()
	else
		assert(instanceof(arg_2_0, var_0_0))
	end

	return arg_2_0
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	assert(not getmetatable(arg_3_1), "drop data should not has metatable")

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		arg_3_0[iter_3_0] = iter_3_1
	end

	arg_3_0:InitConfig()
end

function var_0_0.InitConfig(arg_4_0)
	if not var_0_0.inited then
		var_0_0.InitSwitch()
	end

	arg_4_0.configId = arg_4_0.id
	arg_4_0.cfg = switch(arg_4_0.type, var_0_0.ConfigCase, var_0_0.ConfigDefault, arg_4_0)
end

function var_0_0.getConfigTable(arg_5_0)
	return arg_5_0.cfg
end

function var_0_0.getName(arg_6_0)
	return arg_6_0.name or arg_6_0:getConfig("name")
end

function var_0_0.getIcon(arg_7_0)
	return arg_7_0:getConfig("icon")
end

function var_0_0.getOwnedCount(arg_8_0)
	return switch(arg_8_0.type, var_0_0.CountCase, var_0_0.CountDefault, arg_8_0)
end

function var_0_0.getSubClass(arg_9_0)
	return switch(arg_9_0.type, var_0_0.SubClassCase, var_0_0.SubClassDefault, arg_9_0)
end

function var_0_0.getDropRarity(arg_10_0)
	return switch(arg_10_0.type, var_0_0.RarityCase, var_0_0.RarityDefault, arg_10_0)
end

function var_0_0.DropTrans(arg_11_0, ...)
	return switch(arg_11_0.type, var_0_0.TransCase, var_0_0.TransDefault, arg_11_0, ...)
end

function var_0_0.AddItemOperation(arg_12_0)
	return switch(arg_12_0.type, var_0_0.AddItemCase, var_0_0.AddItemDefault, arg_12_0)
end

function var_0_0.MsgboxIntroSet(arg_13_0, ...)
	return switch(arg_13_0.type, var_0_0.MsgboxIntroCase, var_0_0.MsgboxIntroDefault, arg_13_0, ...)
end

function var_0_0.UpdateDropTpl(arg_14_0, ...)
	return switch(arg_14_0.type, var_0_0.UpdateDropCase, var_0_0.UpdateDropDefault, arg_14_0, ...)
end

function var_0_0.InitSwitch()
	var_0_0.inited = true
	var_0_0.ConfigCase = {
		[DROP_TYPE_RESOURCE] = function(arg_16_0)
			local var_16_0 = Item.getConfigData(id2ItemId(arg_16_0.id))

			arg_16_0.desc = var_16_0.display

			return var_16_0
		end,
		[DROP_TYPE_ITEM] = function(arg_17_0)
			local var_17_0 = Item.getConfigData(arg_17_0.id)

			arg_17_0.desc = var_17_0.display

			if var_17_0.type == Item.LOVE_LETTER_TYPE then
				arg_17_0.desc = string.gsub(arg_17_0.desc, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_17_0.extra))
			end

			return var_17_0
		end,
		[DROP_TYPE_VITEM] = function(arg_18_0)
			local var_18_0 = Item.getConfigData(arg_18_0.id)

			arg_18_0.desc = var_18_0.display

			return var_18_0
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_19_0)
			local var_19_0 = Item.getConfigData(arg_19_0.id)

			arg_19_0.desc = string.gsub(var_19_0.display, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_19_0.count))

			return var_19_0
		end,
		[DROP_TYPE_EQUIP] = function(arg_20_0)
			local var_20_0 = Equipment.getConfigData(arg_20_0.id)

			arg_20_0.desc = var_20_0.descrip

			return var_20_0
		end,
		[DROP_TYPE_SHIP] = function(arg_21_0)
			local var_21_0 = pg.ship_data_statistics[arg_21_0.id]
			local var_21_1, var_21_2, var_21_3 = ShipWordHelper.GetWordAndCV(var_21_0.skin_id, ShipWordHelper.WORD_TYPE_DROP)

			arg_21_0.desc = var_21_3 or i18n("ship_drop_desc_default")
			arg_21_0.ship = Ship.New({
				configId = arg_21_0.id,
				skin_id = arg_21_0.skinId,
				propose = arg_21_0.propose
			})
			arg_21_0.ship.remoulded = arg_21_0.remoulded
			arg_21_0.ship.virgin = arg_21_0.virgin

			return var_21_0
		end,
		[DROP_TYPE_FURNITURE] = function(arg_22_0)
			local var_22_0 = pg.furniture_data_template[arg_22_0.id]

			arg_22_0.desc = var_22_0.describe

			return var_22_0
		end,
		[DROP_TYPE_SKIN] = function(arg_23_0)
			local var_23_0 = pg.ship_skin_template[arg_23_0.id]
			local var_23_1, var_23_2, var_23_3 = ShipWordHelper.GetWordAndCV(arg_23_0.id, ShipWordHelper.WORD_TYPE_DROP)

			arg_23_0.desc = var_23_3

			return var_23_0
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_24_0)
			local var_24_0 = pg.ship_skin_template[arg_24_0.id]
			local var_24_1, var_24_2, var_24_3 = ShipWordHelper.GetWordAndCV(arg_24_0.id, ShipWordHelper.WORD_TYPE_DROP)

			arg_24_0.desc = var_24_3

			return var_24_0
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_25_0)
			local var_25_0 = pg.equip_skin_template[arg_25_0.id]

			arg_25_0.desc = var_25_0.desc

			return var_25_0
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_26_0)
			local var_26_0 = pg.world_item_data_template[arg_26_0.id]

			arg_26_0.desc = var_26_0.display

			return var_26_0
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_27_0)
			return pg.item_data_frame[arg_27_0.id]
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_28_0)
			return pg.item_data_chat[arg_28_0.id]
		end,
		[DROP_TYPE_SPWEAPON] = function(arg_29_0)
			local var_29_0 = pg.spweapon_data_statistics[arg_29_0.id]

			arg_29_0.desc = var_29_0.descrip

			return var_29_0
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_30_0)
			local var_30_0 = pg.activity_ryza_item[arg_30_0.id]

			arg_30_0.item = AtelierMaterial.New({
				configId = arg_30_0.id
			})
			arg_30_0.desc = arg_30_0.item:GetDesc()

			return var_30_0
		end,
		[DROP_TYPE_OPERATION] = function(arg_31_0)
			arg_31_0.ship = getProxy(BayProxy):getShipById(arg_31_0.count)

			local var_31_0 = pg.ship_data_statistics[arg_31_0.ship.configId]
			local var_31_1, var_31_2, var_31_3 = ShipWordHelper.GetWordAndCV(var_31_0.skin_id, ShipWordHelper.WORD_TYPE_DROP)

			arg_31_0.desc = var_31_3 or i18n("ship_drop_desc_default")

			return var_31_0
		end,
		[DROP_TYPE_STRATEGY] = function(arg_32_0)
			return arg_32_0.isWorldBuff and pg.world_SLGbuff_data[arg_32_0.id] or pg.strategy_data_template[arg_32_0.id]
		end,
		[DROP_TYPE_EMOJI] = function(arg_33_0)
			local var_33_0 = pg.emoji_template[arg_33_0.id]

			arg_33_0.name = var_33_0.item_name
			arg_33_0.desc = var_33_0.item_desc

			return var_33_0
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_34_0)
			local var_34_0 = WorldCollectionProxy.GetCollectionTemplate(arg_34_0.id)

			arg_34_0.desc = var_34_0.name

			return var_34_0
		end,
		[DROP_TYPE_META_PT] = function(arg_35_0)
			local var_35_0 = pg.ship_strengthen_meta[arg_35_0.id]
			local var_35_1 = Item.getConfigData(var_35_0.itemid)

			arg_35_0.desc = var_35_1.display

			return var_35_1
		end,
		[DROP_TYPE_WORKBENCH_DROP] = function(arg_36_0)
			local var_36_0 = pg.activity_workbench_item[arg_36_0.id]

			arg_36_0.item = WorkBenchItem.New({
				configId = arg_36_0.id
			})
			arg_36_0.desc = arg_36_0.item:GetDesc()

			return var_36_0
		end,
		[DROP_TYPE_BUFF] = function(arg_37_0)
			local var_37_0 = pg.benefit_buff_template[arg_37_0.id]

			arg_37_0.desc = var_37_0.desc

			return var_37_0
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_38_0)
			local var_38_0 = pg.commander_data_template[arg_38_0.id]

			arg_38_0.desc = ""

			return var_38_0
		end,
		[DROP_TYPE_TRANS_ITEM] = function(arg_39_0)
			return pg.drop_data_restore[arg_39_0.id]
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_40_0)
			local var_40_0 = pg.dorm3d_furniture_template[arg_40_0.id]

			arg_40_0.desc = var_40_0.desc

			return var_40_0
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_41_0)
			local var_41_0 = pg.dorm3d_gift[arg_41_0.id]

			arg_41_0.desc = ""

			return var_41_0
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_42_0)
			local var_42_0 = pg.dorm3d_resource[arg_42_0.id]

			arg_42_0.desc = ""

			return var_42_0
		end
	}

	function var_0_0.ConfigDefault(arg_43_0)
		local var_43_0 = arg_43_0.type

		if var_43_0 > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_43_1 = pg.activity_drop_type[var_43_0].relevance

			return var_43_1 and pg[var_43_1][arg_43_0.id]
		end
	end

	var_0_0.CountCase = {
		[DROP_TYPE_RESOURCE] = function(arg_44_0)
			return getProxy(PlayerProxy):getRawData():getResById(arg_44_0.id), true
		end,
		[DROP_TYPE_ITEM] = function(arg_45_0)
			local var_45_0 = getProxy(BagProxy):getItemCountById(arg_45_0.id)

			if arg_45_0:getConfig("type") == Item.LOVE_LETTER_TYPE then
				return math.min(var_45_0, 1), true
			else
				return var_45_0, true
			end
		end,
		[DROP_TYPE_EQUIP] = function(arg_46_0)
			local var_46_0 = arg_46_0:getConfig("group")

			assert(pg.equip_data_template.get_id_list_by_group[var_46_0], "equip groupId not exist")

			local var_46_1 = pg.equip_data_template.get_id_list_by_group[var_46_0]

			return underscore.reduce(var_46_1, 0, function(arg_47_0, arg_47_1)
				local var_47_0 = getProxy(EquipmentProxy):getEquipmentById(arg_47_1)

				return arg_47_0 + (var_47_0 and var_47_0.count or 0) + getProxy(BayProxy):GetEquipCountInShips(arg_47_1)
			end)
		end,
		[DROP_TYPE_SHIP] = function(arg_48_0)
			return getProxy(BayProxy):getConfigShipCount(arg_48_0.id)
		end,
		[DROP_TYPE_FURNITURE] = function(arg_49_0)
			return getProxy(DormProxy):getRawData():GetOwnFurnitureCount(arg_49_0.id)
		end,
		[DROP_TYPE_STRATEGY] = function(arg_50_0)
			return arg_50_0.count, tobool(arg_50_0.count)
		end,
		[DROP_TYPE_SKIN] = function(arg_51_0)
			return getProxy(ShipSkinProxy):getSkinCountById(arg_51_0.id)
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_52_0)
			return getProxy(ShipSkinProxy):getSkinCountById(arg_52_0.id)
		end,
		[DROP_TYPE_VITEM] = function(arg_53_0)
			if arg_53_0:getConfig("virtual_type") == 22 then
				local var_53_0 = getProxy(ActivityProxy):getActivityById(arg_53_0:getConfig("link_id"))

				return var_53_0 and var_53_0.data1 or 0, true
			end
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_54_0)
			local var_54_0 = getProxy(EquipmentProxy):getEquipmnentSkinById(arg_54_0.id)

			return (var_54_0 and var_54_0.count or 0) + getProxy(BayProxy):GetEquipSkinCountInShips(arg_54_0.id)
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_55_0)
			local var_55_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_55_0.type].activity_id):GetItemById(arg_55_0.id)

			return var_55_0 and var_55_0.count or 0
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_56_0)
			local var_56_0 = getProxy(AttireProxy):getAttireFrame(AttireConst.TYPE_ICON_FRAME, arg_56_0.id)

			return var_56_0 and (not var_56_0:expiredType() or not not var_56_0:isExpired()) and 1 or 0
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_57_0)
			local var_57_0 = getProxy(AttireProxy):getAttireFrame(AttireConst.TYPE_CHAT_FRAME, arg_57_0.id)

			return var_57_0 and (not var_57_0:expiredType() or not not var_57_0:isExpired()) and 1 or 0
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_58_0)
			local var_58_0 = nowWorld()

			if var_58_0.type ~= World.TypeFull then
				assert(false)

				return 0, false
			else
				return var_58_0:GetInventoryProxy():GetItemCount(arg_58_0.id), false
			end
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_59_0)
			return getProxy(CommanderProxy):GetSameConfigIdCommanderCount(arg_59_0.id)
		end
	}

	function var_0_0.CountDefault(arg_60_0)
		local var_60_0 = arg_60_0.type

		if var_60_0 > DROP_TYPE_USE_ACTIVITY_DROP then
			return getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[var_60_0].activity_id):getVitemNumber(arg_60_0.id)
		else
			return 0, false
		end
	end

	var_0_0.SubClassCase = {
		[DROP_TYPE_RESOURCE] = function(arg_61_0)
			return
		end,
		[DROP_TYPE_ITEM] = function(arg_62_0)
			return Item.New(arg_62_0)
		end,
		[DROP_TYPE_VITEM] = function(arg_63_0)
			return Item.New(arg_63_0)
		end,
		[DROP_TYPE_EQUIP] = function(arg_64_0)
			return Equipment.New(arg_64_0)
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_65_0)
			return Item.New({
				count = 1,
				id = arg_65_0.id,
				extra = arg_65_0.count
			})
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_66_0)
			return WorldItem.New(arg_66_0)
		end
	}

	function var_0_0.SubClassDefault(arg_67_0)
		assert(false, string.format("drop type %d without subClass", arg_67_0.type))
	end

	var_0_0.RarityCase = {
		[DROP_TYPE_RESOURCE] = function(arg_68_0)
			return arg_68_0:getConfig("rarity")
		end,
		[DROP_TYPE_ITEM] = function(arg_69_0)
			return arg_69_0:getConfig("rarity")
		end,
		[DROP_TYPE_EQUIP] = function(arg_70_0)
			return arg_70_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_SHIP] = function(arg_71_0)
			return arg_71_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_FURNITURE] = function(arg_72_0)
			return arg_72_0:getConfig("rarity")
		end,
		[DROP_TYPE_SKIN] = function(arg_73_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_74_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_VITEM] = function(arg_75_0)
			return arg_75_0:getConfig("rarity")
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_76_0)
			return arg_76_0:getConfig("rarity")
		end,
		[DROP_TYPE_BUFF] = function(arg_77_0)
			return ItemRarity.Purple
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_78_0)
			return arg_78_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_79_0)
			return arg_79_0:getConfig("rarity")
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_80_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_81_0)
			return ItemRarity.Gold
		end
	}

	function var_0_0.RarityDefault(arg_82_0)
		return 1
	end

	var_0_0.TransCase = {
		[DROP_TYPE_TRANS_ITEM] = function(arg_83_0)
			local var_83_0 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_83_0:getConfig("resource_type"),
				count = arg_83_0:getConfig("resource_num") * arg_83_0.count
			})
			local var_83_1 = Drop.New({
				type = arg_83_0:getConfig("target_type"),
				id = arg_83_0:getConfig("target_id")
			})

			var_83_0.name = string.format("%s(%s)", var_83_0:getName(), var_83_1:getName())

			return var_83_0
		end,
		[DROP_TYPE_RESOURCE] = function(arg_84_0)
			for iter_84_0, iter_84_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)) do
				if pg.battlepass_event_pt[iter_84_1.id].pt == arg_84_0.id then
					return nil, arg_84_0
				end
			end

			return arg_84_0
		end,
		[DROP_TYPE_OPERATION] = function(arg_85_0)
			if arg_85_0.id ~= 3 then
				return nil
			end

			return arg_85_0
		end,
		[DROP_TYPE_VITEM] = function(arg_86_0, arg_86_1, arg_86_2)
			assert(arg_86_0:getConfig("type") == 0, "item type error:must be virtual type from " .. arg_86_0.id)

			return switch(arg_86_0:getConfig("virtual_type"), {
				function()
					if arg_86_0:getConfig("link_id") == ActivityConst.LINLK_DUNHUANG_ACT then
						return nil, arg_86_0
					end

					return arg_86_0
				end,
				[6] = function()
					local var_88_0 = arg_86_2.taskId
					local var_88_1 = getProxy(ActivityProxy)
					local var_88_2 = var_88_1:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

					if var_88_2 then
						local var_88_3 = var_88_2.data1KeyValueList[1]

						var_88_3[var_88_0] = defaultValue(var_88_3[var_88_0], 0) + arg_86_0.count

						var_88_1:updateActivity(var_88_2)
					end

					return nil, arg_86_0
				end,
				[13] = function()
					local var_89_0 = arg_86_0:getName()

					if not SkinCouponActivity.StaticExistActivity() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("coupon_timeout_tip", var_89_0))

						return nil
					elseif SkinCouponActivity.StaticOwnMaxCntSkinCoupon() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("coupon_repeat_tip", var_89_0))

						return nil
					elseif SkinCouponActivity.StaticOwnAllSkin() then
						if arg_86_0.count > 1 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("coupon_repeat_tip", var_89_0))
						end

						return SkinCouponActivity.StaticGetEquivalentRes(), nil
					else
						return arg_86_0, nil
					end
				end,
				[21] = function()
					return nil, arg_86_0
				end
			}, function()
				return arg_86_0
			end)
		end,
		[DROP_TYPE_SHIP] = function(arg_92_0, arg_92_1)
			if Ship.isMetaShipByConfigID(arg_92_0.id) and Player.isMetaShipNeedToTrans(arg_92_0.id) then
				local var_92_0 = table.indexof(arg_92_1, arg_92_0.id, 1)

				if var_92_0 then
					table.remove(arg_92_1, var_92_0)
				else
					local var_92_1 = Player.metaShip2Res(arg_92_0.id)
					local var_92_2 = Drop.New(var_92_1[1])

					getProxy(BayProxy):addMetaTransItemMap(arg_92_0.id, var_92_2)

					return arg_92_0, var_92_2
				end
			end

			return arg_92_0
		end,
		[DROP_TYPE_SKIN] = function(arg_93_0)
			arg_93_0.isNew = not getProxy(ShipSkinProxy):hasOldNonLimitSkin(arg_93_0.id)

			return arg_93_0
		end
	}

	function var_0_0.TransDefault(arg_94_0)
		return arg_94_0
	end

	var_0_0.AddItemCase = {
		[DROP_TYPE_RESOURCE] = function(arg_95_0)
			local var_95_0 = id2res(arg_95_0.id)

			assert(var_95_0, "res should be defined: " .. arg_95_0.id)

			local var_95_1 = getProxy(PlayerProxy)
			local var_95_2 = var_95_1:getData()

			var_95_2:addResources({
				[var_95_0] = arg_95_0.count
			})
			var_95_1:updatePlayer(var_95_2)
		end,
		[DROP_TYPE_ITEM] = function(arg_96_0)
			if arg_96_0:getConfig("type") == Item.EXP_BOOK_TYPE then
				local var_96_0 = getProxy(BagProxy):getItemCountById(arg_96_0.id)
				local var_96_1 = math.min(arg_96_0:getConfig("max_num") - var_96_0, arg_96_0.count)

				if var_96_1 > 0 then
					getProxy(BagProxy):addItemById(arg_96_0.id, var_96_1)
				end
			else
				getProxy(BagProxy):addItemById(arg_96_0.id, arg_96_0.count, arg_96_0.extra)
			end
		end,
		[DROP_TYPE_EQUIP] = function(arg_97_0)
			getProxy(EquipmentProxy):addEquipmentById(arg_97_0.id, arg_97_0.count)
		end,
		[DROP_TYPE_SHIP] = function(arg_98_0)
			return
		end,
		[DROP_TYPE_FURNITURE] = function(arg_99_0)
			local var_99_0 = getProxy(DormProxy)
			local var_99_1 = Furniture.New({
				id = arg_99_0.id,
				count = arg_99_0.count
			})

			if var_99_1:isRecordTime() then
				var_99_1.date = pg.TimeMgr.GetInstance():GetServerTime()
			end

			var_99_0:AddFurniture(var_99_1)
		end,
		[DROP_TYPE_SKIN] = function(arg_100_0)
			local var_100_0 = getProxy(ShipSkinProxy)
			local var_100_1 = ShipSkin.New({
				id = arg_100_0.id
			})

			var_100_0:addSkin(var_100_1)
		end,
		[DROP_TYPE_VITEM] = function(arg_101_0)
			arg_101_0 = arg_101_0:getSubClass()

			assert(arg_101_0:isVirtualItem(), "item type error(virtual item)>>" .. arg_101_0.id)
			switch(arg_101_0:getConfig("virtual_type"), {
				[0] = function()
					getProxy(ActivityProxy):addVitemById(arg_101_0.id, arg_101_0.count)
				end,
				function()
					local var_103_0 = getProxy(ActivityProxy)
					local var_103_1 = arg_101_0:getConfig("link_id")
					local var_103_2

					if var_103_1 > 0 then
						var_103_2 = var_103_0:getActivityById(var_103_1)
					else
						var_103_2 = var_103_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)
					end

					if var_103_2 and not var_103_2:isEnd() then
						if not table.contains(var_103_2.data1_list, arg_101_0.id) then
							table.insert(var_103_2.data1_list, arg_101_0.id)
						end

						var_103_0:updateActivity(var_103_2)
					end
				end,
				function()
					local var_104_0 = getProxy(ActivityProxy)
					local var_104_1 = var_104_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE)

					for iter_104_0, iter_104_1 in ipairs(var_104_1) do
						iter_104_1.data1 = iter_104_1.data1 + arg_101_0.count

						local var_104_2 = iter_104_1:getConfig("config_id")
						local var_104_3 = pg.activity_vote[var_104_2]

						if var_104_3 and var_104_3.ticket_id_period == arg_101_0.id then
							iter_104_1.data3 = iter_104_1.data3 + arg_101_0.count
						end

						var_104_0:updateActivity(iter_104_1)
						pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_VOTE, {
							ptId = arg_101_0.id,
							ptCount = arg_101_0.count
						})
					end
				end,
				[4] = function()
					local var_105_0 = getProxy(ColoringProxy):getColorItems()

					var_105_0[arg_101_0.id] = (var_105_0[arg_101_0.id] or 0) + arg_101_0.count
				end,
				[6] = function()
					local var_106_0 = getProxy(ActivityProxy)
					local var_106_1 = var_106_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

					if var_106_1 then
						var_106_1.data3 = var_106_1.data3 + arg_101_0.count

						var_106_0:updateActivity(var_106_1)
					end
				end,
				[7] = function()
					local var_107_0 = getProxy(ChapterProxy)

					var_107_0:updateRemasterTicketsNum(math.min(var_107_0.remasterTickets + arg_101_0.count, pg.gameset.reactivity_ticket_max.key_value))
				end,
				[9] = function()
					local var_108_0 = getProxy(ActivityProxy)
					local var_108_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

					if var_108_1 then
						var_108_1.data1_list[1] = var_108_1.data1_list[1] + arg_101_0.count

						var_108_0:updateActivity(var_108_1)
					end
				end,
				[10] = function()
					local var_109_0 = getProxy(ActivityProxy)
					local var_109_1 = var_109_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_INSTAGRAM)

					if var_109_1 and not var_109_1:isEnd() then
						var_109_1.data1 = var_109_1.data1 + arg_101_0.count

						var_109_0:updateActivity(var_109_1)
						self:sendNotification(GAME.ACTIVITY_BE_UPDATED, {
							activity = var_109_1
						})
					end
				end,
				[11] = function()
					local var_110_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)

					if var_110_0 and not var_110_0:isEnd() then
						var_110_0.data1 = var_110_0.data1 + arg_101_0.count
					end
				end,
				[12] = function()
					local var_111_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

					if var_111_0 and not var_111_0:isEnd() then
						var_111_0.data1KeyValueList[1][arg_101_0.id] = (var_111_0.data1KeyValueList[1][arg_101_0.id] or 0) + arg_101_0.count
					end
				end,
				[13] = function()
					SkinCouponActivity.AddSkinCoupon(arg_101_0.id)
				end,
				[14] = function()
					local var_113_0 = nowWorld():GetBossProxy()

					if WorldBossConst.WORLD_BOSS_ITEM_ID == arg_101_0.id then
						var_113_0:AddSummonPt(arg_101_0.count)
					elseif WorldBossConst.WORLD_PAST_BOSS_ITEM_ID == arg_101_0.id then
						var_113_0:AddSummonPtOld(arg_101_0.count)
					end
				end,
				[15] = function()
					local var_114_0 = getProxy(ActivityProxy)
					local var_114_1 = var_114_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

					if var_114_1 and not var_114_1:isEnd() then
						local var_114_2 = pg.activity_event_grid[var_114_1.data1]

						if arg_101_0.id == var_114_2.ticket_item then
							var_114_1.data2 = var_114_1.data2 + arg_101_0.count
						elseif arg_101_0.id == var_114_2.explore_item then
							var_114_1.data3 = var_114_1.data3 + arg_101_0.count
						end
					end

					var_114_0:updateActivity(var_114_1)
				end,
				[16] = function()
					local var_115_0 = getProxy(ActivityProxy)
					local var_115_1 = var_115_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHAKE_BEADS)

					for iter_115_0, iter_115_1 in pairs(var_115_1) do
						if iter_115_1 and not iter_115_1:isEnd() and arg_101_0.id == iter_115_1:getConfig("config_id") then
							iter_115_1.data1 = iter_115_1.data1 + arg_101_0.count

							var_115_0:updateActivity(iter_115_1)
						end
					end
				end,
				[20] = function()
					local var_116_0 = getProxy(BagProxy)
					local var_116_1 = pg.gameset.urpt_chapter_max.description
					local var_116_2 = var_116_1[1]
					local var_116_3 = var_116_1[2]
					local var_116_4 = var_116_0:GetLimitCntById(var_116_2)
					local var_116_5 = math.min(var_116_3 - var_116_4, arg_101_0.count)

					if var_116_5 > 0 then
						var_116_0:addItemById(var_116_2, var_116_5)
						var_116_0:AddLimitCnt(var_116_2, var_116_5)
					end
				end,
				[21] = function()
					local var_117_0 = getProxy(ActivityProxy)
					local var_117_1 = var_117_0:getActivityById(arg_101_0:getConfig("link_id"))

					if var_117_1 and not var_117_1:isEnd() then
						var_117_1.data2 = 1

						var_117_0:updateActivity(var_117_1)
					end
				end,
				[22] = function()
					local var_118_0 = getProxy(ActivityProxy)
					local var_118_1 = var_118_0:getActivityById(arg_101_0:getConfig("link_id"))

					if var_118_1 and not var_118_1:isEnd() then
						var_118_1.data1 = var_118_1.data1 + arg_101_0.count

						var_118_0:updateActivity(var_118_1)
					end
				end,
				[23] = function()
					local var_119_0 = (function()
						for iter_120_0, iter_120_1 in ipairs(pg.gameset.package_lv.description) do
							if arg_101_0.id == iter_120_1[1] then
								return iter_120_1[2]
							end
						end
					end)()

					assert(var_119_0)

					local var_119_1 = getProxy(PlayerProxy)
					local var_119_2 = var_119_1:getData()

					var_119_2:addExpToLevel(var_119_0)
					var_119_1:updatePlayer(var_119_2)
				end,
				[24] = function()
					local var_121_0 = arg_101_0:getConfig("link_id")
					local var_121_1 = getProxy(ActivityProxy):getActivityById(var_121_0)

					if var_121_1 and not var_121_1:isEnd() and var_121_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
						var_121_1.data2 = var_121_1.data2 + arg_101_0.count

						getProxy(ActivityProxy):updateActivity(var_121_1)
					end
				end,
				[25] = function()
					local var_122_0 = getProxy(ActivityProxy)
					local var_122_1 = var_122_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

					if var_122_1 and not var_122_1:isEnd() then
						var_122_1.data1 = var_122_1.data1 - 1

						if not table.contains(var_122_1.data1_list, arg_101_0.id) then
							table.insert(var_122_1.data1_list, arg_101_0.id)
						end

						var_122_0:updateActivity(var_122_1)

						local var_122_2 = arg_101_0:getConfig("link_id")

						if var_122_2 > 0 then
							local var_122_3 = var_122_0:getActivityById(var_122_2)

							if var_122_3 and not var_122_3:isEnd() then
								var_122_3.data1 = var_122_3.data1 + 1

								var_122_0:updateActivity(var_122_3)
							end
						end
					end
				end,
				[99] = function()
					return
				end,
				[100] = function()
					return
				end
			})
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_125_0)
			getProxy(EquipmentProxy):addEquipmentSkin(arg_125_0.id, arg_125_0.count)
		end,
		[DROP_TYPE_OPERATION] = function(arg_126_0)
			local var_126_0 = getProxy(BayProxy)
			local var_126_1 = var_126_0:getShipById(arg_126_0.count)

			if var_126_1 then
				var_126_1:unlockActivityNpc(0)
				var_126_0:updateShip(var_126_1)
				getProxy(CollectionProxy):flushCollection(var_126_1)
			end
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_127_0)
			nowWorld():GetInventoryProxy():AddItem(arg_127_0.id, arg_127_0.count)
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_128_0)
			local var_128_0 = getProxy(AttireProxy)
			local var_128_1 = pg.TimeMgr.GetInstance():GetServerTime()
			local var_128_2 = IconFrame.New({
				id = arg_128_0.id
			})
			local var_128_3 = var_128_1 + var_128_2:getConfig("time_second")

			var_128_2:updateData({
				isNew = true,
				end_time = var_128_3
			})
			var_128_0:addAttireFrame(var_128_2)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_ATTIRE, var_128_2)
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_129_0)
			local var_129_0 = getProxy(AttireProxy)
			local var_129_1 = pg.TimeMgr.GetInstance():GetServerTime()
			local var_129_2 = ChatFrame.New({
				id = arg_129_0.id
			})
			local var_129_3 = var_129_1 + var_129_2:getConfig("time_second")

			var_129_2:updateData({
				isNew = true,
				end_time = var_129_3
			})
			var_129_0:addAttireFrame(var_129_2)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_ATTIRE, var_129_2)
		end,
		[DROP_TYPE_EMOJI] = function(arg_130_0)
			getProxy(EmojiProxy):addNewEmojiID(arg_130_0.id)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_EMOJI, arg_130_0:getConfigTable())
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_131_0)
			nowWorld():GetCollectionProxy():Unlock(arg_131_0.id)
		end,
		[DROP_TYPE_META_PT] = function(arg_132_0)
			getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_132_0.id):addPT(arg_132_0.count)
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_133_0)
			local var_133_0 = arg_133_0.id
			local var_133_1 = arg_133_0.count
			local var_133_2 = getProxy(ShipSkinProxy)
			local var_133_3 = var_133_2:getSkinById(var_133_0)

			if var_133_3 and var_133_3:isExpireType() then
				local var_133_4 = var_133_1 + var_133_3.endTime
				local var_133_5 = ShipSkin.New({
					id = var_133_0,
					end_time = var_133_4
				})

				var_133_2:addSkin(var_133_5)
			elseif not var_133_3 then
				local var_133_6 = var_133_1 + pg.TimeMgr.GetInstance():GetServerTime()
				local var_133_7 = ShipSkin.New({
					id = var_133_0,
					end_time = var_133_6
				})

				var_133_2:addSkin(var_133_7)
			end
		end,
		[DROP_TYPE_BUFF] = function(arg_134_0)
			local var_134_0 = arg_134_0.id
			local var_134_1 = pg.benefit_buff_template[var_134_0]

			assert(var_134_1 and var_134_1.act_id > 0, "should exist act id")

			local var_134_2 = getProxy(ActivityProxy):getActivityById(var_134_1.act_id)

			if var_134_2 and not var_134_2:isEnd() then
				local var_134_3 = var_134_1.max_time
				local var_134_4 = pg.TimeMgr.GetInstance():GetServerTime() + var_134_3

				var_134_2:AddBuff(ActivityBuff.New(var_134_2.id, var_134_0, var_134_4))
				getProxy(ActivityProxy):updateActivity(var_134_2)
			end
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_135_0)
			return
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_136_0)
			getProxy(ApartmentProxy):changeGiftCount(arg_136_0.id, arg_136_0.count)
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_137_0)
			local var_137_0 = getProxy(ApartmentProxy)
			local var_137_1 = var_137_0:getApartment(arg_137_0:getConfig("ship_group"))

			var_137_1:addSkin(arg_137_0.id)
			var_137_0:updateApartment(var_137_1)
		end
	}

	function var_0_0.AddItemDefault(arg_138_0)
		if arg_138_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_138_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_138_0.type].activity_id)

			if arg_138_0.type == DROP_TYPE_RYZA_DROP then
				if var_138_0 and not var_138_0:isEnd() then
					var_138_0:AddItem(AtelierMaterial.New({
						configId = arg_138_0.id,
						count = arg_138_0.count
					}))
					getProxy(ActivityProxy):updateActivity(var_138_0)
				end
			elseif var_138_0 and not var_138_0:isEnd() then
				var_138_0:addVitemNumber(arg_138_0.id, arg_138_0.count)
				getProxy(ActivityProxy):updateActivity(var_138_0)
			end
		else
			print("can not handle this type>>" .. arg_138_0.type)
		end
	end

	var_0_0.MsgboxIntroCase = {
		[DROP_TYPE_RESOURCE] = function(arg_139_0, arg_139_1, arg_139_2)
			setText(arg_139_2, arg_139_0:getConfig("display"))
		end,
		[DROP_TYPE_ITEM] = function(arg_140_0, arg_140_1, arg_140_2)
			local var_140_0 = arg_140_0:getConfig("display")

			if arg_140_0:getConfig("type") == Item.LOVE_LETTER_TYPE then
				var_140_0 = string.gsub(var_140_0, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_140_0.extra))
			elseif arg_140_0:getConfig("combination_display") ~= nil then
				local var_140_1 = arg_140_0:getConfig("combination_display")

				if var_140_1 and #var_140_1 > 0 then
					var_140_0 = Item.StaticCombinationDisplay(var_140_1)
				end
			end

			setText(arg_140_2, SwitchSpecialChar(var_140_0, true))
		end,
		[DROP_TYPE_FURNITURE] = function(arg_141_0, arg_141_1, arg_141_2)
			setText(arg_141_2, arg_141_0:getConfig("describe"))
		end,
		[DROP_TYPE_SHIP] = function(arg_142_0, arg_142_1, arg_142_2)
			local var_142_0 = arg_142_0:getConfig("skin_id")
			local var_142_1, var_142_2, var_142_3 = ShipWordHelper.GetWordAndCV(var_142_0, ShipWordHelper.WORD_TYPE_DROP, nil, PLATFORM_CODE ~= PLATFORM_US)

			setText(arg_142_2, var_142_3 or i18n("ship_drop_desc_default"))
		end,
		[DROP_TYPE_OPERATION] = function(arg_143_0, arg_143_1, arg_143_2)
			local var_143_0 = arg_143_0:getConfig("skin_id")
			local var_143_1, var_143_2, var_143_3 = ShipWordHelper.GetWordAndCV(var_143_0, ShipWordHelper.WORD_TYPE_DROP, nil, PLATFORM_CODE ~= PLATFORM_US)

			setText(arg_143_2, var_143_3 or i18n("ship_drop_desc_default"))
		end,
		[DROP_TYPE_EQUIP] = function(arg_144_0, arg_144_1, arg_144_2)
			setText(arg_144_2, arg_144_1.name or arg_144_0:getConfig("name") or "")
		end,
		[DROP_TYPE_STRATEGY] = function(arg_145_0, arg_145_1, arg_145_2)
			local var_145_0 = arg_145_0:getConfig("desc")

			for iter_145_0, iter_145_1 in ipairs({
				arg_145_0.count
			}) do
				var_145_0 = string.gsub(var_145_0, "$" .. iter_145_0, iter_145_1)
			end

			setText(arg_145_2, var_145_0)
		end,
		[DROP_TYPE_SKIN] = function(arg_146_0, arg_146_1, arg_146_2)
			setText(arg_146_2, arg_146_0:getConfig("desc"))
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_147_0, arg_147_1, arg_147_2)
			setText(arg_147_2, arg_147_0:getConfig("desc"))
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_148_0, arg_148_1, arg_148_2)
			local var_148_0 = arg_148_0:getConfig("desc")
			local var_148_1 = _.map(arg_148_0:getConfig("equip_type"), function(arg_149_0)
				return EquipType.Type2Name2(arg_149_0)
			end)

			setText(arg_148_2, var_148_0 .. "\n\n" .. i18n("word_fit") .. ": " .. table.concat(var_148_1, ","))
		end,
		[DROP_TYPE_VITEM] = function(arg_150_0, arg_150_1, arg_150_2)
			setText(arg_150_2, arg_150_0:getConfig("display"))
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_151_0, arg_151_1, arg_151_2)
			setText(arg_151_2, arg_151_0:getConfig("display"))
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_152_0, arg_152_1, arg_152_2, arg_152_3)
			local var_152_0 = WorldCollectionProxy.GetCollectionType(arg_152_0.id) == WorldCollectionProxy.WorldCollectionType.FILE and "file" or "record"

			setText(arg_152_2, i18n("world_" .. var_152_0 .. "_desc", arg_152_0:getConfig("name")))
			setText(arg_152_3, i18n("world_" .. var_152_0 .. "_name", arg_152_0:getConfig("name")))
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_153_0, arg_153_1, arg_153_2)
			setText(arg_153_2, arg_153_0:getConfig("desc"))
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_154_0, arg_154_1, arg_154_2)
			setText(arg_154_2, arg_154_0:getConfig("desc"))
		end,
		[DROP_TYPE_EMOJI] = function(arg_155_0, arg_155_1, arg_155_2)
			setText(arg_155_2, arg_155_0:getConfig("item_desc"))
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_156_0, arg_156_1, arg_156_2)
			desc = string.gsub(arg_156_0:getConfig("display"), "$1", ShipGroup.getDefaultShipNameByGroupID(arg_156_0.count))

			setText(arg_156_2, SwitchSpecialChar(desc, true))
		end,
		[DROP_TYPE_META_PT] = function(arg_157_0, arg_157_1, arg_157_2)
			setText(arg_157_2, arg_157_0:getConfig("display"))
		end,
		[DROP_TYPE_BUFF] = function(arg_158_0, arg_158_1, arg_158_2)
			setText(arg_158_2, arg_158_0:getConfig("desc"))
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_159_0, arg_159_1, arg_159_2)
			setText(arg_159_2, "")
		end
	}

	function var_0_0.MsgboxIntroDefault(arg_160_0, arg_160_1, arg_160_2)
		if arg_160_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			setText(arg_160_2, arg_160_0:getConfig("display"))
		else
			assert(false, "can not handle this type>>" .. arg_160_0.type)
		end
	end

	var_0_0.UpdateDropCase = {
		[DROP_TYPE_RESOURCE] = function(arg_161_0, arg_161_1, arg_161_2)
			updateItem(arg_161_1, Item.New({
				id = id2ItemId(arg_161_0.id)
			}), arg_161_2)
		end,
		[DROP_TYPE_ITEM] = function(arg_162_0, arg_162_1, arg_162_2)
			updateItem(arg_162_1, arg_162_0:getSubClass(), arg_162_2)
		end,
		[DROP_TYPE_EQUIP] = function(arg_163_0, arg_163_1, arg_163_2)
			updateEquipment(arg_163_1, arg_163_0:getSubClass(), arg_163_2)
		end,
		[DROP_TYPE_SHIP] = function(arg_164_0, arg_164_1, arg_164_2)
			updateShip(arg_164_1, arg_164_0.ship, arg_164_2)
		end,
		[DROP_TYPE_OPERATION] = function(arg_165_0, arg_165_1, arg_165_2)
			updateShip(arg_165_1, arg_165_0.ship, arg_165_2)
		end,
		[DROP_TYPE_FURNITURE] = function(arg_166_0, arg_166_1, arg_166_2)
			updateFurniture(arg_166_1, arg_166_0, arg_166_2)
		end,
		[DROP_TYPE_STRATEGY] = function(arg_167_0, arg_167_1, arg_167_2)
			arg_167_2.isWorldBuff = arg_167_0.isWorldBuff

			updateStrategy(arg_167_1, arg_167_0, arg_167_2)
		end,
		[DROP_TYPE_SKIN] = function(arg_168_0, arg_168_1, arg_168_2)
			arg_168_2.isSkin = true
			arg_168_2.isNew = arg_168_0.isNew

			updateShip(arg_168_1, Ship.New({
				configId = tonumber(arg_168_0:getConfig("ship_group") .. "1"),
				skin_id = arg_168_0.id
			}), arg_168_2)
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_169_0, arg_169_1, arg_169_2)
			local var_169_0 = setmetatable({
				count = arg_169_0.count
			}, {
				__index = arg_169_0:getConfigTable()
			})

			updateEquipmentSkin(arg_169_1, var_169_0, arg_169_2)
		end,
		[DROP_TYPE_VITEM] = function(arg_170_0, arg_170_1, arg_170_2)
			updateItem(arg_170_1, Item.New({
				id = arg_170_0.id
			}), arg_170_2)
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_171_0, arg_171_1, arg_171_2)
			updateWorldItem(arg_171_1, WorldItem.New({
				id = arg_171_0.id
			}), arg_171_2)
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_172_0, arg_172_1, arg_172_2)
			updateWorldCollection(arg_172_1, arg_172_0, arg_172_2)
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_173_0, arg_173_1, arg_173_2)
			updateAttire(arg_173_1, AttireConst.TYPE_CHAT_FRAME, arg_173_0:getConfigTable(), arg_173_2)
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_174_0, arg_174_1, arg_174_2)
			updateAttire(arg_174_1, AttireConst.TYPE_ICON_FRAME, arg_174_0:getConfigTable(), arg_174_2)
		end,
		[DROP_TYPE_EMOJI] = function(arg_175_0, arg_175_1, arg_175_2)
			updateEmoji(arg_175_1, arg_175_0:getConfigTable(), arg_175_2)
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_176_0, arg_176_1, arg_176_2)
			arg_176_2.count = 1

			updateItem(arg_176_1, arg_176_0:getSubClass(), arg_176_2)
		end,
		[DROP_TYPE_SPWEAPON] = function(arg_177_0, arg_177_1, arg_177_2)
			updateSpWeapon(arg_177_1, SpWeapon.New({
				id = arg_177_0.id
			}), arg_177_2)
		end,
		[DROP_TYPE_META_PT] = function(arg_178_0, arg_178_1, arg_178_2)
			updateItem(arg_178_1, Item.New({
				id = arg_178_0:getConfig("id")
			}), arg_178_2)
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_179_0, arg_179_1, arg_179_2)
			arg_179_2.isSkin = true
			arg_179_2.isTimeLimit = true
			arg_179_2.count = 1

			updateShip(arg_179_1, Ship.New({
				configId = tonumber(arg_179_0:getConfig("ship_group") .. "1"),
				skin_id = arg_179_0.id
			}), arg_179_2)
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_180_0, arg_180_1, arg_180_2)
			AtelierMaterial.UpdateRyzaItem(arg_180_1, arg_180_0.item, arg_180_2)
		end,
		[DROP_TYPE_WORKBENCH_DROP] = function(arg_181_0, arg_181_1, arg_181_2)
			WorkBenchItem.UpdateDrop(arg_181_1, arg_181_0.item, arg_181_2)
		end,
		[DROP_TYPE_FEAST_DROP] = function(arg_182_0, arg_182_1, arg_182_2)
			WorkBenchItem.UpdateDrop(arg_182_1, WorkBenchItem.New({
				configId = arg_182_0.id,
				count = arg_182_0.count
			}), arg_182_2)
		end,
		[DROP_TYPE_BUFF] = function(arg_183_0, arg_183_1, arg_183_2)
			updateBuff(arg_183_1, arg_183_0.id, arg_183_2)
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_184_0, arg_184_1, arg_184_2)
			updateCommander(arg_184_1, arg_184_0, arg_184_2)
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_185_0, arg_185_1, arg_185_2)
			updateDorm3dFurniture(arg_185_1, arg_185_0, arg_185_2)
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_186_0, arg_186_1, arg_186_2)
			updateDorm3dGift(arg_186_1, arg_186_0, arg_186_2)
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_187_0, arg_187_1, arg_187_2)
			updateDorm3dSkin(arg_187_1, arg_187_0, arg_187_2)
		end
	}

	function var_0_0.UpdateDropDefault(arg_188_0, arg_188_1, arg_188_2)
		warning(string.format("without dropType %d in updateDrop", arg_188_0.type))
	end
end

return var_0_0
