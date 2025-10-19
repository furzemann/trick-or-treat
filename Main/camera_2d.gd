extends Camera2D
class_name SceneCamera

func _ready() -> void:
	GameState.scene_camera = self

func shake(intensity: float = 8.0, duration: float = 0.3):
	var tween := create_tween()
	var original_offset := offset
	
	tween.tween_method(
		func(delta):
			offset = original_offset + Vector2(
				randf_range(-intensity, intensity),
				randf_range(-intensity, intensity)
			)
	, 0.0, 1.0, duration)
	
	tween.finished.connect(func(): offset = original_offset)
