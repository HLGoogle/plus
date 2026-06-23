local NetherBot = NetherBot

-- 标头菜单

local switchButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.titleFrame, "UIPanelButtonTemplate")
switchButton:SetSize(20, 20)
switchButton:SetPoint("TOP", NetherBot.titleFrame, "TOP", 0, -10)
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
    if NetherBot.mainFrame:IsShown() then
        NetherBot.mainFrame:Hide()
        NetherBot.gameMasterFrame:Hide()
        NetherBot.lookupFrame:Hide()
        NetherBot.castSpellFrame:Hide()
        NetherBot.distanceFrame:Hide()
        NetherBot.adminFrame:Hide()
        NetherBot.buildBotFrame:Hide()
        NetherBot.buildBotsFrame:Hide()
        NetherBot.buildBotsPinyinFrame:Hide()
    else
        NetherBot.mainFrame:Show()
    end
end)

local title = NetherBot.titleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("CENTER", NetherBot.titleFrame, "CENTER", 0, 0)
title:SetText("NB")

-- Create the "reload" button
local reloadButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.titleFrame, "UIPanelButtonTemplate")
reloadButton:SetSize(20, 20)
reloadButton:SetPoint("BOTTOM", NetherBot.titleFrame, "BOTTOM", 0, 10)
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