local NetherBot = NetherBot

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化标头菜单 frame

NetherBot.titleFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local titleFrame = NetherBot.titleFrame
titleFrame:SetSize(40, 95)
titleFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
titleFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 20, edgeSize = 20,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
titleFrame:SetMovable(true)
titleFrame:EnableMouse(true)
titleFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
titleFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- 防止框架移出屏幕
titleFrame:SetClampedToScreen(true)
titleFrame:SetBackdropColor(1, 1, 1, 0.2)
titleFrame:Show()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化主菜单 frame

NetherBot.mainFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local mainFrame = NetherBot.mainFrame
mainFrame:SetSize(450, 95)
mainFrame:SetPoint("RIGHT", titleFrame, "LEFT", 0, 0)
mainFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
mainFrame:SetBackdropColor(1, 1, 1, 0.2)
mainFrame:Show()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化管理菜单 frame

NetherBot.gameMasterFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local gameMasterFrame = NetherBot.gameMasterFrame
gameMasterFrame:SetSize(180, 400)
gameMasterFrame:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0)
gameMasterFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
gameMasterFrame:SetBackdropColor(1, 1, 1, 0.2)
gameMasterFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化查找菜单 frame

NetherBot.lookupFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local lookupFrame = NetherBot.lookupFrame
lookupFrame:SetSize(200, 365)
lookupFrame:SetPoint("RIGHT", gameMasterFrame, "LEFT", -20, 0)
lookupFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
lookupFrame:SetBackdropColor(1, 1, 1, 0.2)
lookupFrame:SetBackdropBorderColor(0, 0.5, 1, 0.8)
lookupFrame:SetMovable(true)
lookupFrame:EnableMouse(true)
lookupFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
lookupFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- 防止框架移出屏幕
lookupFrame:SetClampedToScreen(true)
lookupFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化施法菜单 frame

NetherBot.castSpellFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local castSpellFrame = NetherBot.castSpellFrame
castSpellFrame:SetSize(265, 40)
castSpellFrame:SetPoint("TOP", mainFrame, "BOTTOM", 0, 0)
castSpellFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
castSpellFrame:SetBackdropColor(1, 0, 0, 0.2)
castSpellFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化距离菜单 frame

NetherBot.distanceFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local distanceFrame = NetherBot.distanceFrame
distanceFrame:SetSize(440, 40)
distanceFrame:SetPoint("BOTTOM", mainFrame, "TOP", 0, 0)
distanceFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
distanceFrame:SetBackdropColor(1, 0, 0, 0.2)
distanceFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化管理员菜单 frame

NetherBot.adminFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local adminFrame = NetherBot.adminFrame
adminFrame:SetSize(180, 240)
adminFrame:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0)
adminFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
adminFrame:SetBackdropColor(1, 1, 1, 0.2)
adminFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化创建Bot菜单 frame

NetherBot.buildBotFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local buildBotFrame = NetherBot.buildBotFrame
buildBotFrame:SetSize(200, 360)
buildBotFrame:SetPoint("RIGHT", adminFrame, "LEFT", -20, 0)
buildBotFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
buildBotFrame:SetBackdropColor(1, 1, 1, 0.2)
buildBotFrame:SetBackdropBorderColor(0, 1, 1, 0.8)
buildBotFrame:SetMovable(true)
buildBotFrame:EnableMouse(true)
buildBotFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
buildBotFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- 防止框架移出屏幕
buildBotFrame:SetClampedToScreen(true)
buildBotFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化创建Bots菜单 frame

NetherBot.buildBotsFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local buildBotsFrame = NetherBot.buildBotsFrame
buildBotsFrame:SetSize(200, 360)
buildBotsFrame:SetPoint("RIGHT", adminFrame, "LEFT", -20, 0)
buildBotsFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
buildBotsFrame:SetBackdropColor(1, 1, 1, 0.2)
buildBotsFrame:SetBackdropBorderColor(1, 0, 1, 0.8)
buildBotsFrame:SetMovable(true)
buildBotsFrame:EnableMouse(true)
buildBotsFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
buildBotsFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- 防止框架移出屏幕
buildBotsFrame:SetClampedToScreen(true)
buildBotsFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 初始化创建Bots拼音菜单 frame

