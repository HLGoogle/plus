local NetherBot = NetherBot

-- 主菜单

-- 创建主菜单按钮函数
local function CreateButtonMain(offsetX, offsetY, point, relativePoint, table, onClickFunc)
    local button = CreateFrame("Button", NetherBot.CreateNameUnique(), NetherBot.mainFrame, "ActionButtonTemplate")
    button:SetPoint(point, NetherBot.mainFrame, relativePoint, offsetX, offsetY)
    button:SetSize(30, 30)
    -- 去掉文字，保持清爽
    --button:SetText(table.NAME)
    -- 如果要在按钮上悬浮文字，这行代码不能省略，否则文字不可见
    --button:SetNormalFontObject("GameFontNormal")
    local texture = button:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(table.ICON)
    texture:SetAllPoints()
    button:SetNormalTexture(texture)
    local pushedTexture = button:CreateTexture(nil, "BACKGROUND")
    pushedTexture:SetTexture(NetherBot.PUSHED_SQUARE_ICON)
    pushedTexture:SetAllPoints()
    button:SetPushedTexture(pushedTexture)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(table.NAME)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    button:SetScript("OnClick", onClickFunc)
    return button
end

-- 跟随
NetherBot.BUTTON_MAIN_COMMAND_FOLLOW = CreateButtonMain(15, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_FOLLOW, function()
    NetherBot:CommandNPCBotCommandFollow_Player()
end)

-- 跟随攻击开关
NetherBot.BUTTON_MAIN_COMMAND_FOLLOW_ONLY = CreateButtonMain(50, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_FOLLOW_ONLY, function()
    NetherBot:CommandNPCBotCommandFollowOnly_Player()
end)

-- 停止
NetherBot.BUTTON_MAIN_COMMAND_STOP_FULLY = CreateButtonMain(85, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_STOP_FULLY, function()
    NetherBot:CommandNPCBotCommandStopFully_Player()
end)

-- 炮台
NetherBot.BUTTON_MAIN_COMMAND_STANDSTILL = CreateButtonMain(120, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_STANDSTILL, function()
    NetherBot:CommandNPCBotCommandStandstill_Player()
end)

-- 对话开关
NetherBot.BUTTON_MAIN_COMMAND_NO_GOSSIP = CreateButtonMain(155, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_NO_GOSSIP, function()
    NetherBot:CommandNPCBotCommandNoGossip_Player()
end)

-- 下线
NetherBot.BUTTON_MAIN_HIDE = CreateButtonMain(190, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.HIDE, function()
    NetherBot:CommandNPCBotHide_Player()
end)

-- 上线
NetherBot.BUTTON_MAIN_SHOW = CreateButtonMain(225, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.SHOW, function()
    NetherBot:CommandNPCBotShow_Player()
end)

-- 召回
NetherBot.BUTTON_MAIN_RECALL = CreateButtonMain(260, -15, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.RECALL, function()
    NetherBot:CommandNPCBotRecall_Player()
end)


-- 传回
NetherBot.BUTTON_MAIN_RECALL_TELEPORT = CreateButtonMain(15, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.RECALL_TELEPORT, function()
    NetherBot:CommandNPCBotRecallTeleport_Player()
end)

-- 走跑切换
NetherBot.BUTTON_MAIN_COMMAND_WALK = CreateButtonMain(50, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_WALK, function()
    NetherBot:CommandNPCBotCommandWalk_Player()
end)

-- 解绑
NetherBot.BUTTON_MAIN_COMMAND_UNBIND = CreateButtonMain(85, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_UNBIND, function()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        NetherBot:CommandNPCBotCommandUnbind_Player()
    else
        StaticPopupDialogs["UNBIND_NPC"] = {
            text = "输入一个或者多个NPC机器人姓名，不区分大小写，多个姓名之间用|cffFF0000空格|r分割，如果姓名中包含|cffFF0000空格|r，请将|cffFF0000空格|r替换成|cffFF0000下划线|r（[Bots信息]可以查看已解绑机器人的姓名等信息）",
            button1 = "确定",
            button2 = "取消",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self)
                local npc = self.editBox:GetText()
                if npc then
                    if npc ~= "" then
                        NetherBot:CommandNPCBotCommandUnbind_Player(npc)
                    else
                        ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                    end
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("UNBIND_NPC")
    end
end)

