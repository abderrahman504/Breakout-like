extends CharacterBody2D
class_name Paddle

@export var max_speed : float = 350
var _ball_launched : bool = false
@export var launch_angles : MoveAngles


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func launch_ball() -> void:
	if _ball_launched:
		return
	_ball_launched = true
	var ball : Ball = $BallLaunchSpot/Ball
	var glob_pos = ball.global_position
	ball.reparent(get_parent())
	ball.set_deferred("global_position", glob_pos)
	var angle : float
	if velocity == Vector2.ZERO:
		angle = launch_angles.movement_angles[1] if randf() < .5 else launch_angles.movement_angles[2]
	else:
		angle = launch_angles.movement_angles[0] if velocity.x > 0 else launch_angles.movement_angles[3]
	ball.set_move_angle(angle * PI/180)
	ball.constant_linear_velocity = Vector2.from_angle(angle * PI/180) * ball.speed
