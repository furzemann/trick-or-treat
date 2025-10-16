extends AudioStreamPlayer

@export var _theme_dictionary : Dictionary[String, AudioStream]

var _set_volume := 0.

func play_theme(theme_name : String = "level theme", volume := 0.):
	if _theme_dictionary.has(theme_name):
		switch_track(_theme_dictionary[theme_name], volume)
		_set_volume = volume
		
func pause_theme(pause_volume := -10.):
	volume_db = pause_volume

func resume_theme():
	volume_db = _set_volume

func switch_track(track : AudioStream, volume := 0.):
	if stream == track:
		return
	stream = track
	volume_db = volume
	set_playing(true)
