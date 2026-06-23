local NetherBot = NetherBot

-- 管理员菜单

local titleTexture = NetherBot.adminFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(250, 70)
titleTexture:SetPoint("TOP", NetherBot.adminFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.adminFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.adminFrame, "TOP", 0, 0)
titleFontString:SetText("管理员菜单")

-- 创建管理员按钮
local function CreateButton(offsetX, offsetY, point, relativePoint, text, onClickFunc)
    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.adminFrame, "UIPanelButtonTemplate")
    button:SetSize(150, 30)
    button:SetPoint(point, NetherBot.adminFrame, relativePoint, offsetX, offsetY)
    button:SetText(text)
    button:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
    button:SetScript("OnClick", onClickFunc)
    return button
end

-- 召唤老鸨
CreateButton(0, -30, "TOP", "TOP", "召唤老鸨", function()
    -- 在玩家位置生成一个提供机器人招募服务的 NPC
    NetherBot:CommandNPCAdd_Admin(70000)
end)

-- 删除老鸨
CreateButton(0, -70, "TOP", "TOP", "删除老鸨", function()
    NetherBot:CommandNPCDelete_Admin(70000, "|cffFFFF00目标错误！请选中名为『Lagretta』的老鸨...")
end)

-- 创建Bot
CreateButton(0, -110, "TOP", "TOP", "|cff458B74创建Bot", function()
    NetherBot.lookupFrame:Hide()
    NetherBot.buildBotsFrame:Hide()
    NetherBot.buildBotsPinyinFrame:Hide()
    if NetherBot.buildBotFrame:IsShown() then
        NetherBot.buildBotFrame:Hide()
    else
        NetherBot.buildBotFrame:Show()
    end
end)

CreateButton(0, -150, "TOP", "TOP", "|cffCD69C9创建Bots", function()
    NetherBot.lookupFrame:Hide()
    NetherBot.buildBotFrame:Hide()
    NetherBot.buildBotsPinyinFrame:Hide()
    if NetherBot.buildBotsFrame:IsShown() then
        NetherBot.buildBotsFrame:Hide()
    else
        NetherBot.buildBotsFrame:Show()
    end
end)

CreateButton(0, -190, "TOP", "TOP", "|cff993333创建Bots-拼音", function()
    NetherBot.lookupFrame:Hide()
    NetherBot.buildBotFrame:Hide()
    NetherBot.buildBotsFrame:Hide()
    if NetherBot.buildBotsPinyinFrame:IsShown() then
        NetherBot.buildBotsPinyinFrame:Hide()
    else
        NetherBot.buildBotsPinyinFrame:Show()
    end
end)