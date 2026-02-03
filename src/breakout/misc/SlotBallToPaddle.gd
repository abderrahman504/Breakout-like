extends Node
class_name SlotBallToPaddle

## Animated a ball to be slotted to the paddle.
@export var animation_length : float = 1
@export var paddle : Paddle
@onready var start_pos : Vector2 = $Start.position
@onready var max_y : float = $MaxY.position.y
var dest_node : Node2D

var _timer := 0.
var _queue : Array[Ball]

func _ready() -> void:
	dest_node = paddle.get_node("BallLaunchSpot")


func _physics_process(delta : float) -> void:
	if _queue.is_empty(): 
		return
	_timer = min(_timer + delta, animation_length)
	# Animate x coord linearly
	_queue[0].global_position.x = lerp(_queue[0].global_position.x, dest_node.global_position.x, _timer / animation_length)
	
	# Animate y with a two step process, using inverted parabola for first half and squared cosine for the last.
	var T1 := animation_length * 0.4
	var T2 = animation_length - T1
	if _timer < T1:
		# Parabolic
		_queue[0].global_position.y = 2*(max_y-start_pos.y)*_timer/T1 - (max_y-start_pos.y)*pow(_timer/T1,2) + start_pos.y
	elif _timer < animation_length:
		# Cosinal
		_queue[0].global_position.y = pow(cos((_timer-T1)*PI/2/T2), 2) * (max_y-dest_node.global_position.y) + dest_node.global_position.y
	else:
		# Finish
		paddle._ball_slotted = true
		_timer = 0
		_queue[0].reparent(dest_node)
		_queue[0].process_mode = Node.PROCESS_MODE_INHERIT
		_queue[0].trail.disabled = false
		_queue.pop_front()


## Plays an animation of slotting the ball to the paddle. Paddle must not have a slotted ball for this to work.
func slot_ball(ball : Ball) -> void:
	ball.trail.disabled = true
	ball.process_mode = Node.PROCESS_MODE_DISABLED
	_queue.append(ball)
	ball.global_position = start_pos
	_timer = 0
	
