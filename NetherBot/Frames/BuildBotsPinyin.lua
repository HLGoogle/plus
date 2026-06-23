local NetherBot = NetherBot
-- 创建Bots拼音

local titleTexture = NetherBot.buildBotsPinyinFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(280, 70)
titleTexture:SetPoint("TOP", NetherBot.buildBotsPinyinFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.buildBotsPinyinFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.buildBotsPinyinFrame, "TOP", 0, 0)
titleFontString:SetText("创建Bots-拼音")

local hideButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.buildBotsPinyinFrame, "UIPanelCloseButton")
hideButton:SetSize(40, 40)
hideButton:SetPoint("TOPRIGHT", NetherBot.buildBotsPinyinFrame, "TOPRIGHT", 12, 12)
hideButton:SetScript("OnClick", function()
    NetherBot.buildBotsPinyinFrame:Hide()
end)

local scrollFrame = CreateFrame("ScrollFrame", NetherBot:CreateNameUnique(), NetherBot.buildBotsPinyinFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", NetherBot.buildBotsPinyinFrame, "TOPLEFT", 0, -35)
scrollFrame:SetPoint("BOTTOMRIGHT", NetherBot.buildBotsPinyinFrame, "BOTTOMRIGHT", -4, 12)

local listFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), scrollFrame)
listFrame:SetSize(scrollFrame:GetWidth(), scrollFrame:GetHeight())
scrollFrame:SetScrollChild(listFrame)

local yOffset = -10
for _, value in ipairs(NetherBot.BOT_TEMPLATE_ARRAY) do
    local classCode = value.CLASS.CODE
    local className = value.CLASS.NAME or ""
    local classColour = value.CLASS.COLOUR or ""
    local raceCode = value.RACE.CODE
    local raceName = value.RACE.NAME or ""
    local genderCode = value.GENDER.CODE
    local genderName = value.GENDER.NAME or ""
    local appearanceSkinArray = value.APPEARANCE.SKIN
    local appearanceFaceArray = value.APPEARANCE.FACE
    local appearanceHairstyleArray = value.APPEARANCE.HAIRSTYLE
    local appearanceHairColorArray = value.APPEARANCE.HAIR_COLOR
    local appearanceFeaturesArray = value.APPEARANCE.FEATURES

    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), listFrame, "UIPanelButtonTemplate")
    button:SetSize(170, 25)
    button:SetPoint("TOPLEFT", listFrame, "TOPLEFT", 15, yOffset)
    -- |cffC69B6D .. 人类 .. 男 .. 战士
    button:SetText(classColour .. raceName .. genderName .. className)
    button:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
    button:SetScript("OnClick", function()
        local prompt = "您即将创建『" .. classColour .. raceName .. genderName .. className .. "|r』机器人\n"
        prompt = prompt .. "创建成功后，必须|cffFF0000重启|r服务端！\n"
        prompt = prompt .. "请输入需要创建的机器人数量，一次最多创建|cffFF000010|r个机器人，所有机器人姓名|cffFF0000随机-拼音|r生成，例如『|cffFF0000ZhangSan|r』。"
        StaticPopupDialogs["BUILD_BOTS_PINYIN"] = {
            text = prompt,
            button1 = "确定",
            button2 = "取消",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self)
                -- or OnButton1 = function(self) end
                local npc = self.editBox:GetText()
                local bool = NetherBot:ValidateIsGtZero(npc)
                if bool then
                    local count = tonumber(npc)
                    if count > 10 then
                        ChatFrame1:AddMessage("|cffFFFF00一次最多创建10个机器人！")
                    else
                        for i = 1, count do
                            local pinyinFullName = NetherBot:RandomPinyinFullName()
                            NetherBot:CommandNPCBotCreateNew_Admin(
                                    pinyinFullName,
                                    classCode,
                                    raceCode,
                                    genderCode,
                                    NetherBot:RandomFromArray(appearanceSkinArray),
                                    NetherBot:RandomFromArray(appearanceFaceArray),
                                    NetherBot:RandomFromArray(appearanceHairstyleArray),
                                    NetherBot:RandomFromArray(appearanceHairColorArray),
                                    NetherBot:RandomFromArray(appearanceFeaturesArray),
                                    nil
                            )
                        end
                    end
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("BUILD_BOTS_PINYIN")
    end)
    yOffset = yOffset - 30
end