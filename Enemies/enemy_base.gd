class_name Enemy
extends Entity


var target: Node2D
var move_speed: float = 100
var health: int = 40:
	set(x):
		$HealthBar.value = x
		health = x


func move():
	pass # Override & implement

func die():
	queue_free()
	pass # Optionally override & implement
		# For like dropping items & stuff


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func is_on_screen():
	return $VisibleOnScreenNotifier2D.is_on_screen()

func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health

func hit(damage: int):
	health -= damage
	if health < 0:
		die()

func _physics_process(delta: float) -> void:
	if target:
		move()
		super(delta)
