extends CharacterBody2D
class_name Paddle

@export var max_speed : float = 350
var _ball_launched : bool = false


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func launch_ball() -> void:
	_ball_launched = true
	var ball : Ball = $BallLaunchSpot/Ball
	var glob_pos = ball.global_position
	ball.reparent(get_parent())
	ball.set_deferred("global_position", glob_pos)
	var angle = -90 + (45 * sign(randf()-.5))
	ball.move_angle = angle
	ball.constant_linear_velocity = Vector2.from_angle(angle * PI/180) * ball.speed
