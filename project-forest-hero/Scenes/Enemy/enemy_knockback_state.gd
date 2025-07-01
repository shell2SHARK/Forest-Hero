extends State
class_name EnemyKnockback

@onready var enemy : CharacterBody2D = get_parent().owner
var duration : float = 0
var force : float = 0
var knockbackDirection := Vector2.ZERO
var knockbackVelocity := Vector2.ZERO
var knockbackDamping := 10.0  # suavização

func enter():
	set_knockback()
	play_sfx()

func physics_update(delta: float):
	enemy.gravity(delta)
	take_knockback(delta)

func set_knockback():
	duration = enemy.enemyResource.durationKnockback
	force = enemy.enemyResource.forceKnockback
	knockbackDirection = (enemy.global_position - enemy.player.global_position).normalized()
	knockbackVelocity = knockbackDirection * force
	enemy.enemySpriteSheet.play("Knockback")
	enemy.attack_area.get_child(0).set_deferred("disabled", true)
	enemy.lifeBar.visible = true
	enemy.alertIcon.visible = false # Desativa o alerta do inimigo
	enemy.lookArea.get_child(0).visible = false

func take_knockback(delta):
	if(duration > 0):
		enemy.velocity.x = knockbackVelocity.x
		knockbackVelocity.x = lerp(knockbackVelocity.x, 0.0, knockbackDamping * delta)
		duration -= delta
	else:
		changed_state.emit(self, "Pursuit")
	enemy.move_and_slide()

func play_sfx():
	enemy.audioPlayer.stream = enemy.enemyResource.hurtSFX
	enemy.audioPlayer.play()
