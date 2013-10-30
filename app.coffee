btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort()
request = require 'request'
child_p = require 'child_process'
users = require './user.json'

# bluetooth event
btSerial.on 'found', (addr, name) ->
	for user in users
		if user.addr == addr
			console.log user.name + ' is here.'

# forever discover
discover = () ->
	btSerial.inquire()
	arguments.callee(this)

# main
console.log 'finding...'
discover()

# open the door
openDoor = () ->
	child_p.exec "curl -d 'tuple=[\"door\",\"open\"]' http://linda.masuilab.org/delta.write", (a,b,c) ->
		console.log 'curled'
