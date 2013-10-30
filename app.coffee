btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort()
users = require './user.json'
action = require './action'

brbTime = 300000

# bluetooth event
btSerial.on 'found', (address, name) ->
	for user in users
		if user.address is address
			now = Date.now()
			action.welcome(user) if !user.time or (now - user.time) > brbTime
			console.info user.address + ' ' + user.name + ' is here.'
			user.time = now

# forever discover
discover = () ->
	btSerial.inquire()
	arguments.callee(this)

# main
console.log 'discovering...'
discover()

