extends KinematicBody2D

func _ready():
	$Sprite/AnimationPlayer.play("idle")


func _process(delta):
	position = get_parent().get_parent().pos

