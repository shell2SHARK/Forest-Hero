extends State
class_name PlayerKnockback

@onready var player : CharacterBody2D = get_parent().owner
var duration : float = 0
var force : float = 0
var knockbackDirection := Vector2.ZERO
var knockbackVelocity := Vector2.ZERO
var knockbackDamping := 10.0  # suavização

func enter():
	set_knockback()
	play_sfx()
	player.attack_area.get_child(0).set_deferred("disabled", true)

func physics_update(delta: float):
	player.gravity(delta)
	take_knockback(delta)

func set_knockback():
	duration = player.playerResource.durationKnockback
	force = player.playerResource.forceKnockback
	knockbackDirection = (player.global_position - player.actualEnemy.global_position).normalized()
	knockbackVelocity = knockbackDirection * force
	player.playerSpriteSheet.play("Knockback")

func take_knockback(delta):
	if(duration > 0):
		player.velocity = knockbackVelocity
		knockbackVelocity = lerp(knockbackVelocity, Vector2.ZERO, knockbackDamping * delta)
		duration -= delta
	else:
		#player.collisionBox.set_deferred("disabled", false)
		changed_state.emit(self, "Movement")
	player.move_and_slide()

func play_sfx():
	player.audioPlayer.stream = player.playerResource.hurtSFX
	player.audioPlayer.play()
