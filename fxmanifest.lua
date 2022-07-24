fx_version 'bodacious'
game 'gta5'
author 'Favik <favik@favik.cz>'
description 'Racing Depo'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua',
}
