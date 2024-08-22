local addonName, addon = ...
local f
local _G = _G

local scale = 1

local function scaleSingleFrame(frame, overrideScale)
    if (type(frame) == "string") then
        frame = _G[frame]
    end
    if frame then
        if (not frame:IsForbidden()) then
            frame:SetScale(overrideScale or scale)
        else
            error("Attempted to scale a Forbidden frame:", frame)
        end
    end
end

local loadFrames = {
    ["Blizzard_AchievementUI"] = "AchievementFrame",
    ["Blizzard_ArchaeologyUI"] = "ArchaeologyFrame",
    ["Blizzard_AnimaDiversionUI"] = "AnimaDiversionFrame",
    ["Blizzard_ArenaUI"] = {
        "ArenaPrepFrames",
        "ArenaEnemyFrames"
    },
    ["Blizzard_AuctionHouseUI"] = "AuctionHouseFrame",
    ["Blizzard_AzeriteEssenceUI"] = "AzeriteEssenceUI",
    ["Blizzard_AzeriteRespecUI"] = "AzeriteRespecFrame",
    ["Blizzard_AzeriteUI"] = onAzeriteShow,
    ["Blizzard_BarberShopUI"] = "BarberShopFrame",
    ["Blizzard_BindingUI"] = "KeyBindingFrame",
    ["Blizzard_BlackMarketUI"] = "BlackMarketFrame",
    ["Blizzard_PVPUI"] = {
        "PvPObjectiveBannerFrame"
    },
    ["Blizzard_ChallengesUI"] = {
        "ChallengesKeystoneFrame",
        "ChallengeModeCompleteBanner"
    },
    ["Blizzard_Calendar"] = "CalendarFrame",
    ["Blizzard_Collections"] = "CollectionsJournal",
    ["Blizzard_Communities"] = "CommunitiesFrame",
    ["Blizzard_CompactRaidFrames"] = {
        "CompactRaidFrameContainer",
        "CompactRaidFrameManager"
    },
    ["Blizzard_CovenantPreviewUI"] = "CovenantPreviewFrame",
    ["Blizzard_CovenantSanctum"] = "CovenantSanctumFrame",
    ["Blizzard_DeathRecap"] = "DeathRecapFrame",
    ["Blizzard_EncounterJournal"] = "EncounterJournal",
    ["Blizzard_FlightMap"] = "FlightMapFrame",
    ["Blizzard_GarrisonUI"] = onGarrisonLoad,
    ["Blizzard_GMSurveyUI"] = "GMSurveyFrame",
    ["Blizzard_GuildUI"] = "GuildFrame",
    ["Blizzard_GuildBankUI"] = "GuildBankFrame",
    ["Blizzard_InspectUI"] = "InspectFrame",
    ["Blizzard_ItemSocketingUI"] = "ItemSocketingFrame",
    ["Blizzard_MacroUI"] = "MacroFrame",
    ["Blizzard_ObliterumUI"] = "ObliterumForgeFrame",
    ["Blizzard_PetBattleUI"] = "PetBattleFrame",
    ["Blizzard_PlayerChoiceUI"] = "PlayerChoiceFrame",
    ["Blizzard_ReforgingUI"] = {
        "ReforgingFrame",
        "AzeriteRespecFrame"
    },
    ["Blizzard_RuneforgeUI"] = "RuneforgeFrame",
    ["Blizzard_Soulbinds"] = "SoulbindViewer",
    ["Blizzard_TimeManager"] = "TimeManagerFrame",
    ["Blizzard_TradeSkillUI"] = "TradeSkillFrame",
    ["Blizzard_TrainerUI"] = "ClassTrainerFrame",
    ["Blizzard_TalentUI"] = "PlayerTalentFrame",
    ["Blizzard_VoidStorageUI"] = "VoidStorageFrame",
    ["Blizzard_LookingForGroupUI"] = "LFGParentFrame",
    ["Blizzard_WeeklyRewards"] = "WeeklyRewardsFrame",
    ["Blizzard_AuctionUI"] = "AuctionFrame",
    ["Blizzard_Collections"] = {
        "WardrobeFrame",
        "CollectionsJournal"
    },
    ["Blizzard_AuctionUI"] = "AuctionFrame",
    ["Blizzard_TorghastLevelPicker"] = "TorghastLevelPickerFrame",
    ["Blizzard_GarrisonUI"] = {
        "GarrisonLandingPage",
        "CovenantMissionFrame"
    },
    ["Blizzard_Soulbinds"] = "SoulbindViewer",
    ["Blizzard_TorghastLevelPicker"] = "TorghastLevelPickerFrame",
    ["Blizzard_CovenantRenown"] = "CovenantRenownFrame",
    ["Blizzard_GarrisonUI"] = "GarrisonLandingPage",
    ["Blizzard_ObjectiveTracker"] = "ObjectiveTrackerFrame",
    ["Blizzard_GenericTraitUI"] = "GenericTraitFrame",
    ["Blizzard_PlayerChoice"] = "PlayerChoiceFrame",
    ["Blizzard_ItemInteractionUI"] = "ItemInteractionFrame",
    ["Blizzard_OrderHallUI"] = "OrderHallTalentFrame"
}

