extends Node2D

var getItemPorcentage : float = 0
@export var enemyResource : EnemyData
@onready var audioPlayer : AudioStreamPlayer2D = %AudioStreamPlayer2D

func _ready() -> void:
	play_sfx()

func _on_smoke_animation_finished() -> void:
	# Sorteia se o inimigo spawna um item ou nao
	randomize()
	getItemPorcentage = randf_range(0,100)
	
	if(getItemPorcentage <= enemyResource.porcentageToDrop):
		var item = enemyResource.itemToGive.instantiate()
		item.position = position
		get_tree().current_scene.add_child(item)

	queue_free()

func play_sfx():
	# Toca o sfx
	audioPlayer.stream = enemyResource.explosionSFX
	audioPlayer.play()
