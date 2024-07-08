﻿local var_0_0 = require("protobuf")
local var_0_1 = require("common_pb")

module("p18_pb")

local var_0_2 = {}

CS_18001 = var_0_0.Descriptor()
var_0_2.CS_18001_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_18002 = var_0_0.Descriptor()
var_0_2.SC_18002_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_FIGHT_COUNT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18002_TARGET_LIST_FIELD = var_0_0.FieldDescriptor()
CS_18003 = var_0_0.Descriptor()
var_0_2.CS_18003_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_18004 = var_0_0.Descriptor()
var_0_2.SC_18004_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18004_TARGET_LIST_FIELD = var_0_0.FieldDescriptor()
SC_18005 = var_0_0.Descriptor()
var_0_2.SC_18005_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18005_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18005_TARGET_LIST_FIELD = var_0_0.FieldDescriptor()
CS_18006 = var_0_0.Descriptor()
var_0_2.CS_18006_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_18007 = var_0_0.Descriptor()
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD = var_0_0.FieldDescriptor()
CS_18008 = var_0_0.Descriptor()
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD = var_0_0.FieldDescriptor()
SC_18009 = var_0_0.Descriptor()
var_0_2.SC_18009_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_18100 = var_0_0.Descriptor()
var_0_2.CS_18100_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_18101 = var_0_0.Descriptor()
var_0_2.SC_18101_FLASH_COUNT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD = var_0_0.FieldDescriptor()
CS_18102 = var_0_0.Descriptor()
var_0_2.CS_18102_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_18103 = var_0_0.Descriptor()
var_0_2.SC_18103_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD = var_0_0.FieldDescriptor()
CS_18104 = var_0_0.Descriptor()
var_0_2.CS_18104_ID_FIELD = var_0_0.FieldDescriptor()
SC_18105 = var_0_0.Descriptor()
var_0_2.SC_18105_INFO_FIELD = var_0_0.FieldDescriptor()
CS_18201 = var_0_0.Descriptor()
var_0_2.CS_18201_PAGE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_18201_TYPE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_18201_ACT_ID_FIELD = var_0_0.FieldDescriptor()
SC_18202 = var_0_0.Descriptor()
var_0_2.SC_18202_LIST_FIELD = var_0_0.FieldDescriptor()
CS_18203 = var_0_0.Descriptor()
var_0_2.CS_18203_TYPE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_18203_ACT_ID_FIELD = var_0_0.FieldDescriptor()
SC_18204 = var_0_0.Descriptor()
var_0_2.SC_18204_POINT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_18204_RANK_FIELD = var_0_0.FieldDescriptor()
TARGETINFO = var_0_0.Descriptor()
var_0_2.TARGETINFO_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_NAME_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.TARGETINFO_DISPLAY_FIELD = var_0_0.FieldDescriptor()
ARENARANK = var_0_0.Descriptor()
var_0_2.ARENARANK_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.ARENARANK_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.ARENARANK_NAME_FIELD = var_0_0.FieldDescriptor()
var_0_2.ARENARANK_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.ARENARANK_DISPLAY_FIELD = var_0_0.FieldDescriptor()
ARENASHOP = var_0_0.Descriptor()
var_0_2.ARENASHOP_SHOP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.ARENASHOP_COUNT_FIELD = var_0_0.FieldDescriptor()
RANK_INFO = var_0_0.Descriptor()
var_0_2.RANK_INFO_USER_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.RANK_INFO_POINT_FIELD = var_0_0.FieldDescriptor()
var_0_2.RANK_INFO_NAME_FIELD = var_0_0.FieldDescriptor()
var_0_2.RANK_INFO_LV_FIELD = var_0_0.FieldDescriptor()
var_0_2.RANK_INFO_ARENA_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.RANK_INFO_DISPLAY_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_18001_TYPE_FIELD.name = "type"
var_0_2.CS_18001_TYPE_FIELD.full_name = "p18.cs_18001.type"
var_0_2.CS_18001_TYPE_FIELD.number = 1
var_0_2.CS_18001_TYPE_FIELD.index = 0
var_0_2.CS_18001_TYPE_FIELD.label = 2
var_0_2.CS_18001_TYPE_FIELD.has_default_value = false
var_0_2.CS_18001_TYPE_FIELD.default_value = 0
var_0_2.CS_18001_TYPE_FIELD.type = 13
var_0_2.CS_18001_TYPE_FIELD.cpp_type = 3
CS_18001.name = "cs_18001"
CS_18001.full_name = "p18.cs_18001"
CS_18001.nested_types = {}
CS_18001.enum_types = {}
CS_18001.fields = {
	var_0_2.CS_18001_TYPE_FIELD
}
CS_18001.is_extendable = false
CS_18001.extensions = {}
var_0_2.SC_18002_SCORE_FIELD.name = "score"
var_0_2.SC_18002_SCORE_FIELD.full_name = "p18.sc_18002.score"
var_0_2.SC_18002_SCORE_FIELD.number = 1
var_0_2.SC_18002_SCORE_FIELD.index = 0
var_0_2.SC_18002_SCORE_FIELD.label = 2
var_0_2.SC_18002_SCORE_FIELD.has_default_value = false
var_0_2.SC_18002_SCORE_FIELD.default_value = 0
var_0_2.SC_18002_SCORE_FIELD.type = 13
var_0_2.SC_18002_SCORE_FIELD.cpp_type = 3
var_0_2.SC_18002_RANK_FIELD.name = "rank"
var_0_2.SC_18002_RANK_FIELD.full_name = "p18.sc_18002.rank"
var_0_2.SC_18002_RANK_FIELD.number = 2
var_0_2.SC_18002_RANK_FIELD.index = 1
var_0_2.SC_18002_RANK_FIELD.label = 2
var_0_2.SC_18002_RANK_FIELD.has_default_value = false
var_0_2.SC_18002_RANK_FIELD.default_value = 0
var_0_2.SC_18002_RANK_FIELD.type = 13
var_0_2.SC_18002_RANK_FIELD.cpp_type = 3
var_0_2.SC_18002_FIGHT_COUNT_FIELD.name = "fight_count"
var_0_2.SC_18002_FIGHT_COUNT_FIELD.full_name = "p18.sc_18002.fight_count"
var_0_2.SC_18002_FIGHT_COUNT_FIELD.number = 3
var_0_2.SC_18002_FIGHT_COUNT_FIELD.index = 2
var_0_2.SC_18002_FIGHT_COUNT_FIELD.label = 2
var_0_2.SC_18002_FIGHT_COUNT_FIELD.has_default_value = false
var_0_2.SC_18002_FIGHT_COUNT_FIELD.default_value = 0
var_0_2.SC_18002_FIGHT_COUNT_FIELD.type = 13
var_0_2.SC_18002_FIGHT_COUNT_FIELD.cpp_type = 3
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.name = "fight_count_reset_time"
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.full_name = "p18.sc_18002.fight_count_reset_time"
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.number = 4
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.index = 3
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.label = 2
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.has_default_value = false
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.default_value = 0
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.type = 13
var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD.cpp_type = 3
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.name = "flash_target_count"
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.full_name = "p18.sc_18002.flash_target_count"
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.number = 5
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.index = 4
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.label = 2
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.has_default_value = false
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.default_value = 0
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.type = 13
var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD.cpp_type = 3
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.name = "vanguard_ship_id_list"
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.full_name = "p18.sc_18002.vanguard_ship_id_list"
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.number = 6
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.index = 5
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.label = 3
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.has_default_value = false
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.default_value = {}
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.type = 13
var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD.cpp_type = 3
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.name = "main_ship_id_list"
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.full_name = "p18.sc_18002.main_ship_id_list"
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.number = 7
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.index = 6
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.label = 3
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.has_default_value = false
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.default_value = {}
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.type = 13
var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD.cpp_type = 3
var_0_2.SC_18002_TARGET_LIST_FIELD.name = "target_list"
var_0_2.SC_18002_TARGET_LIST_FIELD.full_name = "p18.sc_18002.target_list"
var_0_2.SC_18002_TARGET_LIST_FIELD.number = 8
var_0_2.SC_18002_TARGET_LIST_FIELD.index = 7
var_0_2.SC_18002_TARGET_LIST_FIELD.label = 3
var_0_2.SC_18002_TARGET_LIST_FIELD.has_default_value = false
var_0_2.SC_18002_TARGET_LIST_FIELD.default_value = {}
var_0_2.SC_18002_TARGET_LIST_FIELD.message_type = TARGETINFO
var_0_2.SC_18002_TARGET_LIST_FIELD.type = 11
var_0_2.SC_18002_TARGET_LIST_FIELD.cpp_type = 10
SC_18002.name = "sc_18002"
SC_18002.full_name = "p18.sc_18002"
SC_18002.nested_types = {}
SC_18002.enum_types = {}
SC_18002.fields = {
	var_0_2.SC_18002_SCORE_FIELD,
	var_0_2.SC_18002_RANK_FIELD,
	var_0_2.SC_18002_FIGHT_COUNT_FIELD,
	var_0_2.SC_18002_FIGHT_COUNT_RESET_TIME_FIELD,
	var_0_2.SC_18002_FLASH_TARGET_COUNT_FIELD,
	var_0_2.SC_18002_VANGUARD_SHIP_ID_LIST_FIELD,
	var_0_2.SC_18002_MAIN_SHIP_ID_LIST_FIELD,
	var_0_2.SC_18002_TARGET_LIST_FIELD
}
SC_18002.is_extendable = false
SC_18002.extensions = {}
var_0_2.CS_18003_TYPE_FIELD.name = "type"
var_0_2.CS_18003_TYPE_FIELD.full_name = "p18.cs_18003.type"
var_0_2.CS_18003_TYPE_FIELD.number = 1
var_0_2.CS_18003_TYPE_FIELD.index = 0
var_0_2.CS_18003_TYPE_FIELD.label = 2
var_0_2.CS_18003_TYPE_FIELD.has_default_value = false
var_0_2.CS_18003_TYPE_FIELD.default_value = 0
var_0_2.CS_18003_TYPE_FIELD.type = 13
var_0_2.CS_18003_TYPE_FIELD.cpp_type = 3
CS_18003.name = "cs_18003"
CS_18003.full_name = "p18.cs_18003"
CS_18003.nested_types = {}
CS_18003.enum_types = {}
CS_18003.fields = {
	var_0_2.CS_18003_TYPE_FIELD
}
CS_18003.is_extendable = false
CS_18003.extensions = {}
var_0_2.SC_18004_RESULT_FIELD.name = "result"
var_0_2.SC_18004_RESULT_FIELD.full_name = "p18.sc_18004.result"
var_0_2.SC_18004_RESULT_FIELD.number = 1
var_0_2.SC_18004_RESULT_FIELD.index = 0
var_0_2.SC_18004_RESULT_FIELD.label = 2
var_0_2.SC_18004_RESULT_FIELD.has_default_value = false
var_0_2.SC_18004_RESULT_FIELD.default_value = 0
var_0_2.SC_18004_RESULT_FIELD.type = 13
var_0_2.SC_18004_RESULT_FIELD.cpp_type = 3
var_0_2.SC_18004_TARGET_LIST_FIELD.name = "target_list"
var_0_2.SC_18004_TARGET_LIST_FIELD.full_name = "p18.sc_18004.target_list"
var_0_2.SC_18004_TARGET_LIST_FIELD.number = 2
var_0_2.SC_18004_TARGET_LIST_FIELD.index = 1
var_0_2.SC_18004_TARGET_LIST_FIELD.label = 3
var_0_2.SC_18004_TARGET_LIST_FIELD.has_default_value = false
var_0_2.SC_18004_TARGET_LIST_FIELD.default_value = {}
var_0_2.SC_18004_TARGET_LIST_FIELD.message_type = TARGETINFO
var_0_2.SC_18004_TARGET_LIST_FIELD.type = 11
var_0_2.SC_18004_TARGET_LIST_FIELD.cpp_type = 10
SC_18004.name = "sc_18004"
SC_18004.full_name = "p18.sc_18004"
SC_18004.nested_types = {}
SC_18004.enum_types = {}
SC_18004.fields = {
	var_0_2.SC_18004_RESULT_FIELD,
	var_0_2.SC_18004_TARGET_LIST_FIELD
}
SC_18004.is_extendable = false
SC_18004.extensions = {}
var_0_2.SC_18005_SCORE_FIELD.name = "score"
var_0_2.SC_18005_SCORE_FIELD.full_name = "p18.sc_18005.score"
var_0_2.SC_18005_SCORE_FIELD.number = 1
var_0_2.SC_18005_SCORE_FIELD.index = 0
var_0_2.SC_18005_SCORE_FIELD.label = 2
var_0_2.SC_18005_SCORE_FIELD.has_default_value = false
var_0_2.SC_18005_SCORE_FIELD.default_value = 0
var_0_2.SC_18005_SCORE_FIELD.type = 13
var_0_2.SC_18005_SCORE_FIELD.cpp_type = 3
var_0_2.SC_18005_RANK_FIELD.name = "rank"
var_0_2.SC_18005_RANK_FIELD.full_name = "p18.sc_18005.rank"
var_0_2.SC_18005_RANK_FIELD.number = 2
var_0_2.SC_18005_RANK_FIELD.index = 1
var_0_2.SC_18005_RANK_FIELD.label = 2
var_0_2.SC_18005_RANK_FIELD.has_default_value = false
var_0_2.SC_18005_RANK_FIELD.default_value = 0
var_0_2.SC_18005_RANK_FIELD.type = 13
var_0_2.SC_18005_RANK_FIELD.cpp_type = 3
var_0_2.SC_18005_TARGET_LIST_FIELD.name = "target_list"
var_0_2.SC_18005_TARGET_LIST_FIELD.full_name = "p18.sc_18005.target_list"
var_0_2.SC_18005_TARGET_LIST_FIELD.number = 3
var_0_2.SC_18005_TARGET_LIST_FIELD.index = 2
var_0_2.SC_18005_TARGET_LIST_FIELD.label = 3
var_0_2.SC_18005_TARGET_LIST_FIELD.has_default_value = false
var_0_2.SC_18005_TARGET_LIST_FIELD.default_value = {}
var_0_2.SC_18005_TARGET_LIST_FIELD.message_type = TARGETINFO
var_0_2.SC_18005_TARGET_LIST_FIELD.type = 11
var_0_2.SC_18005_TARGET_LIST_FIELD.cpp_type = 10
SC_18005.name = "sc_18005"
SC_18005.full_name = "p18.sc_18005"
SC_18005.nested_types = {}
SC_18005.enum_types = {}
SC_18005.fields = {
	var_0_2.SC_18005_SCORE_FIELD,
	var_0_2.SC_18005_RANK_FIELD,
	var_0_2.SC_18005_TARGET_LIST_FIELD
}
SC_18005.is_extendable = false
SC_18005.extensions = {}
var_0_2.CS_18006_TYPE_FIELD.name = "type"
var_0_2.CS_18006_TYPE_FIELD.full_name = "p18.cs_18006.type"
var_0_2.CS_18006_TYPE_FIELD.number = 1
var_0_2.CS_18006_TYPE_FIELD.index = 0
var_0_2.CS_18006_TYPE_FIELD.label = 2
var_0_2.CS_18006_TYPE_FIELD.has_default_value = false
var_0_2.CS_18006_TYPE_FIELD.default_value = 0
var_0_2.CS_18006_TYPE_FIELD.type = 13
var_0_2.CS_18006_TYPE_FIELD.cpp_type = 3
CS_18006.name = "cs_18006"
CS_18006.full_name = "p18.cs_18006"
CS_18006.nested_types = {}
CS_18006.enum_types = {}
CS_18006.fields = {
	var_0_2.CS_18006_TYPE_FIELD
}
CS_18006.is_extendable = false
CS_18006.extensions = {}
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.name = "arena_rank_lsit"
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.full_name = "p18.sc_18007.arena_rank_lsit"
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.number = 1
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.index = 0
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.label = 3
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.has_default_value = false
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.default_value = {}
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.message_type = ARENARANK
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.type = 11
var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD.cpp_type = 10
SC_18007.name = "sc_18007"
SC_18007.full_name = "p18.sc_18007"
SC_18007.nested_types = {}
SC_18007.enum_types = {}
SC_18007.fields = {
	var_0_2.SC_18007_ARENA_RANK_LSIT_FIELD
}
SC_18007.is_extendable = false
SC_18007.extensions = {}
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.name = "vanguard_ship_id_list"
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.full_name = "p18.cs_18008.vanguard_ship_id_list"
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.number = 1
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.index = 0
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.label = 3
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.has_default_value = false
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.default_value = {}
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.type = 13
var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD.cpp_type = 3
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.name = "main_ship_id_list"
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.full_name = "p18.cs_18008.main_ship_id_list"
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.number = 2
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.index = 1
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.label = 3
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.has_default_value = false
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.default_value = {}
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.type = 13
var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD.cpp_type = 3
CS_18008.name = "cs_18008"
CS_18008.full_name = "p18.cs_18008"
CS_18008.nested_types = {}
CS_18008.enum_types = {}
CS_18008.fields = {
	var_0_2.CS_18008_VANGUARD_SHIP_ID_LIST_FIELD,
	var_0_2.CS_18008_MAIN_SHIP_ID_LIST_FIELD
}
CS_18008.is_extendable = false
CS_18008.extensions = {}
var_0_2.SC_18009_RESULT_FIELD.name = "result"
var_0_2.SC_18009_RESULT_FIELD.full_name = "p18.sc_18009.result"
var_0_2.SC_18009_RESULT_FIELD.number = 1
var_0_2.SC_18009_RESULT_FIELD.index = 0
var_0_2.SC_18009_RESULT_FIELD.label = 2
var_0_2.SC_18009_RESULT_FIELD.has_default_value = false
var_0_2.SC_18009_RESULT_FIELD.default_value = 0
var_0_2.SC_18009_RESULT_FIELD.type = 13
var_0_2.SC_18009_RESULT_FIELD.cpp_type = 3
SC_18009.name = "sc_18009"
SC_18009.full_name = "p18.sc_18009"
SC_18009.nested_types = {}
SC_18009.enum_types = {}
SC_18009.fields = {
	var_0_2.SC_18009_RESULT_FIELD
}
SC_18009.is_extendable = false
SC_18009.extensions = {}
var_0_2.CS_18100_TYPE_FIELD.name = "type"
var_0_2.CS_18100_TYPE_FIELD.full_name = "p18.cs_18100.type"
var_0_2.CS_18100_TYPE_FIELD.number = 1
var_0_2.CS_18100_TYPE_FIELD.index = 0
var_0_2.CS_18100_TYPE_FIELD.label = 2
var_0_2.CS_18100_TYPE_FIELD.has_default_value = false
var_0_2.CS_18100_TYPE_FIELD.default_value = 0
var_0_2.CS_18100_TYPE_FIELD.type = 13
var_0_2.CS_18100_TYPE_FIELD.cpp_type = 3
CS_18100.name = "cs_18100"
CS_18100.full_name = "p18.cs_18100"
CS_18100.nested_types = {}
CS_18100.enum_types = {}
CS_18100.fields = {
	var_0_2.CS_18100_TYPE_FIELD
}
CS_18100.is_extendable = false
CS_18100.extensions = {}
var_0_2.SC_18101_FLASH_COUNT_FIELD.name = "flash_count"
var_0_2.SC_18101_FLASH_COUNT_FIELD.full_name = "p18.sc_18101.flash_count"
var_0_2.SC_18101_FLASH_COUNT_FIELD.number = 1
var_0_2.SC_18101_FLASH_COUNT_FIELD.index = 0
var_0_2.SC_18101_FLASH_COUNT_FIELD.label = 2
var_0_2.SC_18101_FLASH_COUNT_FIELD.has_default_value = false
var_0_2.SC_18101_FLASH_COUNT_FIELD.default_value = 0
var_0_2.SC_18101_FLASH_COUNT_FIELD.type = 13
var_0_2.SC_18101_FLASH_COUNT_FIELD.cpp_type = 3
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.name = "arena_shop_list"
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.full_name = "p18.sc_18101.arena_shop_list"
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.number = 2
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.index = 1
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.label = 3
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.has_default_value = false
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.default_value = {}
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.message_type = ARENASHOP
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.type = 11
var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD.cpp_type = 10
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.name = "next_flash_time"
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.full_name = "p18.sc_18101.next_flash_time"
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.number = 3
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.index = 2
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.label = 2
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.has_default_value = false
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.default_value = 0
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.type = 13
var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD.cpp_type = 3
SC_18101.name = "sc_18101"
SC_18101.full_name = "p18.sc_18101"
SC_18101.nested_types = {}
SC_18101.enum_types = {}
SC_18101.fields = {
	var_0_2.SC_18101_FLASH_COUNT_FIELD,
	var_0_2.SC_18101_ARENA_SHOP_LIST_FIELD,
	var_0_2.SC_18101_NEXT_FLASH_TIME_FIELD
}
SC_18101.is_extendable = false
SC_18101.extensions = {}
var_0_2.CS_18102_TYPE_FIELD.name = "type"
var_0_2.CS_18102_TYPE_FIELD.full_name = "p18.cs_18102.type"
var_0_2.CS_18102_TYPE_FIELD.number = 1
var_0_2.CS_18102_TYPE_FIELD.index = 0
var_0_2.CS_18102_TYPE_FIELD.label = 2
var_0_2.CS_18102_TYPE_FIELD.has_default_value = false
var_0_2.CS_18102_TYPE_FIELD.default_value = 0
var_0_2.CS_18102_TYPE_FIELD.type = 13
var_0_2.CS_18102_TYPE_FIELD.cpp_type = 3
CS_18102.name = "cs_18102"
CS_18102.full_name = "p18.cs_18102"
CS_18102.nested_types = {}
CS_18102.enum_types = {}
CS_18102.fields = {
	var_0_2.CS_18102_TYPE_FIELD
}
CS_18102.is_extendable = false
CS_18102.extensions = {}
var_0_2.SC_18103_RESULT_FIELD.name = "result"
var_0_2.SC_18103_RESULT_FIELD.full_name = "p18.sc_18103.result"
var_0_2.SC_18103_RESULT_FIELD.number = 1
var_0_2.SC_18103_RESULT_FIELD.index = 0
var_0_2.SC_18103_RESULT_FIELD.label = 2
var_0_2.SC_18103_RESULT_FIELD.has_default_value = false
var_0_2.SC_18103_RESULT_FIELD.default_value = 0
var_0_2.SC_18103_RESULT_FIELD.type = 13
var_0_2.SC_18103_RESULT_FIELD.cpp_type = 3
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.name = "arena_shop_list"
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.full_name = "p18.sc_18103.arena_shop_list"
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.number = 2
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.index = 1
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.label = 3
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.has_default_value = false
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.default_value = {}
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.message_type = ARENASHOP
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.type = 11
var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD.cpp_type = 10
SC_18103.name = "sc_18103"
SC_18103.full_name = "p18.sc_18103"
SC_18103.nested_types = {}
SC_18103.enum_types = {}
SC_18103.fields = {
	var_0_2.SC_18103_RESULT_FIELD,
	var_0_2.SC_18103_ARENA_SHOP_LIST_FIELD
}
SC_18103.is_extendable = false
SC_18103.extensions = {}
var_0_2.CS_18104_ID_FIELD.name = "id"
var_0_2.CS_18104_ID_FIELD.full_name = "p18.cs_18104.id"
var_0_2.CS_18104_ID_FIELD.number = 1
var_0_2.CS_18104_ID_FIELD.index = 0
var_0_2.CS_18104_ID_FIELD.label = 2
var_0_2.CS_18104_ID_FIELD.has_default_value = false
var_0_2.CS_18104_ID_FIELD.default_value = 0
var_0_2.CS_18104_ID_FIELD.type = 13
var_0_2.CS_18104_ID_FIELD.cpp_type = 3
CS_18104.name = "cs_18104"
CS_18104.full_name = "p18.cs_18104"
CS_18104.nested_types = {}
CS_18104.enum_types = {}
CS_18104.fields = {
	var_0_2.CS_18104_ID_FIELD
}
CS_18104.is_extendable = false
CS_18104.extensions = {}
var_0_2.SC_18105_INFO_FIELD.name = "info"
var_0_2.SC_18105_INFO_FIELD.full_name = "p18.sc_18105.info"
var_0_2.SC_18105_INFO_FIELD.number = 1
var_0_2.SC_18105_INFO_FIELD.index = 0
var_0_2.SC_18105_INFO_FIELD.label = 2
var_0_2.SC_18105_INFO_FIELD.has_default_value = false
var_0_2.SC_18105_INFO_FIELD.default_value = nil
var_0_2.SC_18105_INFO_FIELD.message_type = TARGETINFO
var_0_2.SC_18105_INFO_FIELD.type = 11
var_0_2.SC_18105_INFO_FIELD.cpp_type = 10
SC_18105.name = "sc_18105"
SC_18105.full_name = "p18.sc_18105"
SC_18105.nested_types = {}
SC_18105.enum_types = {}
SC_18105.fields = {
	var_0_2.SC_18105_INFO_FIELD
}
SC_18105.is_extendable = false
SC_18105.extensions = {}
var_0_2.CS_18201_PAGE_FIELD.name = "page"
var_0_2.CS_18201_PAGE_FIELD.full_name = "p18.cs_18201.page"
var_0_2.CS_18201_PAGE_FIELD.number = 1
var_0_2.CS_18201_PAGE_FIELD.index = 0
var_0_2.CS_18201_PAGE_FIELD.label = 2
var_0_2.CS_18201_PAGE_FIELD.has_default_value = false
var_0_2.CS_18201_PAGE_FIELD.default_value = 0
var_0_2.CS_18201_PAGE_FIELD.type = 13
var_0_2.CS_18201_PAGE_FIELD.cpp_type = 3
var_0_2.CS_18201_TYPE_FIELD.name = "type"
var_0_2.CS_18201_TYPE_FIELD.full_name = "p18.cs_18201.type"
var_0_2.CS_18201_TYPE_FIELD.number = 2
var_0_2.CS_18201_TYPE_FIELD.index = 1
var_0_2.CS_18201_TYPE_FIELD.label = 2
var_0_2.CS_18201_TYPE_FIELD.has_default_value = false
var_0_2.CS_18201_TYPE_FIELD.default_value = 0
var_0_2.CS_18201_TYPE_FIELD.type = 13
var_0_2.CS_18201_TYPE_FIELD.cpp_type = 3
var_0_2.CS_18201_ACT_ID_FIELD.name = "act_id"
var_0_2.CS_18201_ACT_ID_FIELD.full_name = "p18.cs_18201.act_id"
var_0_2.CS_18201_ACT_ID_FIELD.number = 3
var_0_2.CS_18201_ACT_ID_FIELD.index = 2
var_0_2.CS_18201_ACT_ID_FIELD.label = 1
var_0_2.CS_18201_ACT_ID_FIELD.has_default_value = false
var_0_2.CS_18201_ACT_ID_FIELD.default_value = 0
var_0_2.CS_18201_ACT_ID_FIELD.type = 13
var_0_2.CS_18201_ACT_ID_FIELD.cpp_type = 3
CS_18201.name = "cs_18201"
CS_18201.full_name = "p18.cs_18201"
CS_18201.nested_types = {}
CS_18201.enum_types = {}
CS_18201.fields = {
	var_0_2.CS_18201_PAGE_FIELD,
	var_0_2.CS_18201_TYPE_FIELD,
	var_0_2.CS_18201_ACT_ID_FIELD
}
CS_18201.is_extendable = false
CS_18201.extensions = {}
var_0_2.SC_18202_LIST_FIELD.name = "list"
var_0_2.SC_18202_LIST_FIELD.full_name = "p18.sc_18202.list"
var_0_2.SC_18202_LIST_FIELD.number = 1
var_0_2.SC_18202_LIST_FIELD.index = 0
var_0_2.SC_18202_LIST_FIELD.label = 3
var_0_2.SC_18202_LIST_FIELD.has_default_value = false
var_0_2.SC_18202_LIST_FIELD.default_value = {}
var_0_2.SC_18202_LIST_FIELD.message_type = RANK_INFO
var_0_2.SC_18202_LIST_FIELD.type = 11
var_0_2.SC_18202_LIST_FIELD.cpp_type = 10
SC_18202.name = "sc_18202"
SC_18202.full_name = "p18.sc_18202"
SC_18202.nested_types = {}
SC_18202.enum_types = {}
SC_18202.fields = {
	var_0_2.SC_18202_LIST_FIELD
}
SC_18202.is_extendable = false
SC_18202.extensions = {}
var_0_2.CS_18203_TYPE_FIELD.name = "type"
var_0_2.CS_18203_TYPE_FIELD.full_name = "p18.cs_18203.type"
var_0_2.CS_18203_TYPE_FIELD.number = 1
var_0_2.CS_18203_TYPE_FIELD.index = 0
var_0_2.CS_18203_TYPE_FIELD.label = 2
var_0_2.CS_18203_TYPE_FIELD.has_default_value = false
var_0_2.CS_18203_TYPE_FIELD.default_value = 0
var_0_2.CS_18203_TYPE_FIELD.type = 13
var_0_2.CS_18203_TYPE_FIELD.cpp_type = 3
var_0_2.CS_18203_ACT_ID_FIELD.name = "act_id"
var_0_2.CS_18203_ACT_ID_FIELD.full_name = "p18.cs_18203.act_id"
var_0_2.CS_18203_ACT_ID_FIELD.number = 2
var_0_2.CS_18203_ACT_ID_FIELD.index = 1
var_0_2.CS_18203_ACT_ID_FIELD.label = 1
var_0_2.CS_18203_ACT_ID_FIELD.has_default_value = false
var_0_2.CS_18203_ACT_ID_FIELD.default_value = 0
var_0_2.CS_18203_ACT_ID_FIELD.type = 13
var_0_2.CS_18203_ACT_ID_FIELD.cpp_type = 3
CS_18203.name = "cs_18203"
CS_18203.full_name = "p18.cs_18203"
CS_18203.nested_types = {}
CS_18203.enum_types = {}
CS_18203.fields = {
	var_0_2.CS_18203_TYPE_FIELD,
	var_0_2.CS_18203_ACT_ID_FIELD
}
CS_18203.is_extendable = false
CS_18203.extensions = {}
var_0_2.SC_18204_POINT_FIELD.name = "point"
var_0_2.SC_18204_POINT_FIELD.full_name = "p18.sc_18204.point"
var_0_2.SC_18204_POINT_FIELD.number = 1
var_0_2.SC_18204_POINT_FIELD.index = 0
var_0_2.SC_18204_POINT_FIELD.label = 2
var_0_2.SC_18204_POINT_FIELD.has_default_value = false
var_0_2.SC_18204_POINT_FIELD.default_value = 0
var_0_2.SC_18204_POINT_FIELD.type = 13
var_0_2.SC_18204_POINT_FIELD.cpp_type = 3
var_0_2.SC_18204_RANK_FIELD.name = "rank"
var_0_2.SC_18204_RANK_FIELD.full_name = "p18.sc_18204.rank"
var_0_2.SC_18204_RANK_FIELD.number = 2
var_0_2.SC_18204_RANK_FIELD.index = 1
var_0_2.SC_18204_RANK_FIELD.label = 2
var_0_2.SC_18204_RANK_FIELD.has_default_value = false
var_0_2.SC_18204_RANK_FIELD.default_value = 0
var_0_2.SC_18204_RANK_FIELD.type = 13
var_0_2.SC_18204_RANK_FIELD.cpp_type = 3
SC_18204.name = "sc_18204"
SC_18204.full_name = "p18.sc_18204"
SC_18204.nested_types = {}
SC_18204.enum_types = {}
SC_18204.fields = {
	var_0_2.SC_18204_POINT_FIELD,
	var_0_2.SC_18204_RANK_FIELD
}
SC_18204.is_extendable = false
SC_18204.extensions = {}
var_0_2.TARGETINFO_ID_FIELD.name = "id"
var_0_2.TARGETINFO_ID_FIELD.full_name = "p18.targetinfo.id"
var_0_2.TARGETINFO_ID_FIELD.number = 1
var_0_2.TARGETINFO_ID_FIELD.index = 0
var_0_2.TARGETINFO_ID_FIELD.label = 2
var_0_2.TARGETINFO_ID_FIELD.has_default_value = false
var_0_2.TARGETINFO_ID_FIELD.default_value = 0
var_0_2.TARGETINFO_ID_FIELD.type = 13
var_0_2.TARGETINFO_ID_FIELD.cpp_type = 3
var_0_2.TARGETINFO_LEVEL_FIELD.name = "level"
var_0_2.TARGETINFO_LEVEL_FIELD.full_name = "p18.targetinfo.level"
var_0_2.TARGETINFO_LEVEL_FIELD.number = 2
var_0_2.TARGETINFO_LEVEL_FIELD.index = 1
var_0_2.TARGETINFO_LEVEL_FIELD.label = 2
var_0_2.TARGETINFO_LEVEL_FIELD.has_default_value = false
var_0_2.TARGETINFO_LEVEL_FIELD.default_value = 0
var_0_2.TARGETINFO_LEVEL_FIELD.type = 13
var_0_2.TARGETINFO_LEVEL_FIELD.cpp_type = 3
var_0_2.TARGETINFO_NAME_FIELD.name = "name"
var_0_2.TARGETINFO_NAME_FIELD.full_name = "p18.targetinfo.name"
var_0_2.TARGETINFO_NAME_FIELD.number = 3
var_0_2.TARGETINFO_NAME_FIELD.index = 2
var_0_2.TARGETINFO_NAME_FIELD.label = 2
var_0_2.TARGETINFO_NAME_FIELD.has_default_value = false
var_0_2.TARGETINFO_NAME_FIELD.default_value = ""
var_0_2.TARGETINFO_NAME_FIELD.type = 9
var_0_2.TARGETINFO_NAME_FIELD.cpp_type = 9
var_0_2.TARGETINFO_SCORE_FIELD.name = "score"
var_0_2.TARGETINFO_SCORE_FIELD.full_name = "p18.targetinfo.score"
var_0_2.TARGETINFO_SCORE_FIELD.number = 4
var_0_2.TARGETINFO_SCORE_FIELD.index = 3
var_0_2.TARGETINFO_SCORE_FIELD.label = 2
var_0_2.TARGETINFO_SCORE_FIELD.has_default_value = false
var_0_2.TARGETINFO_SCORE_FIELD.default_value = 0
var_0_2.TARGETINFO_SCORE_FIELD.type = 13
var_0_2.TARGETINFO_SCORE_FIELD.cpp_type = 3
var_0_2.TARGETINFO_RANK_FIELD.name = "rank"
var_0_2.TARGETINFO_RANK_FIELD.full_name = "p18.targetinfo.rank"
var_0_2.TARGETINFO_RANK_FIELD.number = 5
var_0_2.TARGETINFO_RANK_FIELD.index = 4
var_0_2.TARGETINFO_RANK_FIELD.label = 2
var_0_2.TARGETINFO_RANK_FIELD.has_default_value = false
var_0_2.TARGETINFO_RANK_FIELD.default_value = 0
var_0_2.TARGETINFO_RANK_FIELD.type = 13
var_0_2.TARGETINFO_RANK_FIELD.cpp_type = 3
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.name = "vanguard_ship_list"
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.full_name = "p18.targetinfo.vanguard_ship_list"
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.number = 6
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.index = 5
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.label = 3
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.has_default_value = false
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.default_value = {}
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.message_type = var_0_1.SHIPINFO
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.type = 11
var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD.cpp_type = 10
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.name = "main_ship_list"
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.full_name = "p18.targetinfo.main_ship_list"
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.number = 7
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.index = 6
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.label = 3
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.has_default_value = false
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.default_value = {}
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.message_type = var_0_1.SHIPINFO
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.type = 11
var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD.cpp_type = 10
var_0_2.TARGETINFO_DISPLAY_FIELD.name = "display"
var_0_2.TARGETINFO_DISPLAY_FIELD.full_name = "p18.targetinfo.display"
var_0_2.TARGETINFO_DISPLAY_FIELD.number = 8
var_0_2.TARGETINFO_DISPLAY_FIELD.index = 7
var_0_2.TARGETINFO_DISPLAY_FIELD.label = 1
var_0_2.TARGETINFO_DISPLAY_FIELD.has_default_value = false
var_0_2.TARGETINFO_DISPLAY_FIELD.default_value = nil
var_0_2.TARGETINFO_DISPLAY_FIELD.message_type = var_0_1.DISPLAYINFO
var_0_2.TARGETINFO_DISPLAY_FIELD.type = 11
var_0_2.TARGETINFO_DISPLAY_FIELD.cpp_type = 10
TARGETINFO.name = "targetinfo"
TARGETINFO.full_name = "p18.targetinfo"
TARGETINFO.nested_types = {}
TARGETINFO.enum_types = {}
TARGETINFO.fields = {
	var_0_2.TARGETINFO_ID_FIELD,
	var_0_2.TARGETINFO_LEVEL_FIELD,
	var_0_2.TARGETINFO_NAME_FIELD,
	var_0_2.TARGETINFO_SCORE_FIELD,
	var_0_2.TARGETINFO_RANK_FIELD,
	var_0_2.TARGETINFO_VANGUARD_SHIP_LIST_FIELD,
	var_0_2.TARGETINFO_MAIN_SHIP_LIST_FIELD,
	var_0_2.TARGETINFO_DISPLAY_FIELD
}
TARGETINFO.is_extendable = false
TARGETINFO.extensions = {}
var_0_2.ARENARANK_ID_FIELD.name = "id"
var_0_2.ARENARANK_ID_FIELD.full_name = "p18.arenarank.id"
var_0_2.ARENARANK_ID_FIELD.number = 1
var_0_2.ARENARANK_ID_FIELD.index = 0
var_0_2.ARENARANK_ID_FIELD.label = 2
var_0_2.ARENARANK_ID_FIELD.has_default_value = false
var_0_2.ARENARANK_ID_FIELD.default_value = 0
var_0_2.ARENARANK_ID_FIELD.type = 13
var_0_2.ARENARANK_ID_FIELD.cpp_type = 3
var_0_2.ARENARANK_LEVEL_FIELD.name = "level"
var_0_2.ARENARANK_LEVEL_FIELD.full_name = "p18.arenarank.level"
var_0_2.ARENARANK_LEVEL_FIELD.number = 2
var_0_2.ARENARANK_LEVEL_FIELD.index = 1
var_0_2.ARENARANK_LEVEL_FIELD.label = 2
var_0_2.ARENARANK_LEVEL_FIELD.has_default_value = false
var_0_2.ARENARANK_LEVEL_FIELD.default_value = 0
var_0_2.ARENARANK_LEVEL_FIELD.type = 13
var_0_2.ARENARANK_LEVEL_FIELD.cpp_type = 3
var_0_2.ARENARANK_NAME_FIELD.name = "name"
var_0_2.ARENARANK_NAME_FIELD.full_name = "p18.arenarank.name"
var_0_2.ARENARANK_NAME_FIELD.number = 3
var_0_2.ARENARANK_NAME_FIELD.index = 2
var_0_2.ARENARANK_NAME_FIELD.label = 2
var_0_2.ARENARANK_NAME_FIELD.has_default_value = false
var_0_2.ARENARANK_NAME_FIELD.default_value = ""
var_0_2.ARENARANK_NAME_FIELD.type = 9
var_0_2.ARENARANK_NAME_FIELD.cpp_type = 9
var_0_2.ARENARANK_SCORE_FIELD.name = "score"
var_0_2.ARENARANK_SCORE_FIELD.full_name = "p18.arenarank.score"
var_0_2.ARENARANK_SCORE_FIELD.number = 4
var_0_2.ARENARANK_SCORE_FIELD.index = 3
var_0_2.ARENARANK_SCORE_FIELD.label = 2
var_0_2.ARENARANK_SCORE_FIELD.has_default_value = false
var_0_2.ARENARANK_SCORE_FIELD.default_value = 0
var_0_2.ARENARANK_SCORE_FIELD.type = 13
var_0_2.ARENARANK_SCORE_FIELD.cpp_type = 3
var_0_2.ARENARANK_DISPLAY_FIELD.name = "display"
var_0_2.ARENARANK_DISPLAY_FIELD.full_name = "p18.arenarank.display"
var_0_2.ARENARANK_DISPLAY_FIELD.number = 5
var_0_2.ARENARANK_DISPLAY_FIELD.index = 4
var_0_2.ARENARANK_DISPLAY_FIELD.label = 1
var_0_2.ARENARANK_DISPLAY_FIELD.has_default_value = false
var_0_2.ARENARANK_DISPLAY_FIELD.default_value = nil
var_0_2.ARENARANK_DISPLAY_FIELD.message_type = var_0_1.DISPLAYINFO
var_0_2.ARENARANK_DISPLAY_FIELD.type = 11
var_0_2.ARENARANK_DISPLAY_FIELD.cpp_type = 10
ARENARANK.name = "arenarank"
ARENARANK.full_name = "p18.arenarank"
ARENARANK.nested_types = {}
ARENARANK.enum_types = {}
ARENARANK.fields = {
	var_0_2.ARENARANK_ID_FIELD,
	var_0_2.ARENARANK_LEVEL_FIELD,
	var_0_2.ARENARANK_NAME_FIELD,
	var_0_2.ARENARANK_SCORE_FIELD,
	var_0_2.ARENARANK_DISPLAY_FIELD
}
ARENARANK.is_extendable = false
ARENARANK.extensions = {}
var_0_2.ARENASHOP_SHOP_ID_FIELD.name = "shop_id"
var_0_2.ARENASHOP_SHOP_ID_FIELD.full_name = "p18.arenashop.shop_id"
var_0_2.ARENASHOP_SHOP_ID_FIELD.number = 1
var_0_2.ARENASHOP_SHOP_ID_FIELD.index = 0
var_0_2.ARENASHOP_SHOP_ID_FIELD.label = 2
var_0_2.ARENASHOP_SHOP_ID_FIELD.has_default_value = false
var_0_2.ARENASHOP_SHOP_ID_FIELD.default_value = 0
var_0_2.ARENASHOP_SHOP_ID_FIELD.type = 13
var_0_2.ARENASHOP_SHOP_ID_FIELD.cpp_type = 3
var_0_2.ARENASHOP_COUNT_FIELD.name = "count"
var_0_2.ARENASHOP_COUNT_FIELD.full_name = "p18.arenashop.count"
var_0_2.ARENASHOP_COUNT_FIELD.number = 2
var_0_2.ARENASHOP_COUNT_FIELD.index = 1
var_0_2.ARENASHOP_COUNT_FIELD.label = 2
var_0_2.ARENASHOP_COUNT_FIELD.has_default_value = false
var_0_2.ARENASHOP_COUNT_FIELD.default_value = 0
var_0_2.ARENASHOP_COUNT_FIELD.type = 13
var_0_2.ARENASHOP_COUNT_FIELD.cpp_type = 3
ARENASHOP.name = "arenashop"
ARENASHOP.full_name = "p18.arenashop"
ARENASHOP.nested_types = {}
ARENASHOP.enum_types = {}
ARENASHOP.fields = {
	var_0_2.ARENASHOP_SHOP_ID_FIELD,
	var_0_2.ARENASHOP_COUNT_FIELD
}
ARENASHOP.is_extendable = false
ARENASHOP.extensions = {}
var_0_2.RANK_INFO_USER_ID_FIELD.name = "user_id"
var_0_2.RANK_INFO_USER_ID_FIELD.full_name = "p18.rank_info.user_id"
var_0_2.RANK_INFO_USER_ID_FIELD.number = 1
var_0_2.RANK_INFO_USER_ID_FIELD.index = 0
var_0_2.RANK_INFO_USER_ID_FIELD.label = 2
var_0_2.RANK_INFO_USER_ID_FIELD.has_default_value = false
var_0_2.RANK_INFO_USER_ID_FIELD.default_value = 0
var_0_2.RANK_INFO_USER_ID_FIELD.type = 13
var_0_2.RANK_INFO_USER_ID_FIELD.cpp_type = 3
var_0_2.RANK_INFO_POINT_FIELD.name = "point"
var_0_2.RANK_INFO_POINT_FIELD.full_name = "p18.rank_info.point"
var_0_2.RANK_INFO_POINT_FIELD.number = 2
var_0_2.RANK_INFO_POINT_FIELD.index = 1
var_0_2.RANK_INFO_POINT_FIELD.label = 2
var_0_2.RANK_INFO_POINT_FIELD.has_default_value = false
var_0_2.RANK_INFO_POINT_FIELD.default_value = 0
var_0_2.RANK_INFO_POINT_FIELD.type = 13
var_0_2.RANK_INFO_POINT_FIELD.cpp_type = 3
var_0_2.RANK_INFO_NAME_FIELD.name = "name"
var_0_2.RANK_INFO_NAME_FIELD.full_name = "p18.rank_info.name"
var_0_2.RANK_INFO_NAME_FIELD.number = 3
var_0_2.RANK_INFO_NAME_FIELD.index = 2
var_0_2.RANK_INFO_NAME_FIELD.label = 2
var_0_2.RANK_INFO_NAME_FIELD.has_default_value = false
var_0_2.RANK_INFO_NAME_FIELD.default_value = ""
var_0_2.RANK_INFO_NAME_FIELD.type = 9
var_0_2.RANK_INFO_NAME_FIELD.cpp_type = 9
var_0_2.RANK_INFO_LV_FIELD.name = "lv"
var_0_2.RANK_INFO_LV_FIELD.full_name = "p18.rank_info.lv"
var_0_2.RANK_INFO_LV_FIELD.number = 4
var_0_2.RANK_INFO_LV_FIELD.index = 3
var_0_2.RANK_INFO_LV_FIELD.label = 2
var_0_2.RANK_INFO_LV_FIELD.has_default_value = false
var_0_2.RANK_INFO_LV_FIELD.default_value = 0
var_0_2.RANK_INFO_LV_FIELD.type = 13
var_0_2.RANK_INFO_LV_FIELD.cpp_type = 3
var_0_2.RANK_INFO_ARENA_RANK_FIELD.name = "arena_rank"
var_0_2.RANK_INFO_ARENA_RANK_FIELD.full_name = "p18.rank_info.arena_rank"
var_0_2.RANK_INFO_ARENA_RANK_FIELD.number = 5
var_0_2.RANK_INFO_ARENA_RANK_FIELD.index = 4
var_0_2.RANK_INFO_ARENA_RANK_FIELD.label = 2
var_0_2.RANK_INFO_ARENA_RANK_FIELD.has_default_value = false
var_0_2.RANK_INFO_ARENA_RANK_FIELD.default_value = 0
var_0_2.RANK_INFO_ARENA_RANK_FIELD.type = 13
var_0_2.RANK_INFO_ARENA_RANK_FIELD.cpp_type = 3
var_0_2.RANK_INFO_DISPLAY_FIELD.name = "display"
var_0_2.RANK_INFO_DISPLAY_FIELD.full_name = "p18.rank_info.display"
var_0_2.RANK_INFO_DISPLAY_FIELD.number = 6
var_0_2.RANK_INFO_DISPLAY_FIELD.index = 5
var_0_2.RANK_INFO_DISPLAY_FIELD.label = 1
var_0_2.RANK_INFO_DISPLAY_FIELD.has_default_value = false
var_0_2.RANK_INFO_DISPLAY_FIELD.default_value = nil
var_0_2.RANK_INFO_DISPLAY_FIELD.message_type = var_0_1.DISPLAYINFO
var_0_2.RANK_INFO_DISPLAY_FIELD.type = 11
var_0_2.RANK_INFO_DISPLAY_FIELD.cpp_type = 10
RANK_INFO.name = "rank_info"
RANK_INFO.full_name = "p18.rank_info"
RANK_INFO.nested_types = {}
RANK_INFO.enum_types = {}
RANK_INFO.fields = {
	var_0_2.RANK_INFO_USER_ID_FIELD,
	var_0_2.RANK_INFO_POINT_FIELD,
	var_0_2.RANK_INFO_NAME_FIELD,
	var_0_2.RANK_INFO_LV_FIELD,
	var_0_2.RANK_INFO_ARENA_RANK_FIELD,
	var_0_2.RANK_INFO_DISPLAY_FIELD
}
RANK_INFO.is_extendable = false
RANK_INFO.extensions = {}
arenarank = var_0_0.Message(ARENARANK)
arenashop = var_0_0.Message(ARENASHOP)
cs_18001 = var_0_0.Message(CS_18001)
cs_18003 = var_0_0.Message(CS_18003)
cs_18006 = var_0_0.Message(CS_18006)
cs_18008 = var_0_0.Message(CS_18008)
cs_18100 = var_0_0.Message(CS_18100)
cs_18102 = var_0_0.Message(CS_18102)
cs_18104 = var_0_0.Message(CS_18104)
cs_18201 = var_0_0.Message(CS_18201)
cs_18203 = var_0_0.Message(CS_18203)
rank_info = var_0_0.Message(RANK_INFO)
sc_18002 = var_0_0.Message(SC_18002)
sc_18004 = var_0_0.Message(SC_18004)
sc_18005 = var_0_0.Message(SC_18005)
sc_18007 = var_0_0.Message(SC_18007)
sc_18009 = var_0_0.Message(SC_18009)
sc_18101 = var_0_0.Message(SC_18101)
sc_18103 = var_0_0.Message(SC_18103)
sc_18105 = var_0_0.Message(SC_18105)
sc_18202 = var_0_0.Message(SC_18202)
sc_18204 = var_0_0.Message(SC_18204)
targetinfo = var_0_0.Message(TARGETINFO)
