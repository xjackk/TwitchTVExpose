express = require 'express'
app = express()

app.use express.static(__dirname + '/public')

app.listen process.env.PORT || 3000
console.log "Static EXPRESS server listening on port: 3000"