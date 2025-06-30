extends Resource
class_name PlayerStats

@export_group("Movement Values")
@export_range(1,1000) var speed : float = 1
@export_range(1,1000) var jumpForce : float = 1

@export_group("Attack Values")
@export_range(1,1000) var swordValue : float = 1.0
