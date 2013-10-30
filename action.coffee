welcome = (user) ->
	# welcome message
	console.info '*** Welcome ' + user.name + ' ***'
	
	# open the door
	child_p = require 'child_process'
	child_p.exec "curl -d 'tuple=[\"door\",\"open\"]' http://linda.masuilab.org/delta.write", (a,b,c) ->
		console.info 'door opened.'

module.exports =
	welcome: welcome
