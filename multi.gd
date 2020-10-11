extends Node

var serv = 1
var playerid=0

# Called when the node enters the scene tree for the first time.

func position(pos):
	get_parent().posenemis=pos

func frappe(frappe):
	get_parent().frappeenemis=frappe

func punch(punch, rota):
	get_parent().punchennemis=punch
	get_parent().rotapunchennemi=rota

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

func _player_connected(id):
	print(str(id)+" is connected")
	if is_network_master():
		rpc_config("position",2)
		rpc_config("frappe",2)
		rpc_config("punch",2)
	else:
		rpc_config("position",3)
		rpc_config("frappe",3)
		rpc_config("punch",3)
	playerid=id

func _connected_ok():
	print("connected")

func _connected_fail():
	print("fail")

func _process(delta):
	if is_network_master():
		rpc_id(playerid,"position",get_parent().posme)
		rpc_id(playerid,"frappe",get_parent().frappeme)
		rpc_id(playerid,"punch",get_parent().punchme, get_parent().rotapunchme)
	else:
		rpc_id(1,"punch",get_parent().punchme)
		rpc_id(1,"frappe",get_parent().frappeme)
		rpc_id(1,"punch",get_parent().posme,get_parent().rotapunchme)