local frameWhitelist = {
    ["DelvesCompanionConfigurationFrame"] = true,
    ["DelvesCompanionAbilityListFrame"] = true,
    ["StaticPopup1"] = true,
    ["StaticPopup2"] = true,
    ["PVPMatchScoreboard"] = true,
    ["BossTargetFrameContainer"] = true,
    ["ArenaEnemyFramesContainer"] = true,
    ["PartyFrame"] = true,
    ["OverrideActionBar"] = true,
    ["ObjectiveTrackerBonusBannerFrame"] = true,
    ["PVPMatchResults"] = true,
    ["MinimapCluster"] = true,
    ["LFGListInviteDialog"] = true,
    ["LFGListApplicationDialog"] = true,
    ["UIErrorsFrame"] = true,
    ["PlayerPowerBarAlt"] = true,
    ["SpellActivationOverlayFrame"] = true,
    ["LossOfControlFrame"] = true,
    ["ExtraAbilityContainer"] = true,
    ["ReportCheatingDialog"] = true,
    ["GeneralDockManager"] = true,
    ["ChatFrame1EditBox"] = true,
    ["ChatFrame1"] = true,
    ["ChatFrame2"] = true,
    ["ChatFrame3"] = true,
    ["ChatFrame4"] = true,
    ["ChatFrame5"] = true,
    ["ChatFrame6"] = true,
    ["ChatFrame7"] = true,
    ["ChatFrame8"] = true,
    ["ChatFrame9"] = true,
    ["ChatFrame10"] = true,
    ["GuildInviteFrame"] = true,
    ["EncounterBar"] = true,
    ["DeadlyDebuffFrame.Debuff"] = true,
    ["DeadlyDebuffFrame"] = true,
    ["ObjectiveTrackerBlocksFrame"] = true,
    ["BossBanner"] = true,
    ["EventToastManagerFrame"] = true,
    ["MicroButtonAndBagsBar"] = true,
    ["QuickJoinToastButton"] = true,
    ["LFGDungeonReadyPopup"] = true,
    ["GhostFrame"] = true,
    ["TimerTracker"] = true,
    ["WorldMapFrame"] = true,
    ["ChatFrameChannelButton"] = true,
    ["ChatFrameMenuButton"] = true,
    --["EmbeddedItemTooltip"] = true,
    ["MerchantFrame"] = true,
    ["GuildControlPopupFrame"] = true,
    ["TutorialFrame"] = true,
    ["OpacityFrameCloseButton"] = true,
    ["GroupLootFrame1"] = true,
    ["GroupLootFrame2"] = true,
    ["GroupLootFrame3"] = true,
    ["GroupLootFrame4"] = true,
    ["GroupLootFrame5"] = true,
    ["GroupLootFrame6"] = true,
    ["GroupLootFrame7"] = true,
    ["GroupLootFrame8"] = true,
    ["SideDressUpFrame"] = true,
    ["AzeriteItemInBagHelpBox"] = true,
    ["ReportFrame"] = true,
    ["ArtifactRelicHelpBox"] = true,
    ["GroupLootContainer"] = true,
    ["CombatLogUpdateFrame"] = true,
    ["HelpFrame"] = true,
    ["PVEFrame"] = true,
    ["AutoFollowStatus"] = true,
    ["PetBattleQueueReadyFrame"] = true,
    ["PetitionFrame"] = true,
    ["SpellBookFrame"] = true,
    ["TabardFrame"] = true,
    ["RaidBossEmoteFrame"] = true,
    ["ObjectiveTrackerTopBannerFrame"] = true,
    ["SubZoneTextFrame"] = true,
    ["ZoneTextFrame"] = true,
    --["ShoppingTooltip1"] = true,
    ["VoiceChatChannelActivatedNotification"] = true,
    ["TextToSpeechButtonFrame"] = true,
    ["BackpackTokenFrame"] = true,
    ["ContainerFrame8"] = true,
    ["AudioOptionsFrame"] = true,
    ["MirrorTimer2"] = true,
    ["TutorialFrameAlertButton8"] = true,
    ["ModelPreviewFrame"] = true,
    ["TimeAlertFrame"] = true,
    ["RolePollPopup"] = true,
    ["TutorialFrameAlertButton4"] = true,
    ["GossipFrame"] = true,
    ["ContainerFrame10"] = true,
    --["BrowserSettingsTooltip"] = true,
    ["MasterLooterFrame"] = true,
    ["AddFriendFrame"] = true,
    ["PVPParentFrame"] = true,
    ["StatsFrame"] = true,
    ["ProductChoiceFrame"] = true,
    ["PVPReadyDialog"] = true,
    ["PVPFramePopup"] = true,
    ["PlayerReportFrame"] = true,
    ["GameMenuFrame"] = true,
    ["RoleChangedFrame"] = true,
    ["QuestLogDetailFrame"] = true,
    ["BankFrame"] = true,
    ["TutorialFrameAlertButton3"] = true,
    ["ChatConfigFrame"] = true,
    ["LFGBulletinBoardO_OptionFrame4"] = true,
    --["ItemRefTooltip"] = true,
    ["BNToastFrame"] = true,
    ["WorldStateScoreFrame"] = true,
    ["PetStableFrame"] = true,
    ["MailFrame"] = true,
    ["StackSplitFrame"] = true,
    ["MirrorTimer3"] = true,
    ["LFGBulletinBoardO_OptionFrame3"] = true,
    ["QueueReadyCheckPopup"] = true,
    ["WorldMapCompareTooltip1"] = true,
    ["TradeFrame"] = true,
    ["GroupBulletinBoardFrame"] = true,
    ["TicketStatusFrame"] = true,
    ["AvatarPickFrame"] = true,
    ["BagHelpBox"] = true,
    ["FriendsFrame"] = true,
    ["LootHistoryFrame"] = true,
    ["NamePlateTooltip"] = true,
    ["QuestieDBMIntegration"] = true,
    ["LFGBulletinBoardO_OptionFrame1"] = true,
    ["UIWidgetTopCenterContainerFrame"] = true,
    ["TaxiFrame"] = true,
    ["ComboFrame"] = true,
    ["ChannelFrame"] = true,
    ["TutorialFrameAlertButton1"] = true,
    ["IMECandidatesFrame"] = true,
    ["TimeManagerFrame"] = true,
    ["BattleTagInviteFrame"] = true,
    ["RaidWarningFrame"] = true,
    ["ArenaRegistrarFrame"] = true,
    ["ReportCheatingDialog"] = true,
    ["TutorialFrameAlertButton10"] = true,
    ["CharacterFrame"] = true,
    ["ConsolidatedBuffs"] = true,
    ["StaticPopup3"] = true,
    ["StreamingIcon"] = true,
    ["FriendsFriendsFrame"] = true,
    ["ModelPanningFrame"] = true,
    ["SmallTextTooltip"] = true,
    ["QuestFrame"] = true,
    ["InterfaceOptionsFrame"] = true,
    ["OpacityFrame"] = true,
    ["GuildRegistrarFrame"] = true,
    ["ColorPickerFrame"] = true,
    ["CoinPickupFrame"] = true,
    ["SubZoneTextFrame"] = true,
    ["ItemRefShoppingTooltip2"] = true,
    ["DressUpFrame"] = true,
    --["GameTooltip"] = true,
    ["HelpPlateTooltip"] = true,
    ["MirrorTimer1"] = true,
    --["AlertFrame"] = true,
    ["GameCooltipFrame2"] = true,
    ["QuestLogFrame"] = true,
    ["ReadyCheckFrame"] = true,
    ["VideoOptionsFrame"] = true,
    ["TemporaryEnchantFrame"] = true,
    ["FolderPicker"] = true,
    ["ItemRefShoppingTooltip1"] = true,
    ["VoiceChatPromptActivateChannel"] = true,
    ["WatchFrame"] = true,
    ["DurabilityFrame"] = true,
    ["PVPBannerFrame"] = true,
    ["HelpPlate"] = true,
    ["VoiceActivityManager"] = true,
    ["ContainerFrame2"] = true,
    ["TutorialFrameAlertButton6"] = true,
    ["OpenMailFrame"] = true,
    ["TutorialFrameParent"] = true,
    ["WorldMapTooltip"] = true,
    ["UIWidgetBelowMinimapContainerFrame"] = true,
    ["LootFrame"] = true,
    ["RatingMenuFrame"] = true,
    ["GBB.PullDownMenu"] = true,
    ["CombatLogQuickButtonFrame"] = true,
    ["ChatAlertFrame"] = true,
    ["StopwatchFrame"] = true,
    ["AddonList"] = true,
    ["ChatMenu"] = true,
    ["AutoCompleteBox"] = true,
    ["CreateChannelPopup"] = true,
    ["ItemTextFrame"] = true,
    ["ActionStatus"] = true,
    ["ExpansionLandingPage"] = true,
    ["MajorFactionRenownFrame"] = true,
    ["WeeklyRewardsFrame"] = true
}

