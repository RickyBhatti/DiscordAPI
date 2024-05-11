local pairs = pairs
local print = print
local tostring = tostring
local sub = string.sub
local len = string.len
local gsub = string.gsub
local gmatch = string.gmatch
local insert = table.insert

local _GetPlayerIdentifiers = GetPlayerIdentifiers

function Log(message)
    _print("^1DiscordAPI ^7| " .. tostring(message))
end

local cachcedIdentifiers = {}
function GetIdentifiersTable(player)
    if cachcedIdentifiers[player] then return cachcedIdentifiers[player] end
    local data = {}

    for _, v in pairs(_GetPlayerIdentifiers(player))do
        if sub(v, 1, len("license:")) == "license:" then
            data.license = v
        elseif sub(v, 1, len("discord:")) == "discord:" then
            data.discord = gsub(v, "discord:", "")
        end
    end

    cachcedIdentifiers[player] = data
    return data
end

function SplitString(input, separator)
    if separator == nil then separator = "%s" end
    
    local split = {}
    for str in gmatch(input, "([^" .. separator .. "]+)") do
        insert(split, str)
    end

    return split
end