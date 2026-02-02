extends Node

# Singleton script

var _ball_scene : PackedScene = preload("res://scenes/ball.tscn")

var _unused_pool : Dictionary[RID, Ball]
var _queue : Array[Ball]
var _used_balls : Dictionary[RID, Ball]


## Returns a previously unused ball object by claiming it from the object pool or instantiating it.
func get_ball_object() -> Ball:
	var ball : Ball = _ball_scene.instantiate()
	#if _unused_pool.is_empty():
	#	ball = _ball_scene.instantiate()
	#else:
	#	ball = _queue.pop_back()
	#	_unused_pool.erase(ball.get_rid())
	#_used_balls[ball.get_rid()] = ball
	return ball


## Returns the given ball to the object pool and returns true, or returns false if the ball is unused.
func destroy_ball(ball : Ball) -> bool:
	ball.queue_free()
	#var rid : RID = ball.get_rid()
	#if _unused_pool.has(rid): 
	#	printerr("Trying to destroy ball in unused pool")
	#	return false
	#if ball.get_parent() == null:
	#	push_warning("Trying to destroy a ball that isn't in the tree")
	#else:
	#	ball.get_parent().remove_child(ball)
	
	#_unused_pool[ball.get_rid()] = ball
	#_queue.append(ball)
	#if _used_balls.has(rid):
	#	push_warning("Ball Pool encountered unregistered ball. Adding to pool")
	#	_used_balls.erase(rid)
	return true
