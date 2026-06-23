local NetherBot = NetherBot

-- 加载 LibSharedMedia-3.0 库，当前未使用，只是一个示例
-- LibSharedMedia-3.0 依赖 LibStub 库和 LibSharedMedia-3.0 库
local LSM = LibStub("LibSharedMedia-3.0", true)
NetherBot.LSM = LSM

-- 获取玩家职业
-- playerClassId 不一定能获取到，用 playerClassFilename 判断最保险
local playerClassName, playerClassFilename, playerClassId = UnitClass("player")
NetherBot.playerClassFilename = playerClassFilename

-- 职业 ClassFilename
NetherBot.CLASS_FILENAME = {
    WARRIOR = "WARRIOR", -- 战士
    PALADIN = "PALADIN", -- 圣骑士
    HUNTER = "HUNTER", -- 猎人
    ROGUE = "ROGUE", -- 盗贼
    PRIEST = "PRIEST", -- 牧师
    DEATH_KNIGHT = "DEATHKNIGHT", -- 死亡骑士
    SHAMAN = "SHAMAN", -- 萨满
    MAGE = "MAGE", -- 法师
    WARLOCK = "WARLOCK", -- 术士
    DRUID = "DRUID" -- 德鲁伊
}

-- 按钮点击显示的图标（正方形）
NetherBot.PUSHED_SQUARE_ICON = "Interface\\Icons\\spell_magic_polymorphrabbit"
-- 按钮点击显示的图标（圆形）
NetherBot.PUSHED_CIRCLE_ICON = "Interface\\AddOns\\NetherBot\\Images\\PushedCircle"
-- 按钮点击显示的高亮图标（圆形）
NetherBot.HIGHLIGHT_CIRCLE_ICON = "Interface\\AddOns\\NetherBot\\Images\\HighlightCircle"

-- 施法按钮 table
-- 每个职业每个法术的ID，法术等级从高到低降序排序：{法术等级10的ID, 法术等级9的ID, 法术等级8的ID...}
NetherBot.BUTTON_CAST_SPELL_TABLE = {
    -- 战士
    WARRIOR = {
        J_J = {
            NAME = "警戒",
            ICON = "Interface\\Icons\\Ability_Warrior_Vigilance",
            IDS = { 50720 }
        },
        Y_H = {
            NAME = "援护",
            ICON = "Interface\\Icons\\Ability_Warrior_VictoryRush",
            IDS = { 3411 }
        }
    },
    -- 圣骑士
    PALADIN = {
        B_H_Z_S = {
            NAME = "保护之手",
            ICON = "Interface\\Icons\\Spell_Holy_SealOfProtection",
            IDS = { 10278, 5599, 1022 }
        },
        Z_J_Z_S = {
            NAME = "拯救之手",
            ICON = "Interface\\Icons\\Spell_Holy_SealOfSalvation",
            IDS = { 1038 }
        },
        X_S_Z_S = {
            NAME = "牺牲之手",
            ICON = "Interface\\Icons\\Spell_Holy_SealOfSacrifice",
            IDS = { 6940 }
        },
        Z_Y_F_Y = {
            NAME = "正义防御",
            ICON = "Interface\\Icons\\INV_Shoulder_37",
            IDS = { 31789 }
        },
        S_G_D_B = {
            NAME = "圣光道标",
            ICON = "Interface\\Icons\\Ability_Paladin_BeaconofLight",
            IDS = { 53563 }
        },
        Q_X_L_L_Z_F = {
            NAME = "强效力量祝福",
            ICON = "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings",
            IDS = { 48934, 48933, 27141, 25916, 25782 }
        },
        Q_X_Z_H_Z_F = {
            NAME = "强效智慧祝福",
            ICON = "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom",
            IDS = { 48938, 48937, 27143, 25918, 25894 }
        },
        Q_X_W_Z_Z_F = {
            NAME = "强效王者祝福",
            ICON = "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings",
            IDS = { 25898 }
        },
        Q_X_B_H_Z_F = {
            NAME = "强效庇护祝福",
            ICON = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary",
            IDS = { 25899 }
        },
        J_S = {
            NAME = "救赎",
            ICON = "Interface\\Icons\\Spell_Holy_Resurrection",
            IDS = { 48950, 48949, 20773, 20772, 10324, 10322, 7328 }
        },
        S_S_G_S = {
            NAME = "圣神干涉",
            ICON = "Interface\\Icons\\Spell_Nature_TimeStop",
            IDS = { 19752 }
        }
    },
    -- 猎人
    HUNTER = {
        W_D = {
            NAME = "误导",
            ICON = "Interface\\Icons\\Ability_Hunter_Misdirection",
            IDS = { 34477 }
        }
    },
    -- 盗贼
    ROGUE = {
        J_H_J_Q = {
            NAME = "嫁祸诀窍",
            ICON = "Interface\\Icons\\Ability_Rogue_TricksOftheTrade",
            IDS = { 57934 }
        }
    },
    -- 牧师
    PRIEST = {
        Y_H_D_Y = {
            NAME = "愈合祷言",
            ICON = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
            IDS = { 48113, 48112, 33076 }
        },
        P_F_S = {
            NAME = "漂浮术",
            ICON = "Interface\\Icons\\Spell_Holy_LayOnHands",
            IDS = { 1706 }
        },
        F_H_S = {
            NAME = "复活术",
            ICON = "Interface\\Icons\\Spell_Holy_Resurrection",
            IDS = { 48171, 25435, 20770, 10881, 10880, 2010, 2006 }
        }
    },
    -- 死亡骑士
    DEATH_KNIGHT = {
        K_L = {
            NAME = "狂乱",
            ICON = "Interface\\Icons\\Spell_DeathKnight_BladedArmor",
            IDS = { 49016 }
        }
    },
    -- 萨满
    SHAMAN = {
        X_Z_Z_H = {
            NAME = "先祖之魂",
            ICON = "Interface\\Icons\\Spell_Nature_Regenerate",
            IDS = { 49277, 25590, 20777, 20776, 20610, 20609, 2008 }
        }
    },
    -- 法师
    MAGE = {
        H_L_S = {
            NAME = "缓落术",
            ICON = "Interface\\Icons\\Spell_Magic_FeatherFall",
            IDS = { 130 }
        },
        M_F_Y_Z = {
            NAME = "魔法抑制",
            ICON = "Interface\\Icons\\Spell_Nature_AbolishMagic",
            IDS = { 43015, 33944, 10174, 10173, 8451, 8450, 604 }
        },
        M_F_Z_X = {
            NAME = "魔法增效",
            ICON = "Interface\\Icons\\Spell_Holy_FlashHeal",
            IDS = { 43017, 33946, 27130, 10170, 10169, 8455, 1008 }
        }
    },
    -- 术士
    WARLOCK = {

    },
    -- 德鲁伊
    DRUID = {
        F_S = {
            NAME = "复生",
            ICON = "Interface\\Icons\\Spell_Nature_Reincarnation",
            IDS = { 48477, 26994, 20748, 20747, 20742, 20739, 20484 }
        },
        Q_S_H_S = {
            NAME = "起死回生",
            ICON = "Interface\\Icons\\Ability_Druid_LunarGuidance",
            IDS = { 50763, 50764, 50765, 50766, 50767, 50768, 50769 }
        }
    }
}

-- 主按钮 table
NetherBot.BUTTON_MAIN_TABLE = {
    COMMAND_FOLLOW = {
        NAME = "跟随",
        ICON = "Interface\\Icons\\Ability_Tracking"
    },
    COMMAND_FOLLOW_ONLY = {
        NAME = "跟随攻击开关",
        ICON = "Interface\\Icons\\ability_hunter_huntervswild"
    },
    COMMAND_STOP_FULLY = {
        NAME = "停止",
        ICON = "Interface\\Icons\\ABILITY_SEAL"
    },
    COMMAND_STANDSTILL = {
        NAME = "炮台",
        ICON = "Interface\\Icons\\Ability_Vehicle_SiegeEngineCannon"
    },
    COMMAND_NO_GOSSIP = {
        NAME = "对话开关",
        ICON = "Interface\\Icons\\Spell_Holy_Silence"
    },
    HIDE = {
        NAME = "下线",
        ICON = "Interface\\Icons\\Spell_Nature_SpiritWolf"
    },
    SHOW = {
        NAME = "上线",
        ICON = "Interface\\Icons\\Ability_Hunter_BeastCall"
    },
    RECALL = {
        NAME = "召回",
        ICON = "Interface\\Icons\\Ability_Hunter_BeastTraining"
    },
    RECALL_TELEPORT = {
        NAME = "传回",
        ICON = "Interface\\Icons\\Spell_Arcane_Blink"
    },
    COMMAND_WALK = {
        NAME = "走跑切换",
        ICON = "Interface\\Icons\\Ability_Rogue_FleetFooted"
    },
    COMMAND_UNBIND = {
        NAME = "解绑",
        ICON = "Interface\\Icons\\Spell_ChargeNegative"
    },
    COMMAND_REBIND = {
        NAME = "重绑",
        ICON = "Interface\\Icons\\Spell_ChargePositive"
    },
    RECALL_SPAWNS = {
        NAME = "重绑所有",
        ICON = "Interface\\Icons\\INV_Misc_GroupNeedMore"
    },
    INFO = {
        NAME = "Bots信息",
        ICON = "Interface\\Icons\\Spell_Magic_PolymorphChicken"
    },
    KILL = {
        NAME = "杀死",
        ICON = "Interface\\Icons\\Ability_Hunter_RapidKilling"
    },
    VEHICLE_EJECT = {
        NAME = "脱离载具",
        ICON = "Interface\\Icons\\Ability_Mount_GyrocoptorElite"
    }
}

-- 导航按钮 table
NetherBot.BUTTON_NAV_TABLE = {
    GAME_MASTER = {
        NAME = "GM",
        ICON = "Interface\\AddOns\\NetherBot\\Images\\GameMaster"
    },
    ADMIN = {
        NAME = "管理员",
        ICON = "Interface\\AddOns\\NetherBot\\Images\\Admin"
    },
    CAST_SPELL = {
        NAME = "施法",
        ICON = "Interface\\AddOns\\NetherBot\\Images\\CastSpell"
    },
    DISTANCE = {
        NAME = "距离",
        ICON = "Interface\\AddOns\\NetherBot\\Images\\Distance"
    }
}

-- 距离按钮 table
NetherBot.BUTTON_DISTANCE_TABLE = {
    DISTANCE_30 = {
        NAME = "30码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_01"
    },
    DISTANCE_40 = {
        NAME = "40码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_02"
    },
    DISTANCE_50 = {
        NAME = "50码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_03"
    },
    DISTANCE_60 = {
        NAME = "60码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_04"
    },
    DISTANCE_70 = {
        NAME = "70码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_05"
    },
    DISTANCE_80 = {
        NAME = "80码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_06"
    },
    DISTANCE_90 = {
        NAME = "90码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_07"
    },
    DISTANCE_100 = {
        NAME = "100码跟随距离",
        ICON = "Interface\\Icons\\achievement_pvp_h_08"
    },
    DISTANCE_ATTACK_SHORT = {
        NAME = "最小远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_a"
    },
    DISTANCE_ATTACK_LONG = {
        NAME = "最大远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_h"
    },
    DISTANCE_ATTACK_0 = {
        NAME = "0码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_01"
    },
    DISTANCE_ATTACK_10 = {
        NAME = "10码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_02"
    },
    DISTANCE_ATTACK_15 = {
        NAME = "15码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_03"
    },
    DISTANCE_ATTACK_20 = {
        NAME = "20码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_04"
    },
    DISTANCE_ATTACK_30 = {
        NAME = "30码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_05"
    },
    DISTANCE_ATTACK_40 = {
        NAME = "40码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_06"
    },
    DISTANCE_ATTACK_50 = {
        NAME = "50码远程攻击距离",
        ICON = "Interface\\Icons\\achievement_pvp_a_07"
    }
}

-- 机器人职业 table
NetherBot.BOT_CLASS_TABLE = {
    WARRIOR = { CODE = 1, NAME = "战士", COLOUR = "|cffC69B6D" },
    PALADIN = { CODE = 2, NAME = "圣骑士", COLOUR = "|cffF58CBA" },
    HUNTER = { CODE = 3, NAME = "猎人", COLOUR = "|cffAAD372" },
    ROGUE = { CODE = 4, NAME = "盗贼", COLOUR = "|cffFFF468" },
    PRIEST = { CODE = 5, NAME = "牧师", COLOUR = "|cffF0EBE0" },
    DEATH_KNIGHT = { CODE = 6, NAME = "死亡骑士", COLOUR = "|cffC41E3B" },
    SHAMAN = { CODE = 7, NAME = "萨满", COLOUR = "|cff2359FF" },
    MAGE = { CODE = 8, NAME = "法师", COLOUR = "|cff68CCEF" },
    WARLOCK = { CODE = 9, NAME = "术士", COLOUR = "|cff9382C9" },
    DRUID = { CODE = 11, NAME = "德鲁伊", COLOUR = "|cffFF7C0A" },
    BLADE_MASTER = { CODE = 12, NAME = "剑圣", COLOUR = "|cffC69B6D" },
    SPHYNX = { CODE = 13, NAME = "黑曜石毁灭者", COLOUR = "|cffF0EBE0" },
    ARCHMAGE = { CODE = 14, NAME = "大魔导师", COLOUR = "|cff68CCEF" },
    DREADLORD = { CODE = 15, NAME = "恐惧魔王", COLOUR = "|cffA330C9" },
    SPELLBREAKER = { CODE = 16, NAME = "破法者", COLOUR = "|cff68CCEF" },
    DARK_RANGER = { CODE = 17, NAME = "黑暗游侠", COLOUR = "|cffAAD372" },
    NECROMANCER = { CODE = 18, NAME = "死灵法师", COLOUR = "|cff9382C9" },
    SEA_WITCH = { CODE = 19, NAME = "娜迦女海巫", COLOUR = "|cff68CCEF" },
    CRYPT_LORD = { CODE = 20, NAME = "地穴领主", COLOUR = "|cff009ABF" }
}

