extends AnimatableBody2D
class_name Ball


@export var speed : float = 350
@export var move_angles : MoveAngles
var move_angle : float


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(constant_linear_velocity * delta)
	if collision != null:
		#print("Ball detected collision")
		_on_collision(collision)


func _on_collision(collision : KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	var reflect_logic : ReflectLogic = $ReflectLogic
	if collider is Node:
		var collider_children = collider.get_children()
		for n in collider_children:
			if n is ReflectLogic:
				reflect_logic = n
	
	if collider is Brick:
		collider.ball_collision.emit(collision)
	set_move_angle(reflect_logic.get_reflect_angle(constant_linear_velocity, collision))



func set_move_angle(angle_radians : float) -> void:
	#print("setting move angle to ", angle_radians * 180/PI)
	move_angle = move_angles.clamp_angle_radian(angle_radians) * 180/PI
	#move_angle = angle_radians * 180/PI
	#print("post clamp angle =  ", move_angle)
	constant_linear_velocity = Vector2.from_angle(move_angle * PI/180) * speed
