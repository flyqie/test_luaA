﻿local var_0_0 = require("protobuf")
local var_0_1 = require("common_pb")

module("p24_pb")

local var_0_2 = {}

CS_24002 = var_0_0.Descriptor()
var_0_2.CS_24002_ACTIVITY_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_24002_GROUP_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_24002_MODE_FIELD = var_0_0.FieldDescriptor()
SC_24003 = var_0_0.Descriptor()
var_0_2.SC_24003_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_24004 = var_0_0.Descriptor()
var_0_2.CS_24004_ACTIVITY_ID_FIELD = var_0_0.FieldDescriptor()
SC_24005 = var_0_0.Descriptor()
var_0_2.SC_24005_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_24005_USER_CHALLENGE_FIELD = var_0_0.FieldDescriptor()
SC_24010 = var_0_0.Descriptor()
var_0_2.SC_24010_SCORE_FIELD = var_0_0.FieldDescriptor()
CS_24011 = var_0_0.Descriptor()
var_0_2.CS_24011_ACTIVITY_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_24011_MODE_FIELD = var_0_0.FieldDescriptor()
SC_24012 = var_0_0.Descriptor()
var_0_2.SC_24012_RESULT_FIELD = var_0_0.FieldDescriptor()
GROUPINFO = var_0_0.Descriptor()
var_0_2.GROUPINFO_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.GROUPINFO_SHIP_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.GROUPINFO_COMMANDERS_FIELD = var_0_0.FieldDescriptor()
CHALLENGEINFO = var_0_0.Descriptor()
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD = var_0_0.FieldDescriptor()
USERCHALLENGEINFO = var_0_0.Descriptor()
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_MODE_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_ISSL_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD = var_0_0.FieldDescriptor()
SHIPINCHALLENGE = var_0_0.Descriptor()
var_0_2.SHIPINCHALLENGE_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD = var_0_0.FieldDescriptor()
GROUPINFOINCHALLENGE = var_0_0.Descriptor()
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD = var_0_0.FieldDescriptor()
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD = var_0_0.FieldDescriptor()
COMMANDERINCHALLENGE = var_0_0.Descriptor()
var_0_2.COMMANDERINCHALLENGE_POS_FIELD = var_0_0.FieldDescriptor()
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD = var_0_0.FieldDescriptor()
CS_24020 = var_0_0.Descriptor()
var_0_2.CS_24020_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_24021 = var_0_0.Descriptor()
var_0_2.SC_24021_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_24021_TIMES_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_24021_AWARDS_FIELD = var_0_0.FieldDescriptor()
CS_24022 = var_0_0.Descriptor()
var_0_2.CS_24022_CHALLENGEIDS_FIELD = var_0_0.FieldDescriptor()
SC_24023 = var_0_0.Descriptor()
var_0_2.SC_24023_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_24023_DROP_LIST_FIELD = var_0_0.FieldDescriptor()
SC_24100 = var_0_0.Descriptor()
var_0_2.SC_24100_SCORE_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_24002_ACTIVITY_ID_FIELD.name = "activity_id"
var_0_2.CS_24002_ACTIVITY_ID_FIELD.full_name = "p24.cs_24002.activity_id"
var_0_2.CS_24002_ACTIVITY_ID_FIELD.number = 1
var_0_2.CS_24002_ACTIVITY_ID_FIELD.index = 0
var_0_2.CS_24002_ACTIVITY_ID_FIELD.label = 2
var_0_2.CS_24002_ACTIVITY_ID_FIELD.has_default_value = false
var_0_2.CS_24002_ACTIVITY_ID_FIELD.default_value = 0
var_0_2.CS_24002_ACTIVITY_ID_FIELD.type = 13
var_0_2.CS_24002_ACTIVITY_ID_FIELD.cpp_type = 3
var_0_2.CS_24002_GROUP_LIST_FIELD.name = "group_list"
var_0_2.CS_24002_GROUP_LIST_FIELD.full_name = "p24.cs_24002.group_list"
var_0_2.CS_24002_GROUP_LIST_FIELD.number = 2
var_0_2.CS_24002_GROUP_LIST_FIELD.index = 1
var_0_2.CS_24002_GROUP_LIST_FIELD.label = 3
var_0_2.CS_24002_GROUP_LIST_FIELD.has_default_value = false
var_0_2.CS_24002_GROUP_LIST_FIELD.default_value = {}
var_0_2.CS_24002_GROUP_LIST_FIELD.message_type = GROUPINFO
var_0_2.CS_24002_GROUP_LIST_FIELD.type = 11
var_0_2.CS_24002_GROUP_LIST_FIELD.cpp_type = 10
var_0_2.CS_24002_MODE_FIELD.name = "mode"
var_0_2.CS_24002_MODE_FIELD.full_name = "p24.cs_24002.mode"
var_0_2.CS_24002_MODE_FIELD.number = 3
var_0_2.CS_24002_MODE_FIELD.index = 2
var_0_2.CS_24002_MODE_FIELD.label = 2
var_0_2.CS_24002_MODE_FIELD.has_default_value = false
var_0_2.CS_24002_MODE_FIELD.default_value = 0
var_0_2.CS_24002_MODE_FIELD.type = 13
var_0_2.CS_24002_MODE_FIELD.cpp_type = 3
CS_24002.name = "cs_24002"
CS_24002.full_name = "p24.cs_24002"
CS_24002.nested_types = {}
CS_24002.enum_types = {}
CS_24002.fields = {
	var_0_2.CS_24002_ACTIVITY_ID_FIELD,
	var_0_2.CS_24002_GROUP_LIST_FIELD,
	var_0_2.CS_24002_MODE_FIELD
}
CS_24002.is_extendable = false
CS_24002.extensions = {}
var_0_2.SC_24003_RESULT_FIELD.name = "result"
var_0_2.SC_24003_RESULT_FIELD.full_name = "p24.sc_24003.result"
var_0_2.SC_24003_RESULT_FIELD.number = 1
var_0_2.SC_24003_RESULT_FIELD.index = 0
var_0_2.SC_24003_RESULT_FIELD.label = 2
var_0_2.SC_24003_RESULT_FIELD.has_default_value = false
var_0_2.SC_24003_RESULT_FIELD.default_value = 0
var_0_2.SC_24003_RESULT_FIELD.type = 13
var_0_2.SC_24003_RESULT_FIELD.cpp_type = 3
SC_24003.name = "sc_24003"
SC_24003.full_name = "p24.sc_24003"
SC_24003.nested_types = {}
SC_24003.enum_types = {}
SC_24003.fields = {
	var_0_2.SC_24003_RESULT_FIELD
}
SC_24003.is_extendable = false
SC_24003.extensions = {}
var_0_2.CS_24004_ACTIVITY_ID_FIELD.name = "activity_id"
var_0_2.CS_24004_ACTIVITY_ID_FIELD.full_name = "p24.cs_24004.activity_id"
var_0_2.CS_24004_ACTIVITY_ID_FIELD.number = 1
var_0_2.CS_24004_ACTIVITY_ID_FIELD.index = 0
var_0_2.CS_24004_ACTIVITY_ID_FIELD.label = 2
var_0_2.CS_24004_ACTIVITY_ID_FIELD.has_default_value = false
var_0_2.CS_24004_ACTIVITY_ID_FIELD.default_value = 0
var_0_2.CS_24004_ACTIVITY_ID_FIELD.type = 13
var_0_2.CS_24004_ACTIVITY_ID_FIELD.cpp_type = 3
CS_24004.name = "cs_24004"
CS_24004.full_name = "p24.cs_24004"
CS_24004.nested_types = {}
CS_24004.enum_types = {}
CS_24004.fields = {
	var_0_2.CS_24004_ACTIVITY_ID_FIELD
}
CS_24004.is_extendable = false
CS_24004.extensions = {}
var_0_2.SC_24005_RESULT_FIELD.name = "result"
var_0_2.SC_24005_RESULT_FIELD.full_name = "p24.sc_24005.result"
var_0_2.SC_24005_RESULT_FIELD.number = 1
var_0_2.SC_24005_RESULT_FIELD.index = 0
var_0_2.SC_24005_RESULT_FIELD.label = 2
var_0_2.SC_24005_RESULT_FIELD.has_default_value = false
var_0_2.SC_24005_RESULT_FIELD.default_value = 0
var_0_2.SC_24005_RESULT_FIELD.type = 13
var_0_2.SC_24005_RESULT_FIELD.cpp_type = 3
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.name = "current_challenge"
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.full_name = "p24.sc_24005.current_challenge"
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.number = 2
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.index = 1
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.label = 2
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.has_default_value = false
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.default_value = nil
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.message_type = CHALLENGEINFO
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.type = 11
var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD.cpp_type = 10
var_0_2.SC_24005_USER_CHALLENGE_FIELD.name = "user_challenge"
var_0_2.SC_24005_USER_CHALLENGE_FIELD.full_name = "p24.sc_24005.user_challenge"
var_0_2.SC_24005_USER_CHALLENGE_FIELD.number = 3
var_0_2.SC_24005_USER_CHALLENGE_FIELD.index = 2
var_0_2.SC_24005_USER_CHALLENGE_FIELD.label = 3
var_0_2.SC_24005_USER_CHALLENGE_FIELD.has_default_value = false
var_0_2.SC_24005_USER_CHALLENGE_FIELD.default_value = {}
var_0_2.SC_24005_USER_CHALLENGE_FIELD.message_type = USERCHALLENGEINFO
var_0_2.SC_24005_USER_CHALLENGE_FIELD.type = 11
var_0_2.SC_24005_USER_CHALLENGE_FIELD.cpp_type = 10
SC_24005.name = "sc_24005"
SC_24005.full_name = "p24.sc_24005"
SC_24005.nested_types = {}
SC_24005.enum_types = {}
SC_24005.fields = {
	var_0_2.SC_24005_RESULT_FIELD,
	var_0_2.SC_24005_CURRENT_CHALLENGE_FIELD,
	var_0_2.SC_24005_USER_CHALLENGE_FIELD
}
SC_24005.is_extendable = false
SC_24005.extensions = {}
var_0_2.SC_24010_SCORE_FIELD.name = "score"
var_0_2.SC_24010_SCORE_FIELD.full_name = "p24.sc_24010.score"
var_0_2.SC_24010_SCORE_FIELD.number = 1
var_0_2.SC_24010_SCORE_FIELD.index = 0
var_0_2.SC_24010_SCORE_FIELD.label = 2
var_0_2.SC_24010_SCORE_FIELD.has_default_value = false
var_0_2.SC_24010_SCORE_FIELD.default_value = 0
var_0_2.SC_24010_SCORE_FIELD.type = 13
var_0_2.SC_24010_SCORE_FIELD.cpp_type = 3
SC_24010.name = "sc_24010"
SC_24010.full_name = "p24.sc_24010"
SC_24010.nested_types = {}
SC_24010.enum_types = {}
SC_24010.fields = {
	var_0_2.SC_24010_SCORE_FIELD
}
SC_24010.is_extendable = false
SC_24010.extensions = {}
var_0_2.CS_24011_ACTIVITY_ID_FIELD.name = "activity_id"
var_0_2.CS_24011_ACTIVITY_ID_FIELD.full_name = "p24.cs_24011.activity_id"
var_0_2.CS_24011_ACTIVITY_ID_FIELD.number = 1
var_0_2.CS_24011_ACTIVITY_ID_FIELD.index = 0
var_0_2.CS_24011_ACTIVITY_ID_FIELD.label = 2
var_0_2.CS_24011_ACTIVITY_ID_FIELD.has_default_value = false
var_0_2.CS_24011_ACTIVITY_ID_FIELD.default_value = 0
var_0_2.CS_24011_ACTIVITY_ID_FIELD.type = 13
var_0_2.CS_24011_ACTIVITY_ID_FIELD.cpp_type = 3
var_0_2.CS_24011_MODE_FIELD.name = "mode"
var_0_2.CS_24011_MODE_FIELD.full_name = "p24.cs_24011.mode"
var_0_2.CS_24011_MODE_FIELD.number = 2
var_0_2.CS_24011_MODE_FIELD.index = 1
var_0_2.CS_24011_MODE_FIELD.label = 2
var_0_2.CS_24011_MODE_FIELD.has_default_value = false
var_0_2.CS_24011_MODE_FIELD.default_value = 0
var_0_2.CS_24011_MODE_FIELD.type = 13
var_0_2.CS_24011_MODE_FIELD.cpp_type = 3
CS_24011.name = "cs_24011"
CS_24011.full_name = "p24.cs_24011"
CS_24011.nested_types = {}
CS_24011.enum_types = {}
CS_24011.fields = {
	var_0_2.CS_24011_ACTIVITY_ID_FIELD,
	var_0_2.CS_24011_MODE_FIELD
}
CS_24011.is_extendable = false
CS_24011.extensions = {}
var_0_2.SC_24012_RESULT_FIELD.name = "result"
var_0_2.SC_24012_RESULT_FIELD.full_name = "p24.sc_24012.result"
var_0_2.SC_24012_RESULT_FIELD.number = 1
var_0_2.SC_24012_RESULT_FIELD.index = 0
var_0_2.SC_24012_RESULT_FIELD.label = 2
var_0_2.SC_24012_RESULT_FIELD.has_default_value = false
var_0_2.SC_24012_RESULT_FIELD.default_value = 0
var_0_2.SC_24012_RESULT_FIELD.type = 13
var_0_2.SC_24012_RESULT_FIELD.cpp_type = 3
SC_24012.name = "sc_24012"
SC_24012.full_name = "p24.sc_24012"
SC_24012.nested_types = {}
SC_24012.enum_types = {}
SC_24012.fields = {
	var_0_2.SC_24012_RESULT_FIELD
}
SC_24012.is_extendable = false
SC_24012.extensions = {}
var_0_2.GROUPINFO_ID_FIELD.name = "id"
var_0_2.GROUPINFO_ID_FIELD.full_name = "p24.groupinfo.id"
var_0_2.GROUPINFO_ID_FIELD.number = 1
var_0_2.GROUPINFO_ID_FIELD.index = 0
var_0_2.GROUPINFO_ID_FIELD.label = 2
var_0_2.GROUPINFO_ID_FIELD.has_default_value = false
var_0_2.GROUPINFO_ID_FIELD.default_value = 0
var_0_2.GROUPINFO_ID_FIELD.type = 13
var_0_2.GROUPINFO_ID_FIELD.cpp_type = 3
var_0_2.GROUPINFO_SHIP_LIST_FIELD.name = "ship_list"
var_0_2.GROUPINFO_SHIP_LIST_FIELD.full_name = "p24.groupinfo.ship_list"
var_0_2.GROUPINFO_SHIP_LIST_FIELD.number = 2
var_0_2.GROUPINFO_SHIP_LIST_FIELD.index = 1
var_0_2.GROUPINFO_SHIP_LIST_FIELD.label = 3
var_0_2.GROUPINFO_SHIP_LIST_FIELD.has_default_value = false
var_0_2.GROUPINFO_SHIP_LIST_FIELD.default_value = {}
var_0_2.GROUPINFO_SHIP_LIST_FIELD.type = 13
var_0_2.GROUPINFO_SHIP_LIST_FIELD.cpp_type = 3
var_0_2.GROUPINFO_COMMANDERS_FIELD.name = "commanders"
var_0_2.GROUPINFO_COMMANDERS_FIELD.full_name = "p24.groupinfo.commanders"
var_0_2.GROUPINFO_COMMANDERS_FIELD.number = 3
var_0_2.GROUPINFO_COMMANDERS_FIELD.index = 2
var_0_2.GROUPINFO_COMMANDERS_FIELD.label = 3
var_0_2.GROUPINFO_COMMANDERS_FIELD.has_default_value = false
var_0_2.GROUPINFO_COMMANDERS_FIELD.default_value = {}
var_0_2.GROUPINFO_COMMANDERS_FIELD.message_type = var_0_1.COMMANDERSINFO
var_0_2.GROUPINFO_COMMANDERS_FIELD.type = 11
var_0_2.GROUPINFO_COMMANDERS_FIELD.cpp_type = 10
GROUPINFO.name = "groupinfo"
GROUPINFO.full_name = "p24.groupinfo"
GROUPINFO.nested_types = {}
GROUPINFO.enum_types = {}
GROUPINFO.fields = {
	var_0_2.GROUPINFO_ID_FIELD,
	var_0_2.GROUPINFO_SHIP_LIST_FIELD,
	var_0_2.GROUPINFO_COMMANDERS_FIELD
}
GROUPINFO.is_extendable = false
GROUPINFO.extensions = {}
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.name = "season_max_score"
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.full_name = "p24.challengeinfo.season_max_score"
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.number = 1
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.index = 0
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.label = 2
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.default_value = 0
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.type = 13
var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.name = "activity_max_score"
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.full_name = "p24.challengeinfo.activity_max_score"
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.number = 2
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.index = 1
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.label = 2
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.default_value = 0
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.type = 13
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.name = "season_max_level"
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.full_name = "p24.challengeinfo.season_max_level"
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.number = 3
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.index = 2
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.label = 2
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.default_value = 0
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.type = 13
var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.name = "activity_max_level"
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.full_name = "p24.challengeinfo.activity_max_level"
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.number = 4
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.index = 3
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.label = 2
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.default_value = 0
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.type = 13
var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.name = "season_id"
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.full_name = "p24.challengeinfo.season_id"
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.number = 5
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.index = 4
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.label = 2
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.default_value = 0
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.type = 13
var_0_2.CHALLENGEINFO_SEASON_ID_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.name = "dungeon_id_list"
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.full_name = "p24.challengeinfo.dungeon_id_list"
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.number = 6
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.index = 5
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.label = 3
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.default_value = {}
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.type = 13
var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD.cpp_type = 3
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.name = "buff_list"
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.full_name = "p24.challengeinfo.buff_list"
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.number = 7
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.index = 6
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.label = 3
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.has_default_value = false
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.default_value = {}
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.type = 13
var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD.cpp_type = 3
CHALLENGEINFO.name = "challengeinfo"
CHALLENGEINFO.full_name = "p24.challengeinfo"
CHALLENGEINFO.nested_types = {}
CHALLENGEINFO.enum_types = {}
CHALLENGEINFO.fields = {
	var_0_2.CHALLENGEINFO_SEASON_MAX_SCORE_FIELD,
	var_0_2.CHALLENGEINFO_ACTIVITY_MAX_SCORE_FIELD,
	var_0_2.CHALLENGEINFO_SEASON_MAX_LEVEL_FIELD,
	var_0_2.CHALLENGEINFO_ACTIVITY_MAX_LEVEL_FIELD,
	var_0_2.CHALLENGEINFO_SEASON_ID_FIELD,
	var_0_2.CHALLENGEINFO_DUNGEON_ID_LIST_FIELD,
	var_0_2.CHALLENGEINFO_BUFF_LIST_FIELD
}
CHALLENGEINFO.is_extendable = false
CHALLENGEINFO.extensions = {}
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.name = "current_score"
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.full_name = "p24.userchallengeinfo.current_score"
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.number = 1
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.index = 0
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.label = 2
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.default_value = 0
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.name = "level"
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.full_name = "p24.userchallengeinfo.level"
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.number = 2
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.index = 1
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.label = 2
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.default_value = 0
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_LEVEL_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.name = "groupinc_list"
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.full_name = "p24.userchallengeinfo.groupinc_list"
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.number = 3
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.index = 2
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.label = 3
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.default_value = {}
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.message_type = GROUPINFOINCHALLENGE
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.type = 11
var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD.cpp_type = 10
var_0_2.USERCHALLENGEINFO_MODE_FIELD.name = "mode"
var_0_2.USERCHALLENGEINFO_MODE_FIELD.full_name = "p24.userchallengeinfo.mode"
var_0_2.USERCHALLENGEINFO_MODE_FIELD.number = 4
var_0_2.USERCHALLENGEINFO_MODE_FIELD.index = 3
var_0_2.USERCHALLENGEINFO_MODE_FIELD.label = 2
var_0_2.USERCHALLENGEINFO_MODE_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_MODE_FIELD.default_value = 0
var_0_2.USERCHALLENGEINFO_MODE_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_MODE_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.name = "issl"
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.full_name = "p24.userchallengeinfo.issl"
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.number = 5
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.index = 4
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.label = 2
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.default_value = 0
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_ISSL_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.name = "season_id"
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.full_name = "p24.userchallengeinfo.season_id"
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.number = 6
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.index = 5
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.label = 2
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.default_value = 0
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.name = "dungeon_id_list"
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.full_name = "p24.userchallengeinfo.dungeon_id_list"
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.number = 7
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.index = 6
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.label = 3
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.default_value = {}
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD.cpp_type = 3
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.name = "buff_list"
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.full_name = "p24.userchallengeinfo.buff_list"
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.number = 8
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.index = 7
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.label = 3
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.has_default_value = false
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.default_value = {}
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.type = 13
var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD.cpp_type = 3
USERCHALLENGEINFO.name = "userchallengeinfo"
USERCHALLENGEINFO.full_name = "p24.userchallengeinfo"
USERCHALLENGEINFO.nested_types = {}
USERCHALLENGEINFO.enum_types = {}
USERCHALLENGEINFO.fields = {
	var_0_2.USERCHALLENGEINFO_CURRENT_SCORE_FIELD,
	var_0_2.USERCHALLENGEINFO_LEVEL_FIELD,
	var_0_2.USERCHALLENGEINFO_GROUPINC_LIST_FIELD,
	var_0_2.USERCHALLENGEINFO_MODE_FIELD,
	var_0_2.USERCHALLENGEINFO_ISSL_FIELD,
	var_0_2.USERCHALLENGEINFO_SEASON_ID_FIELD,
	var_0_2.USERCHALLENGEINFO_DUNGEON_ID_LIST_FIELD,
	var_0_2.USERCHALLENGEINFO_BUFF_LIST_FIELD
}
USERCHALLENGEINFO.is_extendable = false
USERCHALLENGEINFO.extensions = {}
var_0_2.SHIPINCHALLENGE_ID_FIELD.name = "id"
var_0_2.SHIPINCHALLENGE_ID_FIELD.full_name = "p24.shipinchallenge.id"
var_0_2.SHIPINCHALLENGE_ID_FIELD.number = 1
var_0_2.SHIPINCHALLENGE_ID_FIELD.index = 0
var_0_2.SHIPINCHALLENGE_ID_FIELD.label = 2
var_0_2.SHIPINCHALLENGE_ID_FIELD.has_default_value = false
var_0_2.SHIPINCHALLENGE_ID_FIELD.default_value = 0
var_0_2.SHIPINCHALLENGE_ID_FIELD.type = 13
var_0_2.SHIPINCHALLENGE_ID_FIELD.cpp_type = 3
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.name = "hp_rant"
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.full_name = "p24.shipinchallenge.hp_rant"
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.number = 2
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.index = 1
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.label = 2
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.has_default_value = false
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.default_value = 0
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.type = 13
var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD.cpp_type = 3
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.name = "ship_info"
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.full_name = "p24.shipinchallenge.ship_info"
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.number = 3
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.index = 2
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.label = 2
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.has_default_value = false
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.default_value = nil
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.message_type = var_0_1.SHIPINFO
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.type = 11
var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD.cpp_type = 10
SHIPINCHALLENGE.name = "shipinchallenge"
SHIPINCHALLENGE.full_name = "p24.shipinchallenge"
SHIPINCHALLENGE.nested_types = {}
SHIPINCHALLENGE.enum_types = {}
SHIPINCHALLENGE.fields = {
	var_0_2.SHIPINCHALLENGE_ID_FIELD,
	var_0_2.SHIPINCHALLENGE_HP_RANT_FIELD,
	var_0_2.SHIPINCHALLENGE_SHIP_INFO_FIELD
}
SHIPINCHALLENGE.is_extendable = false
SHIPINCHALLENGE.extensions = {}
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.name = "id"
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.full_name = "p24.groupinfoinchallenge.id"
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.number = 1
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.index = 0
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.label = 2
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.has_default_value = false
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.default_value = 0
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.type = 13
var_0_2.GROUPINFOINCHALLENGE_ID_FIELD.cpp_type = 3
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.name = "ships"
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.full_name = "p24.groupinfoinchallenge.ships"
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.number = 2
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.index = 1
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.label = 3
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.has_default_value = false
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.default_value = {}
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.message_type = SHIPINCHALLENGE
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.type = 11
var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD.cpp_type = 10
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.name = "commanders"
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.full_name = "p24.groupinfoinchallenge.commanders"
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.number = 3
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.index = 2
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.label = 3
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.has_default_value = false
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.default_value = {}
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.message_type = COMMANDERINCHALLENGE
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.type = 11
var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD.cpp_type = 10
GROUPINFOINCHALLENGE.name = "groupinfoinchallenge"
GROUPINFOINCHALLENGE.full_name = "p24.groupinfoinchallenge"
GROUPINFOINCHALLENGE.nested_types = {}
GROUPINFOINCHALLENGE.enum_types = {}
GROUPINFOINCHALLENGE.fields = {
	var_0_2.GROUPINFOINCHALLENGE_ID_FIELD,
	var_0_2.GROUPINFOINCHALLENGE_SHIPS_FIELD,
	var_0_2.GROUPINFOINCHALLENGE_COMMANDERS_FIELD
}
GROUPINFOINCHALLENGE.is_extendable = false
GROUPINFOINCHALLENGE.extensions = {}
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.name = "pos"
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.full_name = "p24.commanderinchallenge.pos"
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.number = 1
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.index = 0
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.label = 2
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.has_default_value = false
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.default_value = 0
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.type = 13
var_0_2.COMMANDERINCHALLENGE_POS_FIELD.cpp_type = 3
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.name = "commanderinfo"
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.full_name = "p24.commanderinchallenge.commanderinfo"
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.number = 2
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.index = 1
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.label = 2
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.has_default_value = false
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.default_value = nil
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.message_type = var_0_1.COMMANDERINFO
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.type = 11
var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD.cpp_type = 10
COMMANDERINCHALLENGE.name = "commanderinchallenge"
COMMANDERINCHALLENGE.full_name = "p24.commanderinchallenge"
COMMANDERINCHALLENGE.nested_types = {}
COMMANDERINCHALLENGE.enum_types = {}
COMMANDERINCHALLENGE.fields = {
	var_0_2.COMMANDERINCHALLENGE_POS_FIELD,
	var_0_2.COMMANDERINCHALLENGE_COMMANDERINFO_FIELD
}
COMMANDERINCHALLENGE.is_extendable = false
COMMANDERINCHALLENGE.extensions = {}
var_0_2.CS_24020_TYPE_FIELD.name = "type"
var_0_2.CS_24020_TYPE_FIELD.full_name = "p24.cs_24020.type"
var_0_2.CS_24020_TYPE_FIELD.number = 1
var_0_2.CS_24020_TYPE_FIELD.index = 0
var_0_2.CS_24020_TYPE_FIELD.label = 2
var_0_2.CS_24020_TYPE_FIELD.has_default_value = false
var_0_2.CS_24020_TYPE_FIELD.default_value = 0
var_0_2.CS_24020_TYPE_FIELD.type = 13
var_0_2.CS_24020_TYPE_FIELD.cpp_type = 3
CS_24020.name = "cs_24020"
CS_24020.full_name = "p24.cs_24020"
CS_24020.nested_types = {}
CS_24020.enum_types = {}
CS_24020.fields = {
	var_0_2.CS_24020_TYPE_FIELD
}
CS_24020.is_extendable = false
CS_24020.extensions = {}
var_0_2.SC_24021_RESULT_FIELD.name = "result"
var_0_2.SC_24021_RESULT_FIELD.full_name = "p24.sc_24021.result"
var_0_2.SC_24021_RESULT_FIELD.number = 1
var_0_2.SC_24021_RESULT_FIELD.index = 0
var_0_2.SC_24021_RESULT_FIELD.label = 2
var_0_2.SC_24021_RESULT_FIELD.has_default_value = false
var_0_2.SC_24021_RESULT_FIELD.default_value = 0
var_0_2.SC_24021_RESULT_FIELD.type = 13
var_0_2.SC_24021_RESULT_FIELD.cpp_type = 3
var_0_2.SC_24021_TIMES_FIELD.name = "times"
var_0_2.SC_24021_TIMES_FIELD.full_name = "p24.sc_24021.times"
var_0_2.SC_24021_TIMES_FIELD.number = 2
var_0_2.SC_24021_TIMES_FIELD.index = 1
var_0_2.SC_24021_TIMES_FIELD.label = 3
var_0_2.SC_24021_TIMES_FIELD.has_default_value = false
var_0_2.SC_24021_TIMES_FIELD.default_value = {}
var_0_2.SC_24021_TIMES_FIELD.message_type = var_0_1.KVDATA
var_0_2.SC_24021_TIMES_FIELD.type = 11
var_0_2.SC_24021_TIMES_FIELD.cpp_type = 10
var_0_2.SC_24021_AWARDS_FIELD.name = "awards"
var_0_2.SC_24021_AWARDS_FIELD.full_name = "p24.sc_24021.awards"
var_0_2.SC_24021_AWARDS_FIELD.number = 3
var_0_2.SC_24021_AWARDS_FIELD.index = 2
var_0_2.SC_24021_AWARDS_FIELD.label = 3
var_0_2.SC_24021_AWARDS_FIELD.has_default_value = false
var_0_2.SC_24021_AWARDS_FIELD.default_value = {}
var_0_2.SC_24021_AWARDS_FIELD.message_type = var_0_1.KVDATA
var_0_2.SC_24021_AWARDS_FIELD.type = 11
var_0_2.SC_24021_AWARDS_FIELD.cpp_type = 10
SC_24021.name = "sc_24021"
SC_24021.full_name = "p24.sc_24021"
SC_24021.nested_types = {}
SC_24021.enum_types = {}
SC_24021.fields = {
	var_0_2.SC_24021_RESULT_FIELD,
	var_0_2.SC_24021_TIMES_FIELD,
	var_0_2.SC_24021_AWARDS_FIELD
}
SC_24021.is_extendable = false
SC_24021.extensions = {}
var_0_2.CS_24022_CHALLENGEIDS_FIELD.name = "challengeids"
var_0_2.CS_24022_CHALLENGEIDS_FIELD.full_name = "p24.cs_24022.challengeids"
var_0_2.CS_24022_CHALLENGEIDS_FIELD.number = 1
var_0_2.CS_24022_CHALLENGEIDS_FIELD.index = 0
var_0_2.CS_24022_CHALLENGEIDS_FIELD.label = 3
var_0_2.CS_24022_CHALLENGEIDS_FIELD.has_default_value = false
var_0_2.CS_24022_CHALLENGEIDS_FIELD.default_value = {}
var_0_2.CS_24022_CHALLENGEIDS_FIELD.type = 13
var_0_2.CS_24022_CHALLENGEIDS_FIELD.cpp_type = 3
CS_24022.name = "cs_24022"
CS_24022.full_name = "p24.cs_24022"
CS_24022.nested_types = {}
CS_24022.enum_types = {}
CS_24022.fields = {
	var_0_2.CS_24022_CHALLENGEIDS_FIELD
}
CS_24022.is_extendable = false
CS_24022.extensions = {}
var_0_2.SC_24023_RESULT_FIELD.name = "result"
var_0_2.SC_24023_RESULT_FIELD.full_name = "p24.sc_24023.result"
var_0_2.SC_24023_RESULT_FIELD.number = 1
var_0_2.SC_24023_RESULT_FIELD.index = 0
var_0_2.SC_24023_RESULT_FIELD.label = 2
var_0_2.SC_24023_RESULT_FIELD.has_default_value = false
var_0_2.SC_24023_RESULT_FIELD.default_value = 0
var_0_2.SC_24023_RESULT_FIELD.type = 13
var_0_2.SC_24023_RESULT_FIELD.cpp_type = 3
var_0_2.SC_24023_DROP_LIST_FIELD.name = "drop_list"
var_0_2.SC_24023_DROP_LIST_FIELD.full_name = "p24.sc_24023.drop_list"
var_0_2.SC_24023_DROP_LIST_FIELD.number = 2
var_0_2.SC_24023_DROP_LIST_FIELD.index = 1
var_0_2.SC_24023_DROP_LIST_FIELD.label = 3
var_0_2.SC_24023_DROP_LIST_FIELD.has_default_value = false
var_0_2.SC_24023_DROP_LIST_FIELD.default_value = {}
var_0_2.SC_24023_DROP_LIST_FIELD.message_type = var_0_1.DROPINFO
var_0_2.SC_24023_DROP_LIST_FIELD.type = 11
var_0_2.SC_24023_DROP_LIST_FIELD.cpp_type = 10
SC_24023.name = "sc_24023"
SC_24023.full_name = "p24.sc_24023"
SC_24023.nested_types = {}
SC_24023.enum_types = {}
SC_24023.fields = {
	var_0_2.SC_24023_RESULT_FIELD,
	var_0_2.SC_24023_DROP_LIST_FIELD
}
SC_24023.is_extendable = false
SC_24023.extensions = {}
var_0_2.SC_24100_SCORE_FIELD.name = "score"
var_0_2.SC_24100_SCORE_FIELD.full_name = "p24.sc_24100.score"
var_0_2.SC_24100_SCORE_FIELD.number = 1
var_0_2.SC_24100_SCORE_FIELD.index = 0
var_0_2.SC_24100_SCORE_FIELD.label = 2
var_0_2.SC_24100_SCORE_FIELD.has_default_value = false
var_0_2.SC_24100_SCORE_FIELD.default_value = 0
var_0_2.SC_24100_SCORE_FIELD.type = 13
var_0_2.SC_24100_SCORE_FIELD.cpp_type = 3
SC_24100.name = "sc_24100"
SC_24100.full_name = "p24.sc_24100"
SC_24100.nested_types = {}
SC_24100.enum_types = {}
SC_24100.fields = {
	var_0_2.SC_24100_SCORE_FIELD
}
SC_24100.is_extendable = false
SC_24100.extensions = {}
challengeinfo = var_0_0.Message(CHALLENGEINFO)
commanderinchallenge = var_0_0.Message(COMMANDERINCHALLENGE)
cs_24002 = var_0_0.Message(CS_24002)
cs_24004 = var_0_0.Message(CS_24004)
cs_24011 = var_0_0.Message(CS_24011)
cs_24020 = var_0_0.Message(CS_24020)
cs_24022 = var_0_0.Message(CS_24022)
groupinfo = var_0_0.Message(GROUPINFO)
groupinfoinchallenge = var_0_0.Message(GROUPINFOINCHALLENGE)
sc_24003 = var_0_0.Message(SC_24003)
sc_24005 = var_0_0.Message(SC_24005)
sc_24010 = var_0_0.Message(SC_24010)
sc_24012 = var_0_0.Message(SC_24012)
sc_24021 = var_0_0.Message(SC_24021)
sc_24023 = var_0_0.Message(SC_24023)
sc_24100 = var_0_0.Message(SC_24100)
shipinchallenge = var_0_0.Message(SHIPINCHALLENGE)
userchallengeinfo = var_0_0.Message(USERCHALLENGEINFO)