-- 机器人种族表
NetherBot.BOT_RACE_TABLE = {
    HUMAN = { CODE = 1, NAME = "人类" },
    ORC = { CODE = 2, NAME = "兽人" },
    DWARF = { CODE = 3, NAME = "矮人" },
    NIGHT_ELF = { CODE = 4, NAME = "暗夜精灵" },
    UNDEAD = { CODE = 5, NAME = "亡灵" },
    TAUREN = { CODE = 6, NAME = "牛头人" },
    GNOME = { CODE = 7, NAME = "侏儒" },
    TROLL = { CODE = 8, NAME = "巨魔" },
    BLOOD_ELF = { CODE = 10, NAME = "血精灵" },
    DRAENEI = { CODE = 11, NAME = "德莱尼" }
}

-- 机器人性别表
NetherBot.BOT_GENDER_TABLE = {
    MALE = { CODE = 0, NAME = "男" },
    FEMALE = { CODE = 1, NAME = "女" }
}

-- 机器人外貌范围表
-- SKIN：皮肤
-- FACE：面部
-- HAIRSTYLE：发型
-- HAIR_COLOR：发色
-- FEATURES：特征
NetherBot.BOT_APPEARANCE_TABLE = {
    -- 人类男：皮肤 0-9 面部 0-11 发型 0-16 发色 0-9 特征 0-8
    HUMAN_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8 }
    },
    -- 人类女：皮肤 0-9 面部 0-14 发型 0-23 发色 0-9 特征 0-6
    HUMAN_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6 }
    },
    -- 矮人男：皮肤 0-8 面部 0-9 发型 0-15 发色 0-9 特征 0-10
    DWARF_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    },
    -- 矮人女：皮肤 0-8 面部 0-9发型 0-18 发色 0-9 特征 0-5
    DWARF_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5 }
    },
    -- 暗夜精灵男：皮肤 0-8 面部 0-8 发型 0-11 发色 0-7 特征 0-5
    NIGHT_ELF_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7 },
        FEATURES = { 0, 1, 2, 3, 4, 5 }
    },
    -- 暗夜精灵女：皮肤 0-8 面部 0-8 发型 0-11 发色 0-7 特征 0-9
    NIGHT_ELF_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    },
    -- 侏儒男：皮肤 0-4 面部 0-6 发型 0-11 发色 0-8 特征 0-7
    GNOME_MALE = {
        SKIN = { 0, 1, 2, 3, 4 },
        FACE = { 0, 1, 2, 3, 4, 5, 6 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7 }
    },
    -- 侏儒女：皮肤 0-4 面部 0-6 发型 0-11 发色 0-8 特征 0-6
    GNOME_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4 },
        FACE = { 0, 1, 2, 3, 4, 5, 6 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6 }
    },
    -- 德莱尼男：皮肤 0-13 面部 0-9 发型 0-13 发色 0-6 特征 0-7
    DRAENEI_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7 }
    },
    -- 德莱尼女：皮肤 0-13 面部 0-9 发型 0-15 发色 0-6 特征 0-6
    DRAENEI_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6 }
    },
    -- 兽人男：皮肤 0-8 面部 0-8 发型 0-11 发色 0-7 特征 0-10
    ORC_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    },
    -- 兽人女：皮肤 0-8 面部 0-8 发型 0-12 发色 0-7 特征 0-6
    ORC_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6 }
    },
    -- 不死男：皮肤 0-5 面部 0-9 发型 0-14 发色 0-9 特征 0-16
    UNDEAD_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 }
    },
    -- 不死女：皮肤 0-5 面部 0-9 发型 0-14 发色 0-9 特征 0-7
    UNDEAD_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7 }
    },
    -- 牛头男：皮肤 0-18 面部 0-4 发型 0-12 发色 0-2 特征 0-6
    TAUREN_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
        FACE = { 0, 1, 2, 3, 4 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
        HAIR_COLOR = { 0, 1, 2 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6 }
    },
    -- 牛头女：皮肤 0-10 面部 0-3 发型 0-11 发色 0-2 特征 0-4
    TAUREN_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        FACE = { 0, 1, 2, 3 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        HAIR_COLOR = { 0, 1, 2 },
        FEATURES = { 0, 1, 2, 3, 4 }
    },
    -- 巨魔男：皮肤 0-5 面部 0-4 发型 0-9 发色 0-9 特征 0-10
    TROLL_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5 },
        FACE = { 0, 1, 2, 3, 4 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    },
    -- 巨魔女：皮肤 0-5 面部 0-5 发型 0-9 发色 0-9 特征 0-5
    TROLL_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5 },
        FACE = { 0, 1, 2, 3, 4, 5 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5 }
    },
    -- 血精灵男：皮肤 0-9 面部 0-9 发型 0-15 发色 0-9 特征 0-9
    BLOOD_ELF_MALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    },
    -- 血精灵女：皮肤 0-9 面部 0-9 发型 0-18 发色 0-9 特征 0-10
    BLOOD_ELF_FEMALE = {
        SKIN = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FACE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        HAIRSTYLE = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
        HAIR_COLOR = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
        FEATURES = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    },
}

-- 创建一个机器人模板数组
NetherBot.BOT_TEMPLATE_ARRAY = {
    -- class：职业
    -- race：种族
    -- gender：性别
    -- appearance：外貌
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 战士 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARRIOR, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 圣骑士 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PALADIN, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 猎人 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.HUNTER, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 盗贼 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ROGUE, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 牧师 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.PRIEST, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 死亡骑士 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.DWARF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DWARF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 萨满 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SHAMAN, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 法师 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.TROLL, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TROLL_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.MAGE, RACE = NetherBot.BOT_RACE_TABLE.DRAENEI, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.DRAENEI_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 术士 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.ORC, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.ORC_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.UNDEAD, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.UNDEAD_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.GNOME, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.GNOME_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.WARLOCK, RACE = NetherBot.BOT_RACE_TABLE.BLOOD_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.BLOOD_ELF_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> 德鲁伊 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.DRUID, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DRUID, RACE = NetherBot.BOT_RACE_TABLE.NIGHT_ELF, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.NIGHT_ELF_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DRUID, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DRUID, RACE = NetherBot.BOT_RACE_TABLE.TAUREN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.TAUREN_FEMALE },
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>> War3 <<<<<<<<<<<<<<<<<<<<<<<<<<<
    { CLASS = NetherBot.BOT_CLASS_TABLE.BLADE_MASTER, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SPHYNX, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ARCHMAGE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.MALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_MALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.ARCHMAGE, RACE = NetherBot.BOT_RACE_TABLE.HUMAN, GENDER = NetherBot.BOT_GENDER_TABLE.FEMALE, APPEARANCE = NetherBot.BOT_APPEARANCE_TABLE.HUMAN_FEMALE },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DREADLORD, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SPELLBREAKER, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.DARK_RANGER, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.NECROMANCER, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.SEA_WITCH, RACE = {}, GENDER = {}, APPEARANCE = {} },
    { CLASS = NetherBot.BOT_CLASS_TABLE.CRYPT_LORD, RACE = {}, GENDER = {}, APPEARANCE = {} }
}

-- 计数器
local function CreateCounter()
    -- 初始值为 0
    local count = 0
    -- 返回一个函数，每次调用该函数，count 加 1 并返回新值
    return function()
        count = count + 1
        return count
    end
end
-- 创建计数器实例
local counter = CreateCounter()
-- 创建全局唯一名称，一般用来创建组件时，指定的组件名称
function NetherBot:CreateNameUnique()
    local count = counter()
    return "NetherBotNameUnique" .. count
end

-- 通过 16 位的 GUID 获取生物模板 entry
-- creature_template 表的 entry 字段值
local function GetCreatureTemplateEntry(guid)
    if guid then
        -- local knownTypes = {[0]="player", [3]="NPC", [4]="pet", [5]="vehicle"};
        -- 335-12340 版本暂时只发现 [0] [3] [5] 类型
        -- [0] 是玩家类型（无 entry）
        local creatureTemplateType = tonumber(guid:sub(5, 5), 16)
        if creatureTemplateType == 3 or creatureTemplateType == 5 then
            -- 生物模板的 entry
            local creatureTemplateEntry = tonumber(guid:sub(8, 12), 16)
            if creatureTemplateEntry then
                return creatureTemplateEntry
            end
        end
    end
end

-- 校验选中目标是否是玩家
function NetherBot:ValidateTargetIsPlayer()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        local creatureTemplateType = tonumber(targetGUID:sub(5, 5), 16)
        if creatureTemplateType == 0 then
            return true
        end
    end
end

-- 绑定按钮点击处理
function NetherBot:BindingButtonClick(button, icon, keyState)
    if button and icon and keyState then
        -- 获取按钮 PushedTexture 图标
        local pushedTexture = button:GetPushedTexture():GetTexture()
        if keyState == "down" then -- 按下绑定按键，触发按钮点击事件，并切换图标
            -- 使用这种方式触发点击事件，PushedTexture 不会触发，需要代码控制
            button:Click()
            button:GetNormalTexture():SetTexture(pushedTexture)
        elseif keyState == "up" then -- 放开绑定按键，将图标切换回去
            button:GetNormalTexture():SetTexture(icon)
        end
    end
end

-- 校验参数是否大于 0，只支持数字和字符串类型
-- 字符串类型会转换后再判断，如果无法转换，返回 false
function NetherBot:ValidateIsGtZero(param)
    if param then
        local paramType = type(param)
        if paramType == "string" then
            if param ~= "" then
                -- 如果转换时 nil 溢出（例如："2323224a"），则返回 -1
                local t = tonumber(param) or -1
                if t and t > 0 then
                    return true
                end
            end
        elseif paramType == "number" then
            if param > 0 then
                return true
            end
        end
    end
end

-- 判断字符串中是否包含空格
function NetherBot:ContainsSpace(str)
    return string.find(str, " ") ~= nil
end

-- 根据一个或者多个空格分割字符串，返回一个数组
function NetherBot:SplitBySpace(str)
    local words = {}
    for word in str:gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

-- 根据传入的开始数字和结束数字，返回一个包含这两个数字之间的数组
function NetherBot:GenerateRange(startNumber, endNumber)
    local numbers = {}
    for i = startNumber, endNumber do
        table.insert(numbers, i)
    end
    return numbers
end

-- 清除 frame 中的元素
-- 注意：清除不了 FontString
function NetherBot:ClearFrame(frame)
    for i, child in ipairs({frame:GetChildren()}) do
        -- 隐藏元素
        child:Hide()
        -- 解除父子关系，从Frame中移除
        child:SetParent(nil)
    end
end

-- 定义一个函数来创建有序表
function NetherBot:CreateOrderTable()
    local tbl = {}
    local order = {}
    -- 添加键值对到有序表
    function tbl:add(key, value)
        table.insert(order, key)
        self[key] = value
    end
    -- 遍历有序表按照定义顺序
    function tbl:pairsByOrder()
        local i = 0
        return function()
            i = i + 1
            local key = order[i]
            if key then
                return key, self[key]
            end
        end
    end
    return tbl
end

