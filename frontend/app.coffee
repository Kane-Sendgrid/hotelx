express = require('express')
app = express()
port = 8080

app.get '/', (req, res) ->
  body = 'Hello World';
  res.setHeader('Content-Type', 'text/plain')
  res.setHeader('Content-Length', body.length)
  res.send('Hello World')
  res.end(body)

app.listen(port)
console.log 'Listening on port ' + port