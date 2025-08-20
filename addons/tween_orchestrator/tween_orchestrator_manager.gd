@tool
extends EditorPlugin

const AUTOLOAD_NAME := "TweenOrchestrator"
const AUTOLOAD_PATH := "res://addons/tween_orchestrator/code/tween_orchestrator.gd"

func _enable_plugin() -> void:
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)

func _disable_plugin() -> void:
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)