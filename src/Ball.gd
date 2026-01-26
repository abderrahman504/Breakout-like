extends AnimatableBody2D
class_name Ball


@export var speed : float = 350
@export var move_angles : MoveAngles
var move_angle : float


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(constant_linear_velocity * delta)
	if collision != null:
		_on_collision(collision)


func _on_collision(collision : KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	var reflect_logic : ReflectLogic = $ReflectLogic
	if collider is Node:
		var collider_children = collider.get_children()
		for n in collider_children:
			if n is ReflectLogic:
				reflect_logic = n
	
	move_angle = reflect_logic.get_reflect_angle(constant_linear_velocity, collision)
	constant_linear_velocity = Vector2.from_angle(move_angle * PI/180) * speed
