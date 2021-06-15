TriggerServerEvent( "DiscordAPI:UpdateChatPermissions" )

TriggerEvent( "chat:addSuggestion", "/chattag", "Select the tag that appears beside your name.", {
    { name = "ID", help = "Chat tag ID." }
} )