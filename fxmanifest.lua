fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author "StevoScripts and edited for rsg by phil resource here https://github.com/stevoscriptss/stevo_citizenship?tab=readme-ov-file"

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'modules/client.lua',
    'modules/npcs.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'modules/server.lua',
}

dependencies {
    'rsg-core',
    'oxmysql',
}

files {
  'locales/*.json'
}

lua54 "yes"