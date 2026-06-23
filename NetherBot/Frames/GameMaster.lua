local NetherBot = NetherBot

-- GM菜单

local titleTexture = NetherBot.gameMasterFrame:CreateTexture(nil, "OVERLAY")
titleTexture:SetSize(250, 70)
titleTexture:SetPoint("TOP", NetherBot.gameMasterFrame, "TOP", 0, 14)
titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")

local titleFontString = NetherBot.gameMasterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleFontString:SetPoint("TOP", NetherBot.gameMasterFrame, "TOP", 0, 0)
titleFontString:SetText("GM 菜单")

-- 创建GM按钮
local function CreateButton(offsetX, offsetY, point, relativePoint, text, onClickFunc)
    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.gameMasterFrame, "UIPanelButtonTemplate")
    button:SetSize(150, 30)
    button:SetPoint(point, NetherBot.gameMasterFrame, relativePoint, offsetX, offsetY)
    button:SetText(text)
    button:GetNormalTexture():SetVertexColor(0.10, 1.00, 0.10)
    button:SetScript("OnClick", onClickFunc)
    return button
end

-- 雇佣
CreateButton(0, -30, "TOP", "TOP", "雇佣", function()
    NetherBot:CommandNPCBotAdd_GM()
end)

-- 解雇
CreateButton(0, -70, "TOP", "TOP", "解雇", function()
    NetherBot:CommandNPCBotRemove_GM()
end)

-- 移动
CreateButton(0, -110, "TOP", "TOP", "移动", function()
    local targetGUID = UnitGUID("target")
    if targetGUID then
        NetherBot:CommandNPCBotMove_GM()
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
                local bool = NetherBot:ValidateIsGtZero(npc)
                if bool then
                    NetherBot:CommandNPCBotMove_GM(npc)
                else
                    ChatFrame1:AddMessage("|cffFFFF00无效输入！")
                end
            end
        }
        StaticPopup_Show("MOVE_NPC")
    end
end)

-- 复活
CreateButton(0, -150, "TOP", "TOP", "复活", function()
    NetherBot:CommandNPCBotRevive_GM()
end)

-- 空闲Bots
CreateButton(0, -190, "TOP", "TOP", "空闲Bots", function()
    NetherBot:CommandNPCBotListSpawnedFree_Admin()
end)

-- 所有Bots
CreateButton(0, -230, "TOP", "TOP", "所有Bots", function()
    NetherBot:CommandNPCBotListSpawned_Admin()
end)

-- 查找
CreateButton(0, -270, "TOP", "TOP", "|cff3A5FCD查找", function()
    NetherBot.buildBotFrame:Hide()
    NetherBot.buildBotsFrame:Hide()
    NetherBot.buildBotsPinyinFrame:Hide()
    if NetherBot.lookupFrame:IsShown() then
        NetherBot.lookupFrame:Hide()
    else
        NetherBot.lookupFrame:Show()
    end
end)

-- 删除
CreateButton(0, -310, "TOP", "TOP", "|cffFF0000删除", function()
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
                NetherBot:CommandNPCBotDelete_GM()
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
                local bool = NetherBot:ValidateIsGtZero(npc)
                if bool then
                    StaticPopupDialogs["CONFIRM_DELETE"] = {
                        text = "确定要|cffFF0000删除|r？",
                        button1 = "|cffFF0000是",
                        button2 = "否",
                        timeout = 0,
                        whileDead = true,
                        hideOnEscape = true,
                        OnAccept = function()
                            NetherBot:CommandNPCBotDeleteId_GM(npc)
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

-- 删除空闲机器人
CreateButton(0, -350, "TOP", "TOP", "|cffFF0000删除空闲Bots", function()
    StaticPopupDialogs["DELETE_NPC_FREE"] = {
        text = "确定要|cffFF0000删除|r所有空闲机器人？",
        button1 = "|cffFF0000是",
        button2 = "否",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnAccept = function()
            NetherBot:CommandNPCBotDeleteFree_GM()
        end
    }
    StaticPopup_Show("DELETE_NPC_FREE")
end)