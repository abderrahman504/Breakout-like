extends CharacterBody2D
class_name Paddle

@export var max_speed : float = 350
var _ball_slotted : bool = false
@export var launch_angles : MoveAngles


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func launch_ball() -> void:
	if not _ball_slotted:
		return
	_ball_slotted = false
	var ball : Ball = $BallLaunchSpot/Ball
	ball.reparent(get_parent())
	var angle : float
	if velocity == Vector2.ZERO:
		angle = launch_angles.movement_angles[1] if randf() < .5 else launch_angles.movement_angles[2]
	else:
		angle = launch_angles.movement_angles[0] if velocity.x > 0 else launch_angles.movement_angles[3]
	ball.set_move_angle(angle * PI/180)
	ball.constant_linear_velocity = Vector2.from_angle(angle * PI/180) * ball.speed
