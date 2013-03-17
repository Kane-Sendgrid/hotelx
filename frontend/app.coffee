express = require 'express'
cons = require 'consolidate'
partials = require 'express-partials'
app = express()
port = 8080

# turn on layout.hamlc
app.use partials()

app.engine 'hamlc', cons['haml-coffee']
#app.set 'views', __dirname + '/views'
app.set 'view engine', 'hamlc'

# serve static files:
app.use("/js", express.static(__dirname + '/js'));
app.use("/css", express.static(__dirname + '/css'));

app.get '/', (req, res) ->
  #body = 'Hello World';
  #res.setHeader('Content-Type', 'text/plain')
  #res.setHeader('Content-Length', body.length)
  #res.send('Hello World')
  #res.end(body)
  res.render 'app', name: 'Customer1'

app.listen(port)



console.log app
console.log 'Listening on port ' + port