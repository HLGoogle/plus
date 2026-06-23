--[[
NetherBot-NPCBots-V20230629-1.0
1.插件载入时，默认显示，为了方便记忆，显示/隐藏插件，增加了两个命令，可以使用原来的 [/netherbot show] & [/netherbot hide]，也可以使用 [/nb s] & [/nb h]（原作者是：玉素奴香）
2.增加一些 NPCBots 命令
3.增加施法功能，NPCBots 中各个职业的有些法术无法直接对机器人施放，做成了按钮，快捷键是小键盘，或者是CTRL+小键盘（注意：快捷键会覆盖系统设置的快捷键），目前仅死亡骑士未实现，后期会添加，术士没有无法对机器人释放的技能，因此施法条是空的
4.对“生成机器人”按钮加入了 Enter 键盘事件监听，键盘 Enter 可以直接触发点击事件
5.区分普通玩家功能菜单和 GM 玩家功能菜单，GM 菜单中只有 GM 权限的账号能使用
6.增加了一个“生成老鸨”的功能按钮，用来生成一个提供雇佣机器人服务的管家（NPCBots 自带功能）
7.删除了“信息”按钮功能（感觉没啥用）
8.toc 中保留了原作者的信息：NetherstormX & askvod & 玉素奴香
9.大家在使用中有什么建议或者意见，提出来，本人虚心接受
10.跟随模式使用了 follow only 命令，这是一个活跃状态切换命令（在跟随和仅跟随之间切换，仅跟随就是即使附近有敌人，也不会采取任何行动），因此在恢复跟随时，有时需要点两次才能跟随
11.NpcBots 作者在新版本中删除了“剑圣”这个职业，因此此插件也移除了
12.插件的版本命名中包含了日期信息，这个日期对应的是 NPCBots 的版本日期，大家根据自己编译的 NPCBots 版本进行选择

NetherBot-NPCBots-V20230629-1.1
1.增加死亡骑士的施法功能
]]

-- 获取玩家职业
-- playerClassId 不一定能获取到，用 playerClassFilename 判断最保险
local playerClassName, playerClassFilename, playerClassId = UnitClass("player")

