fx_version "cerulean"
game "gta5" 

name "DiscordAPI"
description "An all one in solution for Discord API, that controls chat tags, permissions."
author "ricky"
version "v2.2.1"

lua54 "yes"

client_scripts {
    "**/cl_*.lua",
}

server_scripts {
    "sv_config.lua",
    "sv_utility.lua",
    "sv_discord_api.lua",
    "**/sv_*.lua"
}

server_exports {
    "getRoles",
    "isRolePresent"
}
