extends Timer

# On timeout: call <damage_method>(damage) on parent

var damage_method := "hit"
var damage := 1


func set_damage(damage: int):
	self.damage = damage
	return self


func _on_timeout() -> void:
	var parent = get_parent()
	if parent.has_method(damage_method):
		parent.call_deferred(damage_method, damage)
	else: queue_free()
