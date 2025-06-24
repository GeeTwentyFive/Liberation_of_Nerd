extends Chicken


const DROP = preload("res://Weapons/BottomlessChickenPouch/BottomlessChickenPouch.tscn")


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH * (
		$Sprite2D.scale.x *
		$Sprite2D.scale.y
	)
	max_health = health

func die():
	var drop = DROP.instantiate()
	drop.global_position = global_position
	get_parent().add_child(drop)
	
	super()
