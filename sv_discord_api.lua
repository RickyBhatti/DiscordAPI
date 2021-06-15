local token = "Bot " .. Config.DiscordToken

local function DiscordRequest( endpoint, method, jsondata )
    local data = nil

    PerformHttpRequest( "https://discord.com/api/" .. endpoint, function( codeResponse, dataResponse, headersResponse )
        data = {
            code = codeResponse,
            data = dataResponse,
            headers = headersResponse
        }
    end, method, ( ( #jsondata > 0 and json.encode( jsondata ) ) or "" ),
    {
        [ "Content-Type" ] = "application/json",
        [ "Authorization" ] = token
    } )

    while data == nil do
        Citizen.Wait( 0 )
    end

    return data
end

function getRoles( user )
    local identifiers = GetIdentifiersTable( user )

    if identifiers.discord then
        local endpoint = ( "guilds/%s/members/%s" ):format( Config.GuildID, identifiers.discord )
        local result = DiscordRequest( endpoint, "GET", {} )

        if result.code == 200 then
            local data = json.decode( result.data )
            return data.roles
        else
            return {}
        end
    else
        return {}
    end
end

function isRolePresent( user, role )
    local identifiers = GetIdentifiersTable( user )

    if identifiers.discord then
        local endpoint = ( "guilds/%s/members/%s" ):format( Config.GuildID, identifiers.discord )
        local result = DiscordRequest( endpoint, "GET", {} )

        if result.code == 200 then
            local data = json.decode( result.data )
            local toFind = Config.DiscordRoles[ tostring( role ) ]

            for k, v in pairs( data.roles ) do
                if toFind == v then
                    return true
                end
            end
        else
            return false
        end
    else
        return false
    end
end

Citizen.CreateThread( function()
    local guild = DiscordRequest( "guilds/" .. Config.GuildID, "GET", {} )

    if guild.code == 200 then 
        local data = json.decode( guild.data )
        Log( "Permission guild was set to: " .. data.name .. " (ID: " .. data.id .. ")" )
    else
        Log( "^1An error has occured with your guild information. (".. ( guild.data or guild.code ) .. ")" )
    end
end )