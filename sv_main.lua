Citizen.CreateThread(function()
    local name = GetCurrentResourceName()
    local meta_name = GetResourceMetadata(name, "name", 0)

    if name ~= "DiscordAPI" then 
        Log("^1WARNING: The resource name is not DiscordAPI. Unless this is intentional, please change the resource name to DiscordAPI.") 
    end

    if not IsPrincipalAceAllowed("resource." .. name, "command.add_principal") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.add_principal' permission. The resource may not function as intended. Please grant this permission in the server.cfg.") 
    end
    
    if not IsPrincipalAceAllowed("resource." .. name, "command.add_ace") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.add_ace' permission. The resource may not function as intended. PPlease grant this permission in the server.cfg.") 
    end

    if not IsPrincipalAceAllowed("resource." .. name, "command.remove_principal") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.remove_principal' permission. The resource may not function as intended. Please grant this permission in the server.cfg.")
    end

    if not IsPrincipalAceAllowed("resource." .. name, "command.remove_ace") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.remove_ace' permission. The resource may not function as intended. Please grant this permission in the server.cfg.")
    end
end)