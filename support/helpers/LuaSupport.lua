﻿local var_0_0 = print

function originalPrint(...)
	if IsUnityEditor then
		local var_1_0 = _.map({
			...
		}, function(arg_2_0)
			return tostring(arg_2_0)
		end)

		var_0_0(debug.traceback(table.concat(var_1_0, " "), 2))
	else
		var_0_0(...)
	end
end

if IsUnityEditor then
	function print(...)
		local var_3_0 = _.map({
			...
		}, function(arg_4_0)
			return tostring(arg_4_0)
		end)

		var_0_0(debug.traceback(table.concat(var_3_0, " "), 2))
	end
else
	function print()
		return
	end
end

local var_0_1 = setmetatable({}, {
	__mode = "kv"
})
local var_0_2 = getmetatable(GameObject)
local var_0_3 = var_0_2.__index

function var_0_2.__index(arg_6_0, arg_6_1)
	if arg_6_1 == "transform" then
		local var_6_0 = var_0_1[arg_6_0]

		if var_6_0 then
			return var_6_0
		end

		local var_6_1 = var_0_3(arg_6_0, arg_6_1)

		var_0_1[arg_6_0] = var_6_1

		return var_6_1
	elseif arg_6_1 == "gameObject" then
		return arg_6_0
	else
		return var_0_3(arg_6_0, arg_6_1)
	end
end

local var_0_4 = setmetatable({}, {
	__mode = "kv"
})
local var_0_5 = getmetatable(Transform)
local var_0_6 = var_0_5.__index

function var_0_5.__index(arg_7_0, arg_7_1)
	if arg_7_1 == "gameObject" then
		local var_7_0 = var_0_4[arg_7_0]

		if var_7_0 then
			return var_7_0
		end

		local var_7_1 = var_0_6(arg_7_0, arg_7_1)

		var_0_4[arg_7_0] = var_7_1

		return var_7_1
	elseif arg_7_1 == "transform" then
		return arg_7_0
	else
		return var_0_6(arg_7_0, arg_7_1)
	end
end

function gcAll(arg_8_0)
	PoolMgr.GetInstance():ExcessPainting()
	ResourceMgr.Inst:unloadUnusedAssetBundles()
	GCThread.GetInstance():GC(arg_8_0)
end

function RemoveTableItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_0 do
		if arg_9_0[iter_9_0 - var_9_0] == arg_9_1 then
			table.remove(arg_9_0, iter_9_0 - var_9_0)

			if arg_9_2 then
				var_9_0 = var_9_0 + 1
			else
				break
			end
		end
	end
end

function IsNil(arg_10_0)
	return arg_10_0 == nil or arg_10_0:Equals(nil)
end

function isnan(arg_11_0)
	return arg_11_0 ~= arg_11_0
end

function GetDir(arg_12_0)
	return string.match(arg_12_0, ".*/")
end

function GetFileName(arg_13_0)
	return string.match(arg_13_0, ".*/(.*)")
end

