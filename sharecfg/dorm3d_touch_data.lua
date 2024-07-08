pg = pg or {}
pg.dorm3d_touch_data = {
	[101] = {
		trigger_area = "Default",
		char_id = 20220,
		heartbeat_action = "",
		standby_action = "",
		id = 101,
		heartbeat_talk = "",
		heartbeat_default = "",
		finish_action = "",
		stage_unlock = {
			{
				1101,
				1102,
				1103,
				1104,
				1105,
				1106,
				1107,
				1108
			},
			{},
			{}
		},
		camera_trigger = {
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			}
		}
	},
	[102] = {
		trigger_area = "Bed",
		char_id = 20220,
		heartbeat_action = "",
		standby_action = "GoToBedLStart",
		id = 102,
		heartbeat_talk = "",
		heartbeat_default = "",
		finish_action = "GoToBedLEnd",
		stage_unlock = {
			{
				1301,
				1302,
				1303,
				1304
			},
			{},
			{}
		},
		camera_trigger = {
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			}
		}
	},
	[103] = {
		trigger_area = "Chair",
		char_id = 20220,
		heartbeat_action = "",
		standby_action = "SitStart",
		id = 103,
		heartbeat_talk = "",
		heartbeat_default = "",
		finish_action = "SitEnd",
		stage_unlock = {
			{
				1201,
				1202,
				1203,
				1204
			},
			{},
			{}
		},
		camera_trigger = {
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			}
		}
	},
	[104] = {
		trigger_area = "Table",
		char_id = 20220,
		heartbeat_action = "",
		standby_action = "SitHStart",
		id = 104,
		heartbeat_talk = "",
		heartbeat_default = "",
		finish_action = "SitHEnd",
		stage_unlock = {
			{
				1401,
				1402,
				1403,
				1404
			},
			{},
			{}
		},
		camera_trigger = {
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			},
			{
				101,
				102,
				103,
				104,
				105,
				106
			}
		}
	},
	[201] = {
		trigger_area = "Default",
		char_id = 20220,
		finish_action = "",
		standby_action = "",
		id = 201,
		camera_trigger = "",
		stage_unlock = {
			{
				1101,
				1102,
				1103,
				1104,
				1105,
				1106,
				1107,
				1108
			},
			{},
			{}
		},
		heartbeat_action = {
			2101,
			2102,
			2103
		},
		heartbeat_talk = {
			1101,
			1102,
			1103
		},
		heartbeat_default = {
			{
				1201,
				1202
			},
			{
				1403,
				1404
			}
		}
	},
	[202] = {
		trigger_area = "Bed",
		char_id = 20220,
		finish_action = "GoToBedLEnd",
		standby_action = "GoToBedLStart",
		id = 202,
		camera_trigger = "",
		stage_unlock = {
			{
				1301,
				1302,
				1303,
				1304
			},
			{},
			{}
		},
		heartbeat_action = {},
		heartbeat_talk = {},
		heartbeat_default = {
			{
				1201,
				1202
			},
			{
				1403,
				1404
			}
		}
	},
	[203] = {
		trigger_area = "Chair",
		char_id = 20220,
		finish_action = "SitEnd",
		standby_action = "SitStart",
		id = 203,
		camera_trigger = "",
		stage_unlock = {
			{
				1201,
				1202,
				1203,
				1204
			},
			{},
			{}
		},
		heartbeat_action = {},
		heartbeat_talk = {},
		heartbeat_default = {
			{
				1201,
				1202
			},
			{
				1403,
				1404
			}
		}
	},
	[204] = {
		trigger_area = "Table",
		char_id = 20220,
		finish_action = "SitHEnd",
		standby_action = "SitHStart",
		id = 204,
		camera_trigger = "",
		stage_unlock = {
			{
				1401,
				1402,
				1403,
				1404
			},
			{},
			{}
		},
		heartbeat_action = {},
		heartbeat_talk = {},
		heartbeat_default = {
			{
				1201,
				1202
			},
			{
				1403,
				1404
			}
		}
	},
	get_id_list_by_char_id = {
		[20220] = {
			101,
			102,
			103,
			104,
			201,
			202,
			203,
			204
		}
	},
	all = {
		101,
		102,
		103,
		104,
		201,
		202,
		203,
		204
	}
}
