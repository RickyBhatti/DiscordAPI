if not Config.AcePermsEnabled then return end

local groups = Config.Groups

local permissions = Config.Permissions

local groupsToRemove = {}
local permissionsToRemove = {}

local groupAdd = "add_principal identifier.%s %s"
local groupRemove = "remove_principal identifier.%s %s"
local permissionAdd = "add_ace identifier.%s \"%s\" allow"
local permissionRemove = "remove_ace identifier.%s \"%s\" allow"

local function applyPermissions( source )
    local identifiers = GetIdentifiersTable( source )

    for _, v in pairs( groupsToRemove ) do
        ExecuteCommand( groupRemove:format( identifiers.license, v ) )
    end

    for k, _ in pairs( permissionsToRemove ) do
        ExecuteCommand( permissionRemove:format( identifiers.license, k ) )
    end

    if identifiers.discord then
        local roles = getRoles( source )

        if roles == nil then return end

        for _, v in pairs( roles ) do
            local groupInformation = groups[ tostring( v ) ]
            local permissionInformation = permissions[ tostring( v ) ]

            if groupInformation then
                ExecuteCommand( groupAdd:format( identifiers.license, groupInformation ) )
                Log( "Granted \"" .. groupInformation.. "\" to " .. GetPlayerName( source ) .. " (" .. identifiers.license .. ")." )
            end

            if permissionInformation then
                Log( "Granting permission set for role ID: " .. v .. "." )
                for _, v2 in pairs( permissionInformation ) do
                    ExecuteCommand( permissionAdd:format( identifiers.license, v2 ) )
                    Log( "Granted \"" .. v2.. "\" to " .. GetPlayerName( source )  .. " (" .. identifiers.license .. ") due to them having the role ID: " .. v .. "." )
                end
            end
        end
    end
end

AddEventHandler( "playerConnecting", function()
    applyPermissions( source )
end )

for _, v in pairs( groups ) do
    table.insert( groupsToRemove, v )
end

for _, v in pairs( permissions ) do
    for _, v2 in pairs( v ) do
        if tostring( v2 ) ~= "" and not permissionsToRemove[ tostring( v2 ) ] then
            permissionsToRemove[ v2 ] = true
        end
    end
end