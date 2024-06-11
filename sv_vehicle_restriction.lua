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

--[[
    VehicleRestrictions = { -- TODO: Decide on a better name for this, plus if it'd be "blacklisting" or "whitelisting" vehicles.
        ["793044205269680128"] = { --// Role: Owner
            "adder"
        },
        ["793043765224931388"] = { --// Role: Member
            "baller"
        }
    }
    VehicleInheritance = { --// Role: Owner
        ["793043765224931388"] = {
            "793044205269680128" --// Role: Member
        }
    }

    Current logic of the tables.
]]--