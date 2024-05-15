local pairs = pairs
local print = print
local tostring = tostring
local sub = string.sub
local len = string.len
local gsub = string.gsub
local gmatch = string.gmatch
local insert = table.insert

cachedIdentifiers = {}

function Log(message)
    print("^1DiscordAPI ^7| " .. tostring(message))
end

function GetIdentifiersTable(player)
    if cachedIdentifiers[player] then return cachedIdentifiers[player] end
    local data = {}

    for _, v in pairs(GetPlayerIdentifiers(player))do
        if sub(v, 1, len("license:")) == "license:" then
            data.license = v
        elseif sub(v, 1, len("discord:")) == "discord:" then
            data.discord = gsub(v, "discord:", "")
        end
    end

    cachedIdentifiers[player] = data
    return data
end

AddEventHandler("playerDropped", function()
    if not cachedIdentifiers[source] then return end
    cachedIdentifiers[source] = nil
end)

function SplitString(input, separator)
    if separator == nil then separator = "%s" end
    
    local split = {}
    for str in gmatch(input, "([^" .. separator .. "]+)") do
        insert(split, str)
    end

    return split
end