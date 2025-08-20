## 🛠️ Usage

1. Create a list of **TweenBinding**:  

```gdscript
@export var tweens: Array[TweenBinding] = []
```

2. Add the target (UI, Node3D, etc) and create clips.

3. You can call it like this:

```gdscript
await TweenOrchestrator.play_from(self, tweens[0].target_path, tweens[0].clip)
```

♻️ Reusing Tween Bindings

You can also create the TweenBinding as a Resource file, allowing you to reuse the same animation across multiple scenes or nodes.

🎮 Example Scene

You can find an example scene here:
👉 https://github.com/darkalardev/Godot-Tween-Orchestrator
