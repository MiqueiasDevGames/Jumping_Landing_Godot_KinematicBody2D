extends KinematicBody2D

export (int) var run_speed = 110
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false

var frame = true
var yframe = 0
var landing = false

func _ready():
	pass
	

func get_input(delta):
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	#var right = true

	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_select")
	
	if jump and is_on_floor():
		jumping = true
		
		velocity.y = jump_speed
		
		
	if right:
		velocity.x += run_speed 
		
	if left:
		velocity.x -= run_speed 
	
	#Virou esquerda direita
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
	#Correndo
	if velocity.length() > 0 and !jumping and !landing:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.play()
	#Parado
	else:
		if !jumping and !landing:
			$AnimatedSprite.animation = "Idle"
			$AnimatedSprite.play()
		


func _physics_process(delta):
	get_input(delta)
	

	if frame:
		yframe = position.y
		frame = false
	else:
		frame = true
		if position.y < yframe:
			landing = false
		if position.y > yframe:
			jumping = false
			landing = true
	
	if jumping and is_on_floor():
		#Pulando
		$AnimatedSprite.animation = "Jump"
		$AnimatedSprite.play()
	if landing and !is_on_floor():
		#Landing
		$AnimatedSprite.animation = "Landing"
		$AnimatedSprite.play()
		

	
	#Gravidade
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	
