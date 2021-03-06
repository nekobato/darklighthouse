btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort()
users = require './user.json'
WebSocket = require 'ws'
wsUri = 'ws://linda.masuilab.org:10010'
ws = new WebSocket wsUri

session = null

ws.on 'open', ()->
	console.log 'connection opened'

ws.on 'message', (data) ->
	json = JSON.parse data
	if json.type is '__session_id'
		session = json.type
		console.log 'discovering...'
		discover()

ws.on 'error', (err) ->
	console.log 'error: ' + err
	setTimeout () ->
		ws = wsUri
	, 10000

ws.on 'close', () ->
	console.log 'connection closed'

# bluetooth event
btSerial.on 'found', (address, name) ->
	console.log address + ' ' + name
	ws.send JSON.stringify({
		type: "__linda_write",
		data: ["delta", ["distance", "deltaTV", address, 0], {}],
		session: session })

discover = ->
  btSerial.inquire()
  arguments.callee.call @
