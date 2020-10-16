extends RigidBody2D


var speed = 250
var jump = 0
var jump_state = 2.0
var jump_change = 0
var jump_number = 3
var frappe = false
var frappetime = 0
var rota = "RIGHT" 
var punch = false
var punchtime = 0
var rotapunch = ""
var uppunch = false
var uppunchtime = 0

func _ready():
	$Sprite/AnimationPlayer.play("idle")

func _physics_process(delta):
	if is_network_master():
		get_parent().get_parent().frappeme=frappe
		get_parent().get_parent().posme=position
		var velocity=Vector2()
		if Input.is_action_pressed("ui_left"):
			velocity.x-=1
			rota = "LEFT"
		if Input.is_action_pressed("ui_right"):
			velocity.x+=1
			rota = "RIGHT"
		if Input.is_action_just_pressed("ui_up"):
			if jump_number>0:
				linear_velocity=Vector2()
				jump = 40
				jump_state = 2
				jump_change = 0
				jump_number -= 1
		if jump > 0:
			gravity_scale=0
			jump-=1
			jump_change+=1
			if jump_change == 10:
				jump_change = 0
				jump_state -= 0.5
			velocity.y-=jump_state
		else:
			gravity_scale=3
		if Input.is_action_just_pressed("frappe"):
			if frappe == false:
				$KinematicBody2D.visible=true
				frappe=true
				$KinematicBody2D/CollisionShape2D.disabled=false
				frappetime=60
		if frappe == true:
			$KinematicBody2D.rotation+=0.15
			frappetime-=1
			if frappetime<0:
				frappe=false
				$KinematicBody2D/CollisionShape2D.disabled=true
				$KinematicBody2D.visible=false
		if Input.is_action_just_pressed("punch"):
			if punch == false :
				punch = true
				punchtime = 30
				get_parent().get_parent().punchme = true
				if rota == "RIGHT":
					rotapunch = "RIGHT"
					get_parent().get_parent().rotapunchme = "RIGHT"
					$KinematicBody2D2.visible=true
					$KinematicBody2D2/CollisionShape2D.disabled=false
				else:
					rotapunch = "LEFT"
					get_parent().get_parent().rotapunchme = "LEFT"
					$KinematicBody2D3.visible=true
					$KinematicBody2D3/CollisionShape2D.disabled=false
		if punch == true:
			if rotapunch == "RIGHT":
				if punchtime > 10:
					$KinematicBody2D2.position.x+=1
				elif punchtime > 0:
					$KinematicBody2D2.position.x+=5
				else:
					punch = false
					$KinematicBody2D2.position.x=0
					$KinematicBody2D2.visible=false
					$KinematicBody2D2/CollisionShape2D.disabled=true
					get_parent().get_parent().punchme = false
			else:
				if punchtime > 10:
					$KinematicBody2D3.position.x-=1
				elif punchtime > 0:
					$KinematicBody2D3.position.x-=5
				else:
					punch = false
					$KinematicBody2D3.position.x=0
					$KinematicBody2D3.visible=false
					$KinematicBody2D3/CollisionShape2D.disabled=true
					get_parent().get_parent().punchme = false
			punchtime-=1
		if Input.is_action_just_pressed("uppunch"):
			if uppunch == false :
				uppunch = true
				uppunchtime = 15
				$KinematicBody2D4.visible=true
				$KinematicBody2D4/CollisionShape2D.disabled=false
		if uppunch == true:
			if uppunchtime > 12:
				$KinematicBody2D4.position.y-=1
			elif uppunchtime > 7:
				$KinematicBody2D4.position.y-=2
			elif uppunchtime > 0:
				$KinematicBody2D4.position.y-=5
			else:
				uppunch = false
				$KinematicBody2D4.position.y=0
				$KinematicBody2D4.visible=false
				$KinematicBody2D4/CollisionShape2D.disabled=true
			uppunchtime-=1
		velocity.y+=1
		position+=velocity*3
		if linear_velocity.y == 0 and jump == 0:
			jump_number=3
	else:
		position=get_parent().get_parent().posenemis
		if get_parent().get_parent().frappeenemis == true:
			$KinematicBody2D.visible=true
			$KinematicBody2D/CollisionShape2D.disabled=false
			$KinematicBody2D.rotation+=0.15
		else:
			$KinematicBody2D/CollisionShape2D.disabled=true
			$KinematicBody2D.visible=false
		if get_parent().get_parent().punchennemis == true:
			if punch == false:
				punch=true
				punchtime=30
				if get_parent().get_parent().rotapunchennemi == "RIGHT":
					$KinematicBody2D2.visible=true
					$KinematicBody2D2/CollisionShape2D.disabled=false
				else:
					$KinematicBody2D3.visible=true
					$KinematicBody2D3/CollisionShape2D.disabled=false
		if punch == true:
			if get_parent().get_parent().rotapunchennemi == "RIGHT":
				if punchtime > 10:
					$KinematicBody2D2.position.x+=1
				elif punchtime > 0:
					$KinematicBody2D2.position.x+=5
				else:
					punch = false
					$KinematicBody2D2.position.x=0
					$KinematicBody2D2.visible=false
					$KinematicBody2D2/CollisionShape2D.disabled=true
			else:
				if punchtime > 10:
					$KinematicBody2D3.position.x-=1
				elif punchtime > 0:
					$KinematicBody2D3.position.x-=5
				else:
					punch = false
					$KinematicBody2D3.position.x=0
					$KinematicBody2D3.visible=false
					$KinematicBody2D3/CollisionShape2D.disabled=true
			punchtime-=1

