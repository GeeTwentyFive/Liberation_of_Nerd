extends Item


const USE_ENEMY_SPEED_MULTIPLIER = 0.01
const ACTIVATED_ALPHA = 0.5


var activated_enemies: Array[Enemy] = []


func apply_passive():
	for node in get_parent().get_children():
		if node is Enemy:
			node.process_mode = Node.PROCESS_MODE_INHERIT
			activated_enemies.append(node)

func remove_passive():
	for enemy in activated_enemies:
		if enemy: # Check if still exists
			if not enemy.is_on_screen():
				enemy.process_mode = Node.PROCESS_MODE_DISABLED

func use():
	if $EnemyFreezeTimer.is_stopped():
		super()
		sprite.modulate.a = ACTIVATED_ALPHA
		sprite.scale *= 2
		holder.held_item = null
		for enemy in activated_enemies:
			enemy.move_speed *= USE_ENEMY_SPEED_MULTIPLIER
		$EnemyFreezeTimer.connect(
			"timeout",
			func():
				for enemy in activated_enemies:
					if enemy: # Check if still exists
						enemy.move_speed /= USE_ENEMY_SPEED_MULTIPLIER
				delete()
		)
		$EnemyFreezeTimer.start()
