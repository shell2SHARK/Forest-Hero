extends State
class_name PlayerMovement

@onready var player : CharacterBody2D = get_parent().owner
var speed = 0
var jumpVelocity = 0

func enter():
	# Aplica os valores da resource ao objeto jogador
	speed = player.playerResource.speed
	jumpVelocity = -player.playerResource.jumpForce

func physics_update(delta: float):
	player.gravity(delta)
	move_player(delta)
	
	# So ataca se estiver no chao
	if(Input.is_action_just_pressed("attack_player") and player.is_on_floor()):
		changed_state.emit(self, "Attack")

func move_player(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = jumpVelocity
		play_sfx()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * speed
		player.attack_area.rotation_degrees = 0 if direction > 0 else 180 # Compara quando a hitbox deve girar
		player.playerSpriteSheet.play("Moving")
		player.playerSpriteSheet.flip_h = direction < 0 # Usa direction pra controlar a boleana
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.playerSpriteSheet.play("Idle")

	player.move_and_slide()

func play_sfx():
	# Toca o sfx
	player.audioPlayer.stream = player.playerResource.jumpSFX
	player.audioPlayer.play()
