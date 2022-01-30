extends Node

# 読込進捗通知シグナル
signal _scene_loading(percent)
# 読込完了シグナル
signal _loaded_scene(scene)
# 読込失敗シグナル
signal _scene_load_error

# ローディング実行時間
const limit_msec = 100
# ローダー
var loader
# 読み込み完了
var finished = false

# 対象シーンパス設定
func set_target_scene(path):
	# ローダー作成
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		return FAILED
	return OK

# ローディング処理
func process(delta):
	if loader == null || finished:
		return
	var time = OS.get_ticks_msec()
	while OS.get_ticks_msec() < time + limit_msec:
		var ret = loader.poll()
		if ret == OK:
			# 読み込み実行
			continue
		elif ret == ERR_FILE_EOF:
			# 読み込み完了
			finished = true
			emit_signal('_loaded_scene', loader.get_resource())
			return
		else:
			# 読み込み失敗
			emit_signal('_scene_load_error')
			loader = null
			return
	# 進捗通知
	var p = float(loader.get_stage() + 1) / float(loader.get_stage_count())
	emit_signal('_scene_loading', p)
