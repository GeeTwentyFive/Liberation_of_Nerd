extends Node


func _input(event: InputEvent) -> void:
	for action in InputMap.get_actions():
		if event.is_action_pressed(action):
			match action:
				"restart": get_tree().reload_current_scene()
				"quit": get_tree().quit()


func _init() -> void:
	Engine.max_fps = DisplayServer.screen_get_refresh_rate() * 2

func _ready() -> void:
	var player: Player = $Map/Player
	
	player.hit.connect(get_tree().reload_current_scene)
	
	for node in $Map.get_children():
		if node is Enemy:
			node.process_mode = Node.PROCESS_MODE_DISABLED
			node.target = player
