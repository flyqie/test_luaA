local var_0_0 = class("ActivityItemPool", import(".BaseVO"))
local var_0_1 = pg.activity_random_award_item

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.awards = arg_1_1.awards or {}
	arg_1_0.prevId = arg_1_1.prevId
	arg_1_0.index = arg_1_1.index
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_random_award_template
end

function var_0_0.getComsume(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("resource_category")
	local var_3_1 = arg_3_0:getConfig("resource_type")
	local var_3_2 = arg_3_0:getConfig("resource_num")

	return {
		type = var_3_0,
		id = var_3_1,
		count = var_3_2
	}
end

function var_0_0.enoughResForUsage(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getComsume()

	if var_4_0.type == DROP_TYPE_RESOURCE then
		if getProxy(PlayerProxy):getData():getResById(var_4_0.id) < var_4_0.count * arg_4_1 then
			return false
		end
	elseif var_4_0.type == DROP_TYPE_ITEM and getProxy(BagProxy):getItemCountById(var_4_0.id) < var_4_0.count * arg_4_1 then
		return false
	end

	return true
end

function var_0_0.getItemCount(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("item_list")

	return _.reduce(var_5_0, 0, function(arg_6_0, arg_6_1)
		return arg_6_0 + arg_6_1[2]
	end)
end

function var_0_0.getleftItemCount(arg_7_0)
	return arg_7_0:getItemCount() - arg_7_0:getFetchCount()
end

function var_0_0.getFetchCount(arg_8_0)
	return _.reduce(_.values(arg_8_0.awards), 0, function(arg_9_0, arg_9_1)
		return arg_9_0 + arg_9_1
	end)
end

function var_0_0.getMainItems(arg_10_0)
	return arg_10_0:filterItems(true)
end

function var_0_0.filterItems(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getConfig("main_item")
	local var_11_1 = _.select(arg_11_0:getConfig("item_list"), function(arg_12_0)
		if arg_11_1 then
			return table.contains(var_11_0, arg_12_0[1])
		else
			return not table.contains(var_11_0, arg_12_0[1])
		end
	end)

	return (_.map(var_11_1, function(arg_13_0)
		local var_13_0 = var_0_1[arg_13_0[1]]
		local var_13_1 = arg_11_0.awards[arg_13_0[1]] or 0

		return {
			id = var_13_0.commodity_id,
			type = var_13_0.resource_category,
			count = var_13_0.num,
			surplus = arg_13_0[2] - var_13_1,
			total = arg_13_0[2]
		}
	end))
end

function var_0_0.getItems(arg_14_0)
	local var_14_0 = arg_14_0:filterItems(true)
	local var_14_1 = arg_14_0:filterItems(false)

	return var_14_0, var_14_1
end

function var_0_0.canOpenNext(arg_15_0)
	return _.all(arg_15_0:getMainItems(), function(arg_16_0)
		return arg_16_0.surplus == 0
	end)
end

return var_0_0
