extends Item


const PASSIVE_DAMAGE_MULTIPLIER = 1.1
const USE_DAMAGE_MULTIPLIER = 10
const ACTIVATED_ALPHA = 0.5


var used: bool = false


func apply_passive():
	holder.attack_damage_multiplier *= PASSIVE_DAMAGE_MULTIPLIER

func remove_passive():
	holder.attack_damage_multiplier /= PASSIVE_DAMAGE_MULTIPLIER

func use():
	if used: return
	sprite.modulate.a = ACTIVATED_ALPHA
	sprite.scale *= 2
	holder.held_item = null
	holder.attack_damage_multiplier *= USE_DAMAGE_MULTIPLIER
	holder.attacked.connect(
		func():
			holder.attack_damage_multiplier /= USE_DAMAGE_MULTIPLIER
			remove_passive()
			super.use()
	)
	used = true

func drop():
	pass # Not droppable
