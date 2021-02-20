--[[--
 @package   sdl_net
 @filename  sdl_net.lua
 @version   1.0
 @author    Díaz Urbaneja Víctor Eduardo Diex <victor.vector008@gmail.com>
 @date      20.02.2021 04:33:57 -04
]]

-- @see https://github.com/tangent128/luasdl2/
-- @see https://github.com/kikito/middleclass
local net = require "SDL.net"
local class = require "middleclass"
local json = require "cjson"

local sdl_net, set = class('sdl_net')

function sdl_net:initialize(username, host, port)
	-- Init net
	net.init()
	self.username = username or 'johndoe'
	self.host = host or 'localhost'
	self.port = port or 5959
end

function sdl_net:connect()
	-- Create and connect
	local address, err = net.resolveHost(self.host, self.port)
	self.socket = net.openTcp(address)
end

function sdl_net:composer(message)
	self.message = {
		username = self.username,
		message  = message,
		time = os.date('%H:%M:%S'),
	}
	self.message_encode = json.encode(self.message)
end

function sdl_net:send()
	self.socket:send(self.message_encode)
end

function sdl_net:receive()
end

function sdl_net:disconnect()
	net.quit()
	self.running = false
end

return sdl_net
