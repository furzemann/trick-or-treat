extends Node

@export var sfx: Dictionary[String, AudioStream]
@export var random_characters_sound: Array[AudioStream] = []
@export var singing_sfx: Array[AudioStream] = []

var active_players: Array[AudioStreamPlayer] = []

func play_sfx(sfx_name: String, volume_db: float = 0.0, randomised_pitch: bool = false, pitch:=randf_range(0.8,1.2) , playback_start: float = 0.0, playback_end:= sfx[sfx_name].get_length()) -> void:
	if not sfx.has(sfx_name):
		push_warning("SFXManager: Sound not found - " + sfx_name)
		return

	var stream: AudioStream = sfx[sfx_name]
	if stream == null:
		push_warning("SFXManager: Null stream for name - " + sfx_name)
		return

	_play_stream(stream, volume_db, randomised_pitch, pitch, playback_start, playback_end)


func random_npc_sounds(randomised_pitch: bool = false, volume_db: float = 0.0, pitch := randf_range(0.5,1.5)) -> void:
	if random_characters_sound.is_empty():
		push_warning("SFXManager: 'random_characters_sound' array is empty!")
		return

	var stream: AudioStream = random_characters_sound.pick_random()
	if stream == null:
		push_warning("SFXManager: Null stream in 'random_characters_sound'!")
		return

	_play_stream(stream, volume_db, randomised_pitch, pitch)

func sing(randomised_pitch:bool = false, volume_db: float = 0.0, pitch:= randf_range(0.8,1.2), playback_start:= 0.0, playback_end:= 300.0) -> void:
	if singing_sfx.is_empty():
		push_warning("SFXManager: 'singing_sfx' array is empty!")
		return
	var stream: AudioStream = singing_sfx.pick_random()
	if stream == null:
		push_warning("SFXManager: Null stream in 'random_characters_sound'!")
		return

	_play_stream(stream, volume_db, randomised_pitch, pitch,playback_start, playback_end)
	
func _play_stream(stream: AudioStream, volume_db: float, randomised_pitch: bool, pitch:=randf_range(0.8,1.2), playback_start: float = 0.0, playback_end := stream.get_length()) -> void:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch if randomised_pitch else 1.0

	add_child(player)
	player.play(playback_start)
	if playback_end > 0.0:
		var duration = playback_end - playback_start
		if duration > 0.0:
			await get_tree().create_timer(duration).timeout
			if is_instance_valid(player):
				player.stop()

	player.finished.connect(func():
		active_players.erase(player)
		player.queue_free()
	)
	active_players.append(player)
