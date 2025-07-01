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

func physics_update(delta: float):
	enemy.gravity(delta)
	take_knockback(delta)

func set_knockback():
	duration = enemy.enemyResource.durationKnockback
	force = enemy.enemyResource.forceKnockback
	knockbackDirection = (enemy.global_position - enemy.player.global_position).normalized()
	knockbackVelocity = knockbackDirection * force
	enemy.enemySpriteSheet.play("Knockback")
	enemy.collisionBox.set_deferred("disabled", true)
	enemy.lifeBar.visible = true

func take_knockback(delta):
	if(duration > 0):
		enemy.velocity = knockbackVelocity
		knockbackVelocity = lerp(knockbackVelocity, Vector2.ZERO, knockbackDamping * delta)
		duration -= delta
	else:
		enemy.collisionBox.set_deferred("disabled", false)
		changed_state.emit(self, "Pursuit")
	enemy.move_and_slide()
