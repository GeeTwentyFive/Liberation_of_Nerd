extends Enemy


@export var drop := preload(
	"res://Weapons/VibratingSharkTooth/VibratingSharkTooth.tscn"
).instantiate()


var sharkteeth: Array[Sharktooth] = []


func _ready() -> void:
	for node in get_children():
		if node is Sharktooth:
			sharkteeth.append(node)
			await get_tree().process_frame
			await get_tree().process_frame
			node.target = target

func _physics_process(delta: float) -> void:
	for sharktooth in sharkteeth:
		if sharktooth == null: continue
		drop.global_position = sharktooth.global_position
		return
	
	# Only reached if all sharkteeth are null
	get_parent().add_child(drop)
