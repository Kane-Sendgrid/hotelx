express = require 'express'
consolidate = require 'consolidate'
partials = require 'express-partials'
crypto = require 'crypto'
useragent = require 'express-useragent'
http = require 'http'
http_proxy = require 'http-proxy'
socket_io = require 'socket.io'
connect_assets = require 'connect-assets'
app = express()

# settings:
app.port = 3000
crypto_secret = '35345453dfgja2sljf657sdfs034597xvlklnwrov345rn3lifslk345f345lklsjsflkjewrlwergdgf'

# turn on layout.hamlc
app.use partials()
app.engine 'hamlc', consolidate['haml-coffee']
app.set 'view engine', 'hamlc'
app.use useragent.express()
app.use require('connect-assets')()

app.get '/', (req, res) ->
	res.render 'app', name: 'Customer1'

	crypto_data = req.headers.host + req.headers['user-agent'] + Math.random + (Math.floor(Math.random() * (99999999 - 1 + 1)) + 1)
	hash = crypto.createHmac("md5", crypto_secret).update(crypto_data).digest("hex")
	#console.log hash, useragent

server = http.createServer(app)
socket_io = socket_io.listen(server)
server.listen(app.port)

socket_io.sockets.on "connection", (socket) ->

	socket.on "chat", (data) ->
		socket.emit "chat-reply",
			"response from server: " + data

console.log 'Proxy is listening on port ' + app.proxy_port
console.log 'Hotelx.com is listening on port ' + app.port
console.log 'Environment ' + process.env.NODE_ENV