-- ==========================================
-- 0. 装备部位本地化翻译表 (全2字强制对齐)
-- ==========================================
local SlotNames = {
    ["INVTYPE_HEAD"] = "头部",
    ["INVTYPE_NECK"] = "项链",
    ["INVTYPE_SHOULDER"] = "肩膀",
    ["INVTYPE_BODY"] = "衬衣",
    ["INVTYPE_CHEST"] = "胸甲",
    ["INVTYPE_ROBE"] = "胸甲",
    ["INVTYPE_WAIST"] = "腰带",
    ["INVTYPE_LEGS"] = "腿部",
    ["INVTYPE_FEET"] = "鞋子",
    ["INVTYPE_WRIST"] = "护腕",
    ["INVTYPE_HAND"] = "手套",
    ["INVTYPE_FINGER"] = "戒指",
    ["INVTYPE_TRINKET"] = "饰品",
    ["INVTYPE_CLOAK"] = "披风",
    ["INVTYPE_WEAPON"] = "单手",
    ["INVTYPE_SHIELD"] = "副手",
    ["INVTYPE_2HWEAPON"] = "双手",
    ["INVTYPE_WEAPONMAINHAND"] = "主手",
    ["INVTYPE_WEAPONOFFHAND"] = "副手",
    ["INVTYPE_HOLDABLE"] = "副手",
    ["INVTYPE_RANGED"] = "远程",
    ["INVTYPE_THROWN"] = "远程",
    ["INVTYPE_RANGEDRIGHT"] = "远程",
    ["INVTYPE_RELIC"] = "圣物",
    ["INVTYPE_TABARD"] = "战袍",
}
local function GetFullItemNameFromLink(itemLink)
    if not itemLink or type(itemLink) ~= "string" then
        return nil
    end
    local tooltip = CreateFrame("GameTooltip", "ItemLinkTooltip", nil, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetHyperlink(itemLink)
    local fullItemName = ItemLinkTooltipTextLeft1:GetText()
     
    tooltip:Hide()
     
    return fullItemName
   
end


local function ReplaceLinkWithFullName(itemLink)
    local fullName = GetFullItemNameFromLink(itemLink)
    if not fullName then return itemLink end
    
    if not fullName:match("^%[.*%]$") then
        fullName = "[" .. fullName .. "]"
    end
    local newLink = itemLink:gsub("(|h).-(|h)", "%1" .. fullName .. "%2", 1)
    return newLink
end

local function GetItemFullInformation(itemlink)
     if not itemlink or type(itemlink) ~= "string" then
        return nil
    end
    local tooltip = CreateFrame("GameTooltip", "LinkInfoTooltip", nil, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetHyperlink(itemlink)
    local lines=tooltip:NumLines() 
    for i=1,lines do
        local text=_G["LinkInfoTooltipTextLeft" .. i]
        print(text:GetText())
    end
end




-- ==========================================
-- 1. 创建主面板
-- ==========================================
local ViewerFrame = CreateFrame("Frame", nil, UIParent)
ViewerFrame:SetSize(235, 380)
ViewerFrame:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT", 10,-12) 
local  eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "MerInspectEquip" then
        ViewerFrame:SetPoint("TOPLEFT", InspectEquip_InfoWindow, "TOPRIGHT", 10, 0) 
    end

end)

-- ==========================================
-- 【手动调整面板左右位置的地方】
-- ==========================================
if InspectEquip   then
    ViewerFrame:SetPoint("TOPLEFT", InspectEquip_InfoWindow, "TOPRIGHT", 10, 0) 
end

ViewerFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
ViewerFrame:SetBackdropColor(0, 0, 0, 0.9) 
ViewerFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1) 
ViewerFrame:Hide()

local title = ViewerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -12)
title:SetText("Bot装备|cff00ff00(请手动查询同步)|r")

-- ==========================================
-- 2. 数据缓存与 UI 列表渲染
-- ==========================================
local EventFrame = CreateFrame("Frame")
local itemButtons = {}

-- 注册本地数据库
BotEquipViewerDB = BotEquipViewerDB or {}
local botItems = BotEquipViewerDB

