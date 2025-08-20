extends Node

const TweenTrack = preload("res://addons/tween_orchestrator/code/tween_track.gd")
const TweenClip = preload("res://addons/tween_orchestrator/code/tween_clip.gd")

var _running_for := {}

func _ensure_bucket(target: Object) -> void:
	if not _running_for.has(target):
		_running_for[target] = []

func playing_for(target: Object) -> bool:
	return _running_for.has(target) and _running_for[target].size() > 0

func stop(target: Object) -> void:
	if not _running_for.has(target):
		return
	for t in _running_for[target]:
		if t:
			t.kill()
	_running_for[target].clear()

func _apply_overrides(track: TweenTrack, overrides: Dictionary, index: int) -> TweenTrack:
	if overrides.is_empty():
		return track
	var clone := track.duplicate(true) as TweenTrack
	for k in ["property", "to", "duration", "trans", "ease", "wait_before", "parallel", "hide_on_finish"]:
		if overrides.has(k):
			clone.set(k, overrides[k])
	if overrides.has(index) and overrides[index] is Dictionary:
		for k in overrides[index].keys():
			clone.set(k, overrides[index][k])
	return clone

func _run_batch_parallel(target: Object, batch: Array[TweenTrack]) -> void:
	if batch.is_empty():
		return
	var t := (target as Node).create_tween().set_parallel(true)
	_running_for[target].append(t)
	for tr in batch:
		if is_equal_approx(tr.duration, 0.0):
			target.set(tr.property, tr.to)
		else:
			t.tween_property(target, str(tr.property), tr.to, tr.duration).set_trans(tr.trans).set_ease(tr.ease)
		if tr.hide_on_finish and target is CanvasItem:
			t.tween_callback(Callable(target, "hide"))
	await t.finished
	_running_for[target].erase(t)

func play(target: Object, clip: TweenClip, overrides: Dictionary = {}) -> void:
	if not is_instance_valid(target):
		return
	if clip == null:
		return
	_ensure_bucket(target)
	var batch: Array[TweenTrack] = []
	for i in clip.tracks.size():
		var raw := clip.tracks[i]
		if raw == null:
			continue
		var tr: TweenTrack = _apply_overrides(raw, overrides, i)
		if tr.wait_before > 0.0:
			await _run_batch_parallel(target, batch)
			batch.clear()
			await (target as Node).get_tree().create_timer(tr.wait_before).timeout
		if tr.parallel:
			batch.append(tr)
		else:
			await _run_batch_parallel(target, batch)
			batch.clear()
			if is_equal_approx(tr.duration, 0.0):
				target.set(tr.property, tr.to)
				if tr.hide_on_finish and target is CanvasItem:
					(target as CanvasItem).hide()
			else:
				var t := (target as Node).create_tween()
				_running_for[target].append(t)
				t.tween_property(target, str(tr.property), tr.to, tr.duration).set_trans(tr.trans).set_ease(tr.ease)
				if tr.hide_on_finish and target is CanvasItem:
					t.tween_callback(Callable(target, "hide"))
				await t.finished
				_running_for[target].erase(t)
	await _run_batch_parallel(target, batch)
	batch.clear()

func play_from(owner: Node, target_path: NodePath, clip: TweenClip, overrides: Dictionary = {}) -> void:
	if owner == null or target_path == NodePath("") or clip == null:
		return
	var target := owner.get_node_or_null(target_path)
	if not is_instance_valid(target):
		return
	await play(target, clip, overrides)
