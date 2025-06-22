class_name Enemy
extends Entity


var move_speed := 100.0
var health := 40:
	set(x):
		$HealthBar.value = x
		health = x


var target: Node2D
var max_health: int


func move():
	pass # Override & implement

func die():
	queue_free()
	pass # Optionally override & implement
		# (for like dropping items & stuff)


func _ready() -> void:
	max_health = health

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func is_on_screen():
	return $VisibleOnScreenNotifier2D.is_on_screen()

# I have to do it like this because
# UI elements are asynchronously loaded
# *after* _ready(), even .call_deferred()
# is too early...
var _initialized := false
func _process(delta: float) -> void:
	if not _initialized:
		$HealthBar.max_value = health
		$HealthBar.value = health
		_initialized = true

func hit(damage: int):
	health -= damage
	if health < 0:
		die()

func _physics_process(delta: float) -> void:
	if target:
		move()
		super(delta)
