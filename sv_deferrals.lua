if not Config.DiscordRequired then return end

local GuildRequired = Config.GuildRequired

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetIdentifiersTable(source)
    local discord = identifiers.discord

    if not discord then
        deferrals.done("You must have Discord open to join this server.")
        return
    end

    if GuildRequired and not isInGuild(source) then
        deferrals.done("You must be in the Discord server to join this server.")
        return
    end

    deferrals.done()
end)