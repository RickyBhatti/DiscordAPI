Citizen.CreateThread(function()
    local name = GetCurrentResourceName()
    local version = tostring(GetResourceMetadata(name, "version", 0))
    local principal = "resource." .. name

    if name ~= "DiscordAPI" then 
        Log("^1WARNING: The resource name is not DiscordAPI. Unless this is intentional, please change the resource name to DiscordAPI.") 
    end

    if not IsPrincipalAceAllowed(principal, "command.add_principal") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.add_principal' permission. The resource may not function as intended. Please grant this permission in the server.cfg.") 
    end
    
    if not IsPrincipalAceAllowed(principal, "command.add_ace") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.add_ace' permission. The resource may not function as intended. Please grant this permission in the server.cfg.") 
    end

    if not IsPrincipalAceAllowed(principal, "command.remove_principal") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.remove_principal' permission. The resource may not function as intended. Please grant this permission in the server.cfg.")
    end

    if not IsPrincipalAceAllowed(principal, "command.remove_ace") then 
        Log("^1WARNING: DiscordAPI is missing the 'command.remove_ace' permission. The resource may not function as intended. Please grant this permission in the server.cfg.")
    end

    PerformHttpRequest("https://raw.githubusercontent.com/RickyBhatti/DiscordAPI/refs/heads/main/version.txt", function(code, text, _)
        if code ~= 200 then
            Log("^1WARNING: DiscordAPI was unable to check for updates. Please ensure you have an active internet connection.")
            return
        end
            
        if version ~= tostring(text):gsub("\n", "") then
            Log("^1WARNING: Your version of DiscordAPI doesn't match the latest version.")
            Log("^1WARNING: Your version: ^7" .. version)
            Log("^1WARNING: Latest version: ^7" .. text)
        end
    end)
end)
