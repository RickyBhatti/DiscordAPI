if not Config.ChatRolesEnabled then return end

local RoleList = Config.RoleList
local ServerID = Config.ServerID
local cachedPlayerRoles = {}
local playerSelectedRole = {}
local playerStaffChatStatus = {}

local function syncTags( source )
    local src = source
    local identifiers = GetIdentifiersTable( src )

    if identifiers.discord then
        local roles = getRoles( src )
        local rolesAllowed = {}
        local highestRole, highestRoleIndex = nil, nil

        for i = 1, #RoleList do 
            if tostring( RoleList[ i ][ 1 ] ) == "0" then
                table.insert( rolesAllowed, i )
                highestRoleIndex = i
            end
            if roles ~= nil then
                for _, v in pairs( roles ) do
                    if tostring( RoleList[ i ][ 1 ] ) == tostring( v ) then
                        table.insert( rolesAllowed, i )
                        highestRole, highestRoleIndex = v, i
                    end
                end
            end
        end

        cachedPlayerRoles[ src ] = rolesAllowed
        playerSelectedRole[ src ] = RoleList[ highestRoleIndex ][ 2 ]
    end
end

local function sendMessage( source, message )
    TriggerClientEvent( "chat:addMessage", source, {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "Server", tostring( message ) }
    } )
end

AddEventHandler( "chatMessage", function( source, name, message )
    CancelEvent()

    local source, args, role = tonumber( source ), SplitString( message ), playerSelectedRole[ source ]
    if role == nil then
        syncTags( source )
        role = playerSelectedRole[ source ]
    end

    if not string.find( args[ 1 ], "/" ) and not playerStaffChatStatus[ source ] then
        if ServerID then
            TriggerClientEvent( "chatMessage", -1, "^*^7" .. source .. " | " .. role .. name .. "^r^7: " .. message )
        else
            TriggerClientEvent( "chatMessage", -1, "^*^7" .. role .. name .. "^r^7: " .. message )
        end
    elseif not string.find( args[ 1 ], "/" ) and playerStaffChatStatus[ source ] then
        for k, _ in pairs( playerStaffChatStatus ) do
            TriggerClientEvent( "chatMessage", k, "^*^7[^8Staff Chat^7] " .. role .. name .. "^r^7: " .. message )
        end
    end
end )

local function setData( source )
    syncTags( source )
    
    if IsPlayerAceAllowed( source, "DiscordAPI:StaffChat" ) then
        playerStaffChatStatus[ tonumber( source ) ] = false
        TriggerClientEvent( "DiscordAPI:staffChatStatus", source, false )
    end
end

RegisterNetEvent( "DiscordAPI:UpdateChatPermissions" )
AddEventHandler( "DiscordAPI:UpdateChatPermissions", function()
    setData( source )
end )

AddEventHandler( "playerDropped", function()
    cachedPlayerRoles[ source ] = nil
    playerSelectedRole[ source ] = nil
end )

RegisterCommand( "chattag", function( source, args, rawCommand )
    local src = source
    local roleList = cachedPlayerRoles[ src ]
    if roleList == nil then
        syncTags( src )
        roleList = cachedPlayerRoles[ src ]
    end

    if #args == 0 then
        for k, v in pairs( roleList ) do
            TriggerClientEvent( "chatMessage", src, "^*" .. k .. "^r^7: " .. RoleList[ v ][ 2 ] )
        end
        sendMessage( src, "Use /chattag <id> to select the tag you'd like to use.^r^7" )
    elseif #args == 1 then
        local selectedID = tonumber( args[ 1 ] )
        if selectedID > 0 and selectedID <= #roleList then
            playerSelectedRole[ src ] = RoleList[ roleList[ selectedID ] ][ 2 ]
            sendMessage( src, "You've selected to use the following as your tag: " .. playerSelectedRole[ src ] .. "^r^7" )
        else
            sendMessage( src, "You've selected out of range.^r^7" )
        end
    end
end )

local function StaffChat( source )
    local src = tonumber( source )
    if IsPlayerAceAllowed( src, "DiscordAPI:StaffChat" ) then
        playerStaffChatStatus[ src ] = not ( playerStaffChatStatus[ src ] or false )

        if playerStaffChatStatus[ src ] then
            TriggerClientEvent( "DiscordAPI:staffChatStatus", src, true )
            sendMessage( src, "You've entered staff chat." )
        else
            TriggerClientEvent( "DiscordAPI:staffChatStatus", src, false )
            sendMessage( src, "You've left staff chat." )
        end
    else
        sendMessage( src, "You're not authorized to enter staff chat." )
    end
end

RegisterCommand( "staffchat", function( source )
    StaffChat( source )
end, false )

RegisterCommand( "sc", function( source )
    StaffChat( source )
end, false )