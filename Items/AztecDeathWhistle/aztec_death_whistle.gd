extends Item


const PASSIVE_DAMAGE_MULTIPLIER = 2.0
const USE_ENEMY_SPEED_MULTIPLIER = 0.01
const FLASH = preload("AztecDeathWhistleFlash.tscn")
const BLEED = preload("AztecDeathWhistleBleed.tscn")


func apply_passive():
	holder.attack_damage_multiplier *= PASSIVE_DAMAGE_MULTIPLIER

func remove_passive():
	holder.attack_damage_multiplier *= PASSIVE_DAMAGE_MULTIPLIER

func use():
	super()
	for node in get_parent().get_children():
		if (
			node is Enemy
		) and (
			node.process_mode != PROCESS_MODE_DISABLED
		):
			node.move_speed *= USE_ENEMY_SPEED_MULTIPLIER
			node.add_child(BLEED.instantiate())
	holder.add_child(FLASH.instantiate())
	delete()
