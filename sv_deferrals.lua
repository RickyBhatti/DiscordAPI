if not Config.DiscordRequired then return end

local _GetIdentifiersTable = GetIdentifiersTable
local _isInGuild = isInGuild

local GuildRequired = Config.GuildRequired

AddEventHandler("playerConnecting", function(_, _, deferrals)
    local src = source
    deferrals.defer()
    Wait(0)
    
    local identifiers = _GetIdentifiersTable(src)
    local discord = identifiers.discord

    if not discord then
        deferrals.done("You must have Discord open to join this server.")
        return
    end

    if GuildRequired and not _isInGuild(src) then
        deferrals.done("You must be in the Discord server to join this server.")
        return
    end

    deferrals.done()
end)
