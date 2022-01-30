extends ColorRect

var scene_loader = preload('res://Scripts/SceneLoader.gd').new()
var next_scene
var exit_anim_completed

# シーン変更
func change_scene(target_path):
	scene_loader.set_target_scene(target_path)
	_start_exit_anim()

func _enter_tree():
	scene_loader.connect("_scene_loading", _on_scene_loading)
	scene_loader.connect("_loaded_scene", _on_loaded_scene)
	scene_loader.connect("_scene_load_error", _on_scene_load_error)
	# 画面表示アニメーション開始
	_start_enter_anim()

func _exit_tree():
	scene_loader.disconnect("_scene_loading", _on_scene_loading)
	scene_loader.disconnect("_loaded_scene", _on_loaded_scene)
	scene_loader.disconnect("_scene_load_error", _on_scene_load_error)

func _process(delta):
	scene_loader.process(delta)

# Enterアニメーション
func _start_enter_anim():
	# Nodeを表示する
	visible = true
	# アニメーション
	$EnterAnim.interpolate_property(
		self,
		"color",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		1,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$EnterAnim.start()

# Exitアニメーション
func _start_exit_anim():
	# Nodeを表示する
	visible = true
	# アニメーション
	$ExitAnim.interpolate_property(
		self,
		"color",
		Color(1, 1, 1, 0),
		Color(1, 1, 1, 1),
		1,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$ExitAnim.start()

# 画面遷移
func _next_scene():
	# Scene読み込み済み、アニメーション終了済みであれば画面遷移する
	if next_scene and exit_anim_completed:
		visible = false
		get_tree().change_scene_to(next_scene)

# Enterアニメーション完了処理
func _on_EnterAnim_tween_completed(object, key):
	# Nodeを非表示
	visible = false

# Exitアニメーション完了処理
func _on_ExitAnim_tween_completed(object, key):
	exit_anim_completed = true
	# 画面遷移
	_next_scene()

# ローディング中
func _on_scene_loading(p):
	# ローディング中の画面表示を更新
	print("Loading... %d" % [int(p * 100)])

# ロード完了
func _on_loaded_scene(scene):
	next_scene = scene
	# 画面遷移
	_next_scene()

# ロード失敗
func _on_scene_load_error(error_type):
	# エラーの場合の表示
	print('error:' + str(error_type))
