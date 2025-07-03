extends Resource
class_name PlayerData

@export_group("Movement Values")
@export_range(1,1000) var life : float = 1
@export_range(1,1000) var speed : float = 1
@export_range(1,1000) var jumpForce : float = 1

@export_group("Attack Values")
@export_range(1,1000) var swordValue : float = 1.0

@export_group("Damage Values")
@export_range(1,1000) var durationKnockback : float = 1
@export_range(1,1000) var forceKnockback : float = 1

@export_group("Sound Values")
@export var attackSFX : AudioStream
@export var jumpSFX : AudioStream
@export var hurtSFX : AudioStream
@export var deadSFX : AudioStream
@export var healSFX : AudioStream
