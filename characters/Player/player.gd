extends CharacterBody2D

# Snelheden
const WALK_SPEED = 100.0
const RUN_SPEED = 200.0

# Houd bij welke kant we op kijken (standaard naar beneden)
var facing_direction = "down" 

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# 1. Input uitlezen (welke toetsen worden ingedrukt?)
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	# Zorg dat diagonaal lopen niet sneller gaat
	input_vector = input_vector.normalized()

	# 2. Bepalen of we aan het rennen zijn
	var is_running = Input.is_action_pressed("run")

	# 3. Beweging en Animatie tegelijkertijd regelen
	if input_vector != Vector2.ZERO:
		# --- WE BEWEGEN ---
		
		# Bepaal de kijkrichting op basis van de input
		if abs(input_vector.x) > abs(input_vector.y):
			# Horizontaal (links of rechts)
			if input_vector.x > 0:
				facing_direction = "right"
				sprite.flip_h = false  # Normaal (kijkt naar rechts)
			else:
				facing_direction = "right" # BLIJFT "right"! We flippen alleen de sprite
				sprite.flip_h = true   # Spiegel (kijkt naar links)
		else:
			# Verticaal (omhoog of omlaag)
			if input_vector.y > 0:
				facing_direction = "down"
			else:
				facing_direction = "up"
		
		# Bepaal de snelheid en speel de animatie af
		if is_running:
			velocity = input_vector * RUN_SPEED
			sprite.play("run_" + facing_direction)
		else:
			velocity = input_vector * WALK_SPEED
			sprite.play("walk_" + facing_direction)
			
	else:
		# --- WE STAAN STIL ---
		velocity = Vector2.ZERO
		sprite.play("idle_" + facing_direction)

	# 4. Voer de daadwerkelijke beweging uit
	move_and_slide()
