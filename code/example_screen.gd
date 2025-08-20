extends Node

@export var logo: TextureRect

@export var tweens: Array[TweenBinding] = []

func _on_fade_button_pressed() -> void:
	await TweenOrchestrator.play_from(self,tweens[0].target_path, tweens[0].clip)


func _on_scale_button_pressed() -> void:
	await TweenOrchestrator.play_from(self,tweens[1].target_path, tweens[1].clip)


func _on_fade_and_scale_button_pressed() -> void:
	await TweenOrchestrator.play_from(self,tweens[2].target_path, tweens[2].clip)
