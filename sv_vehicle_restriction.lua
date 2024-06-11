if not Config.VehicleRestrictionsEnabled then return end

-- TODO: Localizations go here.
-- TODO: Deal with the data tables, ensure they're O(1) lookup time, ideally.

AddEventHandler("playerConnecting", function()
    local source = source
    local identifiers = GetIdentifiersTable(source)
    local license, discord = identifiers.license, identifiers.discord

    if not discord then return end

    local roles = getRoles(source)
    if roles == nil then return end

    -- TODO: Logic goes here.
end)