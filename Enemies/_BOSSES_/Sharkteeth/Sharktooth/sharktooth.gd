extends Enemy


func move():
	global_rotation = (
		target.global_position - global_position
	).angle()
	
	$Lunger.target_position = target.global_position
