extends CanvasLayer

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var progressBar : ProgressBar = %ProgressBar
@onready var enemyCount : Label = %Enemy_Count
var totalEnemies := 0

func _ready() -> void:
	progressBar.max_value = player.playerResource.life
	totalEnemies = get_tree().get_nodes_in_group("Enemy").size()

func _process(_delta: float) -> void:
	set_infos()

func set_infos():
	progressBar.value = player.life
	enemyCount.text = str(totalEnemies)
