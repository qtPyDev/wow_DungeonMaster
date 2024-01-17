--[[
Copyright 2023-2024 qtPy
DungeonMaster is distributed under the terms of the All Rights Reserved License.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This file is part of DungeonMaster.
--]]

local addon = {};
local addonName = "DungeonMaster";
_G[addonName] = addon;

local dungeonMasterUI = {};
local dungeonMasterFunctions = {};

function dungeonMasterFunctions.HandleSession()
    local startXP = dungeonMasterFunctions.StartSession();
    -- Temporary Test Function
    C_Timer.After(50, function()
        local gainedXP = dungeonMasterFunctions.EndSession(startXP);
        print("Total XP Gained: " ..gainedXP);
    end)
end

function dungeonMasterFunctions.StartSession()
    local startXP, startXPMax = dungeonMasterFunctions.GetPlayerXP();
    print("XP: " ..startXP.. " of " ..startXPMax);

    return startXP;
end

function dungeonMasterFunctions.EndSession(startXP)
    local endXP, endXPMax = dungeonMasterFunctions.GetPlayerXP();

    local gainedXP = dungeonMasterFunctions.GetXPGained(startXP, endXP);
    return gainedXP;
end

function dungeonMasterFunctions.GetPlayerXP()
    local playerXP = UnitXP("player");
    local playerXPMax = UnitXPMax("player");
    return playerXP, playerXPMax;
end

function dungeonMasterFunctions.GetXPGained(startXP, endXP)
    local gainedXP = endXP - startXP;
    return gainedXP;
end

function dungeonMasterFunctions.HandleSlashCommands(str)
    if (str == "toggle") or (str == "") then
        print("Toggle UI");
    elseif (str == "info") or (str == "about") then
        print("info");
    elseif (str == "xp") then
        dungeonMasterFunctions.GetPlayerXP();
    elseif (str == "track") then
        dungeonMasterFunctions.HandleSession();
    end
end

function DungeonMaster_OnLoad()
    SlashCmdList[addonName] = dungeonMasterFunctions.HandleSlashCommands;
    SLASH_DungeonMaster1 = "/dungeonmaster";
    SLASH_DungeonMaster2 = "/dm";
end