for i = 1, 25 do
    local btn = CreateFrame("Button", nil, ViewerFrame)
    btn:SetSize(215, 16)
    if i == 1 then
        btn:SetPoint("TOPLEFT", ViewerFrame, "TOPLEFT", 10, -35)
    else
        btn:SetPoint("TOPLEFT", itemButtons[i-1], "BOTTOMLEFT", 0, -2)
    end
    
    local fs = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fs:SetAllPoints()
    fs:SetJustifyH("LEFT")
    btn:SetFontString(fs)
    
    btn:SetScript("OnEnter", function(self)
        if self.itemLink then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(self.itemLink)
            GameTooltip:Show()
        end
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    itemButtons[i] = btn
end

local function UpdateItemList()
    for i = 1, 25 do
        if botItems[i] then
            itemButtons[i]:SetText(botItems[i].display)
            itemButtons[i].itemLink = botItems[i].link
            itemButtons[i]:Show()
        else
            itemButtons[i]:SetText("")
            itemButtons[i].itemLink = nil
            itemButtons[i]:Hide()
        end
    end
end

-- ==========================================
-- 3. 勾选框控制 (仅控制UI显示，不再干扰数据后台收集)
-- ==========================================
local CheckBtn = CreateFrame("CheckButton", "BotEquipCheckButton", CharacterFrame, "UICheckButtonTemplate")
CheckBtn:SetPoint("TOP", CharacterFrame, "TOP", 50, -14)
CheckBtn:SetSize(24, 24)
CheckBtn:SetFrameLevel(CharacterFrame:GetFrameLevel() + 5) 
-- 【这里修改了勾选框文字的颜色为亮绿色】
_G[CheckBtn:GetName().."Text"]:SetText("|cff00ff00机器人装备|r")

CheckBtn:SetChecked(true) 

CheckBtn:SetScript("OnClick", function(self)
    if self:GetChecked() then
        ViewerFrame:Show()
    else
        ViewerFrame:Hide()
    end
end)

PaperDollFrame:HookScript("OnShow", function()
    if CheckBtn:GetChecked() then
        ViewerFrame:Show()
    end
end)

PaperDollFrame:HookScript("OnHide", function()
    ViewerFrame:Hide()
end)


-- ==========================================
-- 4. 事件监听核心 (常驻后台静默刷新)
-- ==========================================
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
EventFrame:RegisterEvent("CHAT_MSG_MONSTER_WHISPER")

local lastWhisperTime = 0 

EventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == "BotEquipViewer" then
        BotEquipViewerDB = BotEquipViewerDB or {}
        botItems = BotEquipViewerDB
        UpdateItemList()
        
    elseif event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_MONSTER_WHISPER" then
        local text = arg1
        if not string.find(text, "item:") then return end
        
        local currentTime = GetTime()
        if currentTime - lastWhisperTime > 0.5 then
            wipe(botItems)
        end
        lastWhisperTime = currentTime
        
        local iconStr = string.match(text, "(|T.-|t)") or ""
        local itemData, itemName = string.match(text, "|H(item:.-)|h%[(.-)%]|h")
        local itemID = string.match(text, "item:(%d+)") 
        local fullItemLink = string.match(text, "|c%x%x%x%x%x%x%x%x|Hitem:[^|]+|h.-|h|r")
        local displayedLinkName=ReplaceLinkWithFullName(fullItemLink)
        if itemData and itemName and itemID then
            local colorStr = string.match(text, "(|c%x%x%x%x%x%x%x%x)") or "|cffa335ee"
            local cleanLink = colorStr .. "|H" .. itemData .. "|h[" .. itemName .. "]|h|r"
            
            local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(tonumber(itemID))
            
            local locText = ""
            if itemEquipLoc and SlotNames[itemEquipLoc] then
                locText = "|cffffd200" .. SlotNames[itemEquipLoc] .. ":|r "
            end
            
            local displayText = locText .. iconStr .. " " .. displayedLinkName
            
            table.insert(botItems, { display = displayText, link = displayedLinkName })
            
            if #botItems > 25 then
                table.remove(botItems, 1)
            end
            
            UpdateItemList()
        end
    end
end)

local function filterfunc(self, event, msg)
    if event=="CHAT_MSG_SYSTEM" then
        if string.find(msg,"不在你的队伍中")   then
        return true           
        end
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filterfunc)