function DumpTable(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		if iter_14_1 ~= nil then
			Debugger.Log("Key: {0}, Value: {1}", tostring(iter_14_0), tostring(iter_14_1))
		else
			Debugger.Log("Key: {0}, Value nil", tostring(iter_14_0))
		end
	end
end

function PrintTable(arg_15_0)
	local var_15_0 = {}

	local function var_15_1(arg_16_0, arg_16_1, arg_16_2)
		for iter_16_0, iter_16_1 in pairs(arg_16_0) do
			if type(iter_16_1) == "table" then
				table.insert(arg_16_1, arg_16_2 .. tostring(iter_16_0) .. ":\n")
				var_15_1(iter_16_1, arg_16_1, arg_16_2 .. " ")
			else
				table.insert(arg_16_1, arg_16_2 .. tostring(iter_16_0) .. ": " .. tostring(iter_16_1) .. "\n")
			end
		end
	end

	var_15_1(arg_15_0, var_15_0, "")

	return table.concat(var_15_0, "")
end

function PrintLua(arg_17_0, arg_17_1)
	local var_17_0

	arg_17_1 = arg_17_1 or _G

	for iter_17_0 in string.gmatch(arg_17_0, "%w+") do
		arg_17_1 = arg_17_1[iter_17_0]
	end

	local var_17_1 = arg_17_1

	if var_17_1 == nil then
		Debugger.Log("Lua Module {0} not exists", arg_17_0)

		return
	end

	Debugger.Log("-----------------Dump Table {0}-----------------", arg_17_0)

	if type(var_17_1) == "table" then
		for iter_17_1, iter_17_2 in pairs(var_17_1) do
			Debugger.Log("Key: {0}, Value: {1}", iter_17_1, tostring(iter_17_2))
		end
	end

	local var_17_2 = getmetatable(var_17_1)

	Debugger.Log("-----------------Dump meta {0}-----------------", arg_17_0)

	while var_17_2 ~= nil and var_17_2 ~= var_17_1 do
		for iter_17_3, iter_17_4 in pairs(var_17_2) do
			if iter_17_3 ~= nil then
				Debugger.Log("Key: {0}, Value: {1}", tostring(iter_17_3), tostring(iter_17_4))
			end
		end

		var_17_2 = getmetatable(var_17_2)
	end

	Debugger.Log("-----------------Dump meta Over-----------------")
	Debugger.Log("-----------------Dump Table Over-----------------")
end

function IsString(arg_18_0)
	return type(arg_18_0) == "string"
end

function IsNumber(arg_19_0)
	return type(arg_19_0) == "number"
end

function tobool(arg_20_0)
	return arg_20_0 and true or false
end

function warning(...)
	if IsUnityEditor then
		local var_21_0 = _.map({
			...
		}, function(arg_22_0)
			return tostring(arg_22_0)
		end)

		Debugger.LogWarning(debug.traceback(table.concat(var_21_0, " "), 2))
	else
		Debugger.LogWarning(...)
	end
end

function errorMsg(...)
	if IsUnityEditor then
		local var_23_0 = _.map({
			...
		}, function(arg_24_0)
			return tostring(arg_24_0)
		end)

		Debugger.LogError(debug.traceback(table.concat(var_23_0, " "), 2))
	else
		Debugger.LogError(...)
	end
end

function BuildVector3(arg_25_0)
	return Vector3(arg_25_0[1], arg_25_0[2], arg_25_0[3])
end

function ShowFuncInfo(arg_26_0)
	local var_26_0 = debug.getinfo(arg_26_0)

	return string.format("file:%s#%d", var_26_0.source, var_26_0.linedefined)
end

function String2Table(arg_27_0)
	local var_27_0 = {}

	for iter_27_0 in arg_27_0:gmatch(".") do
		table.insert(var_27_0, iter_27_0)
	end

	return var_27_0
end

local var_0_7 = require("bit")

function unicode_to_utf8(arg_28_0)
	if type(arg_28_0) ~= "string" then
		return arg_28_0
	end

	local var_28_0 = ""
	local var_28_1 = 1

	while true do
		local var_28_2 = string.byte(arg_28_0, var_28_1)
		local var_28_3

		if var_28_2 ~= nil and string.sub(arg_28_0, var_28_1, var_28_1 + 1) == "\\u" then
			var_28_3 = tonumber("0x" .. string.sub(arg_28_0, var_28_1 + 2, var_28_1 + 5))
			var_28_1 = var_28_1 + 6
		elseif var_28_2 ~= nil then
			var_28_3 = var_28_2
			var_28_1 = var_28_1 + 1
		else
			break
		end

		if var_28_3 <= 127 then
			var_28_0 = var_28_0 .. string.char(var_0_7.band(var_28_3, 127))
		elseif var_28_3 >= 128 and var_28_3 <= 2047 then
			var_28_0 = var_28_0 .. string.char(var_0_7.bor(192, var_0_7.band(var_0_7.rshift(var_28_3, 6), 31)))
			var_28_0 = var_28_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_28_3, 63)))
		elseif var_28_3 >= 2048 and var_28_3 <= 65535 then
			var_28_0 = var_28_0 .. string.char(var_0_7.bor(224, var_0_7.band(var_0_7.rshift(var_28_3, 12), 15)))
			var_28_0 = var_28_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_0_7.rshift(var_28_3, 6), 63)))
			var_28_0 = var_28_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_28_3, 63)))
		end
	end

	return var_28_0 .. "\x00"
end

