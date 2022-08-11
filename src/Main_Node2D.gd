#GameMain_Node2D

#エネミーの左右移動　もうちょっとシンプルなコードに
#スクリプトでBGの星の動作を管理できるように

#ゲーム開始前のシーンアニメ、面クリア時のアニメとか

#10面分の雛形を作る
#エネミーの硬さ
#スコア加算
#爆発のエフェクト


#音
#BGM
#画面ゆらせる？
#自機の移動処理をkineticに変更

#==========================================
#完了タスク
#==========================================
#1面のクリア（エネミーのアクティブリストで実装）
#ステージクリア処理
#星の速度調整、バックスクロール
#ゲーム開始、終了処理

#Main_Node2D
extends Node2D

var GameMainScen = preload("res://src/GameMain/GameMain_Node2D.tscn")
var GameScene
#var gamemain

#Init All of Game Status
func _ready() -> void:
	randomize()

	$BackGroundStars.StarSpeed = 10
	
	GlobalNode.GameState = GlobalNode.GState.TITLE
	
	GameScene = GameMainScen.instance()
	add_child(GameScene)

#
func GameTitleInit():
	GlobalNode.GameState = GlobalNode.GState.TITLE
	$CanvasLayer/TitleNode.visible = true
	$BackGroundStars.StarSpeed = 10
	

func _process(delta: float) -> void:
	
	#Flash StartGame Text
	var col = OS.get_ticks_usec()
	if col % 3 == 0:
		col = OS.get_ticks_usec() % GlobalNode.Colormax
		$CanvasLayer/TitleNode/BtnStart.add_color_override("font_color", ColorN(GlobalNode.ColorName[col]))
		
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
	
	$CanvasLayer/TitleNode.visible = false
	
	
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

