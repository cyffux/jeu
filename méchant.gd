extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$KinematicBody2D/Sprite/AnimationPlayer.play("idle")


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x-=7
	elif Input.is_action_pressed("ui_right"):
		position.x+=7
