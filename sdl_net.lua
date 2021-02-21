--[[--
 @package   sdl_net
 @filename  sdl_net.lua
 @version   1.1
 @author    Díaz Urbaneja Víctor Eduardo Diex <victor.vector008@gmail.com>
 @date      20.02.2021 04:33:57 -04
]]

-- @see https://github.com/tangent128/luasdl2/
local net = require "SDL.net"
local json = require "cjson"

local sdl_net = {}
sdl_net.__index = sdl_net;

function sdl_net.new(_, username, host, port)
    -- Init net
    net.init()

	local self = setmetatable({}, {__index=sdl_net})
    self.username = username or 'johndoe'
    self.host = host or 'localhost'
    self.port = port or 5959
    return self
end

function sdl_net:connect()
    -- Create and connect
    local address, err = net.resolveHost(self.host, self.port)
    assert(not err, "Error resolving host")
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

function sdl_net.receive() -- TODO
end

function sdl_net:disconnect()
	net.quit()
	self.running = false
end

return setmetatable(sdl_net, {__call = sdl_net.new})
