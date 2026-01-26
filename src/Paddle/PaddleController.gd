extends Node
class_name PaddleController


@export var paddle : Paddle

func _ready() -> void:
	if paddle == null:
		printerr("No paddle reference for ", get_path)


func _process(_delta: float) -> void:
	if paddle == null: return
	var move_dir : float = Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left")
	paddle.velocity = Vector2.RIGHT * move_dir * paddle.max_speed


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Launch Ball"):
		paddle.launch_ball()
	if Input.is_action_just_pressed("reset_level"):
		reset_level()


func reset_level() -> void:
	get_tree().reload_current_scene()
