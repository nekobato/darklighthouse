WebSocket = require 'ws'
wsUri = 'ws://linda.masuilab.org:10010'
ws = new WebSocket wsUri
users = require './user.json'
{welcome} = require './action'

brbTime = 300000

ws.on 'open', ()->
	console.log 'connection opened'

ws.on 'message', (data) ->
	console.log data
	json = JSON.parse data
	if json.type is '__session_id'
		callbackID = new Date()-0+"_"+Math.floor(Math.random()*1000000)
		ws.send JSON.stringify({
			type: "__linda_watch",
			data: ["delta", ["distance","deltaTV"], callbackID],
			session: json.data})
	if json.data.tuple
		for user in users when user.address is json.data.tuple[1]
			now = new Date.now()
			welcome(user) if not user.time or brbTime < now - user.time
			user.time = now

ws.on 'error', (err) ->
	console.log 'error: ' + err
	setTimeout () ->
		ws = wsUri
	, 10000

ws.on 'close', () ->
	console.log 'connection closed'
