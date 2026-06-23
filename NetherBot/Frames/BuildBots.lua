local NetherBot = NetherBot
-- 创建Bots

local titleTexture = NetherBot.buildBotsFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(280, 70)
titleTexture:SetPoint("TOP", NetherBot.buildBotsFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.buildBotsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.buildBotsFrame, "TOP", 0, 0)
titleFontString:SetText("创建Bots")

local hideButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.buildBotsFrame, "UIPanelCloseButton")
hideButton:SetSize(40, 40)
hideButton:SetPoint("TOPRIGHT", NetherBot.buildBotsFrame, "TOPRIGHT", 12, 12)
hideButton:SetScript("OnClick", function()
    NetherBot.buildBotsFrame:Hide()
end)

local scrollFrame = CreateFrame("ScrollFrame", NetherBot:CreateNameUnique(), NetherBot.buildBotsFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", NetherBot.buildBotsFrame, "TOPLEFT", 0, -35)
scrollFrame:SetPoint("BOTTOMRIGHT", NetherBot.buildBotsFrame, "BOTTOMRIGHT", -4, 12)

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
        prompt = prompt .. "请输入需要创建的机器人数量，一次最多创建|cffFF000010|r个机器人，所有机器人姓名|cffFF0000随机-中文|r生成，例如『|cffFF0000张三|r』。"
        prompt = prompt .. "（|cffFF0000拼接|r：例如选择的是『|cffFF0000人类男战士|r』，最终机器人姓名为『|cffFF0000人类男战士-XXX|r』）"
        StaticPopupDialogs["BUILD_BOTS"] = {
            text = prompt,
            button1 = "确定",
            button2 = "取消",
            button3 = "拼接",
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
                            local chineseFullName = NetherBot:RandomChineseFullName()
                            NetherBot:CommandNPCBotCreateNew_Admin(
                                    chineseFullName,
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
            end,
            -- 第二个按钮点击时，固定调用 OnCancel or OnButton2 函数，且按钮排列在最右边
            -- 点击事件函数可以省略，如果省略，默认点击时隐藏弹出框（一般用作“取消”或者“退出”按钮）
            --OnCancel = function(self) end, -- or OnButton2 = function(self) end
            OnAlt = function(self)
                -- or OnButton3 = function(self) end
                local npc = self.editBox:GetText()
                local bool = NetherBot:ValidateIsGtZero(npc)
                if bool then
                    local count = tonumber(npc)
                    if count > 10 then
                        ChatFrame1:AddMessage("|cffFFFF00一次最多创建10个机器人！")
                    else
                        for i = 1, count do
                            local chineseFullName = NetherBot:RandomChineseFullName()
                            NetherBot:CommandNPCBotCreateNew_Admin(
                                    raceName .. genderName .. className .. "-" .. chineseFullName,
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
        StaticPopup_Show("BUILD_BOTS")
    end)
    yOffset = yOffset - 30
end