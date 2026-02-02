#@tool
extends Line2D
class_name Trail

@export var trailing : Node2D
@export var trail_speed : float = 100
var disabled : bool:
	get:
		return disabled
	set(val):
		disabled = val
		if val:
			hide()
		else:
			show()
			for i in range(points.size()):
				points[i] = trailing.global_position


func _ready() -> void:
	disabled = false


func _process(delta: float) -> void:
	_update(delta)


func _update(delta : float) -> void:
	if trailing == null or points.size() < 2:
		return
	for i in range(points.size()-1, 0, -1):
		var weight : float = (points[i] - points[i-1]).length() * trail_speed * delta
		points[i] =  points[i].move_toward(points[i-1], weight)
	points[0] = trailing.global_position