function utf8_to_unicode(arg_29_0)
	if type(arg_29_0) ~= "string" then
		return arg_29_0
	end

	local var_29_0 = ""
	local var_29_1 = 1
	local var_29_2 = string.byte(arg_29_0, var_29_1)
	local var_29_3 = 0

	while var_29_2 ~= nil do
		local var_29_4
		local var_29_5

		if var_29_2 >= 0 and var_29_2 <= 127 then
			var_29_4 = var_29_2
			var_29_5 = 0
		elseif var_0_7.band(var_29_2, 224) == 192 then
			local var_29_6 = 0
			local var_29_7 = 0
			local var_29_8 = var_0_7.band(var_29_2, var_0_7.rshift(255, 3))

			var_29_1 = var_29_1 + 1
			var_29_2 = string.byte(arg_29_0, var_29_1)

			local var_29_9 = var_0_7.band(var_29_2, var_0_7.rshift(255, 2))

			var_29_4 = var_0_7.bor(var_29_9, var_0_7.lshift(var_0_7.band(var_29_8, var_0_7.rshift(255, 6)), 6))
			var_29_5 = var_0_7.rshift(var_29_8, 2)
		elseif var_0_7.band(var_29_2, 240) == 224 then
			local var_29_10 = 0
			local var_29_11 = 0
			local var_29_12 = 0
			local var_29_13 = var_0_7.band(var_29_2, var_0_7.rshift(255, 3))

			var_29_1 = var_29_1 + 1
			var_29_2 = string.byte(arg_29_0, var_29_1)

			local var_29_14 = var_0_7.band(var_29_2, var_0_7.rshift(255, 2))

			var_29_1 = var_29_1 + 1
			var_29_2 = string.byte(arg_29_0, var_29_1)

			local var_29_15 = var_0_7.band(var_29_2, var_0_7.rshift(255, 2))

			var_29_4 = var_0_7.bor(var_0_7.lshift(var_0_7.band(var_29_14, var_0_7.rshift(255, 6)), 6), var_29_15)
			var_29_5 = var_0_7.bor(var_0_7.lshift(var_29_13, 4), var_0_7.rshift(var_29_14, 2))
		end

		var_29_0 = var_29_0 .. string.format("\\u%02x%02x", var_29_5, var_29_4)

		if var_29_5 == 0 then
			var_29_3 = var_29_3 + 1
		else
			var_29_3 = var_29_3 + 2
		end

		var_29_1 = var_29_1 + 1
		var_29_2 = string.byte(arg_29_0, var_29_1)
	end

	return var_29_0, var_29_3
end

function utf8_size(arg_30_0)
	if not arg_30_0 then
		return 0
	elseif arg_30_0 > 240 then
		return 4
	elseif arg_30_0 > 225 then
		return 3
	elseif arg_30_0 > 192 then
		return 2
	else
		return 1
	end
end

function utf8_len(arg_31_0)
	local var_31_0 = 1
	local var_31_1 = 0
	local var_31_2 = #arg_31_0

	while var_31_0 <= var_31_2 do
		local var_31_3 = string.byte(arg_31_0, var_31_0)

		var_31_0 = var_31_0 + utf8_size(var_31_3)
		var_31_1 = var_31_1 + 1
	end

	return var_31_1
end

function existCall(arg_32_0, ...)
	if arg_32_0 and type(arg_32_0) == "function" then
		return arg_32_0(...)
	end
end

function packEx(...)
	return {
		len = select("#", ...),
		...
	}
end

function unpackEx(arg_34_0)
	return unpack(arg_34_0, 1, arg_34_0.len)
end

function envFunc(arg_35_0, arg_35_1, ...)
	assert(type(arg_35_0) == "table")

	local var_35_0 = getfenv(arg_35_1)

	warning(var_35_0 == _G)
	setfenv(arg_35_1, setmetatable({}, {
		__index = function(arg_36_0, arg_36_1)
			if arg_35_0[arg_36_1] ~= nil then
				return arg_35_0[arg_36_1]
			else
				return var_35_0[arg_36_1]
			end
		end,
		__newindex = function(arg_37_0, arg_37_1, arg_37_2)
			arg_35_0[arg_37_1] = arg_37_2
		end
	}))

	local var_35_1 = packEx(arg_35_1(...))

	setfenv(arg_35_1, var_35_0)

	return unpackEx(var_35_1)
end
