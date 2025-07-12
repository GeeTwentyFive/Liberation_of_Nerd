extends Area2D


# MAKE SURE PARENT IS GameManager


const MAP = preload("res://Map/Map.tscn")


var ran := false
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if ran: return
		ran = true
		collision_mask = 0
		body.reparent(self)
		body.held_weapon.reparent(self)
		if body.held_item:
			body.held_item.reparent(self)
		var old_map = get_parent().get_node("Map")
		while old_map:
			old_map.queue_free()
			await get_tree().process_frame
		get_parent().add_child(MAP.instantiate())
		while get_parent().get_node("Map") == null:
			await get_tree().process_frame
		while get_parent().get_node("Map").get_node("Player") == null:
			await get_tree().process_frame
		var new_player = get_parent().get_node("Map").get_node("Player")
		while new_player:
			new_player.queue_free()
			await get_tree().process_frame
		while get_parent().get_node("Map").get_node("DDD") == null:
			await get_tree().process_frame
		var new_DDD = get_parent().get_node("Map").get_node("DDD")
		while new_DDD:
			new_DDD.queue_free()
			await get_tree().process_frame
		body.reparent(get_parent().get_node("Map"))
		body.held_weapon.reparent(get_parent().get_node("Map"))
		if body.held_item:
			body.held_item.reparent(get_parent().get_node("Map"))
		body.global_position = Vector2.ZERO
		await get_tree().physics_frame
		get_parent()._ready()
		queue_free()
