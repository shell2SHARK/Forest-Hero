extends CanvasLayer

@export var stageMusic : AudioStream
#@onready var loseScene : PackedScene
@onready var winScene : PackedScene = preload("res://Scenes/UI/Win/Win_UI.tscn")
@onready var musicPlayer : AudioStreamPlayer = %Music_Player
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var lifeBar : ProgressBar = %Life_Bar
@onready var enemyCount : Label = %Enemy_Count
var totalEnemies := 0
var endGame := false

func _ready() -> void:
	lifeBar.max_value = player.playerResource.life
	totalEnemies = get_tree().get_nodes_in_group("Enemy").size()
	
	if(stageMusic):
		musicPlayer.stream = stageMusic
		musicPlayer.play()

func _process(_delta: float) -> void:
	if(!endGame):
		set_infos()
	
	if(Input.is_action_just_pressed("ui_home")):
		totalEnemies = 0

func set_infos():
	lifeBar.value = player.life
	enemyCount.text = str(totalEnemies)
	
	if(totalEnemies <= 0):
		musicPlayer.stop()
		var stateMachinePlayer = player.get_node("State_Machine")
		stateMachinePlayer.set_new_state(stateMachinePlayer.actualState, "Idle")
		lifeBar.visible = false
		enemyCount.visible = false
		var winScreen = winScene.instantiate()
		add_child(winScreen)
		endGame = true