-- 重绑
NetherBot.BUTTON_MAIN_COMMAND_REBIND = CreateButtonMain(120, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.COMMAND_REBIND, function()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        NetherBot:CommandNPCBotCommandRebind_Player()
    else
        StaticPopupDialogs["REBIND_NPC"] = {
            text = "输入一个或者多个NPC机器人姓名，不区分大小写，多个姓名之间用|cffFF0000空格|r分割，如果姓名中包含|cffFF0000空格|r，请将|cffFF0000空格|r替换成|cffFF0000下划线|r（[Bots信息]可以查看已解绑机器人的姓名等信息）",
            button1 = "确定",
            button2 = "取消",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self)
                local npc = self.editBox:GetText()
                if npc then
                    if npc ~= "" then
                        NetherBot:CommandNPCBotCommandRebind_Player(npc)
                    else
                        ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                    end
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("REBIND_NPC")
    end
end)

-- 重绑所有
NetherBot.BUTTON_MAIN_RECALL_SPAWNS = CreateButtonMain(155, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.RECALL_SPAWNS, function()
    NetherBot:CommandNPCBotRecallSpawns_Player()
end)


-- Bots信息
NetherBot.BUTTON_MAIN_INFO = CreateButtonMain(190, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.INFO, function()
    local bool = NetherBot:ValidateTargetIsPlayer()
    if bool then
        NetherBot:CommandNPCBotInfo_Player()
    else
        ChatFrame1:AddMessage("|cffFFFF00必须选中玩家！")
    end
end)

-- 杀死
NetherBot.BUTTON_MAIN_KILL = CreateButtonMain(225, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.KILL, function()
    NetherBot:CommandNPCBotKill_Player()
end)

-- 脱离载具
NetherBot.BUTTON_MAIN_VEHICLE_EJECT = CreateButtonMain(260, -50, "TOPLEFT", "TOPLEFT", NetherBot.BUTTON_MAIN_TABLE.VEHICLE_EJECT, function()
    NetherBot:CommandNPCBotVehicleEject_Player()
end)



-- 创建导航菜单按钮函数
local function CreateButtonNav(offsetX, offsetY, point, relativePoint, table, onClickFunc)
    local button = CreateFrame("Button", NetherBot.CreateNameUnique(), NetherBot.mainFrame, "ActionButtonTemplate")
    button:SetPoint(point, NetherBot.mainFrame, relativePoint, offsetX, offsetY)
    button:SetSize(30, 30)
    local texture = button:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(table.ICON)
    texture:SetAllPoints()
    button:SetNormalTexture(texture)
    local pushedTexture = button:CreateTexture(nil, "BACKGROUND")
    pushedTexture:SetTexture(NetherBot.PUSHED_CIRCLE_ICON)
    pushedTexture:SetAllPoints()
    button:SetPushedTexture(pushedTexture)
    button:SetHighlightTexture(NetherBot.HIGHLIGHT_CIRCLE_ICON, "ADD")
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(table.NAME)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    button:SetScript("OnClick", onClickFunc)
    return button
end

-- GM
CreateButtonNav(-15, -15, "TOPRIGHT", "TOPRIGHT", NetherBot.BUTTON_NAV_TABLE.GAME_MASTER, function()
    NetherBot.adminFrame:Hide()
    if NetherBot.gameMasterFrame:IsShown() then
        NetherBot.gameMasterFrame:Hide()
    else
        NetherBot.gameMasterFrame:Show()
    end
end)

-- 管理员
CreateButtonNav(-50, -15, "TOPRIGHT", "TOPRIGHT", NetherBot.BUTTON_NAV_TABLE.ADMIN, function()
    NetherBot.gameMasterFrame:Hide()
    if NetherBot.adminFrame:IsShown() then
        NetherBot.adminFrame:Hide()
    else
        NetherBot.adminFrame:Show()
    end
end)

-- 施法
CreateButtonNav(-15, -50, "TOPRIGHT", "TOPRIGHT", NetherBot.BUTTON_NAV_TABLE.CAST_SPELL, function()
    if NetherBot.castSpellFrame:IsShown() then
        NetherBot.castSpellFrame:Hide()
    else
        NetherBot.castSpellFrame:Show()
    end
end)

-- 距离
CreateButtonNav(-50, -50, "TOPRIGHT", "TOPRIGHT", NetherBot.BUTTON_NAV_TABLE.DISTANCE, function()
    if NetherBot.distanceFrame:IsShown() then
        NetherBot.distanceFrame:Hide()
    else
        NetherBot.distanceFrame:Show()
    end
end)