NetherBot.buildBotsPinyinFrame = CreateFrame("Frame", NetherBot:CreateNameUnique(), UIParent)
local buildBotsPinyinFrame = NetherBot.buildBotsPinyinFrame
buildBotsPinyinFrame:SetSize(200, 360)
buildBotsPinyinFrame:SetPoint("RIGHT", adminFrame, "LEFT", -20, 0)
buildBotsPinyinFrame:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 12, right = 12, top = 12, bottom = 12 }
})
buildBotsPinyinFrame:SetBackdropColor(1, 1, 1, 0.2)
buildBotsPinyinFrame:SetBackdropBorderColor(1, 0, 0, 0.8)
buildBotsPinyinFrame:SetMovable(true)
buildBotsPinyinFrame:EnableMouse(true)
buildBotsPinyinFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
buildBotsPinyinFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)
-- 防止框架移出屏幕
buildBotsPinyinFrame:SetClampedToScreen(true)
buildBotsPinyinFrame:Hide()
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 自定义插件显示/隐藏命令

-- 创建表，存储 Frame 的位置信息
local framePositions = {}
-- 创建函数，记录 Frame 的位置信息
local function RecordFramePosition(frame)
    if frame then
        local point, relativeTo, relativePoint, xOff, yOff = frame:GetPoint()
        framePositions[frame] = {
            point = point,
            relativeTo = relativeTo,
            relativePoint = relativePoint,
            xOff = xOff,
            yOff = yOff
        }
    end
end
-- 创建函数，重置 Frame 的位置信息
local function ResetFramePosition(frame)
    if frame then
        local position = framePositions[frame]
        if position then
            -- 清除所有锚点（必须）
            frame:ClearAllPoints()
            frame:SetPoint(position.point, position.relativeTo, position.relativePoint, position.xOff, position.yOff)
        end
    end
end
-- 在这里调用，即使 Frame 移动，或者移动后重新加载插件，始终存储的都是初始位置信息
-- 如果在移动后调用，记录的就是移动后的位置信息
RecordFramePosition(titleFrame)
RecordFramePosition(lookupFrame)
RecordFramePosition(buildBotFrame)
RecordFramePosition(buildBotsFrame)
RecordFramePosition(buildBotsPinyinFrame)

-- 固定写法：[SLASH_] + [名称] + [数字]，[名称]可以使用下划线
-- SlashCmdList 集合新增元素时，必须使用[名称]
SLASH_NETHER_BOT_CMD1 = '/netherbot'
SLASH_NETHER_BOT_CMD2 = '/nb'
SlashCmdList['NETHER_BOT_CMD'] = function(msg)
    if msg == "show" or msg == "s" then
        titleFrame:Show()
        mainFrame:Show()
        ChatFrame1:AddMessage("|cffFFFF00[NetherBot]已显示！")
    elseif msg == "hide" or msg == "h" then
        titleFrame:Hide()
        mainFrame:Hide()
        gameMasterFrame:Hide()
        lookupFrame:Hide()
        castSpellFrame:Hide()
        distanceFrame:Hide()
        adminFrame:Hide()
        buildBotFrame:Hide()
        buildBotsFrame:Hide()
        buildBotsPinyinFrame:Hide()
        ChatFrame1:AddMessage("|cffFFFF00[NetherBot]已隐藏！")
    elseif msg == "reset" or msg == "r" then
        ResetFramePosition(titleFrame)
        ResetFramePosition(lookupFrame)
        ResetFramePosition(buildBotFrame)
        ResetFramePosition(buildBotsFrame)
        ResetFramePosition(buildBotsPinyinFrame)
        ChatFrame1:AddMessage("|cffFFFF00[NetherBot]已重置！")
    end
end
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<