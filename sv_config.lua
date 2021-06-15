Config = {
    DiscordToken = "", -- Bot token (The bot must be in your Discord server.)
    GuildID = "", -- Server ID (The server that the roles are based off of.)

    ChatRolesEnabled = true, -- If you'd like chat tags, staff chat, enabled or not.
    RoleList = { -- Role ID of 0, will grant the role to everyone.
        {0, "👦🏻 ^4Civilian | "}, -- All.
        {793043765224931388, "👨🏼‍🎓 ^3Member | "}, -- Member
        {793043749164417054, "👨🏼‍🎓 ^2Civilian | "}, -- Certified Civilian
        {793044003385245716, "🐛 ^6Bug Hunter | "}, -- Bug Hunter
        {793043998658134026, "💯 ^2First 100 | "}, -- First 100
        {772883493772328990, "🔧 ^3SADOT | "}, -- SADOT
        {793043912829960204, "👮 ^4Police Officer | "}, -- PD Ranks
        {728051858425249914, "🕵️ ^3F.B.I. | "}, -- F.B.I. Ranks
        {793043849857597461, "👨‍🚒 ^1SAFRC | "}, -- Fire/EMS Ranks
        {706576615336968233, "💎 ^6Server Booster | "}, -- Server Booster
        {793044035337846835, "💳 ^3Donator | "}, -- Donator
        {793044044497682464, "💳 ^3Patron | "}, -- Patreon - Tier 1
        {793044058062061590, "💎 ^3Patron | "}, -- Patreon - Tier 2
        {793044068639834152, "👑 ^3Patron | "}, -- Patreon - Tier 3
        {793044096263651368, "💻 ^3Support Team | "}, -- Support Team
        {793044152769576960, "🛡️ ^2Trial Moderator | "}, -- Trial Moderator
        {793044157861986365, "🛡️ ^2Moderator | "}, -- Moderator
        {793044162818867211, "🛡️ ^2Admin | "}, -- Admin
        {793044167298777099, "🛡️ ^6Senior Admin | "}, -- Senior Admin
        {793044172923600936, "💼 ^3Server Manager | "}, -- Server Manager
        {793044186353106974, "👨🏻‍💻 ️^1Developer | "}, -- Developer
        {793044195891740722, "🤵🏻 ^8Community Manager | "}, -- Community Manager
        {793044200614395904, "🤵🏻 ^8Community Director | "}, -- Community Director
        {793044205269680128, "🐉 ^8Owner | "}, -- Owner
    },
    ServerID = true, -- If you'd like the resource to disable the players server ID before their name in chat.

    DiscordRoles = { -- Roles you'd like to be able to check for using the Discord API. Name is anything you'd like it to be.
        [ "Public Cop" ] = "793043744726843412",
    },

    AcePermsEnabled = true, -- If you'd like the resource to grant ace permissions or not.
    Groups = { -- These are the group ace permissions that you'd like to grant based off of Discord roles.
        [ "793044205269680128" ] = "group.admin", --// Role: Owner
        [ "793043765224931388" ] = "group.member", --// Role: Member
    },
    Permissions = { -- Special command permissions you'd like to grant users with certain Discord roles.
        [ "793044205269680128" ] = { --// Role: Owner
            "aop.*",
            "chattoggle",
        }
    }
}