-- 定义一个函数来随机从数组中取值
function NetherBot:RandomFromArray(arr)
    if type(arr) == "table" and #arr > 0 then
        local randomIndex = math.random(1, #arr)
        return arr[randomIndex]
    end
end

-- 中文姓氏
local CHINESE_FAMILY_NAMES = {
    "赵", "钱", "孙", "李", "周", "吴", "郑", "王", "冯", "陈", "褚", "卫", "蒋", "沈", "韩", "杨", "朱",
    "秦", "尤", "许", "何", "吕", "施", "张", "孔", "曹", "严", "华", "金", "魏", "陶", "姜", "戚", "谢",
    "邹", "喻", "柏", "水", "窦", "章", "云", "苏", "潘", "葛", "奚", "范", "彭", "郎", "鲁", "韦", "昌",
    "马", "苗", "凤", "花", "方", "俞", "任", "袁", "柳", "酆", "鲍", "史", "唐", "费", "廉", "岑", "薛",
    "雷", "贺", "倪", "汤", "滕", "殷", "罗", "毕", "郝", "邬", "安", "常", "乐", "于", "时", "傅", "皮",
    "卞", "齐", "康", "伍", "余", "元", "卜", "顾", "孟", "平", "黄", "和", "穆", "萧", "尹", "姚", "邵",
    "湛", "汪", "祁", "毛", "禹", "狄", "米", "贝", "明", "臧", "计", "伏", "成", "戴", "谈", "宋", "茅",
    "庞", "熊", "纪", "舒", "屈", "项", "祝", "董", "梁", "杜", "阮", "蓝", "闵", "席", "季", "麻", "强",
    "贾", "路", "娄", "危", "江", "童", "颜", "郭", "梅", "盛", "林", "刁", "钟", "徐", "邱", "骆", "高",
    "夏", "蔡", "田", "樊", "胡", "凌", "霍", "虞", "万", "支", "柯", "昝", "管", "卢", "莫", "经", "房",
    "裘", "缪", "干", "解", "应", "宗", "丁", "宣", "贲", "邓", "郁", "单", "杭", "洪", "包", "诸", "左",
    "石", "崔", "吉", "钮", "龚", "程", "嵇", "邢", "滑", "裴", "陆", "荣", "翁", "荀", "羊", "於", "惠",
    "甄", "曲", "家", "封", "芮", "羿", "储", "靳", "汲", "邴", "糜", "松", "井", "段", "富", "巫", "乌",
    "焦", "巴", "弓", "牧", "隗", "山", "谷", "车", "侯", "宓", "蓬", "全", "郗", "班", "仰", "秋", "仲",
    "伊", "宫", "宁", "仇", "栾", "暴", "甘", "钭", "厉", "戎", "祖", "武", "符", "刘", "景", "詹", "束",
    "龙", "叶", "幸", "司", "韶", "郜", "黎", "蓟", "薄", "印", "宿", "白", "怀", "蒲", "邰", "从", "鄂",
    "索", "咸", "籍", "赖", "卓", "蔺", "屠", "蒙", "池", "乔", "阴", "鬱", "胥", "能", "苍", "双", "闻",
    "莘", "党", "翟", "谭", "贡", "劳", "逄", "姬", "申", "扶", "堵", "冉", "宰", "郦", "雍", "郤", "璩",
    "桑", "桂", "濮", "牛", "寿", "通", "边", "扈", "燕", "冀", "郏", "浦", "尚", "农", "温", "别", "庄",
    "晏", "柴", "瞿", "阎", "充", "慕", "连", "茹", "习", "宦", "艾", "鱼", "容", "向", "古", "易", "慎",
    "戈", "廖", "庾", "终", "暨", "居", "衡", "步", "都", "耿", "满", "弘", "匡", "国", "文", "寇", "广",
    "禄", "阙", "东", "欧", "殳", "沃", "利", "蔚", "越", "夔", "隆", "师", "巩", "厍", "聂", "晁", "勾",
    "敖", "融", "冷", "訾", "辛", "阚", "那", "简", "饶", "空", "曾", "毋", "沙", "乜", "养", "鞠", "须",
    "丰", "巢", "关", "蒯", "相", "查", "后", "荆", "红", "游", "竺", "权", "逯", "盖", "益", "桓", "公",
    "仉", "督", "晋", "楚", "闫", "法", "汝", "鄢", "涂", "钦", "归", "海", "岳", "帅", "缑", "亢", "况",
    "郈", "有", "琴", "商", "牟", "佘", "佴", "伯", "赏", "墨", "哈", "谯", "笪", "年", "爱", "阳", "佟",
    "言", "福",
    "万俟", "司马", "上官", "欧阳", "夏侯", "诸葛", "闻人", "东方", "赫连", "皇甫", "尉迟", "公羊", "澹台",
    "公冶", "宗政", "濮阳", "淳于", "单于", "太叔", "申屠", "公孙", "仲孙", "轩辕", "令狐", "钟离", "宇文",
    "长孙", "慕容", "鲜于", "闾丘", "司徒", "司空", "丌官", "司寇", "子车", "颛孙", "端木", "巫马", "公西",
    "漆雕", "乐正", "壤驷", "公良", "拓跋", "夹谷", "宰父", "谷梁", "段干", "百里", "东郭", "南门", "呼延",
    "羊舌", "微生", "梁丘", "左丘", "东门", "西门", "南宫", "第五"
}

-- 中文常用名
local CHINESE_COMMON_NAMES = {
    "微", "庚", "殷", "德", "鹰", "宫", "娠", "藏", "辖", "倾", "侮", "颁", "拳", "豆", "逾", "袋", "收",
    "澜", "妄", "绊", "谬", "帽", "貉", "讲", "摸", "洞", "江", "舅", "庭", "囊", "捏", "缘", "愧", "拉",
    "览", "渔", "襄", "佰", "嫁", "情", "导", "字", "堵", "待", "拖", "打", "邪", "秒", "校", "肘", "溜",
    "贷", "逮", "项", "埋", "案", "万", "袜", "勇", "蛋", "洼", "像", "摘", "压", "秋", "筹", "乡", "丫",
    "匠", "捷", "袁", "鞍", "淋", "掉", "猩", "港", "月", "捌", "典", "摊", "啼", "缚", "晦", "卸", "行",
    "诺", "凝", "珐", "醉", "歼", "葬", "择", "迭", "钳", "抠", "夫", "郑", "卵", "痔", "稍", "朝", "锥",
    "无", "翠", "奥", "倪", "夸", "唱", "骑", "蒂", "忠", "唐", "遗", "锭", "讶", "助", "廓", "哪", "悍",
    "塔", "彤", "爽", "棕", "售", "撼", "陇", "辆", "绪", "抑", "肠", "找", "零", "播", "标", "柔", "套",
    "箩", "雍", "吓", "沟", "迪", "类", "玲", "鸳", "鸿", "棒", "郴", "哺", "出", "锈", "愈", "赛", "乱",
    "筛", "乎", "撑", "拙", "尤", "鄙", "胸", "害", "并", "总", "带", "椭", "昨", "裕", "抽", "巩", "疆",
    "婉", "边", "擞", "男", "励", "栏", "坑", "梆", "抚", "耿", "俩", "暂", "那", "何", "鲸", "插", "攻",
    "痴", "癌", "鉴", "汛", "扛", "帝", "狗", "烁", "什", "悠", "樟", "棉", "蓉", "鸯", "撮", "宏", "郧",
    "跺", "奏", "锤", "尽", "鼠", "晓", "永", "跑", "佑", "血", "再", "杨", "萄", "厚", "庐", "溺", "咐",
    "薛", "只", "武", "勒", "犊", "伟", "针", "宅", "镣", "厨", "韶", "砸", "握", "浪", "虚", "咸", "柄",
    "敖", "初", "紧", "贮", "侈", "枯", "倘", "畔", "坤", "洲", "故", "淆", "听", "姿", "饭", "狮", "苦",
    "蹄", "缺", "灿", "她", "拾", "仗", "虏", "暇", "疙", "加", "捐", "现", "跋", "徒", "军", "叮", "抬",
    "熬", "裙", "殊", "陈", "剂", "烂", "镀", "连", "拼", "纸", "碟", "秉", "贰", "第", "虹", "仇", "钮",
    "浅", "工", "抱", "检", "屯", "质", "平", "逸", "翁", "炔", "瘁", "蚁", "谗", "梯", "蹿", "咙", "贸",
    "酱", "吐", "澎", "正", "汰", "代", "幅", "铸", "淡", "至", "净", "咽", "吟", "狱", "栖", "荤", "的",
    "撵", "管", "答", "郭", "九", "喷", "痢", "陋", "耕", "梭", "谴", "坎", "创", "知", "战", "箭", "忘",
    "午", "基", "甚", "徊", "棘", "气", "酵", "红", "塘", "畸", "警", "汁", "翼", "便", "愤", "恒", "呛",
    "铰", "自", "骚", "鹊", "谓", "岂", "阉", "伞", "泡", "启", "苍", "祭", "垃", "莫", "拯", "搂", "然",
    "茫", "蚊", "以", "肯", "啮", "霹", "魄", "梁", "韦", "搅", "拷", "哦", "式", "斋", "喊", "株", "懒",
    "底", "头", "逗", "釜", "最", "想", "驾", "僵", "喂", "奇", "鳃", "札", "赖", "葱", "碘", "淳", "渺",
    "厘", "眶", "泉", "望", "型", "铝", "半", "舆", "绣", "叭", "科", "暖", "嗅", "绷", "腊", "抒", "矗",
    "痘", "利", "埠", "膳", "熟", "拈", "吹", "俏", "笼", "角", "胆", "契", "蹋", "希", "掷", "溢", "迸",
    "鸭", "历", "误", "渐", "务", "溶", "柞", "信", "疵", "册", "粉", "笆", "乙", "瘤", "忧", "师", "党",
    "梦", "蕉", "汀", "态", "拔", "睡", "膜", "艰", "乔", "沉", "聂", "毙", "狙", "心", "伸", "踢", "火",
    "傣", "给", "悉", "墟", "腔", "饲", "衫", "氖", "湘", "惦", "茧", "罐", "三", "坏", "瞻", "哉", "驮",
    "扇", "奸", "醋", "说", "捞", "扶", "时", "逛", "汉", "隐", "艇", "川", "锯", "祟", "份", "做", "走",
    "享", "员", "这", "褐", "驴", "荣", "亡", "擎", "涯", "常", "钥", "查", "挛", "逞", "饺", "断", "势",
    "滚", "骡", "烫", "亏", "躬", "蝶", "群", "篮", "盏", "喻", "臆", "验", "缄", "笋", "位", "盾", "饯",
    "渡", "哥", "餐", "袖", "绅", "啊", "哟", "丈", "拣", "粕", "茵", "湍", "邓", "脚", "郁", "研", "厕",
    "舍", "凹", "版", "戈", "颐", "棍", "象", "烈", "眷", "铅", "惭", "雪", "盔", "憾", "刀", "博", "产",
    "闻", "严", "昆", "密", "落", "额", "轨", "屿", "蔷", "域", "盂", "砍", "苟", "欧", "绎", "河", "和",
    "聪", "俞", "榴", "甲", "噬", "燃", "史", "记", "卧", "蜕", "俱", "遏", "减", "坦", "持", "仕", "派",
    "涵", "煞", "裹", "悬", "轰", "冻", "喘", "确", "溯", "炼", "段", "灶", "肃", "劣", "馒", "斌", "撤",
    "烤", "谢", "耽", "肝", "咒", "炙", "迟", "淹", "踏", "哲", "铜", "荡", "桶", "妒", "太", "村", "印",
    "银", "馆", "拆", "鸵", "睫", "捕", "圈", "烩", "薯", "异", "儡", "撞", "旷", "鸟", "衍", "米", "堕",
    "铣", "贼", "付", "坠", "汞", "税", "瑞", "夜", "些", "匪", "转", "枣", "沏", "疤", "涂", "设", "彭",
    "蓟", "哮", "踪", "竖", "敞", "吠", "敷", "膨", "钩", "刊", "跨", "濒", "嘛", "逐", "儿", "腹", "部",
    "法", "辛", "惜", "苯", "童", "得", "蒋", "队", "省", "灾", "缅", "控", "譬", "芍", "建", "枷", "征",
    "形", "摆", "仅", "欲", "钟", "锨", "黎", "拜", "韩", "破", "奶", "楚", "帘", "拄", "码", "奄", "衙",
    "抓", "蹭", "度", "弹", "止", "耗", "照", "所", "吮", "拱", "狭", "旺", "啦", "杯", "虐", "燥", "菏",
    "曙", "酥", "瓣", "酋", "辊", "畦", "果", "夷", "汕", "雌", "湖", "架", "裳", "齿", "园", "桥", "盼",
    "稻", "蝉", "碰", "义", "拨", "粹", "侦", "捻", "蒲", "速", "拥", "纷", "烧", "揽", "野", "陀", "造",
    "忱", "色", "雕", "青", "堑", "讫", "哆", "临", "叹", "大", "烛", "机", "淮", "双", "增", "您", "袍",
    "伺", "琵", "秘", "顶", "洗", "柿", "弥", "淄", "孽", "顷", "碴", "勿", "胳", "邦", "池", "恬", "皂",
    "庞", "居", "席", "斤", "阮", "赣", "鲤", "抗", "展", "铀", "袱", "嗣", "私", "移", "梨", "萍", "膛",
    "近", "组", "靠", "揩", "狈", "窥", "掣", "辩", "灸", "埂", "骂", "偶", "帮", "对", "凭", "流", "景",
    "娄", "很", "腮", "瓢", "滨", "棚", "滓", "褥", "槽", "怎", "狼", "帐", "陵", "壮", "模", "娃", "颓",
    "仆", "础", "羚", "酚", "匡", "壬", "柒", "根", "存", "蝎", "搏", "觉", "戮", "嵌", "蛀", "登", "输",
    "钞", "谜", "龚", "栅", "左", "矣", "旅", "显", "脓", "怨", "萤", "堪", "疼", "莱", "绩", "识", "贺",
    "靛", "慰", "扦", "淫", "名", "迂", "肢", "予", "诚", "汤", "牙", "埃", "辉", "曰", "醚", "茸", "训",
    "稚", "饵", "倦", "扭", "殉", "锑", "泣", "劲", "沃", "鼎", "磊", "莹", "菜", "贾", "抉", "憎", "浸",
    "跃", "泳", "硅", "内", "伦", "杉", "梧", "蘑", "疑", "乏", "是", "阶", "奋", "锦", "攘", "业", "枝",
    "哀", "侥", "坞", "鞭", "霓", "人", "甄", "诡", "钦", "冗", "址", "归", "刁", "漂", "苗", "拴", "攀",
    "碑", "某", "盆", "掌", "甜", "饶", "合", "吸", "染", "距", "能", "好", "族", "嘴", "聘", "煽", "二",
    "感", "寅", "侍", "瑟", "耶", "舜", "耻", "笔", "柬", "卡", "社", "摧", "礼", "矿", "爵", "闷", "慕",
    "圆", "贞", "寄", "沪", "荚", "炭", "屁", "誉", "堰", "粘", "腰", "牡", "孜", "蓬", "恶", "浆", "接",
    "试", "橱", "描", "蟹", "篱", "铃", "窄", "过", "栗", "精", "真", "吾", "郊", "瓮", "桩", "酒", "挂",
    "央", "椽", "锁", "蛇", "折", "盛", "躲", "颠", "荆", "疥", "窖", "魁", "瘩", "咕", "翻", "讣", "筐",
    "径", "宋", "闪", "均", "萨", "颅", "爆", "楔", "携", "讹", "进", "丹", "叉", "毅", "徐", "沫", "悼",
    "暗", "惠", "削", "告", "潦", "夺", "仿", "沈", "趾", "腻", "娱", "号", "盗", "哩", "非", "婿", "邻",
    "谷", "穿", "睛", "殴", "卓", "判", "瓜", "脆", "阵", "杖", "辨", "回", "拧", "伴", "慨", "捉", "编",
    "致", "办", "赎", "欠", "仍", "烘", "靶", "瞧", "强", "否", "罚", "怯", "孔", "神", "碱", "桑", "司",
    "亥", "旦", "诉", "旧", "卿", "逝", "颜", "馁", "割", "羹", "又", "闹", "邢", "矾", "洽", "疯", "蜡",
    "肤", "烙", "游", "螺", "种", "乳", "辰", "奢", "亭", "逃", "尝", "瑚", "衬", "币", "兔", "房", "漓",
    "啄", "祷", "锌", "定", "看", "椎", "岛", "恩", "彪", "棠", "缴", "谰", "前", "辐", "臂", "泛", "支",
    "疡", "避", "莆", "纬", "侧", "难", "杀", "搀", "浓", "泄", "欺", "降", "地", "剧", "析", "赞", "届",
    "陕", "右", "诊", "辈", "颗", "奎", "窗", "矽", "鸥", "颂", "顽", "诸", "枢", "油", "点", "椰", "华",
    "谨", "会", "亩", "刃", "瞬", "侯", "谊", "琅", "骗", "身", "碍", "凌", "茬", "茁", "涅", "逻", "屎",
    "极", "究", "汾", "绥", "滑", "潜", "盯", "翌", "西", "篷", "拒", "林", "星", "农", "鲁", "芳", "学",
    "揪", "锋", "溉", "苔", "漾", "姨", "纠", "阿", "肉", "鹿", "苏", "吨", "赢", "溅", "联", "苞", "刹",
    "耐", "檄", "菩", "品", "蛰", "必", "芹", "霜", "傲", "挽", "龄", "它", "般", "梅", "瘪", "搬", "余",
    "船", "擒", "协", "峭", "徘", "仓", "录", "领", "读", "扯", "掖", "摄", "馏", "吗", "藕", "送", "删",
    "森", "腆", "盒", "蚜", "穗", "兼", "穆", "屡", "若", "狂", "尼", "国", "寡", "贩", "拿", "梳", "垣",
    "喧", "哭", "辕", "厉", "跳", "辅", "昔", "辗", "婚", "选", "疾", "乍", "赁", "慎", "乘", "理", "硒",
    "阎", "崇", "滤", "因", "胖", "紫", "颊", "蘸", "歪", "蛊", "逊", "垫", "叛", "瑶", "渭", "浇", "喀",
    "冷", "臻", "妮", "湃", "锡", "慑", "隋", "恐", "演", "哑", "焚", "擦", "重", "市", "醒", "惕", "抛",
    "帅", "爱", "栽", "菠", "天", "特", "练", "蛆", "还", "击", "吏", "侠", "囤", "隆", "磷", "栓", "痞",
    "寞", "恫", "扔", "由", "氨", "岗", "懈", "惨", "腑", "有", "批", "善", "脸", "埔", "丽", "毯", "斗",
    "臣", "蚌", "须", "几", "为", "劫", "智", "滔", "葫", "褂", "全", "岁", "蚂", "蹲", "榷", "氦", "凋",
    "碎", "刽", "兑", "凿", "寒", "籍", "超", "滩", "窝", "杭", "甫", "馅", "茨", "捂", "畏", "稳", "涉",
    "弊", "糕", "障", "侄", "菌", "敛", "歧", "隙", "憋", "伤", "戴", "扬", "胀", "翱", "幽", "肩", "皑",
    "证", "痛", "盟", "促", "尸", "歇", "朵", "留", "巫", "砚", "蓖", "澡", "绝", "透", "百", "操", "渝",
    "涤", "躁", "蠢", "炎", "适", "搞", "瘦", "撂", "蔬", "每", "许", "鸣", "揍", "砒", "禄", "职", "脾",
    "采", "囱", "炕", "英", "作", "扰", "冤", "竞", "而", "章", "绳", "源", "妈", "萧", "恋", "蛾", "鹅",
    "啥", "猖", "粮", "熊", "庄", "振", "髓", "仟", "庸", "或", "萌", "厄", "甘", "宽", "才", "揣", "随",
    "另", "界", "盖", "滴", "乒", "争", "谈", "筏", "恭", "荷", "到", "责", "锣", "傅", "兹", "袄", "盈",
    "蜘", "舞", "淌", "限", "哼", "润", "残", "蔼", "息", "失", "歉", "排", "搐", "剃", "缕", "牌", "椒",
    "徽", "涪", "集", "饥", "磕", "鹤", "光", "毫", "苹", "伙", "悸", "谱", "篆", "视", "良", "元", "柯",
    "胃", "己", "妹", "闽", "简", "呀", "恕", "琴", "圃", "躺", "鬼", "俊", "昂", "鼓", "赫", "空", "彼",
    "赔", "矩", "纫", "诞", "詹", "禽", "钾", "安", "鳞", "扳", "芦", "呸", "浚", "遍", "揖", "殿", "窃",
    "背", "赘", "屹", "斑", "披", "繁", "艘", "文", "立", "罢", "驰", "傀", "惩", "既", "区", "裸", "豪",
    "激", "捧", "脐", "聚", "遥", "糯", "父", "漆", "遮", "诽", "猎", "皆", "磁", "拂", "钠", "深", "腥",
    "后", "据", "琐", "脱", "求", "挫", "瞳", "包", "攒", "蕾", "沮", "片", "琼", "崎", "淬", "痕", "滞",
    "粪", "栋", "扒", "赐", "帛", "生", "怜", "尹", "绦", "酗", "映", "殖", "斟", "灌", "约", "膊", "藉",
    "坷", "伊", "瘴", "扞", "贤", "盘", "穴", "们", "剩", "反", "翅", "忿", "蔑", "戳", "昧", "犹", "湛",
    "滁", "肆", "赊", "捣", "忽", "云", "爪", "玩", "亿", "绸", "慢", "拍", "槛", "陪", "焰", "屑", "吊",
    "租", "噪", "吃", "命", "动", "久", "玻", "单", "壶", "容", "畅", "漳", "渴", "剑", "霉", "隘", "渗",
    "氰", "访", "厢", "酉", "鸡", "五", "期", "评", "疲", "凯", "秦", "石", "线", "承", "祁", "勺", "羌",
    "鸦", "匿", "句", "嗜", "追", "凶", "冒", "矛", "呢", "盲", "豫", "蒸", "更", "欢", "抵", "帕", "惫",
    "风", "拓", "驻", "拇", "器", "舵", "室", "楷", "虾", "阂", "交", "四", "谩", "忆", "让", "眉", "冯",
    "漱", "椿", "着", "引", "豁", "测", "稽", "图", "葡", "檬", "富", "免", "应", "夹", "串", "则", "琢",
    "蛔", "电", "呵", "忍", "钡", "射", "列", "役", "香", "紊", "污", "肛", "偿", "短", "着", "窍", "习",
    "菊", "痒", "凄", "执", "冀", "冉", "貌", "瞥", "闺", "附", "塑", "婴", "晴", "筷", "菲", "丑", "胶",
    "笛", "酞", "硝", "柳", "勃", "幼", "织", "迄", "际", "拢", "箱", "督", "蜒", "潭", "毒", "婶", "耀",
    "琳", "晰", "拐", "桨", "却", "峰", "豌", "窘", "镰", "诗", "炒", "受", "坝", "斯", "掀", "烃", "禹",
    "玫", "依", "叫", "保", "魂", "裂", "表", "户", "宵", "妥", "顿", "吩", "维", "调", "峦", "宪", "枚",
    "御", "慈", "卒", "脉", "挨", "沂", "剥", "等", "颇", "巷", "述", "芜", "烦", "认", "拘", "春", "儒",
    "白", "晶", "绞", "豹", "扫", "瞒", "炸", "淘", "壹", "饮", "刘", "下", "挝", "主", "销", "路", "娶",
    "考", "违", "畜", "憨", "世", "败", "唁", "跟", "添", "郸", "捅", "羔", "漠", "恤", "环", "观", "祸",
    "克", "掠", "默", "媚", "秀", "洒", "士", "肮", "券", "释", "畴", "修", "磋", "茄", "篡", "目", "顾",
    "叁", "寿", "疽", "关", "诈", "绑", "牧", "冠", "遁", "贵", "补", "缀", "获", "见", "殃", "需", "肚",
    "氯", "阅", "报", "痈", "端", "浴", "糖", "嗡", "括", "棱", "授", "坛", "脊", "一", "瀑", "壤", "悲",
    "谦", "衰", "唇", "玛", "皿", "橡", "蔗", "食", "肋", "讽", "宾", "迈", "兆", "规", "旭", "惧", "誊",
    "扎", "穷", "妖", "仑", "幕", "赃", "啪", "荔", "筋", "涡", "候", "镑", "骆", "噎", "箕", "困", "猜",
    "撅", "侵", "土", "沾", "阀", "棵", "不", "寂", "腿", "掘", "牛", "借", "舰", "猾", "经", "物", "乖",
    "柏", "劝", "藤", "巴", "效", "孺", "氟", "棋", "累", "歹", "询", "唯", "满", "俘", "姻", "朗", "程",
    "锐", "其", "羞", "诫", "暮", "封", "卫", "躯", "丧", "彬", "慷", "旗", "律", "拟", "但", "疟", "始",
    "升", "妨", "制", "擂", "谍", "廖", "沛", "胡", "茅", "咱", "矮", "悄", "趁", "尉", "卤", "停", "钎",
    "诅", "寓", "鞋", "斜", "菇", "呕", "踩", "旱", "喳", "烬", "朋", "姆", "决", "勾", "辙", "订", "扮",
    "耍", "掏", "渠", "核", "崔", "嘲", "掇", "序", "驶", "力", "践", "山", "兰", "意", "芒", "填", "技",
    "中", "帖", "窑", "仔", "挣", "资", "截", "乓", "蕊", "扩", "粗", "谣", "巍", "称", "钻", "捎", "艳",
    "礁", "腾", "琉", "纳", "莎", "载", "铁", "活", "板", "湿", "梢", "陡", "舌", "摔", "屏", "筒", "舒",
    "恼", "泌", "黔", "译", "驳", "事", "隔", "卷", "渊", "构", "奉", "悟", "锻", "叔", "秸", "将", "陨",
    "疗", "糠", "布", "准", "崭", "束", "赤", "雄", "料", "祈", "城", "狄", "豺", "邮", "虑", "禁", "秧",
    "长", "卜", "东", "场", "卢", "挠", "从", "韭", "略", "陷", "赵", "巢", "纶", "抖", "涛", "郝", "辜",
    "体", "壳", "壁", "硫", "柴", "吉", "坪", "除", "坍", "嫉", "糜", "巡", "缔", "驱", "马", "低", "卯",
    "砰", "惟", "瞄", "孝", "祥", "彩", "肾", "岸", "褪", "蜗", "晚", "蝇", "偷", "绘", "嚣", "馈", "纲",
    "尺", "匈", "话", "蓄", "碱", "苇", "陆", "皮", "蠕", "亚", "诧", "宇", "羊", "清", "胚", "巨", "叙",
    "剿", "题", "上", "通", "患", "砌", "篓", "吝", "垄", "吕", "崩", "孕", "肪", "票", "援", "扑", "诌",
    "辞", "朱", "鄂", "扁", "嫡", "淀", "墓", "扣", "海", "硬", "苫", "乾", "沤", "思", "墒", "桓", "廉",
    "甸", "网", "原", "咆", "漏", "嘉", "奈", "幂", "晨", "砷", "亮", "嚼", "荫", "爹", "掳", "牟", "贫",
    "费", "泥", "褒", "妓", "塞", "甥", "稼", "雨", "小", "衷", "乌", "骸", "戍", "都", "潮", "弦", "盎",
    "誓", "使", "汐", "符", "术", "驹", "膏", "瞅", "坟", "斧", "值", "芥", "噶", "了", "怖", "猫", "殆",
    "蒜", "袒", "养", "鹏", "贯", "宝", "罪", "喝", "越", "逆", "痉", "泅", "咎", "八", "敝", "死", "滦",
    "划", "僚", "葵", "狰", "尔", "侩", "宿", "吭", "汹", "署", "抡", "公", "间", "秃", "橙", "渤", "丸",
    "恿", "岭", "辫", "轩", "奔", "申", "吧", "茎", "撩", "诬", "烽", "块", "艾", "觅", "雏", "赡", "我",
    "张", "款", "置", "枫", "庆", "械", "龟", "议", "舀", "沧", "仪", "泽", "佐", "谆", "样", "凳", "退",
    "宰", "遭", "麦", "沼", "灯", "汗", "潍", "笺", "莉", "挺", "相", "彻", "堆", "柜", "呜", "静", "件",
    "蚤", "娟", "宣", "烯", "恳", "芋", "鸽", "错", "宛", "砾", "缎", "洪", "匹", "煤", "竿", "纽", "耸",
    "剪", "瞩", "佯", "注", "与", "搁", "缮", "酮", "迅", "换", "勉", "泞", "丰", "细", "叼", "阔", "介",
    "姓", "毋", "里", "么", "跪", "弘", "贬", "君", "沦", "泪", "页", "千", "珍", "似", "铱", "招", "倒",
    "铺", "嫌", "婆", "忙", "滥", "早", "危", "轧", "勘", "护", "娩", "挞", "幢", "炯", "沸", "触", "雀",
    "厦", "亦", "孙", "传", "曹", "梗", "瓷", "格", "氢", "掸", "迹", "撰", "澄", "孰", "瓶", "弛", "官",
    "寨", "围", "络", "温", "旁", "秽", "帚", "萝", "数", "甭", "沥", "晒", "化", "芽", "罕", "绿", "嘻",
    "僳", "抄", "轿", "镊", "雹", "钵", "休", "诀", "欣", "医", "素", "佣", "例", "允", "固", "孤", "装",
    "氮", "屈", "虫", "榨", "痹", "邯", "弗", "驼", "犀", "绕", "纹", "材", "缆", "魏", "杜", "臀", "樊",
    "讼", "俐", "示", "邵", "寥", "罗", "雷", "寐", "暴", "缉", "惑", "昭", "呆", "勤", "郡", "朴", "榆",
    "函", "宴", "眺", "靡", "嚎", "够", "粟", "朔", "疚", "晌", "霖", "纤", "痊", "蛮", "辟", "瘸", "闭",
    "圭", "循", "愉", "奖", "焉", "向", "涌", "涩", "尘", "于", "凉", "棺", "阴", "怪", "曝", "丢", "车",
    "仲", "媳", "呈", "吻", "尿", "酿", "轮", "隅", "未", "本", "孵", "靴", "爷", "砧", "帧", "鱼", "喇",
    "苛", "举", "镶", "防", "蛹", "僧", "仙", "劈", "阁", "古", "伎", "柠", "库", "混", "南", "轻", "虎",
    "书", "愚", "沿", "狡", "舷", "珠", "拽", "胜", "绍", "獭", "托", "煎", "醛", "怕", "浊", "易", "葛",
    "负", "碳", "黑", "墙", "酬", "裴", "床", "挚", "含", "新", "铲", "剖", "软", "尧", "氛", "嚷", "戊",
    "老", "益", "秩", "眯", "推", "共", "啡", "麓", "切", "睁", "努", "虽", "涨", "哇", "炊", "翰", "聋",
    "谚", "姚", "燎", "猛", "堡", "霄", "泼", "腋", "铬", "谐", "乃", "琶", "卖", "枕", "毖", "蝴", "音",
    "统", "飞", "肿", "僻", "尾", "昏", "浙", "妙", "锰", "金", "镐", "薪", "篇", "脖", "吞", "顺", "牲",
    "缠", "阳", "胞", "怀", "檀", "嘱", "散", "踊", "曲", "此", "级", "迁", "爸", "站", "朽", "蛙", "挪",
    "邹", "韧", "搽", "犬", "就", "傍", "愿", "浩", "骇", "磅", "榜", "措", "突", "指", "性", "念", "衣",
    "毁", "舟", "辑", "陌", "营", "泵", "甩", "球", "颤", "闸", "巾", "侨", "个", "佛", "亲", "湾", "雅",
    "弱", "副", "弃", "斡", "宗", "番", "泊", "伶", "咀", "胺", "脏", "昼", "履", "讨", "墩", "胁", "戚",
    "运", "轴", "供", "挥", "峻", "各", "嗓", "撬", "胯", "醇", "辽", "妊", "颧", "靳", "蹬", "纪", "衔",
    "曳", "概", "窟", "及", "开", "硼", "横", "眨", "岔", "功", "炉", "政", "桃", "渣", "瓤", "词", "哨",
    "岿", "坯", "十", "即", "响", "暑", "财", "泰", "羡", "腐", "窜", "垢", "孩", "筑", "枪", "帆", "龙",
    "哗", "绒", "没", "蹈", "乞", "蔚", "言", "浑", "佳", "挤", "逼", "凡", "纺", "粥", "晕", "缩", "唉",
    "耳", "碉", "氧", "独", "侗", "弟", "芝", "邱", "镇", "淑", "矢", "七", "啃", "起", "蜀", "粱", "孟",
    "康", "锄", "襟", "翘", "眼", "毗", "蜂", "花", "楞", "寝", "兢", "哈", "两", "倔", "骏", "谋", "酪",
    "烷", "澈", "迷", "翟", "癣", "烟", "眠", "美", "瞪", "涸", "绢", "笨", "语", "咏", "闲", "阻", "急",
    "榔", "津", "盅", "迫", "禾", "愁", "诣", "皖", "讯", "昌", "蔓", "脑", "纯", "裔", "酸", "狐", "察",
    "厂", "嘘", "声", "当", "肥", "耙", "蔽", "睹", "监", "漫", "怠", "踞", "具", "谤", "庙", "掩", "毡",
    "发", "阜", "膀", "荧", "炳", "铆", "冲", "酝", "玉", "匀", "姥", "恃", "晋", "逢", "育", "惺", "闰",
    "匆", "田", "炬", "备", "挟", "敢", "鹃", "周", "拌", "贱", "咳", "讳", "嘶", "蕴", "弧", "佬", "成",
    "团", "股", "坐", "鲜", "胰", "猪", "壕", "悦", "歌", "钓", "傻", "可", "飘", "糊", "树", "症", "淤",
    "赌", "伐", "菱", "沙", "寺", "靖", "垂", "躇", "钱", "麻", "病", "齐", "院", "纱", "锗", "较", "救",
    "班", "撒", "熄", "旋", "咋", "邑", "府", "骤", "揉", "蚀", "请", "拦", "瞎", "尚", "权", "奠", "肖",
    "充", "卞", "露", "聊", "恢", "卉", "详", "店", "口", "鼻", "达", "匝", "终", "舶", "戒", "钝", "假",
    "街", "睬", "讥", "舔", "遇", "完", "审", "味", "济", "摇", "攫", "钧", "门", "续", "赶", "冕", "闯",
    "宙", "桔", "募", "郎", "拭", "俯", "娜", "焦", "先", "彦", "渍", "犯", "粒", "把", "客", "矫", "疏",
    "杏", "霞", "直", "宠", "腺", "镍", "遣", "蓝", "货", "厅", "涧", "竭", "栈", "蹦", "层", "盐", "纵",
    "驭", "该", "雾", "旨", "震", "峡", "担", "邀", "搔", "酌", "伯", "焙", "亨", "献", "炮", "储", "互",
    "岩", "侣", "要", "簿", "泻", "签", "课", "提", "结", "疫", "疹", "诲", "垦", "鳖", "溪", "热", "脂",
    "糙", "掂", "抿", "嘎", "皋", "水", "挎", "消", "面", "贿", "牺", "论", "瘟", "饰", "裁", "廊", "卑",
    "阑", "镜", "解", "敏", "挡", "参", "蚕", "施", "涟", "年", "怔", "彰", "腕", "缨", "馋", "摹", "衡",
    "陶", "家", "藐", "牵", "夕", "隶", "趴", "寻", "同", "广", "刑", "且", "柑", "猿", "脯", "差", "霸",
    "倍", "瘫", "硕", "键", "仁", "惯", "被", "咬", "姑", "夏", "瑰", "刷", "诵", "凑", "艺", "北", "搭",
    "冶", "笑", "局", "弄", "贪", "廷", "继", "窒", "取", "估", "汝", "药", "废", "搪", "倡", "替", "普",
    "系", "债", "在", "涕", "潘", "少", "铂", "守", "杰", "娇", "缓", "亢", "迢", "索", "槐", "垮", "屋",
    "饿", "祝", "趣", "劳", "贝", "雇", "箔", "酶", "捆", "委", "搓", "惮", "俺", "稀", "频", "磨", "丝",
    "日", "帜", "赏", "别", "媒", "骄", "斥", "韵", "遂", "丁", "抢", "籽", "草", "刺", "分", "蓑", "兵",
    "变", "宁", "忌", "复", "巧", "柱", "唾", "溃", "革", "配", "衅", "今", "芭", "伍", "贴", "绵", "萎",
    "链", "绽", "辣", "眩", "疮", "快", "买", "骨", "州", "猴", "敲", "厌", "掺", "赦", "姬", "娥", "召",
    "次", "蔡", "属", "隧", "氓", "影", "狞", "催", "涝", "足", "妆", "墅", "毕", "锅", "悔", "螟", "纂",
    "彝", "惰", "鬃", "狠", "企", "辱", "冰", "怂", "多", "液", "垒", "瓦", "遵", "茂", "敌", "雁", "画",
    "惊", "离", "庇", "砖", "丘", "钒", "铡", "优", "巳", "曾", "啸", "台", "趟", "稗", "糟", "价", "咖",
    "鞘", "庶", "妇", "诛", "吴", "按", "鲍", "妻", "哎", "懊", "骋", "擅", "撕", "戏", "碗", "摩", "率",
    "蔫", "坊", "狸", "堂", "唬", "叠", "如", "末", "圣", "镁", "远", "处", "椅", "境", "絮", "浦", "淖",
    "臃", "汽", "碾", "综", "僳", "掐", "峨", "伪", "教", "肄", "膝", "谅", "镭", "李", "姜", "座", "京",
    "他", "滇", "住", "洋", "谁", "预", "踌", "高", "窿", "积", "剐", "塌", "杂", "桅", "寸", "范", "商",
    "挑", "熔", "茶", "伏", "皱", "往", "碧", "航", "量", "明", "友", "道", "颖", "虞", "赠", "呼", "吁",
    "旬", "汪", "婪", "鞠", "勋", "弓", "吵", "舱", "桌", "外", "状", "覆", "烹", "秆", "威", "茹", "赂",
    "悯", "俭", "岳", "比", "治", "潞", "兜", "跌", "松", "档", "放", "蛤", "绚", "荐", "蜜", "幸", "敦",
    "珊", "橇", "刻", "策", "搜", "牢", "吼", "杆", "稿", "俗", "专", "沁", "坚", "恨", "子", "志", "祖",
    "芬", "熏", "莽", "篙", "酣", "耪", "浮", "女", "碌", "呻", "汲", "捡", "灼", "冬", "敬", "啤", "押",
    "煮", "孪", "况", "玖", "洛", "饱", "兽", "奴", "粳", "竣", "楼", "刮", "藻", "波", "毛", "肺", "肇",
    "干", "民", "叶", "算", "投", "臭", "曼", "谭", "戌", "实", "阐", "洱", "胎", "井", "姐", "者", "方",
    "手", "兴", "晤", "挖", "杠", "懦", "罩", "迎", "凤", "已", "秤", "裤", "箍", "凛", "步", "灭", "尊",
    "木", "王", "灵", "抹", "唆", "惋", "稠", "倚", "占", "蛛", "锹", "递", "损", "囚", "颈", "藩", "虱",
    "哄", "植", "俄", "趋", "剔", "首", "霍", "驯", "健", "慧", "澳", "厩", "戎", "燕", "滋", "羽", "赚",
    "来", "竹", "汇", "寇", "写", "璃", "咯", "樱", "匙", "贡", "苑", "佩", "犁", "耘", "氏", "诱", "圾",
    "惹", "竟", "莲", "臼", "玄", "捶", "匣", "锚", "丛", "问", "剁", "斩", "铭", "垛", "喜", "改", "翔",
    "钙", "屉", "峙", "凸", "之", "爬", "乐", "宜", "砂", "福", "桂", "险", "节", "用", "缝", "框", "嘿",
    "簇", "母", "丙", "咨", "六", "磐", "焊", "崖", "董", "抨", "薄", "令", "嗽", "坡", "嫩", "睦", "袭",
    "呐", "延", "购", "娘", "服", "墨", "蒙", "晾", "癸", "陛", "忻", "探", "众", "偏", "桐", "酷", "峪",
    "刨", "账", "洁", "怒", "龋", "入", "釉", "饼", "揭", "计", "痰", "嚏", "赋", "炽", "季", "沽", "钉",
    "嫂", "融", "膘", "熙", "佃", "吱", "整", "条", "尖", "弯", "粤", "魔", "培", "任", "撇", "黍", "去",
    "返", "也", "绰", "涎", "你", "屠", "枉", "钨", "县", "芯", "堤", "喉", "摈", "兄", "赴", "途", "拎",
    "仰", "懂", "肌", "扼",
    "梦琪", "琪忆", "忆柳", "柳之", "之桃", "桃慕", "慕青", "青问", "问兰", "兰尔", "尔岚", "岚元", "元香",
    "香初", "初夏", "夏沛", "沛菡", "菡傲", "傲珊", "珊曼", "曼文", "文乐", "水绿", "绿曼", "曼荷", "荷夜",
    "乐菱", "菱痴", "痴珊", "珊晓", "晓绿", "绿以", "以菱", "菱冬", "冬云", "云含", "含玉", "玉访", "访枫",
    "枫访", "访云", "云翠", "翠容", "容寒", "寒凡", "凡笑", "笑珊", "珊恨", "夜安", "安觅", "觅海", "海问",
    "恨玉", "玉惜", "惜文", "文香", "香寒", "寒新", "新柔", "柔语", "语蓉", "蓉海", "海安", "安夜", "夜蓉",
    "蓉涵", "涵柏", "柏水", "水桃", "桃醉", "醉蓝", "蓝春", "春儿", "儿语", "问安", "安晓", "晓槐", "花蕾",
    "语琴", "琴从", "从彤", "彤傲", "傲晴", "晴语", "语兰", "兰又", "又菱", "菱碧", "碧彤", "彤元", "元霜",
    "霜怜", "怜梦", "梦紫", "紫寒", "寒妙", "妙彤", "彤寒", "寒珊", "曼易", "槐雅", "雅山", "山花", "枫水",
    "易南", "南莲", "莲紫", "紫翠", "翠雨", "雨寒", "寒易", "易烟", "烟如", "如萱", "萱若", "若南", "南寻",
    "寻真", "真晓", "晓亦", "亦向", "向珊", "珊慕", "慕灵", "灵以", "以蕊", "云谷", "谷南", "南冰", "冰旋",
    "蕊寻", "寻雁", "雁映", "映易", "易雪", "雪柳", "柳孤", "孤岚", "岚笑", "笑霜", "霜海", "海云", "云凝",
    "凝天", "天沛", "沛珊", "珊寒", "寒云", "烟半", "半梦", "梦雅", "雅绿", "绿冰", "冰蓝", "香若", "若烟",
    "旋宛", "宛儿", "儿绿", "绿真", "真盼", "盼儿", "儿晓", "晓霜", "霜碧", "碧凡", "凡夏", "夏菡", "菡曼",
    "曼香", "梦曼", "曼幼", "幼翠", "翠友", "友巧", "巧慕", "慕儿", "儿听", "听寒", "柏夜", "夜蕾", "蕾冰",
    "蓝灵", "灵槐", "槐平", "平安", "安书", "书翠", "翠翠", "翠风", "风香", "香巧", "巧代", "代云", "云梦",
    "寒梦", "梦柏", "柏醉", "醉易", "易访", "访旋", "旋亦", "亦玉", "玉凌", "凌萱", "萱访", "访卉", "卉怀",
    "怀亦", "亦笑", "笑蓝", "春翠", "翠靖", "靖柏", "从寒", "寒夏", "夏岚", "岚忆", "忆香", "香觅", "山从",
    "冰夏", "夏梦", "梦松", "松书", "书雪", "雪乐", "乐枫", "枫念", "念薇", "薇靖", "靖雁", "雁寻", "寻春",
    "觅波", "波静", "静曼", "曼凡", "凡旋", "旋以", "以亦", "亦念", "念露", "露芷", "芷蕾", "蕾千", "千兰",
    "兰新", "新波", "波代", "代真", "真新", "新蕾", "蕾雁", "雁玉", "玉冷", "春恨", "恨山", "翠萱", "萱恨",
    "冷卉", "卉紫", "紫山", "山千", "千琴", "琴恨", "恨天", "天傲", "傲芙", "芙盼", "盼山", "山怀", "怀蝶",
    "蝶冰", "冰兰", "兰山", "山柏", "柏友", "友儿", "儿翠", "冰彤", "彤亦", "亦寒", "寒寒", "寒雁", "雁怜",
    "恨松", "松问", "问旋", "旋从", "从南", "南白", "白易", "易问", "问筠", "筠如", "如霜", "霜半", "半芹",
    "怜云", "云寻", "寻文", "乐丹", "丹翠", "翠柔", "柔谷", "谷山", "山之", "之瑶", "瑶冰", "冰露", "露尔",
    "尔珍", "珍谷", "谷雪", "雪小", "小萱", "萱乐", "乐萱", "萱涵", "涵菡", "芹丹", "丹珍", "珍冰", "妙菡",
    "菡海", "海莲", "莲傲", "傲蕾", "蕾青", "青槐", "槐冬", "冬儿", "儿易", "易梦", "梦惜", "惜雪", "雪宛",
    "宛海", "海之", "之柔", "柔夏", "夏青", "青亦", "亦瑶", "瑶妙", "友蕊", "蕊寄", "寄凡", "凡怜", "雁枫",
    "菡春", "春竹", "竹痴", "痴梦", "紫蓝", "蓝晓", "晓巧", "巧幻", "幻柏", "柏元", "元风", "风冰", "冰枫",
    "访蕊", "蕊紫", "紫青", "青南", "南春", "春芷", "芷蕊", "蕊凡", "凡蕾", "露映", "映波", "波友", "映秋",
    "蕾凡", "凡柔", "柔安", "安蕾", "蕾天", "天荷", "荷含", "玉书", "书兰", "兰雅", "雅琴", "琴书", "书瑶",
    "瑶春", "春雁", "雁从", "从安", "安夏", "夏槐", "槐念", "念芹", "芹怀", "涵蕾", "蕾碧", "碧菡", "菡映",
    "怀萍", "萍代", "代曼", "曼幻", "幻珊", "珊谷", "谷丝", "丝秋", "秋翠", "翠白", "白晴", "晴海", "海露",
    "露妙", "妙菱", "菱代", "代荷", "书蕾", "蕾听", "听白", "白访", "访琴", "青寒", "寒笑", "笑天", "天涵",
    "琴灵", "灵雁", "雁秋", "秋春", "春雪", "雪青", "青乐", "乐瑶", "瑶含", "含烟", "烟涵", "涵双", "双平",
    "平蝶", "蝶雅", "雅蕊", "蕊傲", "傲之", "之灵", "灵薇", "薇绿", "绿春", "卉向", "向彤", "彤小", "小玉",
    "春含", "含蕾", "蕾从", "从梦", "梦从", "从蓉", "蓉初", "初丹", "丹听", "听兰", "兰冬", "冬寒", "寒听",
    "听蓉", "蓉语", "语芙", "芙夏", "夏彤", "彤凌", "凌瑶", "瑶忆", "忆翠", "莲夜", "夜山", "山芷", "芷卉",
    "翠幻", "幻灵", "灵怜", "怜菡", "菡紫", "紫南", "南依", "依珊", "珊妙", "妙竹", "竹访", "访烟", "烟怜",
    "怜蕾", "蕾映", "映寒", "寒友", "友绿", "冰萍", "萍惜", "惜霜", "霜凌", "幻莲", "以蓝", "蓝笑", "笑寒",
    "凌香", "香芷", "雁卉", "卉迎", "迎梦", "梦元", "元柏", "柏曼", "曼柔", "柔代", "代萱", "萱紫", "紫真",
    "真千", "千青", "青凌", "凌寒", "寒紫", "紫安", "安寒", "寒安", "安怀", "书芹", "芹幼", "幼蓉", "蓉以",
    "怀蕊", "蕊秋", "秋荷", "荷涵", "涵雁", "雁以", "以山", "山凡", "凡梅", "梅盼", "盼曼", "曼翠", "翠彤",
    "彤谷", "谷冬", "冬新", "新巧", "巧冷", "冷安", "安千", "千萍", "萍冰", "寄灵", "灵书", "亦梦", "梦露",
    "冰烟", "烟雅", "雅阳", "阳友", "绿南", "南松", "松语", "语蝶", "蝶诗", "诗云", "云飞", "飞风", "风寄",
    "寒忆", "忆寒", "寒秋", "秋烟", "烟芷", "芷巧", "巧水", "水香", "香映", "映之", "之醉", "醉波", "波幻",
    "玉幼", "幼南", "南凡", "凡梦", "梦尔", "尔曼", "曼青", "青筠", "筠念", "念波", "波迎", "迎松", "松青",
    "秋盼", "盼烟", "烟忆", "忆山", "山以", "以寒", "寒香", "香小", "小凡", "凡代", "代亦",
}

-- 拼音姓氏
local PINYIN_FAMILY_NAMES = {
    "Zhao", "Qian", "Sun", "Li", "Zhou", "Wu", "Zheng", "Wang", "Feng", "Chen", "Chu", "Wei", "Jiang",
    "Shen", "Han", "Yang", "Zhu", "Qin", "You", "Xu", "He", "Lv", "Shi", "Zhang", "Kong", "Cao", "Yan",
    "Hua", "Jin", "Tao", "Qi", "Xie", "Zou", "Yu", "Bo", "Shui", "Dou", "Yun", "Su", "Pan", "Ge", "Xi",
    "Fan", "Peng", "Lang", "Lu", "Chang", "Ma", "Miao", "Fang", "Ren", "Yuan", "Liu", "Bao", "Tang",
    "Fei", "Lian", "Cen", "Xue", "Lei", "Ni", "Teng", "Yin", "Luo", "Bi", "Hao", "An", "Le", "Fu", "Pi",
    "Bian", "Kang", "Bu", "Gu", "Meng", "Ping", "Huang", "Mu", "Xiao", "Yao", "Shao", "Zhan", "Mao",
    "Di", "Mi", "Bei", "Ming", "Zang", "Ji", "Cheng", "Dai", "Tan", "Song", "Pang", "Xiong", "Shu",
    "Qu", "Xiang", "Dong", "Liang", "Du", "Ruan", "Lan", "Min", "Qiang", "Jia", "Lou", "Tong", "Guo",
    "Mei", "Sheng", "Lin", "Diao", "Zhong", "Qiu", "Gao", "Xia", "Cai", "Tian", "Hu", "Ling", "Huo",
    "Wan", "Zhi", "Ke", "Zan", "Guan", "Mo", "Jing", "Mou", "Gan", "Jie", "Ying", "Zong", "Ding",
    "Xuan", "Deng", "Dan", "Hang", "Hong", "Zuo", "Cui", "Niu", "Gong", "Xing", "Pei", "Rong", "Weng",
    "Xun", "Hui", "Zhen", "Rui", "Yi", "Bing", "Duan", "Jiao", "Ba", "Shan", "Che", "Hou", "Quan",
    "Ban", "Ning", "Chou", "Luan", "Tou", "Zu", "Long", "Ye", "Si", "Bai", "Huai", "Pu", "Tai", "Cong",
    "E", "Suo", "Xian", "Lai", "Zhuo", "Tu", "Chi", "Qiao", "Neng", "Cang", "Shuang", "Wen", "Xin",
    "Dang", "Zhai", "Lao", "Ran", "Zai", "Yong", "Sang", "Gui", "Shou", "Shang", "Nong", "Bie", "Zhuang",
    "Chai", "Ju", "Chong", "Ru", "Huan", "Ai", "Liao", "Heng", "Geng", "Man", "Kuang", "Kou", "Guang",
    "Que", "Ou", "Wo", "Yue", "Kui", "She", "Nie", "Chao", "Gou", "Ao", "Leng", "Zi", "Kan", "Nei", "Jian",
    "Rao", "Ceng", "Sha", "Mie", "Kuai", "Cha", "Gai", "Fa", "Hai", "Shuai", "Nai", "Ha", "Da", "Nian"
}

-- 拼音常用名
local PINYIN_COMMON_NAMES = {
    "Huang", "Cen", "Wei", "Geng", "Yin", "De", "Ying", "Gong", "Shen", "Zang", "Xia", "Qing", "Wu", "Ban",
    "Quan", "Dou", "Yu", "Dai", "Shou", "Lan", "Wang", "Miu", "Mao", "He", "Jiang", "Mo", "Dong", "Jiu",
    "Ting", "Nang", "Nie", "Yuan", "Kui", "La", "Xiang", "Bai", "Jia", "Dao", "Zi", "Du", "Tuo", "Da",
    "Xie", "Miao", "Xiao", "Zhou", "Liu", "Mai", "An", "Wan", "Wa", "Yong", "Dan", "Zhai", "Ya", "Qiu",
    "Chou", "Jie", "Lin", "Diao", "Xing", "Gang", "Yue", "Ba", "Dian", "Tan", "Ti", "Fu", "Hui", "Nuo",
    "Ning", "Fa", "Zui", "Jian", "Ze", "Die", "Qian", "Kou", "Zheng", "Luan", "Zhi", "Shao", "Chao", "Zhui",
    "Cui", "Ao", "Ni", "Kua", "Chang", "Qi", "Di", "Zhong", "Tang", "Yi", "Ding", "Zhu", "Kuo", "Na", "Han",
    "Ta", "Tong", "Shuang", "Zong", "Long", "Liang", "Xu", "Zhao", "Ling", "Bo", "Biao", "Rou", "Tao", "Luo",
    "Gou", "Lei", "Hong", "Bang", "Chen", "Bu", "Chu", "Xiu", "Sai", "Shai", "Hu", "Cheng", "Zhuo", "You",
    "Bi", "Xiong", "Hai", "Bing", "Zuo", "Bian", "Sou", "Nan", "Li", "Keng", "Zan", "Nei", "Jing", "Cha",
    "Chi", "Ai", "Xun", "Kang", "Shuo", "Zhang", "Mian", "Rong", "Yang", "Cuo", "Yun", "Duo", "Zou", "Chui",
    "Jin", "Shu", "Pao", "Xue", "Zai", "Hou", "Lu", "Le", "Zhen", "Liao", "Za", "Wo", "Lang", "Xian", "Ku",
    "Pan", "Kun", "Gu", "Fan", "Shi", "Que", "Can", "Ge", "Juan", "Tu", "Jun", "Tai", "Qun", "Ji", "Lian",
    "Pin", "Er", "Niu", "Bao", "Tun", "Ping", "Weng", "Gui", "Chan", "Cuan", "Peng", "Yan", "Hun", "Nian",
    "Guan", "Guo", "Pen", "Lou", "Suo", "Kan", "Chuang", "Zhan", "Huai", "Jiao", "Fen", "Heng", "Qiang", "Sao",
    "San", "Cang", "Ran", "Mang", "Wen", "Ken", "Pi", "Po", "Kao", "E", "Tou", "Zha", "Lai", "Cong", "Chun",
    "Kuang", "Lv", "Ke", "Nuan", "Beng", "Shan", "Qiao", "Xi", "Xin", "Ci", "Ce", "Dang", "Meng", "Shui",
    "Ju", "Huo", "Si", "Nai", "Cu", "Lao", "Guang", "Chuan", "Sui", "Zhei", "Yao", "Duan", "Gun", "Sun",
    "Dun", "A", "Yo", "Tuan", "Deng", "She", "Lie", "Mi", "Ou", "Tui", "Pai", "Sha", "Xuan", "Su", "Zao",
    "Man", "Bin", "Che", "Gan", "Zhe", "Cun", "Chai", "Zhuang", "Niao", "Zei", "Rui", "Ye", "Fei", "Zhuan",
    "Ma", "Ben", "Dui", "Sheng", "Kong", "Zhua", "Ceng", "Hao", "Shun", "Bei", "Nve", "Shang", "Pu", "Se",
    "Zeng", "Nin", "Tian", "Pang", "Ruan", "Zu", "Kai", "Hen", "Piao", "Ru", "Cao", "Zen", "Ren", "Gen",
    "Jue", "Nong", "Teng", "Ming", "Cai", "Lun", "Rang", "Qin", "Shuan", "Mou", "Rao", "Neng", "Ka", "Men",
    "Mu", "Gua", "Song", "Sa", "Gao", "Fang", "Reng", "Fou", "Qie", "Sang", "Nao", "Qia", "Feng", "En", "Hua",
    "Pian", "Gai", "Mei", "Bie", "Sen", "Ruo", "Tiao", "Chong", "Wai", "Leng", "Ca", "Shuai", "Te", "Qu", "Hang",
    "Kuan", "Chuai", "Run", "Min", "Ang", "Pei", "Qiong", "Mie", "Chuo", "Huan", "Pa", "Pie", "Kuai", "Guai",
    "Jiong", "Lve", "Shua", "Tie", "Zuan", "Zhun", "Ga", "Suan", "Me", "Diu", "Niang", "Seng", "Zhuai", "Hei",
    "Pou", "Nu", "Fo", "Ha", "Re", "Cou", "Ri", "Zun", "Shei", "Nv", "Nen", "MengQi", "QiYi", "YiLiu", "LiuZhi",
    "ZhiTao", "TaoMu", "MuQing", "QingWen", "WenLan", "LanEr", "ErLan", "LanYuan", "YuanXiang", "XiangChu",
    "ChuXia", "XiaPei", "PeiHan", "HanAo", "AoShan", "ShanMan", "ManWen", "WenLe", "ShuiLv", "LvMan", "ManHe",
    "HeYe", "LeLing", "LingChi", "ChiShan", "ShanXiao", "XiaoLv", "LvYi", "YiLing", "LingDong", "DongYun",
    "YunHan", "HanYu", "YuFang", "FangFeng", "FengFang", "FangYun", "YunCui", "CuiRong", "RongHan", "HanFan",
    "FanXiao", "XiaoShan", "ShanHen", "YeAn", "AnMi", "MiHai", "HaiWen", "HenYu", "YuXi", "XiWen", "WenXiang",
    "XiangHan", "HanXin", "XinRou", "RouYu", "YuRong", "RongHai", "HaiAn", "AnYe", "YeRong", "HanBo", "BoShui",
    "ShuiTao", "TaoZui", "ZuiLan", "LanChun", "ChunEr", "ErYu", "WenAn", "AnXiao", "XiaoHuai", "HuaLei", "YuQin",
    "QinCong", "CongTong", "TongAo", "AoQing", "QingYu", "YuLan", "LanYou", "YouLing", "LingBi", "BiTong",
    "TongYuan", "YuanShuang", "ShuangLian", "LianMeng", "MengZi", "ZiHan", "HanMiao", "MiaoTong", "TongHan",
    "HanShan", "ManYi", "HuaiYa", "YaShan", "ShanHua", "FengShui", "YiNan", "NanLian", "LianZi", "ZiCui", "CuiYu",
    "YuHan", "HanYi", "YiYan", "YanRu", "RuXuan", "XuanRuo", "RuoNan", "NanXun", "XunZhen", "ZhenXiao", "XiaoYi",
    "YiXiang", "XiangShan", "ShanMu", "MuLing", "LingYi", "YiRui", "YunGu", "GuNan", "NanBing", "BingXuan", "RuiXun",
    "XunYan", "YanYing", "YingYi", "YiXue", "XueLiu", "LiuGu", "GuLan", "LanXiao", "XiaoShuang", "ShuangHai",
    "HaiYun", "YunNing", "NingTian", "TianPei", "PeiShan", "ShanHan", "HanYun", "YanBan", "BanMeng", "MengYa",
    "YaLv", "LvBing", "BingLan", "XiangRuo", "RuoYan", "XuanWan", "WanEr", "ErLv", "LvZhen", "ZhenPan", "PanEr",
    "ErXiao", "ShuangBi", "BiFan", "FanXia", "XiaHan", "HanMan", "ManXiang", "MengMan", "ManYou", "YouCui",
    "CuiYou", "YouQiao", "QiaoMu", "MuEr", "ErTing", "TingHan", "BoYe", "YeLei", "LeiBing", "LanLing", "LingHuai",
    "HuaiPing", "PingAn", "AnShu", "ShuCui", "CuiCui", "CuiFeng", "FengXiang", "XiangQiao", "QiaoDai", "DaiYun",
    "YunMeng", "HanMeng", "MengBo", "BoZui", "ZuiYi", "YiFang", "FangXuan", "XuanYi", "YiYu", "YuLing", "LingXuan",
    "XuanFang", "FangHui", "HuiHuai", "HuaiYi", "YiXiao", "XiaoLan", "ChunCui", "CuiJing", "JingBo", "CongHan",
    "HanXia", "XiaLan", "LanYi", "XiangMi", "ShanCong", "BingXia", "XiaMeng", "MengSong", "SongShu", "ShuXue",
    "XueLe", "LeFeng", "FengNian", "NianWei", "WeiJing", "JingYan", "YanXun", "XunChun", "MiBo", "BoJing", "JingMan",
    "ManFan", "FanXuan", "YiYi", "YiNian", "NianLu", "LuZhi", "ZhiLei", "LeiQian", "QianLan", "LanXin", "XinBo", "BoDai",
    "DaiZhen", "ZhenXin", "XinLei", "LeiYan", "YanYu", "YuLeng", "ChunHen", "HenShan", "CuiXuan", "XuanHen",
    "LengHui", "HuiZi", "ZiShan", "ShanQian", "QianQin", "QinHen", "HenTian", "TianAo", "AoFu", "FuPan", "PanShan",
    "ShanHuai", "HuaiDie", "DieBing", "LanShan", "ShanBo", "BoYou", "YouEr", "ErCui", "BingTong", "TongYi", "YiHan",
    "HanHan", "HanYan", "YanLian", "HenSong", "SongWen", "WenXuan", "XuanCong", "CongNan", "NanBai", "BaiYi", "YiWen",
    "WenYun", "YunRu", "RuShuang", "ShuangBan", "BanQin", "LianYun", "YunXun", "XunWen", "LeDan", "DanCui", "CuiRou",
    "RouGu", "GuShan", "ShanZhi", "ZhiYao", "YaoBing", "BingLu", "LuEr", "ErZhen", "ZhenGu", "GuXue", "XueXiao",
    "XiaoXuan", "XuanLe", "LeXuan", "XuanHan", "QinDan", "DanZhen", "ZhenBing", "MiaoHan", "HanHai", "HaiLian",
    "LianAo", "AoLei", "LeiQing", "QingHuai", "HuaiDong", "DongEr", "ErYi", "YiMeng", "MengXi", "XiXue", "XueWan",
    "WanHai", "HaiZhi", "ZhiRou", "RouXia", "XiaQing", "QingYi", "YiYao", "YaoMiao", "YouRui", "RuiJi", "JiFan",
    "FanLian", "YanFeng", "HanChun", "ChunZhu", "ZhuChi", "ChiMeng", "ZiLan", "XiaoQiao", "QiaoHuan", "HuanBo",
    "BoYuan", "YuanFeng", "FengBing", "BingFeng", "FangRui", "RuiZi", "ZiQing", "QingNan", "NanChun", "ChunZhi",
    "ZhiRui", "RuiFan", "FanLei", "LuYing", "YingBo", "YingQiu", "LeiFan", "FanRou", "RouAn", "AnLei", "LeiTian",
    "TianHe", "HeHan", "YuShu", "ShuLan", "LanYa", "YaQin", "QinShu", "ShuYao", "YaoChun", "ChunYan", "YanCong",
    "CongAn", "AnXia", "XiaHuai", "HuaiNian", "NianQin", "QinHuai", "HanLei", "LeiBi", "BiHan", "HanYing",
    "PingDai", "DaiMan", "ManHuan", "HuanShan", "ShanGu", "GuSi", "SiQiu", "QiuCui", "CuiBai", "BaiQing",
    "QingHai", "HaiLu", "LuMiao", "MiaoLing", "LingDai", "DaiHe", "ShuLei", "LeiTing", "TingBai", "BaiFang",
    "FangQin", "QingHan", "HanXiao", "XiaoTian", "TianHan", "QinLing", "LingYan", "YanQiu", "QiuChun", "ChunXue",
    "XueQing", "QingLe", "LeYao", "YaoHan", "YanHan", "HanShuang", "ShuangPing", "PingDie", "DieYa", "YaRui",
    "RuiAo", "AoZhi", "ZhiLing", "LingWei", "WeiLv", "LvChun", "HuiXiang", "XiangTong", "TongXiao", "XiaoYu",
    "ChunHan", "LeiCong", "CongMeng", "MengCong", "CongRong", "RongChu", "ChuDan", "DanTing", "TingLan",
    "LanDong", "DongHan", "HanTing", "TingRong", "RongYu", "YuFu", "FuXia", "XiaTong", "TongLing", "LingYao",
    "YaoYi", "YiCui", "LianYe", "YeShan", "ZhiHui", "CuiHuan", "HuanLing", "LingLian", "LianHan", "HanZi",
    "ZiNan", "NanYi", "YiShan", "ShanMiao", "MiaoZhu", "ZhuFang", "FangYan", "LianLei", "LeiYing", "YingHan",
    "HanYou", "YouLv", "BingPing", "PingXi", "XiShuang", "ShuangLing", "HuanLian", "YiLan", "XiaoHan", "LingXiang",
    "XiangZhi", "YanHui", "HuiYing", "YingMeng", "MengYuan", "YuanBo", "BoMan", "ManRou", "RouDai", "DaiXuan",
    "XuanZi", "ZiZhen", "ZhenQian", "QianQing", "QingLing", "LingHan", "ZiAn", "AnHan", "HanAn", "AnHuai", "ShuQin",
    "QinYou", "YouRong", "RongYi", "HuaiRui", "RuiQiu", "QiuHe", "YanYi", "ShanFan", "FanMei", "MeiPan", "PanMan",
    "ManCui", "CuiTong", "TongGu", "GuDong", "DongXin", "XinQiao", "QiaoLeng", "LengAn", "AnQian", "QianPing",
    "PingBing", "JiLing", "LingShu", "MengLu", "BingYan", "YanYa", "YaYang", "YangYou", "LvNan", "NanSong", "SongYu",
    "YuDie", "DieShi", "ShiYun", "YunFei", "FeiFeng", "FengJi", "HanQiu", "QiuYan", "YanZhi", "ZhiQiao", "QiaoShui",
    "ShuiXiang", "XiangYing", "YingZhi", "ZhiZui", "ZuiBo", "BoHuan", "YuYou", "YouNan", "NanFan", "FanMeng", "MengEr",
    "ErMan", "ManQing", "QingYun", "YunNian", "NianBo", "BoYing", "YingSong", "SongQing", "QiuPan", "PanYan", "ShanYi",
    "HanXiang", "XiangXiao", "XiaoFan", "FanDai", "DaiYi"
}

-- 随机生成中文姓名
function NetherBot:RandomChineseFullName()
    return NetherBot:RandomFromArray(CHINESE_FAMILY_NAMES) .. NetherBot:RandomFromArray(CHINESE_COMMON_NAMES)
end

-- 随机生成拼音姓名
function NetherBot:RandomPinyinFullName()
    return NetherBot:RandomFromArray(PINYIN_FAMILY_NAMES) .. NetherBot:RandomFromArray(PINYIN_COMMON_NAMES)
end

-- 跟随玩家，并主动攻击进入攻击范围，且有仇恨的敌人
function NetherBot:CommandNPCBotCommandFollow_Player()
    SendChatMessage(".npcbot command follow", "SAY")
end

-- 跟随玩家，并在活跃与非活跃之间切换
-- 跟随（活跃）：跟随玩家，并主动攻击进入攻击范围，且有仇恨的敌人
-- 跟随（非活跃）：所有机器人在跟随玩家时，不会采取任何行动
function NetherBot:CommandNPCBotCommandFollowOnly_Player()
    SendChatMessage(".npcbot command follow only", "SAY")
end

-- 停在原地，不会采取任何行动
function NetherBot:CommandNPCBotCommandStopFully_Player()
    SendChatMessage(".npcbot command stopfully", "SAY")
end

-- 停在原地，会攻击进入攻击范围，且有仇恨的敌人（炮台模式）
function NetherBot:CommandNPCBotCommandStandstill_Player()
    SendChatMessage(".npcbot command standstill", "SAY")
end

-- 开启/关闭对话，关闭后，鼠标放在机器人身上，不会显示对话图标，打怪时关闭对话，可以防止误点
function NetherBot:CommandNPCBotCommandNoGossip_Player()
    SendChatMessage(".npcbot command nogossip", "SAY")
end

-- 机器人在走/跑之间切换
function NetherBot:CommandNPCBotCommandWalk_Player()
    SendChatMessage(".npcbot command walk", "SAY")
end

-- 在不解雇机器人的情况下暂时释放机器人，机器人将返回出生的位置，并在那里等待，直到使用 rebind 命令重新绑定（或服务器重新启动）
-- 参数支持传入多个不区分大小写的机器人姓名，多个姓名之间用空格分割，如果姓名中包含空格，必须将空格替换成下划线
-- 例如：机器人 A 的姓名是 "Vivian"，机器人 B 的姓名是 "Amanda Green"
-- 传入的参数应该是 "Vivian Amanda_Green"，或者是 "vivian amanda_green"
function NetherBot:CommandNPCBotCommandUnbind_Player(names)
    if names then
        SendChatMessage(".npcbot command unbind " .. names, "SAY")
    else
        SendChatMessage(".npcbot command unbind", "SAY")
    end
end

-- unbind 的反向操作，重新绑定已经解绑的机器人
-- 参数支持传入多个不区分大小写的机器人姓名，多个姓名之间用空格分割，如果姓名中包含空格，必须将空格替换成下划线
-- 例如：机器人 A 的姓名是 "Vivian"，机器人 B 的姓名是 "Amanda Green"
-- 传入的参数应该是 "Vivian Amanda_Green"，或者是 "vivian amanda_green"
function NetherBot:CommandNPCBotCommandRebind_Player(names)
    if names then
        SendChatMessage(".npcbot command rebind " .. names, "SAY")
    else
        SendChatMessage(".npcbot command rebind", "SAY")
    end
end

-- toggle NPCBots' ability to cast any spells
function NetherBot:CommandNPCBotCommandNoCast_Player()
    SendChatMessage(".npcbot command nocast", "SAY")
end

-- toggle NPCBots' ability to cast spells with non-zero cast time
function NetherBot:CommandNPCBotCommandNoLongCast_Player()
    SendChatMessage(".npcbot command nolongcast", "SAY")
end

-- 使机器人暂时下线，他们将从地图上传送出去，直到被允许回来，不能在战斗中使用
function NetherBot:CommandNPCBotHide_Player()
    SendChatMessage(".npcbot hide", "SAY")
end

-- 将下线的机器人，召唤回来，不能在战斗中使用
function NetherBot:CommandNPCBotShow_Player()
    SendChatMessage(".npcbot show", "SAY")
end

-- 杀死机器人，可以用来解决，有时在副本中，即使脱离了战斗，机器人仍然处于战斗中，导致无法对话，无法复活玩家的 BUG
function NetherBot:CommandNPCBotKill_Player()
    SendChatMessage(".npcbot kill", "SAY")
end

-- 机器人跟随距离（0 - 100）
function NetherBot:CommandNPCBotDistance_Player(param)
    SendChatMessage(".npcbot distance " .. param, "SAY")
end

-- 机器人远程攻击距离（支持数字类型以及两个字符串类型的参数），只对“职责”中选择了“远程”的机器人有效
-- 数字：0 - 50，精确模式，忽略各个职业的伤害法术的攻击距离
--      如果设置成 0 ，所有机器人在战斗时，都将聚集在 boss 脚下
-- "short"：最小远程攻击距离，取各个职业最近射程的伤害法术的攻击距离
-- "long"：最大远程攻击距离，取各个职业最远射程的伤害法术的攻击距离
-- 注意：有奶骑职业的机器人在队伍中时，奶骑的“职责”不仅要选择“治疗”，还必须选择“远程”，且必须使用精确模式！
--      否则奶骑在战斗中会距离敌人很近，因为奶骑的最近射程的伤害法术和最远射程的伤害法术都是“审判”（10 码）
function NetherBot:CommandNPCBotDistanceAttack_Player(param)
    SendChatMessage(".npcbot distance attack " .. param, "SAY")
end

-- 强制机器人直接移动到玩家的位置
function NetherBot:CommandNPCBotRecall_Player()
    SendChatMessage(".npcbot recall", "SAY")
end

-- 强制机器人直接传送到玩家的位置
function NetherBot:CommandNPCBotRecallTeleport_Player()
    SendChatMessage(".npcbot recall teleport", "SAY")
end

-- 强制所有空闲（inactive）状态的机器人直接传送到玩家的位置，例如已经解除绑定的所有机器人
function NetherBot:CommandNPCBotRecallSpawns_Player()
    SendChatMessage(".npcbot recall spawns", "SAY")
end

-- 将机器人强制脱离载具
function NetherBot:CommandNPCBotVehicleEject_Player()
    SendChatMessage(".npcbot vehicle eject", "SAY")
end

-- 必须选中玩家，显示玩家拥有的机器人的各种状态下的数量
function NetherBot:CommandNPCBotInfo_Player()
    SendChatMessage(".npcbot info", "SAY")
end

-- 对机器人使用法术
-- 根据法术等级从高到低的顺序，依次校验玩家是否已经学会该法术，优先对机器人使用高等级法术
-- 否则就算未学会这个法术，也能对机器人使用（不平衡）
function NetherBot:CommandNPCBotUseOnBotSpell_Player(spellIds)
    for index, spellId in pairs(spellIds) do
        -- 校验玩家是否已经学会了这个法术
        local isSpellKnown = IsSpellKnown(spellId)
        if isSpellKnown then
            SendChatMessage(".npcbot useonbot spell " .. spellId, "SAY")
            return
        end
    end
    ChatFrame1:AddMessage("|cffFFFF00你还没有学会这个法术！")
end

-- 对机器人使用物品，物品ID
function NetherBot:CommandNPCBotUseOnBotItem_Player(itemId)
    SendChatMessage(".npcbot useonbot item " .. itemId, "SAY")
end

-- 复活机器人
function NetherBot:CommandNPCBotRevive_GM()
    SendChatMessage(".npcbot revive", "SAY")
end

-- 免费招募一个选中的机器人（绕过购买），仅适用于无主的机器人
function NetherBot:CommandNPCBotAdd_GM()
    SendChatMessage(".npcbot add", "SAY")
end

-- 解雇，通过此方式解除招募的机器人，会保留装备，并会回到原先招募的位置
function NetherBot:CommandNPCBotRemove_GM()
    SendChatMessage(".npcbot remove", "SAY")
end

-- 将机器人移动到玩家当前的位置，只能移动无主机器人，支持选中目标和根据机器人模板 entry（creature_template.entry）两种方式
function NetherBot:CommandNPCBotMove_GM(entry)
    if entry then
        SendChatMessage(".npcbot move " .. entry, "SAY")
    else
        SendChatMessage(".npcbot move", "SAY")
    end
end

-- 删除一个机器人，机器人的装备会回到背包
function NetherBot:CommandNPCBotDelete_GM()
    SendChatMessage(".npcbot delete", "SAY")
end

-- 根据机器人模板 entry（creature_template.entry），永久删除一个机器人，机器人的装备会回到背包
function NetherBot:CommandNPCBotDeleteId_GM(entry)
    SendChatMessage(".npcbot delete id " .. entry, "SAY")
end

-- 删除所有无主的机器人
function NetherBot:CommandNPCBotDeleteFree_GM()
    SendChatMessage(".npcbot delete free", "SAY")
end

-- 根据职业编码，查询种族编码
function NetherBot:CommandNPCBotLookup_GM(classId)
    SendChatMessage(".npcbot lookup " .. classId, "SAY")
end

-- 根据种族编码，生成机器人
function NetherBot:CommandNPCBotSpawn_GM(entry)
    SendChatMessage(".npcbot spawn " .. entry, "SAY")
end

-- 列出所有机器人的ID、名字、等级、位置、活跃状态（active、free）信息
function NetherBot:CommandNPCBotListSpawned_Admin()
    SendChatMessage(".npcbot list spawned", "SAY")
end

-- 列出所有空闲（free）机器人的ID、名字、等级、位置、活跃状态（active、free）信息
function NetherBot:CommandNPCBotListSpawnedFree_Admin()
    SendChatMessage(".npcbot list spawned free", "SAY")
end

-- 在玩家的位置上生成一个 NPC
function NetherBot:CommandNPCAdd_Admin(entry)
    SendChatMessage(".npc add " .. entry, "SAY")
end

-- 删除选中的 NPC，会校验选中的 NPC 的 entry 和参数 entry 是否一致
function NetherBot:CommandNPCDelete_Admin(entry, message)
    local targetEntry = GetCreatureTemplateEntry(UnitGUID("target"))
    if entry and targetEntry and entry == targetEntry then
        SendChatMessage(".npc delete", "SAY")
    else
        if message then
            ChatFrame1:AddMessage(message)
        else
            ChatFrame1:AddMessage("|cffFFFF00目标错误！")
        end
    end
end

-- 创建机器人
-- name：姓名
-- class：职业
-- race：种族
-- gender：性别
-- skin：皮肤
-- face：面部
-- hairstyle：发型
-- hairColor：发色
-- features：特征
-- soundSet：声音，不传此参数，则随机 { 1, 2, 3 }
function NetherBot:CommandNPCBotCreateNew_Admin(name, class, race, gender, skin, face, hairstyle, hairColor, features, soundSet)
    local commandStr = ".npcbot createnew"
    if not name then
        ChatFrame1:AddMessage("|cffFFFF00机器人姓名不能为空")
        return
    end
    if not class then
        ChatFrame1:AddMessage("|cffFFFF00机器人职业不能为空")
        return
    end
    commandStr = commandStr .. " " .. name .. " " .. class
    -- 对于特殊的机器人职业，只需要传 name 和 class
    if race then commandStr = commandStr .. " " .. race end
    if gender then commandStr = commandStr .. " " .. gender end
    if skin then commandStr = commandStr .. " " .. skin end
    if face then commandStr = commandStr .. " " .. face end
    if hairstyle then commandStr = commandStr .. " " .. hairstyle end
    if hairColor then commandStr = commandStr .. " " .. hairColor end
    if features then commandStr = commandStr .. " " .. features end
    if soundSet then commandStr = commandStr .. " " .. soundSet end
    -- .npcbot createnew 机器人1号 2 10 1 6 4 3 2 4
    SendChatMessage(commandStr, "SAY")
end