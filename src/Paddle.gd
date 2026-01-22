extends AnimatableBody2D
class_name Paddle



func _physics_process(delta: float) -> void:
	position += constant_linear_velocity * delta