-- 职业 ClassFilename
local CLASS_FILENAME = {
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

-- 法术表
-- 每个职业每个法术的ID，法术等级从高到低降序排序：{法术等级10的ID, 法术等级9的ID, 法术等级8的ID...}
local SPELL_TABLE = {
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

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 函数定义开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
-- 校验参数是否大于 0，只支持数字和字符串类型
-- 字符串类型会转换后再判断，如果无法转换，返回 false
local function ValidateIsGtZero(param)
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
-- 跟随玩家，并主动攻击进入攻击范围，且有仇恨的敌人
local function CommandNPCBotCommandFollow_Player()
    SendChatMessage(".npcbot command follow", "SAY")
end
-- 跟随玩家，并在活跃与非活跃之间切换
-- 跟随（活跃）：跟随玩家，并主动攻击进入攻击范围，且有仇恨的敌人
-- 跟随（非活跃）：所有机器人在跟随玩家时，不会采取任何行动
local function CommandNPCBotCommandFollowOnly_Player()
    SendChatMessage(".npcbot command follow only", "SAY")
end
-- 停在原地，不会采取任何行动
local function CommandNPCBotCommandStopFully_Player()
    SendChatMessage(".npcbot command stopfully", "SAY")
end
-- 停在原地，会攻击进入攻击范围，且有仇恨的敌人（炮台模式）
local function CommandNPCBotCommandStandstill_Player()
    SendChatMessage(".npcbot command standstill", "SAY")
end
-- 开启/关闭对话，关闭后，鼠标放在机器人身上，不会显示对话图标，打怪时关闭对话，可以防止误点
local function CommandNPCBotCommandNoGossip_Player()
    SendChatMessage(".npcbot command nogossip", "SAY")
end
-- 机器人在走/跑之间切换
local function CommandNPCBotCommandWalk_Player()
    SendChatMessage(".npcbot command walk", "SAY")
end
-- 使机器人暂时下线，他们将从地图上传送出去，直到被允许回来，不能在战斗中使用
local function CommandNPCBotHide_Player()
    SendChatMessage(".npcbot hide", "SAY")
end
-- 将下线的机器人，召唤回来，不能在战斗中使用
local function CommandNPCBotShow_Player()
    SendChatMessage(".npcbot show", "SAY")
end
-- 杀死机器人，可以用来解决，有时在副本中，即使脱离了战斗，机器人仍然处于战斗中，导致无法对话，无法复活玩家的 BUG
local function CommandNPCBotKill_Player()
    SendChatMessage(".npcbot kill", "SAY")
end
-- 机器人跟随距离（0 - 100）
local function CommandNPCBotDistance_Player(param)
    SendChatMessage(".npcbot distance " .. param, "SAY")
end
-- 机器人远程攻击距离（支持数字类型以及两个字符串类型的参数）
-- 数字：0 - 50
-- "short"：最小远程攻击距离
-- "long"：最大远程攻击距离
local function CommandNPCBotDistanceAttack_Player(param)
    SendChatMessage(".npcbot distance attack " .. param, "SAY")
end
-- 强制机器人直接移动到玩家的位置，死后可用
local function CommandNPCBotRecall_Player()
    SendChatMessage(".npcbot recall", "SAY")
end
-- 必须选中玩家，显示玩家拥有的机器人的各种状态下的数量
local function CommandNPCBotInfo_Player()
    SendChatMessage(".npcbot info", "SAY")
end
-- 对机器人使用法术
-- 根据法术等级从高到低的顺序，依次校验玩家是否已经学会该法术，优先对机器人使用高等级法术
-- 否则就算未学会这个法术，也能对机器人使用（不平衡）
local function CommandNPCBotUseOnBotSpell_Player(spellIds)
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
local function CommandNPCBotUseOnBotItem_Player(itemId)
    SendChatMessage(".npcbot useonbot item " .. itemId, "SAY")
end

-- 列出所有机器人的ID、名字、等级、位置、活跃状态（active、free）信息
local function CommandNPCBotListSpawned_GM()
    SendChatMessage(".npcbot list spawned", "SAY")
end
-- 列出所有空闲（free）机器人的ID、名字、等级、位置、活跃状态（active、free）信息
local function CommandNPCBotListSpawnedFree_GM()
    SendChatMessage(".npcbot list spawned free", "SAY")
end
-- 复活机器人
local function CommandNPCBotRevive_GM()
    SendChatMessage(".npcbot revive", "SAY")
end
-- 免费招募一个选中的机器人（绕过购买），仅适用于无主的机器人
local function CommandNPCBotAdd_GM()
    SendChatMessage(".npcbot add", "SAY")
end
-- 解雇，通过此方式解除招募的机器人，会保留装备，并会回到原先招募的位置
local function CommandNPCBotRemove_GM()
    SendChatMessage(".npcbot remove", "SAY")
end
-- 将机器人移动到玩家当前的位置，只能移动无主机器人，支持选中目标和根据机器人模板 entry（creature_template.entry）两种方式
local function CommandNPCBotMove_GM(entry)
    if entry then
        SendChatMessage(".npcbot move " .. entry, "SAY")
    else
        SendChatMessage(".npcbot move", "SAY")
    end
end
-- 删除一个机器人，机器人的装备会回到背包
local function CommandNPCBotDelete_GM()
    SendChatMessage(".npcbot delete", "SAY")
end
-- 根据机器人模板 entry（creature_template.entry），永久删除一个机器人，机器人的装备会回到背包
local function CommandNPCBotDeleteId_GM(entry)
    SendChatMessage(".npcbot delete id " .. entry, "SAY")
end
-- 删除所有无主的机器人
local function CommandNPCBotDeleteFree_GM()
    SendChatMessage(".npcbot delete free", "SAY")
end
-- 根据职业编码，查询种族编码
local function CommandNPCBotLookup_GM(classId)
    SendChatMessage(".npcbot lookup " .. classId, "SAY")
end
-- 根据种族编码，生成机器人
local function CommandNPCBotSpawn_GM(entry)
    SendChatMessage(".npcbot spawn " .. entry, "GUILD")
end
-- 在玩家的位置上生成一个 NPC
local function CommandNPCAdd_GM(entry)
    SendChatMessage(".npc add " .. entry, "SAY")
end
-- 删除选中的 NPC，会校验选中的 NPC 的 entry 和参数 entry 是否一致
local function CommandNPCDelete_GM(entry, message)
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
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 函数定义结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化标头菜单 frame 开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local titleFrame = CreateFrame("Frame", "NetherBotTitleFrame", UIParent)
titleFrame:SetSize(200, 35)
titleFrame:SetPoint("RIGHT", UIParent, "RIGHT", -200, 0)
titleFrame:Show()
titleFrame:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8X8",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
titleFrame:SetBackdropColor(0.35, 0.14, 0.73, 0.25)
titleFrame:SetBackdropBorderColor(0.53, 0.07, 0.89, 1)
titleFrame:SetMovable(true)
titleFrame:EnableMouse(true)
titleFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
titleFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化标头菜单 frame 结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化主菜单 frame 开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local mainFrame = CreateFrame("Frame", "NetherBotMainFrame", UIParent)
mainFrame:SetSize(200, 300)
mainFrame:SetPoint("TOP", titleFrame, "BOTTOM", 0, 0)
mainFrame:Show()
mainFrame:SetBackdrop({
    bgFile = "Interface/Buttons/WHITE8X8",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
mainFrame:SetBackdropColor(0.35, 0.14, 0.73, 0.25)
mainFrame:SetBackdropBorderColor(0.53, 0.07, 0.89, 1)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化主菜单 frame 结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化管理菜单 frame 开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local gameMasterFrame = CreateFrame("Frame", "NetherBotGameMasterFrame", UIParent)
gameMasterFrame:SetSize(136, 230)
gameMasterFrame:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0)
gameMasterFrame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                         edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                         tile = true, tileSize = 16, edgeSize = 16,
                         insets = { left = 4, right = 4, top = 4, bottom = 4 } })
gameMasterFrame:SetBackdropColor(1, 0, 0, 0.2) -- Set the background color to red and transparency to 20%.
gameMasterFrame:SetBackdropBorderColor(0, 1, 0, 1)
gameMasterFrame:Hide() -- hide the admin frame by default
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化管理菜单 frame 结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化查找菜单 frame 开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local lookupFrame = CreateFrame("Frame", "NetherBotLookupFrame", UIParent)
lookupFrame:SetSize(200, 310)
lookupFrame:SetPoint("RIGHT", gameMasterFrame, "LEFT", -20, 0)
lookupFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
lookupFrame:SetBackdropColor(0, 0, 1, 0.3)
lookupFrame:SetBackdropBorderColor(0, 0, 1, 1)
lookupFrame:Hide()
-- Make the frame movable
lookupFrame:SetMovable(true)
lookupFrame:EnableMouse(true)
lookupFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
lookupFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化查找菜单 frame 结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化施法菜单 frame 开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local castSpellFrame = CreateFrame("Frame", "NetherBotCastSpellFrame", UIParent)
castSpellFrame:SetSize(50, 300)
castSpellFrame:SetPoint("LEFT", mainFrame, "RIGHT", 0, 0)
castSpellFrame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                             edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                             tile = true, tileSize = 16, edgeSize = 16,
                             insets = { left = 4, right = 4, top = 4, bottom = 4 } })
