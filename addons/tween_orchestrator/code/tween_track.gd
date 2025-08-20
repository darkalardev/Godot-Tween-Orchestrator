extends Resource
class_name TweenTrack

@export_group("Core")

## [b]Property[/b] to animate on the target. Use the same key you'd pass to [code]set()[/code] (e.g. "modulate", "scale", "position").
@export var property: StringName

## [b]Final value[/b] applied at the end of this track. Must match the property's type (e.g. Color for "modulate", Vector2 for "scale").
@export var to: Variant

## [b]Duration[/b] in seconds. If 0, the value is applied immediately without creating a tween.
@export var duration: float = 0.3

## [b]Transition[/b] curve shape (e.g. LINEAR, CUBIC, EXPO, BACK).
@export var trans: Tween.TransitionType = Tween.TRANS_CUBIC

## [b]Ease[/b] direction (IN, OUT, IN_OUT, OUT_IN).
@export var ease: Tween.EaseType = Tween.EASE_OUT


@export_group("Timing & Flow")

## [b]Wait[/b] time in seconds before starting this track.
@export var wait_before: float = 0.0

## Run this track [b]in parallel[/b] with other parallel tracks in the same batch.
@export var parallel: bool = false


@export_group("Finish Actions")

## If true and target is a [i]CanvasItem[/i], call [code]hide()[/code] when this track finishes.
@export var hide_on_finish: bool = false