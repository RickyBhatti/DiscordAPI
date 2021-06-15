fx_version "cerulean"
game "gta5" 

name "DiscordAPI"
description "An all one in solution for Discord API, that controls chat tags, permissions."
author "ricky"
version "v1.0"

lua54 "yes"

client_scripts {
    "**/cl_*.lua",
}

server_scripts {
    "sv_config.lua",
    "**/sv_*.lua"
}

server_exports {
    "getRoles",
    "isRolePresent"
}