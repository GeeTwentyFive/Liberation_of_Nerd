extends Chicken


const DEFAULT_HEALTH = 1000


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH

#func move():
#	pass # TODO?

func die():
	pass # TODO: Drop Bottomless Chicken Pouch
	super()
