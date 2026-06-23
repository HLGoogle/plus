local NetherBot = NetherBot

-- 查找菜单

local titleTexture = NetherBot.lookupFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(250, 70)
titleTexture:SetPoint("TOP", NetherBot.lookupFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.lookupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.lookupFrame, "TOP", 0, 0)
titleFontString:SetText("选择职业")

local hideButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "UIPanelCloseButton")
hideButton:SetSize(40, 40)
hideButton:SetPoint("TOPRIGHT", NetherBot.lookupFrame, "TOPRIGHT", 12, 12)
hideButton:SetScript("OnClick", function()
    NetherBot.lookupFrame:Hide()
end)

local scrollFrame = CreateFrame("ScrollFrame", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 0, -35)
scrollFrame:SetPoint("BOTTOMRIGHT", NetherBot.lookupFrame, "BOTTOMRIGHT", -4, 80)

local lookupList = CreateFrame("Frame", NetherBot:CreateNameUnique(), scrollFrame)
lookupList:SetSize(scrollFrame:GetWidth(), scrollFrame:GetHeight())
scrollFrame:SetScrollChild(lookupList)

-- 机器人职业 array
local botClassArray = {
    NetherBot.BOT_CLASS_TABLE.WARRIOR,
    NetherBot.BOT_CLASS_TABLE.PALADIN,
    NetherBot.BOT_CLASS_TABLE.HUNTER,
    NetherBot.BOT_CLASS_TABLE.ROGUE,
    NetherBot.BOT_CLASS_TABLE.PRIEST,
    NetherBot.BOT_CLASS_TABLE.DEATH_KNIGHT,
    NetherBot.BOT_CLASS_TABLE.SHAMAN,
    NetherBot.BOT_CLASS_TABLE.MAGE,
    NetherBot.BOT_CLASS_TABLE.WARLOCK,
    NetherBot.BOT_CLASS_TABLE.DRUID,
    NetherBot.BOT_CLASS_TABLE.BLADE_MASTER,
    NetherBot.BOT_CLASS_TABLE.SPHYNX,
    NetherBot.BOT_CLASS_TABLE.ARCHMAGE,
    NetherBot.BOT_CLASS_TABLE.DREADLORD,
    NetherBot.BOT_CLASS_TABLE.SPELLBREAKER,
    NetherBot.BOT_CLASS_TABLE.DARK_RANGER,
    NetherBot.BOT_CLASS_TABLE.NECROMANCER,
    NetherBot.BOT_CLASS_TABLE.SEA_WITCH,
    NetherBot.BOT_CLASS_TABLE.CRYPT_LORD
}

-- 遍历机器人职业列表
local yOffset = -10
for _, value in ipairs(botClassArray) do
    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), lookupList, "UIPanelButtonTemplate")
    button:SetSize(170, 25)
    button:SetPoint("TOPLEFT", lookupList, "TOPLEFT", 15, yOffset)
    button:SetText(value.COLOUR .. value.NAME)
    button:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
    button:SetScript("OnClick", function()
        NetherBot:CommandNPCBotLookup_GM(value.CODE)
    end)
    yOffset = yOffset - 30
end

local spawnIdsButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "UIPanelButtonTemplate")
spawnIdsButton:SetSize(40, 25)
spawnIdsButton:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 15, -300)
spawnIdsButton:SetText("生成")
spawnIdsButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
local spawnIdsInput = CreateFrame("EditBox", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "InputBoxTemplate")
spawnIdsInput:SetSize(120, 25)
spawnIdsInput:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 65, -300)
spawnIdsInput:SetAutoFocus(false)
spawnIdsButton:SetScript("OnClick", function()
    local input = spawnIdsInput:GetText()
    if input and input ~= "" then
        local words = NetherBot:SplitBySpace(input)
        for _, value in ipairs(words) do
            NetherBot:CommandNPCBotSpawn_GM(value)
        end
        spawnIdsInput:SetText("")
        spawnIdsInput:ClearFocus()
    else
        ChatFrame1:AddMessage("|cffFFFF00请输入聊天框中查询出的机器人『ID』，多个机器人『ID』用空格连接，例如：『70111 70112』")
    end
end)
spawnIdsButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("多个机器人『ID』用空格连接")
    GameTooltip:Show()
end)
spawnIdsButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

local spawnRangeButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "UIPanelButtonTemplate")
spawnRangeButton:SetSize(40, 25)
spawnRangeButton:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 15, -330)
spawnRangeButton:SetText("生成")
spawnRangeButton:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
local spawnRangeStartInput = CreateFrame("EditBox", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "InputBoxTemplate")
spawnRangeStartInput:SetSize(55, 25)
spawnRangeStartInput:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 65, -330)
spawnRangeStartInput:SetAutoFocus(false)

--local tilde = NetherBot.lookupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
--tilde:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 118, -335)
--tilde:SetText("~")

local spawnRangeEndInput = CreateFrame("EditBox", NetherBot:CreateNameUnique(), NetherBot.lookupFrame, "InputBoxTemplate")
spawnRangeEndInput:SetSize(55, 25)
spawnRangeEndInput:SetPoint("TOPLEFT", NetherBot.lookupFrame, "TOPLEFT", 130, -330)
spawnRangeEndInput:SetAutoFocus(false)

spawnRangeButton:SetScript("OnClick", function()
    local startInput = spawnRangeStartInput:GetText()
    local startBool = NetherBot:ValidateIsGtZero(startInput)
    local endInput = spawnRangeEndInput:GetText()
    local endBool = NetherBot:ValidateIsGtZero(endInput)
    if startBool and endBool then
        local startId = tonumber(startInput)
        local endId = tonumber(endInput)
        if startId <= endId then
            local ids = NetherBot:GenerateRange(startId, endId)
            for _, value in ipairs(ids) do
                NetherBot:CommandNPCBotSpawn_GM(value)
            end
            spawnRangeStartInput:SetText("")
            spawnRangeStartInput:ClearFocus()
            spawnRangeEndInput:SetText("")
            spawnRangeEndInput:ClearFocus()
        else
            ChatFrame1:AddMessage("|cffFFFF00开始『ID』必须小于或者等于结束『ID』")
        end
    else
        ChatFrame1:AddMessage("|cffFFFF00请输入机器人开始『ID』和结束『ID』")
    end
end)
spawnRangeButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("机器人『ID』范围，输入开始『ID』和结束『ID』")
    GameTooltip:Show()
end)
spawnRangeButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