castSpellFrame:SetBackdropColor(1, 0, 0, 0.2) -- Set the background color to red and transparency to 20%.
castSpellFrame:SetBackdropBorderColor(0, 1, 0, 1)
castSpellFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 初始化施法菜单 frame 结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 标头菜单开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local title = titleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", titleFrame, "TOP", 0, -10)
title:SetText("NetherBot")

-- Create the "reload" button
local reloadButton = CreateFrame("Button", "NetherBotReloadButton", titleFrame, "UIPanelButtonTemplate")
reloadButton:SetSize(21, 20)
reloadButton:SetPoint("TOPLEFT", titleFrame, "TOPLEFT", 20, -7)
reloadButton:SetText("|cff00C957RL")
reloadButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
reloadButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("重载插件")
    GameTooltip:Show()
end)
reloadButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
reloadButton:SetScript("OnClick", function()
    StaticPopupDialogs["CONFIRM_RELOAD"] = {
        text = "确定要|cff00C957重载插件|r？",
        button1 = "|cff00C957是",
        button2 = "否",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnAccept = function()
            -- 重载插件
            ReloadUI()
        end
    }
    StaticPopup_Show("CONFIRM_RELOAD")
end)

local switchButton = CreateFrame("Button", "NetherBotSwitchButton", titleFrame, "UIPanelButtonTemplate")
switchButton:SetSize(21, 20)
switchButton:SetPoint("TOPRIGHT", titleFrame, "TOPRIGHT", -20, -7)
switchButton:SetText("|cff00C957▽")
switchButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
switchButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("展开/收起")
    GameTooltip:Show()
end)
switchButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
switchButton:SetScript("OnClick", function()
    if mainFrame:IsShown() then
        mainFrame:Hide()
        gameMasterFrame:Hide()
        lookupFrame:Hide()
        castSpellFrame:Hide()
    else
        mainFrame:Show()
    end
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 标头菜单结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 主菜单开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Follow Button
local followButton = CreateFrame("Button", "NetherBotFollowButton", mainFrame, "ActionButtonTemplate")
followButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -20)
followButton:SetSize(50, 50)
followButton:SetText("|cff69CCF0跟随\n模式")
followButton:SetNormalFontObject("GameFontNormal")
local followTexture = followButton:CreateTexture(nil, "BACKGROUND")
followTexture:SetTexture("Interface\\Icons\\Ability_Tracking")
followTexture:SetAllPoints()
followButton:SetNormalTexture(followTexture)
local followPushedTexture = followButton:CreateTexture(nil, "BACKGROUND")
followPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
followPushedTexture:SetAllPoints()
followButton:SetPushedTexture(followPushedTexture)
followButton:SetScript("OnClick", function()
    CommandNPCBotCommandFollowOnly_Player()
end)

-- StopFully Button
local stopFullyButton = CreateFrame("Button", "NetherBotStopFullyButton", mainFrame, "ActionButtonTemplate")
stopFullyButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 75, -20)
stopFullyButton:SetSize(50, 50)
stopFullyButton:SetText("|cff69CCF0呆立\n模式")
stopFullyButton:SetNormalFontObject("GameFontNormal")
local stopFullyTexture = stopFullyButton:CreateTexture(nil, "BACKGROUND")
stopFullyTexture:SetTexture("Interface\\Icons\\ABILITY_SEAL")
stopFullyTexture:SetAllPoints()
stopFullyButton:SetNormalTexture(stopFullyTexture)
local stopFullyPushedTexture = stopFullyButton:CreateTexture(nil, "BACKGROUND")
stopFullyPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
stopFullyPushedTexture:SetAllPoints()
stopFullyButton:SetPushedTexture(stopFullyPushedTexture)
stopFullyButton:SetScript("OnClick", function()
    CommandNPCBotCommandStopFully_Player()
end)

-- StandStill Button
local standstillButton = CreateFrame("Button", "NetherBotStandstillButton", mainFrame, "ActionButtonTemplate")
standstillButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 130, -20)
standstillButton:SetSize(50, 50)
standstillButton:SetText("|cff69CCF0炮台\n模式")
standstillButton:SetNormalFontObject("GameFontNormal")
local standstillTexture = standstillButton:CreateTexture(nil, "BACKGROUND")
standstillTexture:SetTexture("Interface\\Icons\\Ability_Vehicle_SiegeEngineCannon")
standstillTexture:SetAllPoints()
standstillButton:SetNormalTexture(standstillTexture)
local standstillPushedTexture = standstillButton:CreateTexture(nil, "BACKGROUND")
standstillPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
standstillPushedTexture:SetAllPoints()
standstillButton:SetPushedTexture(standstillPushedTexture)
standstillButton:SetScript("OnClick", function()
    CommandNPCBotCommandStandstill_Player()
end)

