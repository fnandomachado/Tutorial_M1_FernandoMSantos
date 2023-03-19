extends Actor

export var stomp_impulse = 1000 #PULO QUE O PERSONAGEM DÁ DEPOIS DE PULAR NO INIMIGO

func _on_EnemyDetector_area_entered(area: Area2D) -> void: #CALCULA A VELOCIDADE DE STOMP
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void: #MORRE E REINICIA A CENA
	GlobalVar.moedas = 0
	get_tree().reload_current_scene()

func _process(delta):
	if is_on_floor():
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("andar")
			
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("andar")
			
		if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
			$AnimatedSprite.play("idle")
			
		if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
			$AnimatedSprite.play("idle")
	else:
		if Input.is_action_pressed("jump"):
			$AnimatedSprite.play("pular")
		if Input.is_action_just_released("jump"):
			$AnimatedSprite.play("idle")

func _physics_process(delta: float) -> void: #VELOCIDADE, DIREÇÃO, ETC
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func get_direction() -> Vector2: #COMO FAZER A DIREÇÃO
	
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity( #CALCULA A VELOCIDADE DE MOVIMENTO
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2: #NECESSÁRIO NA VELOCIDADE DO STPOMP
	var out: = linear_velocity
	out.y = -impulse
	return out

func damage(): #DANO DO ESPINHO
	GlobalVar.moedas = 0
	get_tree().reload_current_scene()

