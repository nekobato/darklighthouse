btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort()
users = require './user.json'
{welcome} = require './action'

brbTime = 300000

# bluetooth event
btSerial.on 'found', (address, name) ->
  for user in users when user.address is address
    now = Date.now()
    welcome(user) if not user.time or brbTime < now - user.time
    console.info "#{now} #{user.address} #{user.name} is here."
    user.time = now

# forever discover
discover = ->
  btSerial.inquire()
  arguments.callee.call @

# main
console.log 'discovering...'
discover()