-- noGossip Button
local noGossipButton = CreateFrame("Button", "NetherBotNoGossipButton", mainFrame, "ActionButtonTemplate")
noGossipButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -80)
noGossipButton:SetSize(50, 50)
noGossipButton:SetText("|cff69CCF0对话\n开关")
noGossipButton:SetNormalFontObject("GameFontNormal")
local noGossipTexture = noGossipButton:CreateTexture(nil, "BACKGROUND")
noGossipTexture:SetTexture("Interface\\Icons\\Spell_Holy_Silence")
noGossipTexture:SetAllPoints()
noGossipButton:SetNormalTexture(noGossipTexture)
local noGossipPushedTexture = noGossipButton:CreateTexture(nil, "BACKGROUND")
noGossipPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
noGossipPushedTexture:SetAllPoints()
noGossipButton:SetPushedTexture(noGossipPushedTexture)
noGossipButton:SetScript("OnClick", function()
    CommandNPCBotCommandNoGossip_Player()
end)

-- hide Button
local hideButton = CreateFrame("Button", "NetherBotHideButton", mainFrame, "ActionButtonTemplate")
hideButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 75, -80)
hideButton:SetSize(50, 50)
hideButton:SetText("|cff69CCF0下线")
hideButton:SetNormalFontObject("GameFontNormal")
local hideTexture = hideButton:CreateTexture(nil, "BACKGROUND")
hideTexture:SetTexture("Interface\\Icons\\Spell_Nature_SpiritWolf")
hideTexture:SetAllPoints()
hideButton:SetNormalTexture(hideTexture)
local hidePushedTexture = hideButton:CreateTexture(nil, "BACKGROUND")
hidePushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
hidePushedTexture:SetAllPoints()
hideButton:SetPushedTexture(hidePushedTexture)
hideButton:SetScript("OnClick", function()
    CommandNPCBotHide_Player()
end)

-- show Button
local showButton = CreateFrame("Button", "NetherBotShowButton", mainFrame, "ActionButtonTemplate")
showButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 130, -80)
showButton:SetSize(50, 50)
showButton:SetText("|cff69CCF0上线")
showButton:SetNormalFontObject("GameFontNormal")
local showTexture = showButton:CreateTexture(nil, "BACKGROUND")
showTexture:SetTexture("Interface\\Icons\\Ability_Hunter_BeastCall")
showTexture:SetAllPoints()
showButton:SetNormalTexture(showTexture)
local showPushedTexture = showButton:CreateTexture(nil, "BACKGROUND")
showPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
showPushedTexture:SetAllPoints()
showButton:SetPushedTexture(showPushedTexture)
showButton:SetScript("OnClick", function()
    CommandNPCBotShow_Player()
end)

--revive Button
local reviveButton = CreateFrame("Button", "NetherBotRecallButton", mainFrame, "ActionButtonTemplate")
reviveButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -140)
reviveButton:SetSize(50, 50)
reviveButton:SetText("|cff00FF96召回")
reviveButton:SetNormalFontObject("GameFontNormal")
local reviveTexture = reviveButton:CreateTexture(nil, "BACKGROUND")
reviveTexture:SetTexture("Interface\\Icons\\Ability_Hunter_BeastTraining")
reviveTexture:SetAllPoints()
reviveButton:SetNormalTexture(reviveTexture)
local revivePushedTexture = reviveButton:CreateTexture(nil, "BACKGROUND")
revivePushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
revivePushedTexture:SetAllPoints()
reviveButton:SetPushedTexture(revivePushedTexture)
reviveButton:SetScript("OnClick", function()
    CommandNPCBotRecall_Player()
end)

--kill Button
local killButton = CreateFrame("Button", "NetherBotKillButton", mainFrame, "ActionButtonTemplate")
killButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 75, -140)
killButton:SetSize(50, 50)
killButton:SetText("|cff00FF96杀死")
killButton:SetNormalFontObject("GameFontNormal")
local killTexture = killButton:CreateTexture(nil, "BACKGROUND")
killTexture:SetTexture("Interface\\Icons\\Ability_Hunter_RapidKilling")
killTexture:SetAllPoints()
killButton:SetNormalTexture(killTexture)
local killPushedTexture = killButton:CreateTexture(nil, "BACKGROUND")
killPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
killPushedTexture:SetAllPoints()
killButton:SetPushedTexture(killPushedTexture)
killButton:SetScript("OnClick", function()
    CommandNPCBotKill_Player()
end)

--walk Button
local walkButton = CreateFrame("Button", "NetherBotWalkButton", mainFrame, "ActionButtonTemplate")
walkButton:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 130, -140)
walkButton:SetSize(50, 50)
walkButton:SetText("|cff00FF96走跑\n切换")
walkButton:SetNormalFontObject("GameFontNormal")
local walkTexture = walkButton:CreateTexture(nil, "BACKGROUND")
walkTexture:SetTexture("Interface\\Icons\\Ability_Rogue_FleetFooted")
walkTexture:SetAllPoints()
walkButton:SetNormalTexture(walkTexture)
local walkPushedTexture = walkButton:CreateTexture(nil, "BACKGROUND")
walkPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
walkPushedTexture:SetAllPoints()
walkButton:SetPushedTexture(walkPushedTexture)
walkButton:SetScript("OnClick", function()
    CommandNPCBotCommandWalk_Player()
end)

