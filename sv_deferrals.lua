if not Config.DiscordRequired then return end

local _GetIdentifiersTable = GetIdentifiersTable
local _isInGuild = isInGuild

local GuildRequired = Config.GuildRequired

AddEventHandler("playerConnecting", function(_, _, deferrals)
    deferrals.defer()
    Wait(0)
    
    local identifiers = _GetIdentifiersTable(source)
    local discord = identifiers.discord

    if not discord then
        deferrals.done("You must have Discord open to join this server.")
        return
    end

    if GuildRequired and not _isInGuild(source) then
        deferrals.done("You must be in the Discord server to join this server.")
        return
    end

    deferrals.done()
end)