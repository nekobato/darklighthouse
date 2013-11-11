btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort()
users = require './user.json'
WebSocket = require 'ws'
ws = new WebSocket 'ws://linda.masuilab.org:10010'

session = null

ws.on 'open', ()->
	console.log 'connection opened'

ws.on 'message', (data) ->
	json = JSON.parse data
	if json.type is '__session_id'
		session = json.type
		#ws.send JSON.stringify({type: "__channel_id", data: null, session: session})
		console.log 'discovering...'
		discover()

ws.on 'error', (err) ->
	console.log 'error: ' + err

ws.on 'close', () ->
	console.log 'connection closed'

# bluetooth event
btSerial.on 'found', (address, name) ->
	for user in users when user.address is address
		ws.send JSON.stringify({
			type: "__linda_write",
			data: ["delta", ["distance","deltaTV","nekobato", 0], {}],
			session: session })

discover = ->
  btSerial.inquire()
  arguments.callee.call @
