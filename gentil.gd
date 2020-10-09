extends KinematicBody2D


var speed = 250
var jump = 0
var jump_state = 2.0
var jump_change = 0
var jump_number = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/AnimationPlayer.play("idle")


func _process(delta):
	if is_network_master():
		get_parent().get_parent().posme=position
		var velocity=Vector2()
		if Input.is_action_pressed("ui_left"):
			velocity.x-=1
		if Input.is_action_pressed("ui_right"):
			velocity.x+=1
		if Input.is_action_just_pressed("jump"):
			if jump_number>0:
				jump = 40
				jump_state = 2
				jump_change = 0
				jump_number -= 1
		if jump > 0:
			jump-=1
			jump_change+=1
			if jump_change == 10:
				jump_change = 0
				jump_state -= 0.5
			velocity.y-=jump_state
		
		velocity.y+=1
		var move = move_and_slide(velocity*speed)
		if move.y == 0 and jump == 0:
			jump_number=3
	else:
		position = get_parent().get_parent().posenemis


