extends Enemy


const DEFAULT_MOVE_SPEED = 50
const DEFAULT_HEALTH = 100
const HEAL_AREA = preload("res://_MODULES_/HealArea/HealArea.tscn")


var heal_target: Enemy = null


func _ready() -> void:
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	super()

func move():
	if not heal_target:
		for node in get_parent().get_children():
			if node == self: continue
			if node is Enemy and node.process_mode != PROCESS_MODE_DISABLED:
				heal_target = node
	
	if heal_target:
		apply_central_force(
			(heal_target.position - position).normalized() *
			move_speed
		)
	else: # If no heal target: move away from player
		apply_central_force(
			(position - target.position).normalized() *
			move_speed
		)

func _on_heal_timer_timeout() -> void:
	get_parent().add_child(
		HEAL_AREA.instantiate()
		.set_heal_target_collision_mask(16)
		.set_heal_position(global_position)
	)
