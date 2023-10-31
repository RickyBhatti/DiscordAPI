# DiscordAPI
The ultimate FiveM Discord resource, that allows you to check Discord role(s). With the ability to grant Ace permissions and chat roles based on a Discord role(s).  

Tired of having multiple Discord resources, just to be able to grant Ace permissions, chat roles, and check if a user has a certain Discord Role? Well, look no further. DiscordAPI integrates the 3 most common Discord resources, into one, while enhancing and optimizing them. It will grant and revoke ace groups and permissions, it will grant and revoke chat tags, and will let you check for roles, all based on Discord role(s).
  
## Features
- Applies permissions based on Discord roles, this means you can apply group permissions and unique permissions such as command permissions.
- Removes all permissions, to ensure no one has any permission they're not supposed to.
- In-game chat tags based on Discord roles.
- Display server ID within their chat message.
- Ability to check for certain Discord Roles.
- Lightweight resource, no unrequired code.
  
## Planned Changes
- Expand the API features.
  
## In-Game Example
### Ace Permissions (Server console)
![](https://i.imgur.com/zFuB808.png)
### Chat tags
![](https://i.imgur.com/M2PgdIY.png)
This image contains the server ID at the front (White text):  
![](https://i.imgur.com/RXzFham.png) 
  
## Installation
1. Download the latest release.
2. Drag DiscordAPI into your resource folder.
3. Go to your server.cfg, and write "start DiscordAPI"
4. In your server.cfg, add the following lines:
```
add_ace resource.DiscordAPI command.add_principal allow
add_ace resource.DiscordAPI command.add_ace allow
add_ace resource.DiscordAPI command.remove_principal allow
add_ace resource.DiscordAPI command.remove_ace allow
add_ace group.admin "DiscordAPI:StaffChat" allow
```
5. Change group.admin to your lowest ranking staff group that you'd like to be able to access staff chat.
6. Configure the resource to your liking.

That's it! If everything went correctly, the next time you start your server, you'll see DiscordAPI outputting messages within the console.
  
## Configuration
A sample configuration comes default with the resource, use that as a reference on how to configure the resource properly.

### DiscordToken
You'll need to provide a Discord bot token, for the resource to access your Discord to get the information required to grant chat tags and permissions to your players.
### GuildID
Provide the Discord Server ID of the Discord Server you'd like to base the chat tag and permissions off of.  
### ChatRolesEnabled
Simple true/false option, if it's enabled, the resource will grant chat tags and enable staff chat.  
### RoleList
This is a table that contains the {Discord Role ID, "Chat Tag"}. If you'd like to grant a tag to all users, enter 0 as the Discord Role ID.  
### ServerID
Simple true/false option, if it's enabled, it'll add the users' server ID before their chat tag and name.  
### DiscordRoles
A list of roles you'd like to check for using the exports.  
### AcePermsEnabled
Simple true/false option, if it's enabled, the resource will grant permissions to users joining.  
### Groups
This table will contain the Discord Role ID as a key, and what role to grant as the value.
### Permissions
This table will contain the Discord Role ID as a key, and what permissions to grant as values within the table.
  
## Replacing discord_perms
If you'd like to replace [discord_perms](https://github.com/sadboilogan/discord_perms) with [DiscordAPI](https://github.com/RickyBhatti/DiscordAPI), you'll need to replace the following lines in all the resources you use within your server:
- Replace **exports["discord_perms"]:IsRolePresent** with **exports["DiscordAPI"]:isRolePresent**
- Replace **exports["discord_perms"]:GetRoles** with **exports["DiscordAPI]:getRoles**
  
## Download
Check out the [releases](https://github.com/RickyBhatti/DiscordAPI/releases) page for the newest version.  
  
## Server Performance
![](https://i.imgur.com/zk757un.png)

DiscordAPI is a very lightweight resource and will not cause any performance issues for you while ensuring permissions and chat tags are correctly and accurately applied.   
  
## Credits
Credit to the following resources and their authors for giving me the idea to create a centralized resource.  
[discord_perms](https://github.com/sadboilogan/discord_perms)  
[DiscordAcePerms](https://github.com/JaredScar/DiscordAcePerms)  
[DiscordChatRoles](https://github.com/JaredScar/DiscordChatRoles)  
  
## Contributions
If you've found a bug, you can go ahead and create an [issue](https://github.com/RickyBhatti/DiscordAPI/issues).  
If you've improved the resource, feel free to make a [pull request](https://github.com/RickyBhatti/DiscordAPI/pulls)!  
  
## License
Copyright © 2023 [Ricky Bhatti](https://github.com/RickyBhatti).  
This project is [GNU GPL v3.0](https://github.com/RickyBhatti/DiscordAPI/blob/main/LICENSE) licensed.
