server_script {
	'config.lua',
	'inventory.lua',
	'fivemenu_server.lua',
	'outfits_server.lua',
	'inventory_server.lua',
	'police_server.lua',
	'drogue_serveur.lua',
	'tel_server.lua',
	'poleemploi_server.lua'
}

server_script 'permis_server.lua'
server_script 'menumedic_server.lua'

--Non valides--
server_script 'publicfunds_server.lua'
--Xserver_script 'alcool_server.lua'

client_script {
	'client_data.lua',
	'outfits.lua',
	'inventory.lua',
	'fivemenu_client.lua',
	'fivemenu_functions.lua',
	'outfits_client.lua',
	'inventory_client.lua',
	'police_client.lua',
	'transporter_client.lua',
	'drogue_client.lua',
	'tel_client.lua',
	'distributeur_client.lua',
	'animations_client.lua',
	'localization.lua'
}

client_script 'permis_client.lua'
client_script 'repairkit_client.lua'
client_script 'vehicle_client.lua'
client_script 'weashop_client.lua'
client_script 'menumedic_client.lua'
client_script 'illegalvendor_client.lua'
client_script 'lockpick_client.lua'

--Non valides--
client_script 'publicfunds_client.lua'
--Xclient_script 'alcool_client.lua'