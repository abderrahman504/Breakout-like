extends TextureRect


func _process(delta: float) -> void:
	$Label.text = str(LevelGlobals.backup_balls)
