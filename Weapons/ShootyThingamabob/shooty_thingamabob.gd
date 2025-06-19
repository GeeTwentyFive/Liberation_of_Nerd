extends Weapon


const BASE_ATTACK_DAMAGE = 10


func _ready() -> void:
	attack_damage = BASE_ATTACK_DAMAGE

func attack(attack_direction: Vector2):
	if $AttackCooldown.is_stopped():
		pass # TODO
		
		$AttackCooldown.start()
		super(attack_direction)
