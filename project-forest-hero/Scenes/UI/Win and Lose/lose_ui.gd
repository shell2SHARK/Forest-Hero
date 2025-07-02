extends CanvasLayer

@onready var btnRestart : Button = %Restart_BTN
@onready var whitePanel : ColorRect = %White_Blink
@onready var sfxPlayer : AudioStreamPlayer = %UI_SFX_Player
var blink_interval := 0.1
var fade_duration := 3.0
var target_alpha := 1.0
var startGame := false

func start_button_blink():
	var tween = create_tween().set_loops()
	tween.tween_property(btnRestart, "modulate:a", 0.0, blink_interval)
	tween.tween_property(btnRestart, "modulate:a", 1.0, blink_interval)

func fade_in_background():
	var end_color = whitePanel.color
	end_color.a = target_alpha
	var tween = create_tween()
	tween.tween_property(whitePanel, "color", end_color, fade_duration)
	tween.tween_callback(on_fade_complete)

func on_fade_complete():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stage/Forest.tscn")

func _on_restart_btn_pressed() -> void:
	if(!startGame):
		start_button_blink()
		fade_in_background()
		sfxPlayer.play()
		startGame = true
