extends Node2D
class_name BricksManager

signal all_bricks_destroyed


var _cracks : Dictionary[Vector2i, TileMapLayer]
var _bricks : Dictionary[Vector2i, Brick]

@onready var _brick_layer : TileMapLayer = $BrickLayer
var _brick_scene : PackedScene = load("res://scenes/brick.tscn")


func _ready() -> void:
	for layer : TileMapLayer in $CrackingLayer.get_children():
		layer.clear()
	# Replace tiles in BrickLayer with brick instances.
	for i in _brick_layer.get_used_cells():
		_bricks[i] = _brick_scene.instantiate()
		_bricks[i].position = 0.5*_brick_layer.tile_set.tile_size + _brick_layer.tile_set.tile_size * i * 1.
		add_child(_bricks[i])
		_bricks[i].ball_collision.connect(_on_ball_collision.bind(_bricks[i]))
	_brick_layer.clear()


func _on_ball_collision(_collision : KinematicCollision2D, brick : Brick) -> void:
	var tile : Vector2i = _bricks.find_key(brick)
	if _cracks.has(tile):
		destroy_brick(tile)
	else:
		crack_brick(tile)


func destroy_brick(tile : Vector2i) -> void:
	if _cracks.has(tile):
		_cracks[tile].erase_cell(tile)
		_cracks.erase(tile)
	_bricks[tile].queue_free()
	_bricks.erase(tile)
	if _bricks.is_empty():
		all_bricks_destroyed.emit()


func crack_brick(tile : Vector2i) -> void:
	_cracks[tile] = $CrackingLayer.get_child(randi_range(0,$CrackingLayer.get_child_count()-1))
	_cracks[tile].set_cell(tile, 0, Vector2i(0,0))
