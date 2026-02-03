extends Node2D
class_name Level

## Number of backup balls in the level
@export var _backup_count : int = 3


func _init() -> void:
	LevelGlobals.level = self
	LevelGlobals.backup_balls = _backup_count


func _ready() -> void:
	BallSignalBus.ball_destroyed.connect(_on_ball_destroyed)
	recall_backup_ball()
	


func reset_level() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_all_bricks_destroyed() -> void:
	$UILayer/UI/Success.show()
	get_tree().paused = true


func _on_out_of_bounds_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.destroy()


func _on_ball_destroyed(_ball : Ball) -> void:
	if LevelGlobals.balls.is_empty():
		_on_all_active_balls_lost()


## Called when all balls that are active in the level are gone. Either recalls a backup ball or ends the level
func _on_all_active_balls_lost() -> void:
	if LevelGlobals.backup_balls > 0:
		await get_tree().create_timer(0.5).timeout
		recall_backup_ball()
	else:
		_on_all_balls_lost()


func recall_backup_ball() -> void:
	LevelGlobals.backup_balls -= 1
	var ball := BallObjectPool.get_ball_object()
	add_child(ball)
	$SlotBallToPaddle.slot_ball(ball)


## Called when all active and backup balls have been spent.
func _on_all_balls_lost() -> void:
	$UILayer/UI/Failure.show()
	get_tree().paused = true