local function rescaleEverything()
    -- _G["myScaledFrames"] = {}
    for _, frame in pairs({UIParent:GetChildren()}) do
        if (not frame:IsForbidden()) then
            local frameName = frame:GetName()
            if frameWhitelist[frameName] then
                scaleSingleFrame(frame)
                -- if frameName then
                --   _G["myScaledFrames"][frameName] = true;
                -- end
            end
        end
    end
end

local function scaleAndAdjustBlizzardBags()
    local CONTAINER_SCALE = 1.2

    local function GetInitialContainerFrameOffsetX()
        return 20
    end

    local function GetContainerScale()
        local containerFrameOffsetX = GetInitialContainerFrameOffsetX()
        local xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
        local screenWidth = GetScreenWidth()
        local containerScale = 1
        local leftLimit = 0
        if (BankFrame:IsShown()) then
            leftLimit = BankFrame:GetRight() - 25
        end

        while (containerScale > CONTAINER_SCALE) do
            screenHeight = GetScreenHeight() / containerScale
            -- Adjust the start anchor for bags depending on the multibars
            xOffset = containerFrameOffsetX / containerScale
            yOffset = CONTAINER_OFFSET_Y / containerScale
            -- freeScreenHeight determines when to start a new column of bags
            freeScreenHeight = screenHeight - yOffset
            leftMostPoint = screenWidth - xOffset
            column = 1
            local frameHeight
            local framesInColumn = 0
            local forceScaleDecrease = false
            for index, frame in ipairs(ContainerFrameSettingsManager:GetBagsShown()) do
                framesInColumn = framesInColumn + 1
                frameHeight = frame:GetHeight(true)
                if (freeScreenHeight < frameHeight) then
                    if framesInColumn == 1 then
                        -- If this is the only frame in the column and it doesn't fit, then scale must be reduced and the iteration restarted
                        forceScaleDecrease = true
                        break
                    else
                        -- Start a new column
                        column = column + 1
                        framesInColumn = 0 -- kind of a lie, at this point there's actually a single frame in the new column, but this simplifies where to increment.
                        leftMostPoint = screenWidth - (column * frame:GetWidth(true) * containerScale) - xOffset
                        freeScreenHeight = screenHeight - yOffset
                    end
                end

                freeScreenHeight = freeScreenHeight - frameHeight
            end

            if forceScaleDecrease or (leftMostPoint < leftLimit) then
                containerScale = containerScale - 0.01
            else
                break
            end
        end

        return math.max(containerScale, CONTAINER_SCALE)
    end

    local function UpdateContainerFrameAnchors()
        local containerScale = GetContainerScale()
        local screenHeight = GetScreenHeight() / containerScale
        -- Adjust the start anchor for bags depending on the multibars
        local xOffset = GetInitialContainerFrameOffsetX() / containerScale
        local yOffset = CONTAINER_OFFSET_Y / containerScale
        -- freeScreenHeight determines when to start a new column of bags
        local freeScreenHeight = screenHeight - yOffset
        local previousBag
        local firstBagInMostRecentColumn
        for index, frame in ipairs(ContainerFrameSettingsManager:GetBagsShown()) do
            frame:SetScale(containerScale)
            if index == 1 then
                -- First bag
                frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), "BOTTOMRIGHT", -xOffset, yOffset)
                firstBagInMostRecentColumn = frame
            elseif (freeScreenHeight < frame:GetHeight()) or previousBag:IsCombinedBagContainer() then
                -- Start a new column
                freeScreenHeight = screenHeight - yOffset
                frame:SetPoint("BOTTOMRIGHT", firstBagInMostRecentColumn, "BOTTOMLEFT", -11, 0)
                firstBagInMostRecentColumn = frame
            else
                -- Anchor to the previous bag
                frame:SetPoint("BOTTOMRIGHT", previousBag, "TOPRIGHT", 0, CONTAINER_SPACING)
            end

            previousBag = frame
            freeScreenHeight = freeScreenHeight - frame:GetHeight()
        end
    end

    UpdateContainerFrameAnchors()
