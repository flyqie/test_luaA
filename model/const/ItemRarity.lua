local var_0_0 = class("ItemRarity")

var_0_0.Gray = 1
var_0_0.Blue = 2
var_0_0.Purple = 3
var_0_0.Gold = 4
var_0_0.SSR = 5

function var_0_0.Rarity2Print(arg_1_0)
	if math.clamp(arg_1_0, 1, 9) == arg_1_0 then
		return tostring(arg_1_0)
	else
		return var_0_0.Gray
	end
end

var_0_0.colors = {
	"FFFFFFFF",
	"41D7FFFF",
	"CC7BFFFF",
	"FDC637FF",
	"FF5E39FF",
	"FFFFFFFF",
	"FDC637FF",
	"FFFFFFFF",
	"FDC637FF"
}

function var_0_0.Rarity2HexColor(arg_2_0)
	return var_0_0.colors[arg_2_0]
end

return var_0_0
