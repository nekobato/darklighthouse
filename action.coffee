{spawn} = require 'child_process'

exports.welcome = (user) ->
  console.info '*** Welcome ' + user.name + ' ***'
  curl = spawn 'curl', ['-d', 'tuple=[\"door\",\"open\"]', 'http://linda.masuilab.org/delta.write' ]
  curl.on 'close', ->
    console.info 'door opened.'
