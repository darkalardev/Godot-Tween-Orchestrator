@tool
extends EditorPlugin

const AUTOLOAD_NAME := "TweenOrchestrator"
const AUTOLOAD_PATH := "res://addons/tween_orchestrator/code/tween_orchestrator.gd"
const ADDON_ICON := "res://addons/tween_orchestrator/icon.png"

var icons := {}

func _enable_plugin() -> void:
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)

func _disable_plugin() -> void:
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)

func _enter_tree() -> void:
	icons.default = load(ADDON_ICON)

	add_custom_type(
		"TweenBinding",
		"Resource",
		load("res://addons/tween_orchestrator/code/tween_binding.gd"),
		icons.default
	)

	add_custom_type(
		"TweenClip",
		"Resource",
		load("res://addons/tween_orchestrator/code/tween_clip.gd"),
		icons.default
	)

	add_custom_type(
		"TweenTrack",
		"Resource",
		load("res://addons/tween_orchestrator/code/tween_track.gd"),
		icons.default
	)

func _exit_tree() -> void:
	remove_custom_type("TweenBinding")
	remove_custom_type("TweenClip")
	remove_custom_type("TweenTrack")