extends Item


const ACTIVATED_ALPHA = 0.5


var passive_damage_multiplier := 1.1
var use_damage_multiplier := 10.0


func apply_passive():
	holder.attack_damage_multiplier += passive_damage_multiplier
	super()

func remove_passive():
	holder.attack_damage_multiplier -= passive_damage_multiplier
	super()

func use():
	if used: return
	super()
	sprite.modulate.a = ACTIVATED_ALPHA
	sprite.scale *= 2
	holder.held_item = null
	holder.attack_damage_multiplier += use_damage_multiplier
	holder.attacked.connect(
		func():
			holder.attack_damage_multiplier -= use_damage_multiplier
			remove_passive()
			delete()
	)

func upgrade():
	passive_damage_multiplier *= UPGRADE_MULTIPLIER
	use_damage_multiplier *= UPGRADE_MULTIPLIER
	super()

func drop():
	pass # Not droppable
