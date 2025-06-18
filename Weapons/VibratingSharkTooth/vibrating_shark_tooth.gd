extends Weapon


const BASE_ATTACK_DAMAGE = 10


func _ready() -> void:
	attack_damage = BASE_ATTACK_DAMAGE

func attack(attack_direction: Vector2):
	if $AttackTimer.is_stopped():
		$AttackTimer.start()
	
	var vibration_direction: Vector2 = Vector2.from_angle(rotation + PI/2)
	position = (
		global_position +
		vibration_direction *
		sin(remap(
			$AttackTimer.time_left,
			$AttackTimer.wait_time,
			0,
			PI,
			-PI
		))
	)
	
	super(attack_direction)

func _on_attack_timer_timeout() -> void:
	for body in $EnemyCollider.get_overlapping_bodies():
		if body is Enemy:
			body.hit(calculate_attack_damage())
			(func(): body.linear_velocity = Vector2.ZERO).call_deferred()
