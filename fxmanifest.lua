fx_version 'cerulean'
game 'gta5'

author 'Cornerstone Scripts'
description 'Clothing Items for Ox Inventory'
version '1.0.0'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
