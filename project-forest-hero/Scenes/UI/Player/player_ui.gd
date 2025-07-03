extends CanvasLayer

@export var stageMusic : AudioStream
@onready var winScene : PackedScene = preload("res://Scenes/UI/Win and Lose/Win_UI.tscn")
@onready var musicPlayer : AudioStreamPlayer = %Music_Player
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var lifeBar : ProgressBar = %Life_Bar
@onready var enemyCount : Label = %Enemy_Count
var totalEnemies := 0
var endGame := false

func _ready() -> void:
	# Seta o valor da barra de vida e o numero de inimigos
	lifeBar.max_value = player.playerResource.life
	totalEnemies = get_tree().get_nodes_in_group("Enemy").size()
	
	# Comeca a tocar a musica da fase
	if(stageMusic):
		musicPlayer.stream = stageMusic
		musicPlayer.play()

func _process(_delta: float) -> void:
	if(!endGame):
		set_infos()

func set_infos():
	# Atualiza as infos na UI do jogador
	lifeBar.value = player.life
	enemyCount.text = str(totalEnemies)
	
	# Se nao houver mais inimigos, chama a tela de vencedor
	if(totalEnemies <= 0):
		stop_music()
		var stateMachinePlayer = player.get_node("State_Machine")
		stateMachinePlayer.set_new_state(stateMachinePlayer.actualState, "Idle")
		lifeBar.visible = false
		enemyCount.visible = false
		var winScreen = winScene.instantiate()
		add_child(winScreen)
		endGame = true

func stop_music():
	# Para a musica, chamado tambem na tela de perdedor
	musicPlayer.stop()