end

local function rerunAddonLoadedHooks()
    for addonName in pairs(loadFrames) do
        if (C_AddOns.IsAddOnLoaded(addonName)) then
            f:ADDON_LOADED(addonName, true)
        end
    end
end

local function registerBootTimeHooks()
    --Alert Frame
    hooksecurefunc(
       "AlertFrame_ShowNewAlert",
        function(frame)
            scaleSingleFrame(frame)
       end
    )

    -- bags
    if ContainerFrameCombinedBags then
        hooksecurefunc(
            ContainerFrameCombinedBags,
            "Show",
            function(frame)
                C_Timer.After(
                    0.001,
                    function()
                        scaleSingleFrame(frame)
                    end
                )
            end
        )
    end

    for i = 1, 6 do
        local bagFrame = _G["ContainerFrame" .. i]
        if bagFrame then
            hooksecurefunc(
                bagFrame,
                "Show",
                function(frame)
                    C_Timer.After(
                        0.001,
                        function()
                            scaleAndAdjustBlizzardBags()
                        end
                    )
                end
            )
        end
    end

    --WorldMapFrame.ScrollContainer.GetCursorPosition = function(f)
        --local x, y = MapCanvasScrollControllerMixin.GetCursorPosition(f)
        --local s = WorldMapFrame:GetScale()
       -- return x / s, y / s
    --end
    -- end

    --Dropdowns
    -- hooksecurefunc(DropDownList1, "Show", function(frame)
    --   scaleSingleFrame(frame, 0.71);
    -- end);
    -- hooksecurefunc(DropDownList2, "Show", function(frame)
    --   scaleSingleFrame(frame, 0.71);
    -- end);
