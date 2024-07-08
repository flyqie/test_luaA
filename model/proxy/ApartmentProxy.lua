local var_0_0 = class("ApartmentProxy", import(".NetProxy"))

var_0_0.UPDATE_APARTMENT = "ApartmentProxy.UPDATE_APARTMENT"
var_0_0.UPDATE_GIFT_COUNT = "ApartmentProxy.UPDATE_GIFT_COUNT"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.giftBag = setDefaultZeroMetatable({})
	arg_1_0.giftGiveCount = setDefaultZeroMetatable({})

	arg_1_0:on(28000, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.gifts) do
			arg_1_0.giftBag[iter_2_1.gift_id] = iter_2_1.number
			arg_1_0.giftGiveCount[iter_2_1.gift_id] = iter_2_1.used_number
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.ships) do
			local var_2_0 = Apartment.New(iter_2_3)

			arg_1_0.data[var_2_0.configId] = var_2_0
		end
	end)
end

function var_0_0.updateApartment(arg_3_0, arg_3_1)
	arg_3_0.data[arg_3_1.configId] = arg_3_1:clone()

	arg_3_0:sendNotification(var_0_0.UPDATE_APARTMENT, arg_3_1)
end

function var_0_0.getApartment(arg_4_0, arg_4_1)
	return arg_4_0.data[arg_4_1] and arg_4_0.data[arg_4_1]:clone() or nil
end

function var_0_0.getGiftCount(arg_5_0, arg_5_1)
	return arg_5_0.giftBag[arg_5_1]
end

function var_0_0.changeGiftCount(arg_6_0, arg_6_1, arg_6_2)
	assert(arg_6_2 ~= 0)

	arg_6_0.giftBag[arg_6_1] = arg_6_0.giftBag[arg_6_1] + arg_6_2

	arg_6_0:sendNotification(var_0_0.UPDATE_GIFT_COUNT, arg_6_1)
end

function var_0_0.addGiftGiveCount(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.giftGiveCount[arg_7_1] = arg_7_0.giftGiveCount[arg_7_1] + arg_7_2
end

function var_0_0.isGiveGiftDone(arg_8_0, arg_8_1)
	return arg_8_0.giftGiveCount[arg_8_1] > 0
end

function var_0_0.getGiftUnlockTalk(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(pg.dorm3d_dialogue_group.get_id_list_by_char_id[20220]) do
		local var_9_0 = pg.dorm3d_dialogue_group[iter_9_1]

		if var_9_0.type == 401 and table.contains(var_9_0.trigger_config, arg_9_2) then
			return iter_9_1
		end
	end
end

function var_0_0.GetTimeIndex(arg_10_0)
	local var_10_0 = 3

	for iter_10_0, iter_10_1 in ipairs({
		7,
		16,
		20
	}) do
		if arg_10_0 < iter_10_1 then
			break
		else
			var_10_0 = iter_10_0
		end
	end

	return var_10_0
end

return var_0_0
