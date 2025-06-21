extends Timer


var damage := 1


func set_damage(damage: int):
	self.damage = damage
	return self


func _on_timeout() -> void:
	var parent = get_parent()
	if parent is Enemy:
		parent.hit(damage)
	else: queue_free()
