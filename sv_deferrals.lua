if not Config.DiscordRequired then return end

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetIdentifiersTable(source)
    local discord = identifiers.discord

    if not discord then
        deferrals.done("You must have Discord open to join this server.")
        return
    end

    deferrals.done()
end)