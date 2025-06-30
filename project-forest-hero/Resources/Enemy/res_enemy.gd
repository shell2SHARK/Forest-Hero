extends Resource
class_name EnemyStats

@export_group("Movement Values")
@export var life : int = 1
@export_range(1,1000) var speedPatrol : float = 1
@export_range(1,1000) var speedPursuit : float = 1

@export_group("Pursuit Values")
@export_range(45,1000) var distanceToAttack : float = 45
@export_range(1,1000) var timeToWaitUntilPursuit : float = 1

@export_group("Damage Values")
@export_range(1,1000) var durationKnockback : float = 1
@export_range(1,1000) var forceKnockback : float = 1