end


f = CreateFrame("Frame")

function f:ADDON_LOADED(loadedAddon, isManual)
    local action = loadFrames[loadedAddon]
    if (action) then
        local actionType = type(action)
        if (actionType == "string") then
            scaleSingleFrame(action)
        elseif (actionType == "table") then
            for _, frameName in ipairs(action) do
                scaleSingleFrame(frameName)
            end
        elseif (actionType == "function") then
            action()
        end
    end
end

local hasTouchedScaling = false

function addon:UpdateBlizzardFramesScaling()
    if not hasTouchedScaling then
        scale = 1.3
        rescaleEverything()
        registerBootTimeHooks()
        rerunAddonLoadedHooks()
        hasTouchedScaling = true
    elseif hasTouchedScaling then
        scale = 1
        rescaleEverything()
        registerBootTimeHooks()
        rerunAddonLoadedHooks()
    end
end

local function modifyBlizzardTargetFrame(scale, hideAll)
    if hideAll then
        TargetFrame:Hide()
        return
    end
    local noop = function()
        return
    end
    for _, objname in ipairs(
        {
            "TargetFrameContainer",
            "TargetFrameContent"
        }
    ) do
        local obj = _G["TargetFrame"][objname]
        if obj then
            obj:Hide()
        end
        TargetFrame:SetPoint("BOTTOMLEFT", SUFUnittarget, "TOPLEFT", -25, -76)
        TargetFrame:SetScale(scale)
    end
    local obj = TargetFrameSpellBar
    obj:Hide()
    obj.UpdateShownState = noop