--Distance1 Button
local distance1Button = CreateFrame("Button", "NetherBotDistance1Button", mainFrame, "ActionButtonTemplate")
distance1Button:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -200)
distance1Button:SetSize(50, 50)
distance1Button:SetText("|cff00FF9630码\n跟随|r")
distance1Button:SetNormalFontObject("GameFontNormal")
local distance1Texture = distance1Button:CreateTexture(nil, "BACKGROUND")
distance1Texture:SetTexture("Interface\\Icons\\achievement_pvp_g_01")
distance1Texture:SetAllPoints()
distance1Button:SetNormalTexture(distance1Texture)
local distance1PushedTexture = distance1Button:CreateTexture(nil, "BACKGROUND")
distance1PushedTexture:SetTexture("Interface\\Icons\\achievement_pvp_p_01")
distance1PushedTexture:SetAllPoints()
distance1Button:SetPushedTexture(distance1PushedTexture)
distance1Button:SetScript("OnClick", function()
    CommandNPCBotDistance_Player(30)
end)

--Distance2 Button
local distance2Button = CreateFrame("Button", "NetherBotDistance2Button", mainFrame, "ActionButtonTemplate")
distance2Button:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 75, -200)
distance2Button:SetSize(50, 50)
distance2Button:SetText("|cff00FF9650码\n跟随|r")
distance2Button:SetNormalFontObject("GameFontNormal")
local distance2Texture = distance2Button:CreateTexture(nil, "BACKGROUND")
distance2Texture:SetTexture("Interface\\Icons\\achievement_pvp_o_02")
distance2Texture:SetAllPoints()
distance2Button:SetNormalTexture(distance2Texture)
local distance2PushedTexture = distance2Button:CreateTexture(nil, "BACKGROUND")
distance2PushedTexture:SetTexture("Interface\\Icons\\achievement_pvp_p_02")
distance2PushedTexture:SetAllPoints()
distance2Button:SetPushedTexture(distance2PushedTexture)
distance2Button:SetScript("OnClick", function()
    CommandNPCBotDistance_Player(50)
end)

--Distance3 Button
local distance3Button = CreateFrame("Button", "NetherBotDistance3Button", mainFrame, "ActionButtonTemplate")
distance3Button:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 130, -200)
distance3Button:SetSize(50, 50)
distance3Button:SetText("|cff00FF9685码\n跟随|r")
distance3Button:SetNormalFontObject("GameFontNormal")
local distance3Texture = distance3Button:CreateTexture(nil, "BACKGROUND")
distance3Texture:SetTexture("Interface\\Icons\\achievement_pvp_h_03")
distance3Texture:SetAllPoints()
distance3Button:SetNormalTexture(distance3Texture)
local distance3PushedTexture = distance3Button:CreateTexture(nil, "BACKGROUND")
distance3PushedTexture:SetTexture("Interface\\Icons\\achievement_pvp_p_03")
distance3PushedTexture:SetAllPoints()
distance3Button:SetPushedTexture(distance3PushedTexture)
distance3Button:SetScript("OnClick", function()
    CommandNPCBotDistance_Player(85)
end)

local adminButton = CreateFrame("Button", "NetherBotAdminButton", mainFrame, "UIPanelButtonTemplate")
adminButton:SetSize(50, 22)
adminButton:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", 20, 8)
adminButton:SetText("GM")
adminButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
adminButton:SetScript("OnClick", function()
    if gameMasterFrame:IsShown() then
        gameMasterFrame:Hide()
    else
        gameMasterFrame:Show()
    end
end)

local castSpellButton = CreateFrame("Button", "NetherBotCastSpellButton", mainFrame, "UIPanelButtonTemplate")
castSpellButton:SetSize(50, 22)
castSpellButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -20, 8)
castSpellButton:SetText("施法")
castSpellButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
castSpellButton:SetScript("OnClick", function()
    if castSpellFrame:IsShown() then
        castSpellFrame:Hide()
    else
        castSpellFrame:Show()
    end
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 主菜单结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 管理菜单开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local adminTitle = gameMasterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
adminTitle:SetPoint("TOP", gameMasterFrame, "TOP", 0, -15)
adminTitle:SetText("GM 菜单")

-- Create Admin Buttons
local addButton = CreateFrame("Button", "NetherBotAddButton", gameMasterFrame, "UIPanelButtonTemplate")
addButton:SetSize(56, 22)
addButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 10, -35)
addButton:SetText("雇佣")
addButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
addButton:SetScript("OnClick", function()
    CommandNPCBotAdd_GM()
end)

local removeButton = CreateFrame("Button", "NetherBotRemoveButton", gameMasterFrame, "UIPanelButtonTemplate")
removeButton:SetSize(56, 22)
removeButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 70, -35)
removeButton:SetText("解雇")
removeButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
removeButton:SetScript("OnClick", function()
    CommandNPCBotRemove_GM()
end)

local recallButton = CreateFrame("Button", "NetherBotReviveButton", gameMasterFrame, "UIPanelButtonTemplate")
recallButton:SetSize(56, 22)
recallButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 10, -65)
recallButton:SetText("复活")
recallButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
recallButton:SetScript("OnClick", function()
    CommandNPCBotRevive_GM()
end)

local moveButton = CreateFrame("Button", "NetherBotMoveButton", gameMasterFrame, "UIPanelButtonTemplate")
moveButton:SetSize(56, 22)
moveButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 70, -65)
moveButton:SetText("移动")
moveButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
moveButton:SetScript("OnClick", function()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        CommandNPCBotMove_GM()
    else
        StaticPopupDialogs["MOVE_NPC"] = {
            text = "输入NPC机器人ID，只能移动|cffFF0000无主|r的机器人",
            button1 = "确定",
            button2 = "取消",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self)
                local npc = self.editBox:GetText()
                local bool = ValidateIsGtZero(npc)
                if bool then
                    CommandNPCBotMove_GM(npc)
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("MOVE_NPC")
    end
end)

