if not Config.ChatRolesEnabled then return end

local pairs = pairs
local tostring = tostring
local tonumber = tonumber
local find = string.find
local insert = table.insert

local _IsPlayerAceAllowed = IsPlayerAceAllowed
local _TriggerClientEvent = TriggerClientEvent

local _GetIdentifiersTable = GetIdentifiersTable
local _getRoles = getRoles
local _SplitString = SplitString

local RoleList = Config.RoleList
local ServerID = Config.ServerID

local cachedPlayerRoles = {}
local playerSelectedRole = {}
local playerStaffChatStatus = {}

local function syncTags(source)
    local identifiers = _GetIdentifiersTable(source)

    if not identifiers.discord then return end

    local roles = _getRoles(source)
    local rolesAllowed = {}
    local highestRole, highestRoleIndex = nil, nil

    for i = 1, #RoleList do 
        if tostring(RoleList[i][1]) == "0" then
            insert(rolesAllowed, i)
            highestRoleIndex = i
        end
        if roles ~= nil then
            for _, v in pairs(roles) do
                if tostring(RoleList[i][1]) == tostring(v) then
                    insert(rolesAllowed, i)
                    highestRole, highestRoleIndex = v, i
                end
            end
        end
    end

    cachedPlayerRoles[source] = rolesAllowed
    playerSelectedRole[source] = RoleList[highestRoleIndex][2]
end

local function sendMessage(source, message)
    TriggerClientEvent("chat:addMessage", source, {
        color = {255, 0, 0},
        multiline = true,
        args = {"Server", tostring(message)}
    })
end

AddEventHandler("chatMessage", function(source, name, message)
    CancelEvent()

    local source, args, role = tonumber(source), _SplitString(message), playerSelectedRole[source]
    if role == nil then
        syncTags(source)
        role = playerSelectedRole[source]
    end

    if not find(args[1], "/") and not playerStaffChatStatus[source] then
        if ServerID then
            _TriggerClientEvent("chatMessage", -1, "^*^7" .. source .. " | " .. role .. name .. "^r^7: " .. message)
        else
            _TriggerClientEvent("chatMessage", -1, "^*^7" .. role .. name .. "^r^7: " .. message)
        end
    elseif not find(args[1], "/") and playerStaffChatStatus[source] then
        for k, _ in pairs(playerStaffChatStatus) do
            _TriggerClientEvent("chatMessage", k, "^*^7[^8Staff Chat^7] " .. role .. name .. "^r^7: " .. message)
        end
    end
end)

local function setData(source)
    syncTags(source)
    
    if _IsPlayerAceAllowed(source, "DiscordAPI:StaffChat") then
        playerStaffChatStatus[tonumber(source)] = false
        _TriggerClientEvent("DiscordAPI:staffChatStatus", source, false)
    end
end

RegisterNetEvent("DiscordAPI:UpdateChatPermissions")
AddEventHandler("DiscordAPI:UpdateChatPermissions", function()
    setData(source)
end)

AddEventHandler("playerDropped", function()
    cachedPlayerRoles[source] = nil
    playerSelectedRole[source] = nil
end)

RegisterCommand("chattag", function(source, args, rawCommand)
    local src = source
    local roleList = cachedPlayerRoles[src]
    if roleList == nil then
        syncTags(src)
        roleList = cachedPlayerRoles[src]
    end

    if #args == 0 then
        for k, v in pairs(roleList) do
            _TriggerClientEvent("chatMessage", src, "^*" .. k .. "^r^7: " .. RoleList[v][2])
        end
        sendMessage(src, "Use /chattag <id> to select the tag you'd like to use.^r^7")
    elseif #args == 1 then
        local selectedID = tonumber(args[1])
        if selectedID > 0 and selectedID <= #roleList then
            playerSelectedRole[src] = RoleList[roleList[selectedID]][2]
            sendMessage(src, "You've selected to use the following as your tag: " .. playerSelectedRole[src] .. "^r^7")
        else
            sendMessage(src, "You've selected out of range.^r^7")
        end
    end
end)

local function StaffChat(source)
    local src = tonumber(source)
    if not _IsPlayerAceAllowed(src, "DiscordAPI:StaffChat") then sendMessage(src, "You're not authorized to enter staff chat.") return end

    playerStaffChatStatus[src] = not (playerStaffChatStatus[src] or false)

    if playerStaffChatStatus[src] then
        _TriggerClientEvent("DiscordAPI:staffChatStatus", src, true)
        sendMessage(src, "You've entered staff chat.")
    else
        _TriggerClientEvent("DiscordAPI:staffChatStatus", src, false)
        sendMessage(src, "You've left staff chat.")
    end
end

RegisterCommand("staffchat", function(source)
    StaffChat(source)
end, false)

RegisterCommand("sc", function(source)
    StaffChat(source)
end, false)