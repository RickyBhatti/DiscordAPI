fx_version "cerulean"
game "gta5" 

name "DiscordAPI"
description "An all one in solution for Discord API, that controls chat tags, permissions."
author "ricky"
version "2.2.3"

lua54 "yes"

client_scripts {
    "**/cl_*.lua",
}

server_scripts {
    "sv_config.lua",
    "sv_utility.lua",
    "sv_main.lua",
    "sv_discord_api.lua",
    "sv_ace_perms.lua",
    "sv_chat_tags.lua",
    "sv_deferrals.lua"
}

server_exports {
    "getRoles",
    "isRolePresent"
}
