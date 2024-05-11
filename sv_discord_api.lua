local token = "Bot " .. Config.DiscordToken

local pairs = pairs
local tostring = tostring
local encode = json.encode
local decode = json.decode

local _PerformHttpRequest = PerformHttpRequest
local _Wait = Citizen.Wait

local _GetIdentifiersTable = GetIdentifiersTable
local _Log = Log

local GuildID = Config.GuildID
local DiscordRoles = Config.DiscordRoles

local function DiscordRequest(endpoint, method, jsondata)
    local data = nil

    _PerformHttpRequest("https://discord.com/api/" .. endpoint, function(codeResponse, dataResponse, headersResponse)
        data = {
            code = codeResponse,
            data = dataResponse,
            headers = headersResponse
        }
    end, method, ((#jsondata > 0 and encode(jsondata)) or ""),
    {
        ["Content-Type"] = "application/json",
        ["Authorization"] = token
    })

    while data == nil do
        _Wait(0)
    end

    return data
end

function getRoles(user)
    local identifiers = _GetIdentifiersTable(user)

    if not identifiers.discord then return {} end

    local endpoint = ("guilds/%s/members/%s"):format(GuildID, identifiers.discord)
    local result = DiscordRequest(endpoint, "GET", {})
    if result.code ~= 200 then return {} end

    local data = decode(result.data)
    return data.roles
end

function isRolePresent(user, role)
    local identifiers = _GetIdentifiersTable(user)

    if not identifiers.discord then return false end

    local endpoint = ("guilds/%s/members/%s"):format(GuildID, identifiers.discord)
    local result = DiscordRequest(endpoint, "GET", {})
    if result.code ~= 200 then return false end

    local data = decode(result.data)
    local toFind = DiscordRoles[tostring(role)]

    for k, v in pairs(data.roles) do
        if toFind == v then
            return true
        end
    end
end

Citizen.CreateThread(function()
    local guild = DiscordRequest("guilds/" .. GuildID, "GET", {})

    if guild.code ~= 200 then
        _Log("^1An error has occured with your guild information. (".. (guild.data or guild.code) .. ")")
        return
    end

    local data = decode(guild.data)
    _Log("Permission guild was set to: " .. data.name .. " (ID: " .. data.id .. ")")
end)