extends Node2D


const DEFAULT_HEALTH = 5000


@export var drop: Node2D = preload("res://Weapons/VibratingSharkTooth/VibratingSharkTooth.tscn").instantiate()


func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is VisibleOnScreenNotifier2D: continue
		assert(child is Enemy)
		child.health = DEFAULT_HEALTH/children.size()
		child.max_health = child.health
		child.get_node("VisibleOnScreenNotifier2D").connect("screen_entered", _on_child_enabled)

func _on_child_enabled() -> void:
	for child in get_children():
		child.process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(delta: float) -> void:
	if get_children().is_empty():
		get_parent().add_child(drop)
		queue_free()
	
	else: drop.global_position = get_child(0).global_position
