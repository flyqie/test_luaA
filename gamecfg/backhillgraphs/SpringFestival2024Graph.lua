﻿local var_0_0 = {
	Points = {
		{
			x = 650.7216,
			y = -2
		},
		[8] = {
			x = -581.4284,
			y = 142
		},
		[3] = {
			x = 352.685,
			y = -90
		},
		[4] = {
			x = -45.36319,
			y = -8
		},
		[5] = {
			x = -353.4007,
			y = -202
		},
		[6] = {
			x = -119.3722,
			y = -424
		},
		[7] = {
			x = 164.6624,
			y = -346
		}
	},
	Edges = {
		["5_8"] = {
			p1 = 5,
			p2 = 8
		},
		["5_6"] = {
			p1 = 5,
			p2 = 6
		},
		["6_7"] = {
			p1 = 6,
			p2 = 7
		},
		["3_7"] = {
			p1 = 3,
			p2 = 7
		},
		["3_4"] = {
			p1 = 3,
			p2 = 4
		},
		["4_5"] = {
			p1 = 4,
			p2 = 5
		},
		["1_3"] = {
			p1 = 1,
			p2 = 3
		}
	}
}

for iter_0_0, iter_0_1 in pairs(var_0_0.Points) do
	iter_0_1.scale = 0.4
end

return var_0_0
