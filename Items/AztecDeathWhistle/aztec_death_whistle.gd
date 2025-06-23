extends Item


const FLASH = preload("res://_MODULES_/Flash/Flash.tscn")
const BLEED = preload("res://_MODULES_/Bleed/Bleed.tscn")


var passive_damage_multiplier := 2.0
var use_enemy_speed_multiplier := 0.01


func apply_passive():
	holder.attack_damage_multiplier += passive_damage_multiplier
	super()

func remove_passive():
	holder.attack_damage_multiplier -= passive_damage_multiplier
	super()

func use():
	super()
	for node in get_parent().get_children():
		if (
			node is Enemy
		) and (
			node.process_mode != PROCESS_MODE_DISABLED
		):
			node.move_speed *= use_enemy_speed_multiplier
			node.add_child(BLEED.instantiate())
	holder.add_child(FLASH.instantiate())
	delete()

func upgrade():
	passive_damage_multiplier *= UPGRADE_MULTIPLIER
	super()
