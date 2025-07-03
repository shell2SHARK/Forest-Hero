extends CharacterBody2D

@onready var enemySpriteSheet : AnimatedSprite2D = %AnimatedSprite2D
@onready var raycastFloor : RayCast2D = %RayCast_Floor
@onready var raycastVision: RayCast2D = %RayCast_Vision
@onready var lookArea : Area2D = %Looking_Area
@onready var alertIcon : Sprite2D = %Alert
@onready var collisionBox : CollisionShape2D = %CollisionShape2D
@onready var attack_area : Area2D = %Attack_Area
@onready var lifeBar : ProgressBar = %Life
@onready var audioPlayer : AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@export var enemyResource : EnemyData
@onready var life : float = enemyResource.life
var deadByFall := false

func _ready() -> void:
	# Seta os valores iniciais da barra de vida
	lifeBar.max_value = enemyResource.life
	lifeBar.value = enemyResource.life

# Funcoes globais
func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func set_damage(value: float):
	# Diminui a variavel de vida e reflete pra barra de vida
	life -= value
	lifeBar.value = life
	
	if(life <= 0):
		# Chama o estado de dead imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Dead")
	else:
		# Chama o estado de knockback imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Knockback")

func _on_get_area_area_entered(area: Area2D) -> void:
	# Ao tocar na zona de morte, destroi o jogador diretamente
	if(area.is_in_group("Killzone")):
		deadByFall = true
		$State_Machine.set_new_state($State_Machine.actualState, "Dead")
