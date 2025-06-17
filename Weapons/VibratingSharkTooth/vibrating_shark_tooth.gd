extends Weapon


const BASE_ATTACK_DAMAGE = 100


func _ready() -> void:
	attack_damage = BASE_ATTACK_DAMAGE

func attack(attack_direction: Vector2):
	pass # TODO
	super(attack_direction)
