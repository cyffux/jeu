extends Node

var serv = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	if serv == 1:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_server(1, 2)
		get_tree().network_peer = peer
	else:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_client("192.168.1.138", 1)
		get_tree().network_peer = peer


func _player_connected():
	print("a")
