express = require 'express'
consolidate = require 'consolidate'
partials = require 'express-partials'
crypto = require 'crypto'
useragent = require 'express-useragent'
http = require 'http'
socket_io = require 'socket.io'
connect_assets = require 'connect-assets'

app = express()

# settings:
app.port = process.env.PORT or process.env.VMC_APP_PORT or 8080

#console.log process.env

crypto_secret = '35345453dfgja2sljf657sdfs034597xvlklnwrov345rn3lifslk345f345lklsjsflkjewrlwergdgf'

# turn on layout.hamlc
app.use partials()

app.engine 'hamlc', consolidate['haml-coffee']
#app.set 'views', __dirname + '/views'
app.set 'view engine', 'hamlc'

# serve static files:
#app.use("/js", express.static(__dirname + '/js'));
#app.use("/css", express.static(__dirname + '/css'));

app.use useragent.express()
app.use require('connect-assets')()

#app.use connect_assets(buildDir => 'assets')

#console.log js("modernizr-2.6.2-respond-1.1.0.min")

app.get '/', (req, res) ->
	#render coffee_script.compile coffeeSourceCode

	#body = 'Hello World';
	#res.setHeader('Content-Type', 'text/plain')
	#res.setHeader('Content-Length', body.length)
	#res.send('Hello World')
	#res.end(body)
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

console.log 'Listening on port ' + app.port