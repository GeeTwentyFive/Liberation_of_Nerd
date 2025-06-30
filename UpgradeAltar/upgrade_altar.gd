extends Node2D

# If body on Pad1 and another body on Pad2:
#	Call ".queue_free()" on Pad2 body
#	Call "<upgrade_method>()" on Pad1 body

@export_flags_2d_physics var pad1_target_mask := 64
@export_flags_2d_physics var pad2_target_mask := 64
@export var upgrade_method := "upgrade"


const IMG_PAD_ACTIVE = preload("assets/pad_active.png")
const IMG_PAD_INACTIVE = preload("assets/pad_inactive.png")
const FLASH = preload("res://_MODULES_/Flash/Flash.tscn")


func _ready() -> void:
	$Pad1.collision_mask = pad1_target_mask
	$Pad2.collision_mask = pad2_target_mask

func _on_pad_1_body_entered(body: Node2D) -> void:
	if not body.has_method(upgrade_method): return
	$Pad1/Sprite2D.texture = IMG_PAD_ACTIVE

func _on_pad_1_body_exited(body: Node2D) -> void:
	var has_upgradeable := false
	for _body in $Pad1.get_overlapping_bodies():
		if _body.has_method(upgrade_method):
			has_upgradeable = true
	if not has_upgradeable:
		$Pad1/Sprite2D.texture = IMG_PAD_INACTIVE

func _on_pad_2_body_entered(body: Node2D) -> void:
	$Pad2/Sprite2D.texture = IMG_PAD_ACTIVE

func _on_pad_2_body_exited(body: Node2D) -> void:
	if $Pad2.get_overlapping_bodies().is_empty():
		$Pad2/Sprite2D.texture = IMG_PAD_INACTIVE

func _on_pad_body_entered(body: Node2D) -> void:
	var pad1_bodies = $Pad1.get_overlapping_bodies()
	var pad2_bodies = $Pad2.get_overlapping_bodies()
	if pad1_bodies.size() != 1: return
	if pad2_bodies.size() != 1: return
	if not pad1_bodies[0].has_method(upgrade_method): return
	pad1_bodies[0].call_deferred(upgrade_method)
	pad1_bodies[0].add_child(FLASH.instantiate())
	pad2_bodies[0].queue_free()
	queue_free()
