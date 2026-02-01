extends Node
class_name ReflectLogic

## Used to determine the reflection angle of a body when it collides with the parent body of this logic.
## Simply mirrors the reflection vector.

## Returns the reflect angle for the colliding body to use in radians. 
## [code]collision[/code] is the collision information from the colliding body.
func get_reflect_angle(impact : Vector2, collision : KinematicCollision2D) -> float:
	var norm = collision.get_normal()
	# Clamp the norm to the closest cardinal direction
	var closest : Vector2 = Vector2.LEFT
	print("Unclamped norm = ", norm)
	if norm.dot(Vector2.UP) > norm.dot(closest):
		closest = Vector2.UP
	if norm.dot(Vector2.RIGHT) > norm.dot(closest):
		closest = Vector2.RIGHT
	if norm.dot(Vector2.DOWN) > norm.dot(closest):
		closest = Vector2.DOWN
	
	norm = closest
	print("Clamped norm = ", norm)
	var reflect_angle = impact.bounce(norm).angle()
	return reflect_angle
