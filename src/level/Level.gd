extends Node2D
class_name Level


func _init() -> void:
	LevelGlobals.level = self


func _ready() -> void:
	BallSignalBus.ball_destroyed.connect(_on_ball_destroyed)


func reset_level() -> void:
	get_tree().reload_current_scene()


func _on_all_bricks_destroyed() -> void:
	$UILayer/Control/Success.show()
	get_tree().paused = true


func _on_out_of_bounds_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.destroy()


func _on_ball_destroyed(_ball : Ball) -> void:
	if LevelGlobals.balls.is_empty():
		_on_all_balls_lost()


func _on_all_balls_lost() -> void:
	$UILayer/Control/Failure.show()
	get_tree().paused = true
