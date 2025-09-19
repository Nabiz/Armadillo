extends Timer
class_name CooldownTimer

var on_cooldown: bool = false

func _ready() -> void:
	one_shot = true
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	on_cooldown = false

func start_cooldown() -> void:
	on_cooldown = true
	start()
