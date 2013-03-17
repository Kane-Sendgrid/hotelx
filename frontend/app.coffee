express = require 'express'
cons = require 'consolidate'
partials = require 'express-partials'
crypto = require 'crypto'
useragent = require 'express-useragent'
app = express()

# settings:
port = 8080
crypto_secret = '35345453dfgja2sljf657sdfs034597xvlklnwrov345rn3lifslk345f345lklsjsflkjewrlwergdgf'

# turn on layout.hamlc
app.use partials()

app.engine 'hamlc', cons['haml-coffee']
#app.set 'views', __dirname + '/views'
app.set 'view engine', 'hamlc'

# serve static files:
app.use("/js", express.static(__dirname + '/js'));
app.use("/css", express.static(__dirname + '/css'));

app.use(useragent.express())

app.get '/', (req, res) ->
  #body = 'Hello World';
  #res.setHeader('Content-Type', 'text/plain')
  #res.setHeader('Content-Length', body.length)
  #res.send('Hello World')
  #res.end(body)
	res.render 'app', name: 'Customer1'

	crypto_data = req.headers.host + req.headers['user-agent'] + Math.random + (Math.floor(Math.random() * (99999999 - 1 + 1)) + 1)
	hash = crypto.createHmac("md5", crypto_secret).update(crypto_data).digest("hex")
	console.log hash

app.listen(port)

#console.log app
console.log 'Listening on port ' + port