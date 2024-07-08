﻿local var_0_0 = require("protobuf")
local var_0_1 = require("common_pb")

module("p22_pb")

local var_0_2 = {}

SC_22001 = var_0_0.Descriptor()
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_CLASS_LV_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_CLASS_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD = var_0_0.FieldDescriptor()
CS_22101 = var_0_0.Descriptor()
var_0_2.CS_22101_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_22102 = var_0_0.Descriptor()
var_0_2.SC_22102_STREET_FIELD = var_0_0.FieldDescriptor()
CS_22201 = var_0_0.Descriptor()
var_0_2.CS_22201_ROOM_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_22201_SHIP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_22201_SKILL_POS_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_22201_ITEM_ID_FIELD = var_0_0.FieldDescriptor()
SC_22202 = var_0_0.Descriptor()
var_0_2.SC_22202_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22202_CLASS_INFO_FIELD = var_0_0.FieldDescriptor()
CS_22203 = var_0_0.Descriptor()
var_0_2.CS_22203_ROOM_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_22203_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_22204 = var_0_0.Descriptor()
var_0_2.SC_22204_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22204_EXP_FIELD = var_0_0.FieldDescriptor()
CS_22009 = var_0_0.Descriptor()
var_0_2.CS_22009_TYPE_FIELD = var_0_0.FieldDescriptor()
SC_22010 = var_0_0.Descriptor()
var_0_2.SC_22010_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22010_EXP_IN_WELL_FIELD = var_0_0.FieldDescriptor()
CS_22011 = var_0_0.Descriptor()
var_0_2.CS_22011_SHIP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_22011_BOOKS_FIELD = var_0_0.FieldDescriptor()
SC_22012 = var_0_0.Descriptor()
var_0_2.SC_22012_RESULT_FIELD = var_0_0.FieldDescriptor()
SC_22013 = var_0_0.Descriptor()
var_0_2.SC_22013_PROFICIENCY_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22013_EXP_IN_WELL_FIELD = var_0_0.FieldDescriptor()
CS_22014 = var_0_0.Descriptor()
var_0_2.CS_22014_ROOMID_FIELD = var_0_0.FieldDescriptor()
SC_22015 = var_0_0.Descriptor()
var_0_2.SC_22015_RESULT_FIELD = var_0_0.FieldDescriptor()
NAVALACADEMY_CLASS = var_0_0.Descriptor()
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD = var_0_0.FieldDescriptor()
NAVALACADEMY_STUDENT = var_0_0.Descriptor()
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD = var_0_0.FieldDescriptor()
SHOPPINGSTREET = var_0_0.Descriptor()
var_0_2.SHOPPINGSTREET_LV_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD = var_0_0.FieldDescriptor()
STREETGOODS = var_0_0.Descriptor()
var_0_2.STREETGOODS_GOODS_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.STREETGOODS_DISCOUNT_FIELD = var_0_0.FieldDescriptor()
var_0_2.STREETGOODS_BUY_COUNT_FIELD = var_0_0.FieldDescriptor()
SKILL_CLASS = var_0_0.Descriptor()
var_0_2.SKILL_CLASS_ROOM_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.SKILL_CLASS_SHIP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.SKILL_CLASS_START_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD = var_0_0.FieldDescriptor()
var_0_2.SKILL_CLASS_SKILL_POS_FIELD = var_0_0.FieldDescriptor()
var_0_2.SKILL_CLASS_EXP_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.name = "oil_well_level"
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.full_name = "p22.sc_22001.oil_well_level"
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.number = 1
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.index = 0
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.label = 2
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.has_default_value = false
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.default_value = 0
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.type = 13
var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD.cpp_type = 3
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.name = "oil_well_lv_up_time"
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.full_name = "p22.sc_22001.oil_well_lv_up_time"
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.number = 2
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.index = 1
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.label = 2
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.has_default_value = false
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.default_value = 0
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.type = 13
var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD.cpp_type = 3
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.name = "gold_well_level"
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.full_name = "p22.sc_22001.gold_well_level"
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.number = 3
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.index = 2
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.label = 2
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.has_default_value = false
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.default_value = 0
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.type = 13
var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD.cpp_type = 3
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.name = "gold_well_lv_up_time"
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.full_name = "p22.sc_22001.gold_well_lv_up_time"
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.number = 4
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.index = 3
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.label = 2
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.has_default_value = false
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.default_value = 0
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.type = 13
var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD.cpp_type = 3
var_0_2.SC_22001_CLASS_LV_FIELD.name = "class_lv"
var_0_2.SC_22001_CLASS_LV_FIELD.full_name = "p22.sc_22001.class_lv"
var_0_2.SC_22001_CLASS_LV_FIELD.number = 5
var_0_2.SC_22001_CLASS_LV_FIELD.index = 4
var_0_2.SC_22001_CLASS_LV_FIELD.label = 2
var_0_2.SC_22001_CLASS_LV_FIELD.has_default_value = false
var_0_2.SC_22001_CLASS_LV_FIELD.default_value = 0
var_0_2.SC_22001_CLASS_LV_FIELD.type = 13
var_0_2.SC_22001_CLASS_LV_FIELD.cpp_type = 3
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.name = "class_lv_up_time"
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.full_name = "p22.sc_22001.class_lv_up_time"
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.number = 6
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.index = 5
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.label = 2
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.has_default_value = false
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.default_value = 0
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.type = 13
var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD.cpp_type = 3
var_0_2.SC_22001_CLASS_FIELD.name = "class"
var_0_2.SC_22001_CLASS_FIELD.full_name = "p22.sc_22001.class"
var_0_2.SC_22001_CLASS_FIELD.number = 7
var_0_2.SC_22001_CLASS_FIELD.index = 6
var_0_2.SC_22001_CLASS_FIELD.label = 2
var_0_2.SC_22001_CLASS_FIELD.has_default_value = false
var_0_2.SC_22001_CLASS_FIELD.default_value = nil
var_0_2.SC_22001_CLASS_FIELD.message_type = NAVALACADEMY_CLASS
var_0_2.SC_22001_CLASS_FIELD.type = 11
var_0_2.SC_22001_CLASS_FIELD.cpp_type = 10
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.name = "skill_class_list"
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.full_name = "p22.sc_22001.skill_class_list"
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.number = 8
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.index = 7
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.label = 3
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.has_default_value = false
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.default_value = {}
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.message_type = SKILL_CLASS
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.type = 11
var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD.cpp_type = 10
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.name = "skill_class_num"
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.full_name = "p22.sc_22001.skill_class_num"
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.number = 9
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.index = 8
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.label = 2
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.has_default_value = false
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.default_value = 0
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.type = 13
var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD.cpp_type = 3
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.name = "daily_finish_buff_cnt"
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.full_name = "p22.sc_22001.daily_finish_buff_cnt"
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.number = 10
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.index = 9
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.label = 2
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.has_default_value = false
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.default_value = 0
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.type = 13
var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD.cpp_type = 3
SC_22001.name = "sc_22001"
SC_22001.full_name = "p22.sc_22001"
SC_22001.nested_types = {}
SC_22001.enum_types = {}
SC_22001.fields = {
	var_0_2.SC_22001_OIL_WELL_LEVEL_FIELD,
	var_0_2.SC_22001_OIL_WELL_LV_UP_TIME_FIELD,
	var_0_2.SC_22001_GOLD_WELL_LEVEL_FIELD,
	var_0_2.SC_22001_GOLD_WELL_LV_UP_TIME_FIELD,
	var_0_2.SC_22001_CLASS_LV_FIELD,
	var_0_2.SC_22001_CLASS_LV_UP_TIME_FIELD,
	var_0_2.SC_22001_CLASS_FIELD,
	var_0_2.SC_22001_SKILL_CLASS_LIST_FIELD,
	var_0_2.SC_22001_SKILL_CLASS_NUM_FIELD,
	var_0_2.SC_22001_DAILY_FINISH_BUFF_CNT_FIELD
}
SC_22001.is_extendable = false
SC_22001.extensions = {}
var_0_2.CS_22101_TYPE_FIELD.name = "type"
var_0_2.CS_22101_TYPE_FIELD.full_name = "p22.cs_22101.type"
var_0_2.CS_22101_TYPE_FIELD.number = 1
var_0_2.CS_22101_TYPE_FIELD.index = 0
var_0_2.CS_22101_TYPE_FIELD.label = 2
var_0_2.CS_22101_TYPE_FIELD.has_default_value = false
var_0_2.CS_22101_TYPE_FIELD.default_value = 0
var_0_2.CS_22101_TYPE_FIELD.type = 13
var_0_2.CS_22101_TYPE_FIELD.cpp_type = 3
CS_22101.name = "cs_22101"
CS_22101.full_name = "p22.cs_22101"
CS_22101.nested_types = {}
CS_22101.enum_types = {}
CS_22101.fields = {
	var_0_2.CS_22101_TYPE_FIELD
}
CS_22101.is_extendable = false
CS_22101.extensions = {}
var_0_2.SC_22102_STREET_FIELD.name = "street"
var_0_2.SC_22102_STREET_FIELD.full_name = "p22.sc_22102.street"
var_0_2.SC_22102_STREET_FIELD.number = 1
var_0_2.SC_22102_STREET_FIELD.index = 0
var_0_2.SC_22102_STREET_FIELD.label = 2
var_0_2.SC_22102_STREET_FIELD.has_default_value = false
var_0_2.SC_22102_STREET_FIELD.default_value = nil
var_0_2.SC_22102_STREET_FIELD.message_type = SHOPPINGSTREET
var_0_2.SC_22102_STREET_FIELD.type = 11
var_0_2.SC_22102_STREET_FIELD.cpp_type = 10
SC_22102.name = "sc_22102"
SC_22102.full_name = "p22.sc_22102"
SC_22102.nested_types = {}
SC_22102.enum_types = {}
SC_22102.fields = {
	var_0_2.SC_22102_STREET_FIELD
}
SC_22102.is_extendable = false
SC_22102.extensions = {}
var_0_2.CS_22201_ROOM_ID_FIELD.name = "room_id"
var_0_2.CS_22201_ROOM_ID_FIELD.full_name = "p22.cs_22201.room_id"
var_0_2.CS_22201_ROOM_ID_FIELD.number = 1
var_0_2.CS_22201_ROOM_ID_FIELD.index = 0
var_0_2.CS_22201_ROOM_ID_FIELD.label = 2
var_0_2.CS_22201_ROOM_ID_FIELD.has_default_value = false
var_0_2.CS_22201_ROOM_ID_FIELD.default_value = 0
var_0_2.CS_22201_ROOM_ID_FIELD.type = 13
var_0_2.CS_22201_ROOM_ID_FIELD.cpp_type = 3
var_0_2.CS_22201_SHIP_ID_FIELD.name = "ship_id"
var_0_2.CS_22201_SHIP_ID_FIELD.full_name = "p22.cs_22201.ship_id"
var_0_2.CS_22201_SHIP_ID_FIELD.number = 2
var_0_2.CS_22201_SHIP_ID_FIELD.index = 1
var_0_2.CS_22201_SHIP_ID_FIELD.label = 2
var_0_2.CS_22201_SHIP_ID_FIELD.has_default_value = false
var_0_2.CS_22201_SHIP_ID_FIELD.default_value = 0
var_0_2.CS_22201_SHIP_ID_FIELD.type = 13
var_0_2.CS_22201_SHIP_ID_FIELD.cpp_type = 3
var_0_2.CS_22201_SKILL_POS_FIELD.name = "skill_pos"
var_0_2.CS_22201_SKILL_POS_FIELD.full_name = "p22.cs_22201.skill_pos"
var_0_2.CS_22201_SKILL_POS_FIELD.number = 3
var_0_2.CS_22201_SKILL_POS_FIELD.index = 2
var_0_2.CS_22201_SKILL_POS_FIELD.label = 2
var_0_2.CS_22201_SKILL_POS_FIELD.has_default_value = false
var_0_2.CS_22201_SKILL_POS_FIELD.default_value = 0
var_0_2.CS_22201_SKILL_POS_FIELD.type = 13
var_0_2.CS_22201_SKILL_POS_FIELD.cpp_type = 3
var_0_2.CS_22201_ITEM_ID_FIELD.name = "item_id"
var_0_2.CS_22201_ITEM_ID_FIELD.full_name = "p22.cs_22201.item_id"
var_0_2.CS_22201_ITEM_ID_FIELD.number = 4
var_0_2.CS_22201_ITEM_ID_FIELD.index = 3
var_0_2.CS_22201_ITEM_ID_FIELD.label = 2
var_0_2.CS_22201_ITEM_ID_FIELD.has_default_value = false
var_0_2.CS_22201_ITEM_ID_FIELD.default_value = 0
var_0_2.CS_22201_ITEM_ID_FIELD.type = 13
var_0_2.CS_22201_ITEM_ID_FIELD.cpp_type = 3
CS_22201.name = "cs_22201"
CS_22201.full_name = "p22.cs_22201"
CS_22201.nested_types = {}
CS_22201.enum_types = {}
CS_22201.fields = {
	var_0_2.CS_22201_ROOM_ID_FIELD,
	var_0_2.CS_22201_SHIP_ID_FIELD,
	var_0_2.CS_22201_SKILL_POS_FIELD,
	var_0_2.CS_22201_ITEM_ID_FIELD
}
CS_22201.is_extendable = false
CS_22201.extensions = {}
var_0_2.SC_22202_RESULT_FIELD.name = "result"
var_0_2.SC_22202_RESULT_FIELD.full_name = "p22.sc_22202.result"
var_0_2.SC_22202_RESULT_FIELD.number = 1
var_0_2.SC_22202_RESULT_FIELD.index = 0
var_0_2.SC_22202_RESULT_FIELD.label = 2
var_0_2.SC_22202_RESULT_FIELD.has_default_value = false
var_0_2.SC_22202_RESULT_FIELD.default_value = 0
var_0_2.SC_22202_RESULT_FIELD.type = 13
var_0_2.SC_22202_RESULT_FIELD.cpp_type = 3
var_0_2.SC_22202_CLASS_INFO_FIELD.name = "class_info"
var_0_2.SC_22202_CLASS_INFO_FIELD.full_name = "p22.sc_22202.class_info"
var_0_2.SC_22202_CLASS_INFO_FIELD.number = 2
var_0_2.SC_22202_CLASS_INFO_FIELD.index = 1
var_0_2.SC_22202_CLASS_INFO_FIELD.label = 1
var_0_2.SC_22202_CLASS_INFO_FIELD.has_default_value = false
var_0_2.SC_22202_CLASS_INFO_FIELD.default_value = nil
var_0_2.SC_22202_CLASS_INFO_FIELD.message_type = SKILL_CLASS
var_0_2.SC_22202_CLASS_INFO_FIELD.type = 11
var_0_2.SC_22202_CLASS_INFO_FIELD.cpp_type = 10
SC_22202.name = "sc_22202"
SC_22202.full_name = "p22.sc_22202"
SC_22202.nested_types = {}
SC_22202.enum_types = {}
SC_22202.fields = {
	var_0_2.SC_22202_RESULT_FIELD,
	var_0_2.SC_22202_CLASS_INFO_FIELD
}
SC_22202.is_extendable = false
SC_22202.extensions = {}
var_0_2.CS_22203_ROOM_ID_FIELD.name = "room_id"
var_0_2.CS_22203_ROOM_ID_FIELD.full_name = "p22.cs_22203.room_id"
var_0_2.CS_22203_ROOM_ID_FIELD.number = 1
var_0_2.CS_22203_ROOM_ID_FIELD.index = 0
var_0_2.CS_22203_ROOM_ID_FIELD.label = 2
var_0_2.CS_22203_ROOM_ID_FIELD.has_default_value = false
var_0_2.CS_22203_ROOM_ID_FIELD.default_value = 0
var_0_2.CS_22203_ROOM_ID_FIELD.type = 13
var_0_2.CS_22203_ROOM_ID_FIELD.cpp_type = 3
var_0_2.CS_22203_TYPE_FIELD.name = "type"
var_0_2.CS_22203_TYPE_FIELD.full_name = "p22.cs_22203.type"
var_0_2.CS_22203_TYPE_FIELD.number = 2
var_0_2.CS_22203_TYPE_FIELD.index = 1
var_0_2.CS_22203_TYPE_FIELD.label = 2
var_0_2.CS_22203_TYPE_FIELD.has_default_value = false
var_0_2.CS_22203_TYPE_FIELD.default_value = 0
var_0_2.CS_22203_TYPE_FIELD.type = 13
var_0_2.CS_22203_TYPE_FIELD.cpp_type = 3
CS_22203.name = "cs_22203"
CS_22203.full_name = "p22.cs_22203"
CS_22203.nested_types = {}
CS_22203.enum_types = {}
CS_22203.fields = {
	var_0_2.CS_22203_ROOM_ID_FIELD,
	var_0_2.CS_22203_TYPE_FIELD
}
CS_22203.is_extendable = false
CS_22203.extensions = {}
var_0_2.SC_22204_RESULT_FIELD.name = "result"
var_0_2.SC_22204_RESULT_FIELD.full_name = "p22.sc_22204.result"
var_0_2.SC_22204_RESULT_FIELD.number = 1
var_0_2.SC_22204_RESULT_FIELD.index = 0
var_0_2.SC_22204_RESULT_FIELD.label = 2
var_0_2.SC_22204_RESULT_FIELD.has_default_value = false
var_0_2.SC_22204_RESULT_FIELD.default_value = 0
var_0_2.SC_22204_RESULT_FIELD.type = 13
var_0_2.SC_22204_RESULT_FIELD.cpp_type = 3
var_0_2.SC_22204_EXP_FIELD.name = "exp"
var_0_2.SC_22204_EXP_FIELD.full_name = "p22.sc_22204.exp"
var_0_2.SC_22204_EXP_FIELD.number = 2
var_0_2.SC_22204_EXP_FIELD.index = 1
var_0_2.SC_22204_EXP_FIELD.label = 1
var_0_2.SC_22204_EXP_FIELD.has_default_value = false
var_0_2.SC_22204_EXP_FIELD.default_value = 0
var_0_2.SC_22204_EXP_FIELD.type = 13
var_0_2.SC_22204_EXP_FIELD.cpp_type = 3
SC_22204.name = "sc_22204"
SC_22204.full_name = "p22.sc_22204"
SC_22204.nested_types = {}
SC_22204.enum_types = {}
SC_22204.fields = {
	var_0_2.SC_22204_RESULT_FIELD,
	var_0_2.SC_22204_EXP_FIELD
}
SC_22204.is_extendable = false
SC_22204.extensions = {}
var_0_2.CS_22009_TYPE_FIELD.name = "type"
var_0_2.CS_22009_TYPE_FIELD.full_name = "p22.cs_22009.type"
var_0_2.CS_22009_TYPE_FIELD.number = 1
var_0_2.CS_22009_TYPE_FIELD.index = 0
var_0_2.CS_22009_TYPE_FIELD.label = 2
var_0_2.CS_22009_TYPE_FIELD.has_default_value = false
var_0_2.CS_22009_TYPE_FIELD.default_value = 0
var_0_2.CS_22009_TYPE_FIELD.type = 13
var_0_2.CS_22009_TYPE_FIELD.cpp_type = 3
CS_22009.name = "cs_22009"
CS_22009.full_name = "p22.cs_22009"
CS_22009.nested_types = {}
CS_22009.enum_types = {}
CS_22009.fields = {
	var_0_2.CS_22009_TYPE_FIELD
}
CS_22009.is_extendable = false
CS_22009.extensions = {}
var_0_2.SC_22010_RESULT_FIELD.name = "result"
var_0_2.SC_22010_RESULT_FIELD.full_name = "p22.sc_22010.result"
var_0_2.SC_22010_RESULT_FIELD.number = 1
var_0_2.SC_22010_RESULT_FIELD.index = 0
var_0_2.SC_22010_RESULT_FIELD.label = 2
var_0_2.SC_22010_RESULT_FIELD.has_default_value = false
var_0_2.SC_22010_RESULT_FIELD.default_value = 0
var_0_2.SC_22010_RESULT_FIELD.type = 13
var_0_2.SC_22010_RESULT_FIELD.cpp_type = 3
var_0_2.SC_22010_EXP_IN_WELL_FIELD.name = "exp_in_well"
var_0_2.SC_22010_EXP_IN_WELL_FIELD.full_name = "p22.sc_22010.exp_in_well"
var_0_2.SC_22010_EXP_IN_WELL_FIELD.number = 2
var_0_2.SC_22010_EXP_IN_WELL_FIELD.index = 1
var_0_2.SC_22010_EXP_IN_WELL_FIELD.label = 2
var_0_2.SC_22010_EXP_IN_WELL_FIELD.has_default_value = false
var_0_2.SC_22010_EXP_IN_WELL_FIELD.default_value = 0
var_0_2.SC_22010_EXP_IN_WELL_FIELD.type = 13
var_0_2.SC_22010_EXP_IN_WELL_FIELD.cpp_type = 3
SC_22010.name = "sc_22010"
SC_22010.full_name = "p22.sc_22010"
SC_22010.nested_types = {}
SC_22010.enum_types = {}
SC_22010.fields = {
	var_0_2.SC_22010_RESULT_FIELD,
	var_0_2.SC_22010_EXP_IN_WELL_FIELD
}
SC_22010.is_extendable = false
SC_22010.extensions = {}
var_0_2.CS_22011_SHIP_ID_FIELD.name = "ship_id"
var_0_2.CS_22011_SHIP_ID_FIELD.full_name = "p22.cs_22011.ship_id"
var_0_2.CS_22011_SHIP_ID_FIELD.number = 1
var_0_2.CS_22011_SHIP_ID_FIELD.index = 0
var_0_2.CS_22011_SHIP_ID_FIELD.label = 2
var_0_2.CS_22011_SHIP_ID_FIELD.has_default_value = false
var_0_2.CS_22011_SHIP_ID_FIELD.default_value = 0
var_0_2.CS_22011_SHIP_ID_FIELD.type = 13
var_0_2.CS_22011_SHIP_ID_FIELD.cpp_type = 3
var_0_2.CS_22011_BOOKS_FIELD.name = "books"
var_0_2.CS_22011_BOOKS_FIELD.full_name = "p22.cs_22011.books"
var_0_2.CS_22011_BOOKS_FIELD.number = 2
var_0_2.CS_22011_BOOKS_FIELD.index = 1
var_0_2.CS_22011_BOOKS_FIELD.label = 3
var_0_2.CS_22011_BOOKS_FIELD.has_default_value = false
var_0_2.CS_22011_BOOKS_FIELD.default_value = {}
var_0_2.CS_22011_BOOKS_FIELD.message_type = var_0_1.ITEM_INFO
var_0_2.CS_22011_BOOKS_FIELD.type = 11
var_0_2.CS_22011_BOOKS_FIELD.cpp_type = 10
CS_22011.name = "cs_22011"
CS_22011.full_name = "p22.cs_22011"
CS_22011.nested_types = {}
CS_22011.enum_types = {}
CS_22011.fields = {
	var_0_2.CS_22011_SHIP_ID_FIELD,
	var_0_2.CS_22011_BOOKS_FIELD
}
CS_22011.is_extendable = false
CS_22011.extensions = {}
var_0_2.SC_22012_RESULT_FIELD.name = "result"
var_0_2.SC_22012_RESULT_FIELD.full_name = "p22.sc_22012.result"
var_0_2.SC_22012_RESULT_FIELD.number = 1
var_0_2.SC_22012_RESULT_FIELD.index = 0
var_0_2.SC_22012_RESULT_FIELD.label = 2
var_0_2.SC_22012_RESULT_FIELD.has_default_value = false
var_0_2.SC_22012_RESULT_FIELD.default_value = 0
var_0_2.SC_22012_RESULT_FIELD.type = 13
var_0_2.SC_22012_RESULT_FIELD.cpp_type = 3
SC_22012.name = "sc_22012"
SC_22012.full_name = "p22.sc_22012"
SC_22012.nested_types = {}
SC_22012.enum_types = {}
SC_22012.fields = {
	var_0_2.SC_22012_RESULT_FIELD
}
SC_22012.is_extendable = false
SC_22012.extensions = {}
var_0_2.SC_22013_PROFICIENCY_FIELD.name = "proficiency"
var_0_2.SC_22013_PROFICIENCY_FIELD.full_name = "p22.sc_22013.proficiency"
var_0_2.SC_22013_PROFICIENCY_FIELD.number = 1
var_0_2.SC_22013_PROFICIENCY_FIELD.index = 0
var_0_2.SC_22013_PROFICIENCY_FIELD.label = 2
var_0_2.SC_22013_PROFICIENCY_FIELD.has_default_value = false
var_0_2.SC_22013_PROFICIENCY_FIELD.default_value = 0
var_0_2.SC_22013_PROFICIENCY_FIELD.type = 13
var_0_2.SC_22013_PROFICIENCY_FIELD.cpp_type = 3
var_0_2.SC_22013_EXP_IN_WELL_FIELD.name = "exp_in_well"
var_0_2.SC_22013_EXP_IN_WELL_FIELD.full_name = "p22.sc_22013.exp_in_well"
var_0_2.SC_22013_EXP_IN_WELL_FIELD.number = 2
var_0_2.SC_22013_EXP_IN_WELL_FIELD.index = 1
var_0_2.SC_22013_EXP_IN_WELL_FIELD.label = 2
var_0_2.SC_22013_EXP_IN_WELL_FIELD.has_default_value = false
var_0_2.SC_22013_EXP_IN_WELL_FIELD.default_value = 0
var_0_2.SC_22013_EXP_IN_WELL_FIELD.type = 13
var_0_2.SC_22013_EXP_IN_WELL_FIELD.cpp_type = 3
SC_22013.name = "sc_22013"
SC_22013.full_name = "p22.sc_22013"
SC_22013.nested_types = {}
SC_22013.enum_types = {}
SC_22013.fields = {
	var_0_2.SC_22013_PROFICIENCY_FIELD,
	var_0_2.SC_22013_EXP_IN_WELL_FIELD
}
SC_22013.is_extendable = false
SC_22013.extensions = {}
var_0_2.CS_22014_ROOMID_FIELD.name = "roomid"
var_0_2.CS_22014_ROOMID_FIELD.full_name = "p22.cs_22014.roomid"
var_0_2.CS_22014_ROOMID_FIELD.number = 1
var_0_2.CS_22014_ROOMID_FIELD.index = 0
var_0_2.CS_22014_ROOMID_FIELD.label = 2
var_0_2.CS_22014_ROOMID_FIELD.has_default_value = false
var_0_2.CS_22014_ROOMID_FIELD.default_value = 0
var_0_2.CS_22014_ROOMID_FIELD.type = 13
var_0_2.CS_22014_ROOMID_FIELD.cpp_type = 3
CS_22014.name = "cs_22014"
CS_22014.full_name = "p22.cs_22014"
CS_22014.nested_types = {}
CS_22014.enum_types = {}
CS_22014.fields = {
	var_0_2.CS_22014_ROOMID_FIELD
}
CS_22014.is_extendable = false
CS_22014.extensions = {}
var_0_2.SC_22015_RESULT_FIELD.name = "result"
var_0_2.SC_22015_RESULT_FIELD.full_name = "p22.sc_22015.result"
var_0_2.SC_22015_RESULT_FIELD.number = 1
var_0_2.SC_22015_RESULT_FIELD.index = 0
var_0_2.SC_22015_RESULT_FIELD.label = 2
var_0_2.SC_22015_RESULT_FIELD.has_default_value = false
var_0_2.SC_22015_RESULT_FIELD.default_value = 0
var_0_2.SC_22015_RESULT_FIELD.type = 13
var_0_2.SC_22015_RESULT_FIELD.cpp_type = 3
SC_22015.name = "sc_22015"
SC_22015.full_name = "p22.sc_22015"
SC_22015.nested_types = {}
SC_22015.enum_types = {}
SC_22015.fields = {
	var_0_2.SC_22015_RESULT_FIELD
}
SC_22015.is_extendable = false
SC_22015.extensions = {}
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.name = "proficiency"
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.full_name = "p22.navalacademy_class.proficiency"
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.number = 1
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.index = 0
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.label = 2
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.has_default_value = false
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.default_value = 0
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.type = 13
var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD.cpp_type = 3
NAVALACADEMY_CLASS.name = "navalacademy_class"
NAVALACADEMY_CLASS.full_name = "p22.navalacademy_class"
NAVALACADEMY_CLASS.nested_types = {}
NAVALACADEMY_CLASS.enum_types = {}
NAVALACADEMY_CLASS.fields = {
	var_0_2.NAVALACADEMY_CLASS_PROFICIENCY_FIELD
}
NAVALACADEMY_CLASS.is_extendable = false
NAVALACADEMY_CLASS.extensions = {}
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.name = "ship_id"
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.full_name = "p22.navalacademy_student.ship_id"
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.number = 1
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.index = 0
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.label = 2
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.has_default_value = false
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.default_value = 0
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.type = 13
var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD.cpp_type = 3
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.name = "energy"
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.full_name = "p22.navalacademy_student.energy"
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.number = 2
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.index = 1
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.label = 2
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.has_default_value = false
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.default_value = 0
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.type = 13
var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD.cpp_type = 3
NAVALACADEMY_STUDENT.name = "navalacademy_student"
NAVALACADEMY_STUDENT.full_name = "p22.navalacademy_student"
NAVALACADEMY_STUDENT.nested_types = {}
NAVALACADEMY_STUDENT.enum_types = {}
NAVALACADEMY_STUDENT.fields = {
	var_0_2.NAVALACADEMY_STUDENT_SHIP_ID_FIELD,
	var_0_2.NAVALACADEMY_STUDENT_ENERGY_FIELD
}
NAVALACADEMY_STUDENT.is_extendable = false
NAVALACADEMY_STUDENT.extensions = {}
var_0_2.SHOPPINGSTREET_LV_FIELD.name = "lv"
var_0_2.SHOPPINGSTREET_LV_FIELD.full_name = "p22.shoppingstreet.lv"
var_0_2.SHOPPINGSTREET_LV_FIELD.number = 1
var_0_2.SHOPPINGSTREET_LV_FIELD.index = 0
var_0_2.SHOPPINGSTREET_LV_FIELD.label = 2
var_0_2.SHOPPINGSTREET_LV_FIELD.has_default_value = false
var_0_2.SHOPPINGSTREET_LV_FIELD.default_value = 0
var_0_2.SHOPPINGSTREET_LV_FIELD.type = 13
var_0_2.SHOPPINGSTREET_LV_FIELD.cpp_type = 3
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.name = "next_flash_time"
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.full_name = "p22.shoppingstreet.next_flash_time"
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.number = 2
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.index = 1
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.label = 2
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.has_default_value = false
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.default_value = 0
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.type = 13
var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD.cpp_type = 3
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.name = "lv_up_time"
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.full_name = "p22.shoppingstreet.lv_up_time"
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.number = 3
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.index = 2
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.label = 2
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.has_default_value = false
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.default_value = 0
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.type = 13
var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD.cpp_type = 3
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.name = "goods_list"
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.full_name = "p22.shoppingstreet.goods_list"
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.number = 4
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.index = 3
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.label = 3
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.has_default_value = false
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.default_value = {}
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.message_type = STREETGOODS
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.type = 11
var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD.cpp_type = 10
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.name = "flash_count"
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.full_name = "p22.shoppingstreet.flash_count"
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.number = 5
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.index = 4
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.label = 2
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.has_default_value = false
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.default_value = 0
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.type = 13
var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD.cpp_type = 3
SHOPPINGSTREET.name = "shoppingstreet"
SHOPPINGSTREET.full_name = "p22.shoppingstreet"
SHOPPINGSTREET.nested_types = {}
SHOPPINGSTREET.enum_types = {}
SHOPPINGSTREET.fields = {
	var_0_2.SHOPPINGSTREET_LV_FIELD,
	var_0_2.SHOPPINGSTREET_NEXT_FLASH_TIME_FIELD,
	var_0_2.SHOPPINGSTREET_LV_UP_TIME_FIELD,
	var_0_2.SHOPPINGSTREET_GOODS_LIST_FIELD,
	var_0_2.SHOPPINGSTREET_FLASH_COUNT_FIELD
}
SHOPPINGSTREET.is_extendable = false
SHOPPINGSTREET.extensions = {}
var_0_2.STREETGOODS_GOODS_ID_FIELD.name = "goods_id"
var_0_2.STREETGOODS_GOODS_ID_FIELD.full_name = "p22.streetgoods.goods_id"
var_0_2.STREETGOODS_GOODS_ID_FIELD.number = 1
var_0_2.STREETGOODS_GOODS_ID_FIELD.index = 0
var_0_2.STREETGOODS_GOODS_ID_FIELD.label = 2
var_0_2.STREETGOODS_GOODS_ID_FIELD.has_default_value = false
var_0_2.STREETGOODS_GOODS_ID_FIELD.default_value = 0
var_0_2.STREETGOODS_GOODS_ID_FIELD.type = 13
var_0_2.STREETGOODS_GOODS_ID_FIELD.cpp_type = 3
var_0_2.STREETGOODS_DISCOUNT_FIELD.name = "discount"
var_0_2.STREETGOODS_DISCOUNT_FIELD.full_name = "p22.streetgoods.discount"
var_0_2.STREETGOODS_DISCOUNT_FIELD.number = 2
var_0_2.STREETGOODS_DISCOUNT_FIELD.index = 1
var_0_2.STREETGOODS_DISCOUNT_FIELD.label = 2
var_0_2.STREETGOODS_DISCOUNT_FIELD.has_default_value = false
var_0_2.STREETGOODS_DISCOUNT_FIELD.default_value = 0
var_0_2.STREETGOODS_DISCOUNT_FIELD.type = 13
var_0_2.STREETGOODS_DISCOUNT_FIELD.cpp_type = 3
var_0_2.STREETGOODS_BUY_COUNT_FIELD.name = "buy_count"
var_0_2.STREETGOODS_BUY_COUNT_FIELD.full_name = "p22.streetgoods.buy_count"
var_0_2.STREETGOODS_BUY_COUNT_FIELD.number = 3
var_0_2.STREETGOODS_BUY_COUNT_FIELD.index = 2
var_0_2.STREETGOODS_BUY_COUNT_FIELD.label = 2
var_0_2.STREETGOODS_BUY_COUNT_FIELD.has_default_value = false
var_0_2.STREETGOODS_BUY_COUNT_FIELD.default_value = 0
var_0_2.STREETGOODS_BUY_COUNT_FIELD.type = 13
var_0_2.STREETGOODS_BUY_COUNT_FIELD.cpp_type = 3
STREETGOODS.name = "streetgoods"
STREETGOODS.full_name = "p22.streetgoods"
STREETGOODS.nested_types = {}
STREETGOODS.enum_types = {}
STREETGOODS.fields = {
	var_0_2.STREETGOODS_GOODS_ID_FIELD,
	var_0_2.STREETGOODS_DISCOUNT_FIELD,
	var_0_2.STREETGOODS_BUY_COUNT_FIELD
}
STREETGOODS.is_extendable = false
STREETGOODS.extensions = {}
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.name = "room_id"
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.full_name = "p22.skill_class.room_id"
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.number = 1
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.index = 0
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.label = 2
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.default_value = 0
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.type = 13
var_0_2.SKILL_CLASS_ROOM_ID_FIELD.cpp_type = 3
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.name = "ship_id"
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.full_name = "p22.skill_class.ship_id"
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.number = 2
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.index = 1
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.label = 2
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.default_value = 0
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.type = 13
var_0_2.SKILL_CLASS_SHIP_ID_FIELD.cpp_type = 3
var_0_2.SKILL_CLASS_START_TIME_FIELD.name = "start_time"
var_0_2.SKILL_CLASS_START_TIME_FIELD.full_name = "p22.skill_class.start_time"
var_0_2.SKILL_CLASS_START_TIME_FIELD.number = 3
var_0_2.SKILL_CLASS_START_TIME_FIELD.index = 2
var_0_2.SKILL_CLASS_START_TIME_FIELD.label = 2
var_0_2.SKILL_CLASS_START_TIME_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_START_TIME_FIELD.default_value = 0
var_0_2.SKILL_CLASS_START_TIME_FIELD.type = 13
var_0_2.SKILL_CLASS_START_TIME_FIELD.cpp_type = 3
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.name = "finish_time"
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.full_name = "p22.skill_class.finish_time"
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.number = 4
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.index = 3
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.label = 2
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.default_value = 0
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.type = 13
var_0_2.SKILL_CLASS_FINISH_TIME_FIELD.cpp_type = 3
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.name = "skill_pos"
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.full_name = "p22.skill_class.skill_pos"
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.number = 5
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.index = 4
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.label = 2
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.default_value = 0
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.type = 13
var_0_2.SKILL_CLASS_SKILL_POS_FIELD.cpp_type = 3
var_0_2.SKILL_CLASS_EXP_FIELD.name = "exp"
var_0_2.SKILL_CLASS_EXP_FIELD.full_name = "p22.skill_class.exp"
var_0_2.SKILL_CLASS_EXP_FIELD.number = 6
var_0_2.SKILL_CLASS_EXP_FIELD.index = 5
var_0_2.SKILL_CLASS_EXP_FIELD.label = 2
var_0_2.SKILL_CLASS_EXP_FIELD.has_default_value = false
var_0_2.SKILL_CLASS_EXP_FIELD.default_value = 0
var_0_2.SKILL_CLASS_EXP_FIELD.type = 13
var_0_2.SKILL_CLASS_EXP_FIELD.cpp_type = 3
SKILL_CLASS.name = "skill_class"
SKILL_CLASS.full_name = "p22.skill_class"
SKILL_CLASS.nested_types = {}
SKILL_CLASS.enum_types = {}
SKILL_CLASS.fields = {
	var_0_2.SKILL_CLASS_ROOM_ID_FIELD,
	var_0_2.SKILL_CLASS_SHIP_ID_FIELD,
	var_0_2.SKILL_CLASS_START_TIME_FIELD,
	var_0_2.SKILL_CLASS_FINISH_TIME_FIELD,
	var_0_2.SKILL_CLASS_SKILL_POS_FIELD,
	var_0_2.SKILL_CLASS_EXP_FIELD
}
SKILL_CLASS.is_extendable = false
SKILL_CLASS.extensions = {}
cs_22009 = var_0_0.Message(CS_22009)
cs_22011 = var_0_0.Message(CS_22011)
cs_22014 = var_0_0.Message(CS_22014)
cs_22101 = var_0_0.Message(CS_22101)
cs_22201 = var_0_0.Message(CS_22201)
cs_22203 = var_0_0.Message(CS_22203)
navalacademy_class = var_0_0.Message(NAVALACADEMY_CLASS)
navalacademy_student = var_0_0.Message(NAVALACADEMY_STUDENT)
sc_22001 = var_0_0.Message(SC_22001)
sc_22010 = var_0_0.Message(SC_22010)
sc_22012 = var_0_0.Message(SC_22012)
sc_22013 = var_0_0.Message(SC_22013)
sc_22015 = var_0_0.Message(SC_22015)
sc_22102 = var_0_0.Message(SC_22102)
sc_22202 = var_0_0.Message(SC_22202)
sc_22204 = var_0_0.Message(SC_22204)
shoppingstreet = var_0_0.Message(SHOPPINGSTREET)
skill_class = var_0_0.Message(SKILL_CLASS)
streetgoods = var_0_0.Message(STREETGOODS)
