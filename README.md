## sdl-net

A simple library for sending and receiving data (with Lua-SDL2)

![Screenshot](screenshot.png)

To run this example:

```
cd example/
lua server.lua
```

In a separate terminal run `client.lua`

## Dependencies

- Lua 5.1 (or LuaJIT 2.0)
- [middleclass](https://github.com/kikito/middleclass)
- [Lua-SDL2](https://github.com/tangent128/luasdl2/)

## Documentation

* `sdl_net:new([username, host, port])`: I create a new client. Arguments:
    * (**string**) `username`: user name. default is "johndoe".
    * (**string**) `host`: server to connect to. default is "localhost".
    * (**number**) `port`: the server port. default is 5959.

* `sdl_net:connect()`: I establish the connection to the server.

* `sdl_net:composer(message)`: I compose the message in a JSON. Arguments:
    * (**string**) `message`: The message to be sent.

* `sdl_net:send()`: I send the composite message.

* `sdl_net:disconnect()`: I disconnect from the server.

## Usage

```lua
local sdl_net = require 'sdl_net'
local client = sdl_net:new()

client:connect()
client:composer('Hello World')
client:send()
client:disconnect()
```

## To do

* Implement the method to receive the messages (currently they are previewed in a separate script).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](LICENSE.md)