local addHireBotButton = CreateFrame("Button", "NetherBotAddHireBotButton", gameMasterFrame, "UIPanelButtonTemplate")
addHireBotButton:SetSize(56, 22)
addHireBotButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 10, -95)
addHireBotButton:SetText("召唤老鸨")
addHireBotButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
addHireBotButton:SetScript("OnClick", function()
    -- 在玩家位置生成一个提供机器人招募服务的 NPC
    CommandNPCAdd_GM(70000)
end)

local deleteHireBotButton = CreateFrame("Button", "NetherBotDeleteHireBotButton", gameMasterFrame, "UIPanelButtonTemplate")
deleteHireBotButton:SetSize(56, 22)
deleteHireBotButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 70, -95)
deleteHireBotButton:SetText("删除老鸨")
deleteHireBotButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
deleteHireBotButton:SetScript("OnClick", function()
    CommandNPCDelete_GM(70000, "|cffFFFF00目标错误！请选中名为『Lagretta』的老鸨...")
end)

local listAllButton = CreateFrame("Button", "NetherBotListAllButton", gameMasterFrame, "UIPanelButtonTemplate")
listAllButton:SetSize(56, 22)
listAllButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 10, -125)
listAllButton:SetText("所有Bots")
listAllButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
listAllButton:SetScript("OnClick", function()
    CommandNPCBotListSpawned_GM()
end)

local listFreeButton = CreateFrame("Button", "NetherBotListFreeButton", gameMasterFrame, "UIPanelButtonTemplate")
listFreeButton:SetSize(56, 22)
listFreeButton:SetPoint("TOPLEFT", gameMasterFrame, "TOPLEFT", 70, -125)
listFreeButton:SetText("空闲Bots")
listFreeButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
listFreeButton:SetScript("OnClick", function()
    CommandNPCBotListSpawnedFree_GM()
end)

-- Create the "lookupButton" button
local lookupButton = CreateFrame("Button", "NetherBotLookupButton", gameMasterFrame, "UIPanelButtonTemplate")
lookupButton:SetSize(56, 22)
lookupButton:SetPoint("BOTTOMLEFT", gameMasterFrame, "BOTTOMLEFT", 10, 10)
lookupButton:SetText("|cff6A5ACD查找")
lookupButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
-- Handle the Lookup buttons click event
lookupButton:SetScript("OnClick", function()
    if lookupFrame:IsShown() then
        lookupFrame:Hide()
    else
        lookupFrame:Show()
    end
end)

local deleteButton = CreateFrame("Button", "NetherBotDeleteButton", gameMasterFrame, "UIPanelButtonTemplate")
deleteButton:SetSize(56, 22)
deleteButton:SetPoint("BOTTOMRIGHT", gameMasterFrame, "BOTTOMRIGHT", -10, 10)
deleteButton:SetText("|cffFF0000删除")
deleteButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
deleteButton:SetScript("OnClick", function()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        StaticPopupDialogs["CONFIRM_DELETE"] = {
            text = "确定要|cffFF0000删除|r？",
            button1 = "|cffFF0000是",
            button2 = "否",
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function()
                CommandNPCBotDelete_GM()
            end
        }
        StaticPopup_Show("CONFIRM_DELETE")
    else
        StaticPopupDialogs["DELETE_NPC"] = {
            text = "输入NPC机器人ID:",
            button1 = "确定",
            button2 = "取消",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self)
                local npc = self.editBox:GetText()
                local bool = ValidateIsGtZero(npc)
                if bool then
                    StaticPopupDialogs["CONFIRM_DELETE"] = {
                        text = "确定要|cffFF0000删除|r？",
                        button1 = "|cffFF0000是",
                        button2 = "否",
                        timeout = 0,
                        whileDead = true,
                        hideOnEscape = true,
                        OnAccept = function()
                            CommandNPCBotDeleteId_GM(npc)
                        end
                    }
                    StaticPopup_Show("CONFIRM_DELETE")
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("DELETE_NPC")
    end
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 管理菜单结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 查找菜单开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local lookupTitle = lookupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
lookupTitle:SetPoint("TOPLEFT", lookupFrame, "TOPLEFT", 10, -14)
lookupTitle:SetText("选择职业:")

-- Create the scrollFrame for the list
local lookupScrollFrame = CreateFrame("ScrollFrame", "NetherBotLookupScrollFrame", lookupFrame, "UIPanelScrollFrameTemplate")
lookupScrollFrame:SetPoint("TOPLEFT", lookupFrame, "TOPLEFT", 4, -25)
lookupScrollFrame:SetPoint("BOTTOMRIGHT", lookupFrame, "BOTTOMRIGHT", -4, 4)

-- Create the list frame
local lookupList = CreateFrame("Frame", "NetherBotLookupList", lookupScrollFrame)
lookupList:SetSize(lookupScrollFrame:GetWidth(), lookupScrollFrame:GetHeight())
lookupScrollFrame:SetScrollChild(lookupList)

-- Create the key-value store
local classTable = {
    ["|cffC69B6D战士"] = 1,
    ["|cffF58CBA圣骑士"] = 2,
    ["|cffAAD372猎人"] = 3,
    ["|cffFFF468盗贼"] = 4,
    ["|cffF0EBE0牧师"] = 5,
    ["|cffC41E3B死亡骑士"] = 6,
    ["|cff2359FF萨满"] = 7,
    ["|cff68CCEF法师"] = 8,
    ["|cff9382C9术士"] = 9,
    ["|cff00FF96------------------------------"] = 10,
    ["|cffFF7C0A德鲁伊"] = 11,
    ["|cffC69B6D------------------------------"] = 12,
    ["|cffF0EBE0War3黑曜石毁灭者"] = 13,
    ["|cff68CCEFWar3大魔导师"] = 14,
    ["|cffA330C9War3恐惧魔王"] = 15,
    ["|cff68CCEFWar3破法者"] = 16,
    ["|cffAAD372War3黑暗游侠"] = 17,
    ["|cff9382C9War3死灵法师"] = 18,
    ["|cff68CCEFWar3娜迦女海巫"] = 19,
    ["|cff009ABFWar3地穴领主"] = 20
}

-- Create the buttons for the list items
for key, value in pairs(classTable) do
    local button = CreateFrame("Button", "NetherBotLookupClassButton" .. value, lookupList, "UIPanelButtonTemplate")
    button:SetSize(180, 25)
    button:SetPoint("TOPLEFT", lookupList, "TOPLEFT", 10, -10 - (value - 1) * 30)
    button:SetText(key)
    button:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)

    -- Handle the button's click event
    button:SetScript("OnClick", function()
        CommandNPCBotLookup_GM(value)
        -- You can add your custom functionality here like running a command or doing some other action
    end)
