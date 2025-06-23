extends Item


const ACTIVATED_ALPHA = 0.5


var use_immune_time := 5.0


func apply_passive():
	var player_hurt_collider: Area2D = holder.get_node("HurtCollider")
	player_hurt_collider.disconnect(
		"body_entered",
		holder._on_hurt_collider_body_entered
	)
	player_hurt_collider.connect(
		"body_entered",
		_on_player_hit
	)
	super()

func remove_passive():
	var player_hurt_collider: Area2D = holder.get_node("HurtCollider")
	player_hurt_collider.disconnect(
		"body_entered",
		_on_player_hit
	)
	player_hurt_collider.connect(
		"body_entered",
		holder._on_hurt_collider_body_entered
	)
	super()

func use():
	if $ImmunityTimer.is_stopped():
		super()
		sprite.modulate.a = ACTIVATED_ALPHA
		sprite.scale *= 2
		holder.held_item = null
		$ImmunityTimer.connect("timeout", delete)
		$ImmunityTimer.start(use_immune_time)

func upgrade():
	$ImmunityTimer.wait_time *= UPGRADE_MULTIPLIER
	use_immune_time *= UPGRADE_MULTIPLIER
	super()

func _on_player_hit(body: Node2D) -> void:
	if $ImmunityTimer.is_stopped():
		sprite.modulate.a = ACTIVATED_ALPHA
		if body is Enemy:
			body.apply_central_impulse(-body.linear_velocity)
		$ImmunityTimer.connect("timeout", delete)
		$ImmunityTimer.start()
