extends Node
class_name ReflectLogic

## Used to determine the reflection angle of a body when it collides with the parent body of this logic.
## Simply mirrors the reflection vector.

## Returns the reflect angle for the colliding body to use in radians. 
## [code]collision[/code] is the collision information from the colliding body.
func get_reflect_angle(impact : Vector2, collision : KinematicCollision2D) -> float:
	var norm = collision.get_normal()
	var reflect_angle = impact.bounce(norm).angle()
	return reflect_angle
