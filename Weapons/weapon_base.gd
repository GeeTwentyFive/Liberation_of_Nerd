class_name Weapon
extends Entity


const WEAPON_OFFSET = 16


var attack_damage: float = 10


var holder: Player


func attack(attack_direction: Vector2):
	holder.attacked.emit()
	pass # Override & implement


func calculate_attack_damage():
	return attack_damage * holder.attack_damage_multiplier


func _on_pickup_collider_body_entered(body: Node2D) -> void:
	if body is Player:
		pick_up(body)

func pick_up(player: Player):
	if holder != null: return
	if player.held_weapon != null:
		player.held_weapon.drop()
	holder = player
	player.held_weapon = self
	sprite.visible = false
	(func():collision_shape.disabled = true).call_deferred()

func drop():
	var drop_position: Vector2 = (
		holder.global_position -
		holder.linear_velocity.normalized() *
		holder.collision_shape.shape.get_rect().size
	)
	(func():
		global_position = drop_position
		global_rotation = 0
		collision_shape.disabled = false
	).call_deferred()
	sprite.visible = true
	holder.held_weapon = null
	holder = null

func _physics_process(delta: float) -> void:
	if holder:
		sprite.flip_h = false
		var attack_direction: Vector2 = Input.get_vector(
		"attack_left",
		"attack_right",
		"attack_up",
		"attack_down"
	)
		if attack_direction.length() == 0:
			sprite.visible = false
			global_position = holder.global_position
		else:
			sprite.visible = true
			global_position = (
				holder.global_position + attack_direction * WEAPON_OFFSET
			)
			rotation = attack_direction.angle()
			attack(attack_direction)
	
	else:
		super(delta)
