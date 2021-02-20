--[[--
 @package   sdl_net
 @filename  client.lua
 @version   1.0
 @author    Díaz Urbaneja Víctor Eduardo Diex <victor.vector008@gmail.com>
 @date      20.02.2021 06:33:57 -04
]]

package.path = package.path .. ';../?.lua;'

local sdl_net = require 'sdl_net'

-- User and server authorization
print('Enter a username:')
local username = io.read()
if username == '' then
	username = nil
end

print('Enter a hostname:')
local hostname = io.read()
if hostname == '' then
	hostname = nil
end

local client = sdl_net:new(username, hostname)
client.dialog = {
	help = 'Available commands: /help, /info, /quit, /members',
	connect = ('\27[1mWelcome\27[0m \27[32m%s\27[0m\nto display the help dialog, use the /help command.\n'):format(client.username),
	question = 'Write a message:',
	info = (
		'Connected to server \27[34m%s\27[0m with nickname \27[32m%s\27[0m and port \27[33m%d\27[0m'
	):format(
		client.host, client.username, client.port
	),
	disconnect = 'Goodbye.'
}

client.running, client.state = true, 'Connected'

function client.run()
	while (client.running) do
		if (client.state == 'Connected') then
			print(client.dialog.connect)
			client:connect()
			client.state = 'Chat Room'
		elseif (client.state == 'Chat Room') then
			print(client.dialog.question)

			local prompt = io.read()
			if (prompt) then
				if (prompt == '/help') then
					print(client.dialog.help)
				elseif (prompt == '/info') then
					print(client.dialog.info)
				elseif (prompt == '/quit') then
					client.state = 'Disconnected'
				else
					client:composer(prompt)
					client.state = 'Sending message'
				end
			end
		elseif (client.state == 'Sending message') then
			client:send()
			client.state = 'Chat Room'
		elseif (client.state == 'Disconnected') then
			print(client.dialog.disconnect)
			client:disconnect()
		end
	end
end

client.run()
