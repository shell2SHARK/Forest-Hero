extends Node2D

var getItemPorcentage : float = 0
var enemyResource : EnemyData

func _on_smoke_animation_finished() -> void:
	randomize()
	getItemPorcentage = randf_range(0,100)
	print("res = " , getItemPorcentage)
	if(getItemPorcentage <= enemyResource.porcentageToDrop):
		var item = enemyResource.itemToGive.instantiate()
		item.position = position
		get_tree().current_scene.add_child(item)
	
	queue_free()
