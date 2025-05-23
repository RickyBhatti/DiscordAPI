if not Config.AcePermsEnabled then return end

local pairs = pairs
local tostring = tostring

local _GetIdentifiersTable = GetIdentifiersTable
local _getRoles = getRoles
local _ExecuteCommand = ExecuteCommand
local _GetPlayerName = GetPlayerName
local _Log = Log

local groups = Config.Groups
local permissions = Config.Permissions

local groupsToRemove = {}
local permissionsToRemove = {}

local groupAdd = "add_principal identifier.%s %s"
local groupRemove = "remove_principal identifier.%s %s"
local permissionAdd = "add_ace identifier.%s \"%s\" allow"
local permissionRemove = "remove_ace identifier.%s \"%s\" allow"

local function applyPermissions(source)
    local identifiers = _GetIdentifiersTable(source)
    local license, discord = identifiers.license, identifiers.discord

    for _, v in pairs(groupsToRemove) do
        _ExecuteCommand(groupRemove:format(license, v))
    end

    for k, _ in pairs(permissionsToRemove) do
        _ExecuteCommand(permissionRemove:format(license, k))
    end

    if not discord then return end

    local roles = _getRoles(source)
    if roles == nil then return end

    local name = _GetPlayerName(source) or ""

    for _, v in pairs(roles) do
        local groupInformation = groups[tostring(v)]
        local permissionInformation = permissions[tostring(v)]

        if not groupInformation then goto skipGroupInformation end
        _ExecuteCommand(groupAdd:format(license, groupInformation))
        _Log("Granted \"" .. groupInformation.. "\" to " .. name .. " (" .. license .. ").")
        ::skipGroupInformation::

        if not permissionInformation then goto skipPermissionInformation end
        _Log("Granting permission set for role ID: " .. v .. ".")
        for _, v2 in pairs(permissionInformation) do
            _ExecuteCommand(permissionAdd:format(license, v2))
            _Log("Granted \"" .. v2.. "\" to " .. name  .. " (" .. license .. ") due to them having the role ID: " .. v .. ".")
        end
        ::skipPermissionInformation::
    end
end

AddEventHandler("playerConnecting", function()
    applyPermissions(source)
end)

for _, v in pairs(groups) do
    table.insert(groupsToRemove, v)
end

for _, v in pairs(permissions) do
    for _, v2 in pairs(v) do
        if tostring(v2) ~= "" and not permissionsToRemove[tostring(v2)] then
            permissionsToRemove[v2] = true
        end
    end
end