end

SetCVar("showTargetOfTarget", 0)

function addon:UpdateBlizzardTargetFrame()
    if InCombatLockdown() then
        return
    end
    modifyBlizzardTargetFrame(1.3)
end

local function resizeBuffIcon(buffFrame, newSize)
    if buffFrame then
        buffFrame:SetSize(newSize, newSize)
    end
end

local function resizeDebuffIcon(debuffFrame, newSize)
    if debuffFrame then
        debuffFrame:SetSize(newSize, newSize)
    end
end

local function resizeCenterStatusIcon(newScale)
    for i = 1, 4 do
        local centerStatusIcon = _G["CompactPartyFrameMember" .. i .. "CenterStatusIcon"]
        if centerStatusIcon then
            centerStatusIcon:SetScale(1.2)
        end
    end
end

local newSize = 20

hooksecurefunc("CompactUnitFrame_UtilSetBuff", function(buffFrame)
    resizeBuffIcon(buffFrame, newSize)
end)

hooksecurefunc("CompactUnitFrame_UtilSetDebuff", function(debuffFrame)
    resizeDebuffIcon(debuffFrame, newSize)
end)

resizeCenterStatusIcon(1.2)

function f:PLAYER_LOGIN(...)
    UIParent:SetScale(0.5333333333333333333333333)
    addon:UpdateBlizzardTargetFrame()
    addon:UpdateBlizzardFramesScaling()
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
f:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
f:RegisterEvent("CHAT_MSG_BN_WHISPER")
f:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
f:RegisterEvent("CHAT_MSG_WHISPER")
local function onEvent(self, event, ...)
    if (f[event]) then
        f[event](self, ...)
    end

    if event == "PLAYER_TARGET_CHANGED" then
        addon:UpdateBlizzardTargetFrame()
        return
    end

    if
        (event == "CHAT_MSG_BN_WHISPER_INFORM" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_WHISPER" or
        event == "CHAT_MSG_BN_WHISPER")
    then
        if (ChatFrame11 ~= nil) then
            ChatFrame11:SetScale(1.3)
        end
        if (ChatFrame12 ~= nil) then
            ChatFrame12:SetScale(1.3)
        end
        if (ChatFrame13 ~= nil) then
            ChatFrame13:SetScale(1.3)
        end
        if (ChatFrame14 ~= nil) then
            ChatFrame14:SetScale(1.3)
        end
        if (ChatFrame15 ~= nil) then
            ChatFrame15:SetScale(1.3)
        end
        if (ChatFrame16 ~= nil) then
            ChatFrame16:SetScale(1.3)
        end
        if (ChatFrame17 ~= nil) then
            ChatFrame17:SetScale(1.3)
        end
        if (ChatFrame18 ~= nil) then
            ChatFrame18:SetScale(1.3)
        end
        if (ChatFrame19 ~= nil) then
            ChatFrame19:SetScale(1.3)
        end
        if (ChatFrame20 ~= nil) then
            ChatFrame20:SetScale(1.3)
        end
    end
end

f:SetScript("OnEvent", onEvent)