end

-- Create the "hideLookup" button
local hideLookupButton = CreateFrame("Button", "NetherBotHideLookupButton", lookupFrame, "UIPanelButtonTemplate")
hideLookupButton:SetSize(21, 20)
hideLookupButton:SetPoint("TOPRIGHT", lookupFrame, "TOPRIGHT", -10, -8)
hideLookupButton:SetText("|cffFF0000X")
hideLookupButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
-- Handle Lookup buttons click event
hideLookupButton:SetScript("OnClick", function()
    lookupFrame:Hide()
end)

-- Create the spawnFrame
local spawnFrame = CreateFrame("Frame", "NetherBotSpawnFrame", lookupFrame)
spawnFrame:SetSize(200, 45)
spawnFrame:SetPoint("BOTTOM", lookupFrame, "BOTTOM", 0, -50)
spawnFrame:SetBackdrop({
    bgFile = "Interface/BUTTONS/WHITE8X8",
    edgeFile = "Interface/BUTTONS/WHITE8X8",
    edgeSize = 1,
    insets = { left = 0, right = 0, top = 0, bottom = 0 } })
spawnFrame:SetBackdropColor(0, 0, 1, 0.3)
spawnFrame:SetBackdropBorderColor(0, 0, 1, 1)

-- Create the "buttonSpawnBot" button
local spawnBotButton = CreateFrame("Button", "NetherBotSpawnBotButton", spawnFrame, "UIPanelButtonTemplate")
spawnBotButton:SetSize(80, 25)
spawnBotButton:SetPoint("TOPLEFT", spawnFrame, "TOPLEFT", 15, -10)
spawnBotButton:SetText("生成机器人")
spawnBotButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
-- Create the "classInput" input box
local classInput = CreateFrame("EditBox", "NetherBotClassInput", spawnFrame, "InputBoxTemplate")
classInput:SetSize(80, 25)
classInput:SetPoint("TOPLEFT", spawnFrame, "TOPLEFT", 105, -10)
classInput:SetAutoFocus(false)
-- Handle the buttons click event
spawnBotButton:SetScript("OnClick", function()
    local input = classInput:GetText()
    if input ~= "" then
        CommandNPCBotSpawn_GM(input)
        classInput:SetText("")
        classInput:ClearFocus()
    else
        ChatFrame1:AddMessage("|cffFFFF00请输入聊天框中查询出的机器人『ID』，例如：『70XXX』")
    end
end)
-- 回车触发点击事件
classInput:SetScript("OnEnterPressed", function()
    spawnBotButton:Click()
end)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 查找菜单结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 施法菜单开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 创建施法按钮自增序列函数，返回一个闭包
local function CreateSpellButtonCounter()
    -- 初始值为 0
    local count = 0
    -- 返回一个函数，每次调用该函数，count 加 1 并返回新值
    return function()
        count = count + 1
        return count
    end
end
-- 创建施法按钮自增计数器
local spellButtonCounter = CreateSpellButtonCounter()
-- 创建施法按钮
local function CreateSpellButton(offsetX, offsetY, table, pressKey)
    local count = spellButtonCounter()
    local spellButton = CreateFrame("Button", "NetherBotSpell" .. count .. "Button", castSpellFrame, "UIPanelButtonTemplate")
    spellButton:SetPoint("TOPLEFT", castSpellFrame, "TOPLEFT", offsetX, offsetY)
    spellButton:SetSize(30, 30)
    spellButton:SetNormalFontObject("GameFontNormal")
    local spellTexture = spellButton:CreateTexture(nil, "BACKGROUND")
    spellTexture:SetTexture(table.ICON)
    spellTexture:SetAllPoints()
    spellButton:SetNormalTexture(spellTexture)
    local spellPushedTexture = spellButton:CreateTexture(nil, "BACKGROUND")
    spellPushedTexture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
    spellPushedTexture:SetAllPoints()
    spellButton:SetPushedTexture(spellPushedTexture)
    spellButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(table.NAME .. " [" .. pressKey .. "]")
        GameTooltip:Show()
    end)
    spellButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    spellButton:SetScript("OnClick", function()
        CommandNPCBotUseOnBotSpell_Player(table.IDS)
    end)
    -- 绑定按键，触发按钮点击事件，此设置会覆盖系统按键设置
    SetOverrideBindingClick(spellButton, true, pressKey, spellButton:GetName())
    return spellButton
