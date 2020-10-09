extends Node

var serv = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if serv == 1:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_server(1, 2)
		get_tree().network_peer = peer
	else:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_client("192.168.1.138", 1)
		get_tree().network_peer = peer

func network_peer_connected(id):
	print(id)
