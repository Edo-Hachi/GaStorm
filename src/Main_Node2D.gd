#GameMain_Node2D

#スコア加算
#スコア保存
#取得スコアの表示アニメーション

#出現ループ時の緑は10点、赤は300点とかにする
#隊列に整列時の緑は50点、赤は100点
#攻撃中は隊列時の二倍とか


#敵の弾発射(将来的な弾幕系の実装も視野に)
#敵の攻撃（下に降りてくる　）


#メニューのStartとQuitをコントローラーで選べるように

#2,3,4面くらいはつくってみよう
#4面は中ボス戦（バックスクロール） 中ボス＋エネミーの波状攻撃

#エネミーのループ出現位置に星を出す




#10面分の雛形を作る
#ボスはタイムアタック式で。早いほどスコアが高くなる。
#エネミーの攻撃中はスコア2倍


#音
#BGM
#自機の移動処理をkineticに変更

#==========================================
#Finish Task
#==========================================
#バックスクロール面のエネミー制御、ステージクリア実装
#エネミーの左右移動　もうちょっとシンプルなコードに
#画面ゆらせる？
#爆発のエフェクト
#面クリア時のアニメとか
#スクリプトエンドのタイミングで画面上のエネミーがゼロならステージクリアにするか？
#1面のクリア（エネミーのアクティブリストで実装）
#ステージクリア処理
#星の速度調整、バックスクロール
#ゲーム開始、終了処理
#エネミーの硬さ
#ゲーム開始前のシーンアニメ、
#スクリプトでBGの星の動作を管理できるように


#Main_Node2D
extends Node2D

var GameMainScen = preload("res://src/GameMain/GameMain_Node2D.tscn")
var GameScene
#var gamemain

#Init All of Game Status
func _ready() -> void:
	randomize()
	
	$CanvasTitle/TitleNode/BackGroundStars.SetStarSpeed(10,1)
	#$BackGroundStars.StarSpeed = 10
	
	GlobalNode.GameState = GlobalNode.GState.TITLE
	
	GameScene = GameMainScen.instance()
	add_child(GameScene)

#
func GameTitleInit():
	GlobalNode.GameState = GlobalNode.GState.TITLEs
	$CanvasTitle/TitleNode.visible = true
	$CanvasTitle/TitleNode/BackGroundStars.SetStarSpeed(10,1)
	

func _process(delta: float) -> void:
	
	#Flash StartGame Text
	var col = OS.get_ticks_usec()
	if col % 3 == 0:
		col = OS.get_ticks_usec() % GlobalNode.Colormax
		$CanvasTitle/TitleNode/BtnStart.add_color_override("font_color", ColorN(GlobalNode.ColorName[col]))
		
	if Input.is_action_pressed("BTN_START"):
		GameStart()
	if Input.is_action_pressed("BTN_QUIT"):
		GameQuit()
	
	#yield(get_tree().create_timer(1.0),"timeout")

func GameStart():
	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
#	var gamescn = GameMainScen.instance()
#	add_child(gamescn)
	GameScene.GameStartInit()
	
	$CanvasTitle/TitleNode.visible = false
	
	
#	var aa= get_node("/root/GameMain/GameMain_Node2D")
#	aa.GameStartInit()

func GameQuit():
	get_tree().quit()
	
#Start Button Down スタートボタン押下	
func _on_BtnStart_button_down() -> void:
	GameStart()

#Quit Button Down 終了ボタン押下
func _on_BtnQuit_button_down() -> void:
	GameQuit()

