#取得スコアの表示アニメーション

#締切は9/5だと思え!!!!!!

<<<<<<< HEAD
=======
#サウンドの変更シーケンスコマンド実装
#BGM(バックスクロール時と切り替え)




>>>>>>> origin/main
# 0828, 0829--------------------------
#1-3 通常面
#4 バックスクロール
#5-7 通常面
#8 バックスクロール
#9 シューティング
#10 ボス


#2,3,4面くらいはつくってみよう
#4,8面はバックスクロール
#10面分の雛形を作る


#4面まで普通にギャプラス
#5面で合体
#6面ブロック崩し
#7面インベーダー
#8面ボーナス
#9面シューティング
#10面でボス



#0830-0831
#9面は隕石と敵がランダムに出てくる弾幕面

#0901--
#10面はボス戦（バックスクロール） 中ボス＋エネミーの波状攻撃
#ボスはタイムアタック式で。早いほどスコアが高くなる。

#自機のリスポン時のアニメーション
#自機のスプライト、敵もなんとかしたい　
#敵の弾のスプライトの色をなんとかして
#敵に弾があたった時に、ちょっとノックバックさせたい　


#フラッシュするテキストの色を直そう
#エネミーのループ出現位置に星を出す

#3ウェイショットとかになるアイテム
#BOMB
#ガルザカート
#敵がヒットバック


#タイトルからゲームに移行する時が唐突すぎる
#終了するときもなんかほしいよね
#godotくんのブートロゴをもうちょっとちゃんと見せたい




#エネミーの攻撃中はスコア2倍
#出現ループ時の緑は10点、赤は300点とかにする
#隊列に整列時の緑は50点、赤は100点
#攻撃中は隊列時の二倍とか


#自機の移動処理をkineticに変更

#==========================================
#Finish Task
#==========================================
#サウンドの変更シーケンスコマンド実装
#BGM(バックスクロール時と切り替え)

# 0826, 0827--------------------------
#ゲームオーバー曲
#敵の弾発射(将来的な弾幕系の実装も視野に)
#敵の攻撃（下に降りてくる　）

#メニューのStartとQuitをコントローラーで選べるように

#スコア保存
#ゲームオーバーのステート
#残機管理
#スコア加算

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

var CmdId = 0


#Init All of Game Status
func _ready() -> void:
	randomize()
	
	GlobalNode.DataLoad()
	
	$CanvasBg/BackGroundStars.SetStarSpeed(10,1)
	#$BackGroundStars.StarSpeed = 10
	
	GlobalNode.GameState = GlobalNode.GState.TITLE
	
	$CanvasTitle/lblVersion.text = GlobalNode.Version
#	GameScene = GameMainScen.instance()
#	add_child(GameScene)

#
func GameTitleInit():
	GlobalNode.GameState = GlobalNode.GState.TITLE
	$CanvasTitle.visible = true
	$CanvasBg.visible = true
	$CanvasBg/BackGroundStars.SetStarSpeed(10,1)
	

func _process(delta: float) -> void:
	#set_text("FPS " + String(Engine.get_frames_per_second()))
	$CanvasTitle/TitleNode/lblFps.text = "FPS " + String(Engine.get_frames_per_second())
	
	var ScoreTxt= "HighScore:%010d" % GlobalNode.HighScore
	$CanvasTitle/TitleNode/lblHighScore.text = ScoreTxt

	
	if GlobalNode.GameState == GlobalNode.GState.TITLE:	
		#if Input.is_action_pressed("BTN_START"):
		if Input .is_action_just_pressed("BTN_START"):
			GameStart()
		#if Input.is_action_pressed("BTN_QUIT"):
		if Input.is_action_just_pressed("BTN_QUIT"):
			GameQuit()

		if Input.is_action_just_pressed("ui_up"):
			CmdId = 0
		elif Input.is_action_just_pressed("ui_down"):
			CmdId = 1

		var col = OS.get_ticks_usec()
		if col % 4 == 0:
			col = OS.get_ticks_usec() % GlobalNode.Colormax
		
			$CanvasTitle/TitleNode/BtnStart.add_color_override("font_color",  ColorN("darkgray"))
			$CanvasTitle/TitleNode/BtnQuit.add_color_override("font_color", ColorN("darkgray"))
			
			if  CmdId == 0:
				$CanvasTitle/TitleNode/BtnStart.add_color_override("font_color", ColorN(GlobalNode.ColorName[col]))
			elif CmdId == 1:
					$CanvasTitle/TitleNode/BtnQuit.add_color_override("font_color",  ColorN(GlobalNode.ColorName[col]))
		
		if Input.is_action_just_pressed("Shot") or  Input.is_action_just_pressed("ui_accept"):
			if CmdId == 0:
				GameStart()
			elif CmdId == 1:
				GameQuit()


func GameStart():
	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
	GameScene = GameMainScen.instance()
	add_child(GameScene)

#	var gamescn = GameMainScen.instance()
#	add_child(gamescn)
	GameScene.GameStartInit()
	
	$CanvasTitle.visible = false
	$CanvasBg.visible = false
	
	
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

