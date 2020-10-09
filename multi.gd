extends Node

var serv = 1
var playerid=0

# Called when the node enters the scene tree for the first time.

func position(pos):
	get_parent().pos=pos

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	if serv == 1:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_server(31400, 2)
		get_tree().network_peer = peer
	else:
		var peer = NetworkedMultiplayerENet.new()
		peer.create_client("192.168.1.138", 31400)
		get_tree().network_peer = peer
	set_network_master(1)

func connect_to_server(id):
	print(str(id)+" is connected")
	print(id)

func _player_connected(id):
	print(str(id)+" is connected")
	var playerid=id

func _connected_ok():
	print("connected")

func _connected_fail():
	print("fail")

func _process(delta):
	if is_network_master():
		rset("position",3)
	else:
		rset("position",2)
	rpc("position", Vector2(66,66), get_tree().get_network_unique_id())
