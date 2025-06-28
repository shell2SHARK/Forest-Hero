extends CharacterBody2D

var life : float = 2

func set_damage(value: float):
	life -= value
	print("perde vida " , life)
	
	if(life <= 0):
		queue_free()
