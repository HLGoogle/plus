local NetherBot = NetherBot

-- 施法菜单

-- 创建施法按钮
local function CreateButton(offsetX, offsetY, point, relativePoint, table)
    local button = CreateFrame("Button", NetherBot:CreateNameUnique(), NetherBot.castSpellFrame, "ActionButtonTemplate")
    button:SetPoint(point, NetherBot.castSpellFrame, relativePoint, offsetX, offsetY)
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
    button:SetScript("OnClick", function()
        NetherBot:CommandNPCBotUseOnBotSpell_Player(table.IDS)
    end)
    return button
end

-- >>>>>>>>>>>>>>>>>> 战士 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.WARRIOR then
    NetherBot.BUTTON_CAST_SPELL_WARRIOR_J_J = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.WARRIOR.J_J)
    NetherBot.BUTTON_CAST_SPELL_WARRIOR_Y_H = CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.WARRIOR.Y_H)
end
-- >>>>>>>>>>>>>>>>>> 圣骑士 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.PALADIN then
    NetherBot.BUTTON_CAST_SPELL_PALADIN_B_H_Z_S = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.B_H_Z_S)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Z_J_Z_S = CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Z_J_Z_S)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_X_S_Z_S = CreateButton(60, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.X_S_Z_S)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Z_Y_F_Y = CreateButton(85, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Z_Y_F_Y)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_S_G_D_B = CreateButton(110, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.S_G_D_B)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Q_X_L_L_Z_F = CreateButton(135, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Q_X_L_L_Z_F)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Q_X_Z_H_Z_F = CreateButton(160, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Q_X_Z_H_Z_F)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Q_X_W_Z_Z_F = CreateButton(185, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Q_X_W_Z_Z_F)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_Q_X_B_H_Z_F = CreateButton(210, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.Q_X_B_H_Z_F)
    NetherBot.BUTTON_CAST_SPELL_PALADIN_J_S = CreateButton(235, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PALADIN.J_S)
    -- 对机器人使用神圣干涉没啥用，机器人不会自己取消
end
-- >>>>>>>>>>>>>>>>>> 猎人 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.HUNTER then
    NetherBot.BUTTON_CAST_SPELL_HUNTER_W_D = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.HUNTER.W_D)
end
-- >>>>>>>>>>>>>>>>>> 盗贼 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.ROGUE then
    NetherBot.BUTTON_CAST_SPELL_ROGUE_J_H_J_Q = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.ROGUE.J_H_J_Q)
end
-- >>>>>>>>>>>>>>>>>> 牧师 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.PRIEST then
    NetherBot.BUTTON_CAST_SPELL_PRIEST_Y_H_D_Y = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PRIEST.Y_H_D_Y)
    NetherBot.BUTTON_CAST_SPELL_PRIEST_P_F_S = CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PRIEST.P_F_S)
    NetherBot.BUTTON_CAST_SPELL_PRIEST_F_H_S = CreateButton(60, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.PRIEST.F_H_S)
end
-- >>>>>>>>>>>>>>>>>> 死亡骑士 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.DEATH_KNIGHT then
    NetherBot.BUTTON_CAST_SPELL_DEATH_KNIGHT_K_L = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.DEATH_KNIGHT.K_L)
end
-- >>>>>>>>>>>>>>>>>> 萨满 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.SHAMAN then
    NetherBot.BUTTON_CAST_SPELL_SHAMAN_X_Z_Z_H = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.SHAMAN.X_Z_Z_H)
end
-- >>>>>>>>>>>>>>>>>> 法师 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.MAGE then
    NetherBot.BUTTON_CAST_SPELL_MAGE_H_L_S = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.MAGE.H_L_S)
    NetherBot.BUTTON_CAST_SPELL_MAGE_M_F_Y_Z = CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.MAGE.M_F_Y_Z)
    NetherBot.BUTTON_CAST_SPELL_MAGE_M_F_Z_X = CreateButton(60, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.MAGE.M_F_Z_X)
end
-- >>>>>>>>>>>>>>>>>> 术士 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.WARLOCK then

end
-- >>>>>>>>>>>>>>>>>> 德鲁伊 <<<<<<<<<<<<<<<<<<<
if NetherBot.playerClassFilename == NetherBot.CLASS_FILENAME.DRUID then
    NetherBot.BUTTON_CAST_SPELL_DRUID_F_S = CreateButton(10, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.DRUID.F_S)
    NetherBot.BUTTON_CAST_SPELL_DRUID_Q_S_H_S = CreateButton(35, 0, "LEFT", "LEFT", NetherBot.BUTTON_CAST_SPELL_TABLE.DRUID.Q_S_H_S)
end