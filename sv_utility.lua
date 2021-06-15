function Log( message )
    print( "^1DiscordAPI ^7| " .. tostring( message ) )
end

function GetIdentifiersTable( player )
    local data = {}

    for k, v in pairs( GetPlayerIdentifiers( player ) )do
        if string.sub( v, 1, string.len( "license:" ) ) == "license:" then
            data.license = v
        elseif string.sub( v, 1, string.len( "discord:" ) ) == "discord:" then
            data.discord = string.gsub( v, "discord:", "" )
        end
    end

    return data
end

function SplitString( input, separator )
    if separator == nil then separator = "%s" end
    
    local split = {}
    for str in string.gmatch( input, "([^" .. separator .. "]+)" ) do
        table.insert( split, str )
    end

    return split
end