end

-- >>>>>>>>>>>>>>>>>> 战士 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.WARRIOR then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 90)
    CreateSpellButton(10, -10, SPELL_TABLE.WARRIOR.J_J, "NUMPAD1")
    CreateSpellButton(10, -50, SPELL_TABLE.WARRIOR.Y_H, "NUMPAD2")
end
-- >>>>>>>>>>>>>>>>>> 圣骑士 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.PALADIN then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(90, 210)
    CreateSpellButton(10, -10, SPELL_TABLE.PALADIN.B_H_Z_S, "NUMPAD1")
    CreateSpellButton(10, -50, SPELL_TABLE.PALADIN.Z_J_Z_S, "NUMPAD2")
    CreateSpellButton(10, -90, SPELL_TABLE.PALADIN.X_S_Z_S, "NUMPAD3")
    CreateSpellButton(10, -130, SPELL_TABLE.PALADIN.Z_Y_F_Y, "NUMPAD4")
    CreateSpellButton(10, -170, SPELL_TABLE.PALADIN.S_G_D_B, "NUMPAD5")
    CreateSpellButton(50, -10, SPELL_TABLE.PALADIN.Q_X_L_L_Z_F, "CTRL-NUMPAD1")
    CreateSpellButton(50, -50, SPELL_TABLE.PALADIN.Q_X_Z_H_Z_F, "CTRL-NUMPAD2")
    CreateSpellButton(50, -90, SPELL_TABLE.PALADIN.Q_X_W_Z_Z_F, "CTRL-NUMPAD3")
    CreateSpellButton(50, -130, SPELL_TABLE.PALADIN.Q_X_B_H_Z_F, "CTRL-NUMPAD4")
    CreateSpellButton(50, -170, SPELL_TABLE.PALADIN.J_S, "CTRL-NUMPAD5")
    -- 对机器人使用神圣干涉没啥用，机器人不会自己取消
    --CreateSpellButton(50, -210, SPELL_TABLE.PALADIN.S_S_G_S, "CTRL-NUMPAD6")
end
-- >>>>>>>>>>>>>>>>>> 猎人 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.HUNTER then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 50)
    CreateSpellButton(10, -10, SPELL_TABLE.HUNTER.W_D, "NUMPAD1")
end
-- >>>>>>>>>>>>>>>>>> 盗贼 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.ROGUE then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 50)
    CreateSpellButton(10, -10, SPELL_TABLE.ROGUE.J_H_J_Q, "NUMPAD1")
end
-- >>>>>>>>>>>>>>>>>> 牧师 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.PRIEST then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 130)
    CreateSpellButton(10, -10, SPELL_TABLE.PRIEST.Y_H_D_Y, "NUMPAD1")
    CreateSpellButton(10, -50, SPELL_TABLE.PRIEST.P_F_S, "NUMPAD2")
    CreateSpellButton(10, -90, SPELL_TABLE.PRIEST.F_H_S, "NUMPAD3")
end
-- >>>>>>>>>>>>>>>>>> 死亡骑士 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.DEATH_KNIGHT then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 50)
    CreateSpellButton(10, -10, SPELL_TABLE.DEATH_KNIGHT.K_L, "NUMPAD1")
end
-- >>>>>>>>>>>>>>>>>> 萨满 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.SHAMAN then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 50)
    CreateSpellButton(10, -10, SPELL_TABLE.SHAMAN.X_Z_Z_H, "NUMPAD1")
end
-- >>>>>>>>>>>>>>>>>> 法师 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.MAGE then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 130)
    CreateSpellButton(10, -10, SPELL_TABLE.MAGE.H_L_S, "NUMPAD1")
    CreateSpellButton(10, -50, SPELL_TABLE.MAGE.M_F_Y_Z, "NUMPAD2")
    CreateSpellButton(10, -90, SPELL_TABLE.MAGE.M_F_Z_X, "NUMPAD3")
end
-- >>>>>>>>>>>>>>>>>> 术士 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.WARLOCK then

end
-- >>>>>>>>>>>>>>>>>> 德鲁伊 <<<<<<<<<<<<<<<<<<<
if playerClassFilename == CLASS_FILENAME.DRUID then
    -- 重置施法菜单尺寸
    castSpellFrame:SetSize(50, 90)
    CreateSpellButton(10, -10, SPELL_TABLE.DRUID.F_S, "NUMPAD1")
    CreateSpellButton(10, -50, SPELL_TABLE.DRUID.Q_S_H_S, "NUMPAD2")
end
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 施法菜单结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 自定义插件显示/隐藏命令开始 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 固定写法：[SLASH_] + [名称] + [数字]，[名称]可以使用下划线
-- SlashCmdList 集合新增元素时，必须使用[名称]
SLASH_NETHER_BOT_CMD1 = '/netherbot'
SLASH_NETHER_BOT_CMD2 = '/nb'
SlashCmdList['NETHER_BOT_CMD'] = function(msg)
    if msg == "show" or msg == "s" then
        titleFrame:Show()
        mainFrame:Show()
    elseif msg == "hide" or msg == "h" then
        titleFrame:Hide()
        mainFrame:Hide()
        gameMasterFrame:Hide()
        lookupFrame:Hide()
        castSpellFrame:Hide()
    end
end
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 自定义插件显示/隐藏命令结束 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<