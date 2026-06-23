local NetherBot = NetherBot

-- 施法菜单

-- 创建施法按钮
local function CreateButton(offsetX, offsetY, point, relativePoint, table, onClickFunc)
    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.distanceFrame, "ActionButtonTemplate")
    button:SetPoint(point, NetherBot.distanceFrame, relativePoint, offsetX, offsetY)
    button:SetSize(20, 20)
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

-- 30码跟随距离
CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_30, function()
    NetherBot:CommandNPCBotDistance_Player(30)
end)

-- 40码跟随距离
CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_40, function()
    NetherBot:CommandNPCBotDistance_Player(40)
end)

-- 50码跟随距离
CreateButton(60, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_50, function()
    NetherBot:CommandNPCBotDistance_Player(50)
end)

-- 60码跟随距离
CreateButton(85, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_60, function()
    NetherBot:CommandNPCBotDistance_Player(60)
end)

-- 70码跟随距离
CreateButton(110, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_70, function()
    NetherBot:CommandNPCBotDistance_Player(70)
end)

-- 80码跟随距离
CreateButton(135, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_80, function()
    NetherBot:CommandNPCBotDistance_Player(80)
end)

-- 90码跟随距离
CreateButton(160, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_90, function()
    NetherBot:CommandNPCBotDistance_Player(90)
end)

-- 100码跟随距离
CreateButton(185, 0, "LEFT", "LEFT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_100, function()
    NetherBot:CommandNPCBotDistance_Player(100)
end)


-- 0码远程攻击距离
CreateButton(-10, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_0, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(0)
end)

-- 10码远程攻击距离
CreateButton(-35, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_10, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(10)
end)

-- 15码远程攻击距离
CreateButton(-60, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_15, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(15)
end)

-- 20码远程攻击距离
CreateButton(-85, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_20, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(20)
end)

-- 30码远程攻击距离
CreateButton(-110, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_30, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(30)
end)

-- 40码远程攻击距离
CreateButton(-135, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_40, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(40)
end)

-- 50码远程攻击距离
CreateButton(-160, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_50, function()
    NetherBot:CommandNPCBotDistanceAttack_Player(50)
end)

-- 最小远程攻击距离
CreateButton(-185, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_SHORT, function()
    NetherBot:CommandNPCBotDistanceAttack_Player("short")
end)

-- 最大远程攻击距离
CreateButton(-210, 0, "RIGHT", "RIGHT", NetherBot.BUTTON_DISTANCE_TABLE.DISTANCE_ATTACK_LONG, function()
    NetherBot:CommandNPCBotDistanceAttack_Player("long")
end)