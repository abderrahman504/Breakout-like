extends ReflectLogic
class_name PaddleReflectLogic
## Custom reflection logic for collision with the Paddle.

@export var paddle : Paddle


func _ready() -> void:
	if paddle == null:
		printerr("Paddle not set for ", get_path())


func get_reflect_angle(impact : Vector2, collision : KinematicCollision2D) -> float:
	if paddle == null:
		return 0
	
	var mirrored_angle = impact.bounce(collision.get_normal()).angle()

	var clamped_angle = paddle.launch_angles.clamp_angle_degrees(mirrored_angle * 180/PI)
	# If paddle is stationary then return clamped angle
	# But if it's moving then the adjacent clamped angle from the launch angles list
	if paddle.velocity == Vector2.ZERO:
		return clamped_angle * PI/180
	else:
		var angle_idx = paddle.launch_angles.movement_angles.find(clamped_angle)
		var count = paddle.launch_angles.movement_angles.size()
		if paddle.velocity.x < 0: # Moving left
			return paddle.launch_angles.movement_angles[min(count-1, angle_idx+1)] * PI/180
		else: # Moving right
			return paddle.launch_angles.movement_angles[max(angle_idx-1, 0)] * PI/180
