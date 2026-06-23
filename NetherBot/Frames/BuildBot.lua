local NetherBot = NetherBot
-- 创建Bot

local titleTexture = NetherBot.buildBotFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(250, 70)
titleTexture:SetPoint("TOP", NetherBot.buildBotFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.buildBotFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.buildBotFrame, "TOP", 0, 0)
titleFontString:SetText("创建Bot")

local hideButton = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.buildBotFrame, "UIPanelCloseButton")
hideButton:SetSize(40, 40)
hideButton:SetPoint("TOPRIGHT", NetherBot.buildBotFrame, "TOPRIGHT", 12, 12)
hideButton:SetScript("OnClick", function()
    NetherBot.buildBotFrame:Hide()
end)

local scrollFrame = CreateFrame("ScrollFrame", NetherBot:CreateNameUnique(), NetherBot.buildBotFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", NetherBot.buildBotFrame, "TOPLEFT", 0, -35)
scrollFrame:SetPoint("BOTTOMRIGHT", NetherBot.buildBotFrame, "BOTTOMRIGHT", -4, 12)

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
        prompt = prompt .. "除『War3』某些特殊机器人外，其它机器人外观|cffFF0000随机|r生成。"
        prompt = prompt .. "请输入机器人|cffFF0000姓名|r，如果|cffFF0000姓名|r中包含|cffFF0000空格|r，请用|cffFF0000下划线|r代替。"
        prompt = prompt .. "（|cffFF0000拼接|r：例如选择的是『|cffFF0000人类男战士|r』，输入的是『|cffFF00001号|r』，最终机器人姓名为『|cffFF0000人类男战士-1号|r』）"
        StaticPopupDialogs["BUILD_BOT"] = {
            text = prompt,
            button1 = "确定",
            button2 = "取消",
            button3 = "拼接",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnAccept = function(self) -- or OnButton1 = function(self) end
                local npc = self.editBox:GetText()
                if npc ~= "" then
                    if NetherBot:ContainsSpace(npc) then
                        ChatFrame1:AddMessage("|cffFFFF00姓名中不能包含空格")
                    else
                        NetherBot:CommandNPCBotCreateNew_Admin(
                                npc,
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
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效的输入")
                end
            end,
            -- 第二个按钮点击时，固定调用 OnCancel or OnButton2 函数，且按钮排列在最右边
            -- 点击事件函数可以省略，如果省略，默认点击时隐藏弹出框（一般用作“取消”或者“退出”按钮）
            --OnCancel = function(self) end, -- or OnButton2 = function(self) end
            OnAlt = function(self) -- or OnButton3 = function(self) end
                local npc = self.editBox:GetText()
                if npc ~= "" then
                    if NetherBot:ContainsSpace(npc) then
                        ChatFrame1:AddMessage("|cffFFFF00姓名中不能包含空格")
                    else
                        NetherBot:CommandNPCBotCreateNew_Admin(
                                raceName .. genderName .. className .. "-" .. npc,
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
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效的输入")
                end
            end
        }
        StaticPopup_Show("BUILD_BOT")
    end)
    yOffset = yOffset - 30
end