#取得スコアの表示アニメーション

#締切は9/18だと思え!!!!!!

#9/9
#フラッシュするテキストの色を直そう
#エンディング音楽
#エネミーが攻撃してくる前のモーションを作る



#スコアシステム----------------------------------------
#エネミーの攻撃中はスコア2倍
#出現ループ時の緑は10点、赤は300点とかにする
#隊列に整列時の緑は50点、赤は100点
#攻撃中は隊列時の二倍とか
#点数のポップアップ表示(x2 x3とか)


#ボム使用のためのこすり処理
#敵、敵弾と密接するとエーテルを溜められる
#溜めが量が一定になるとボムを発射できる　


#1-3 通常面
#4 バックスクロール
#5-8 通常面
#9 バックスクロール
#10 ボス




#エネミーのループ出現位置に星を出す

#ガルザカート
#タイトルからゲームに移行する時が唐突すぎる
#終了するときもなんかほしいよね
#godotくんのブートロゴをもうちょっとちゃんと見せたい

#自機のリスポン時のアニメーション
#3ウェイショットとかになるアイテム


#==========================================
#Finish Task
#==========================================
#自機のスプライト、敵もなんとかしたい　

#ボスのヒット音、爆発音
#ボスの色
#バリヤがある時の跳ね返しエフェクト　


#敵に弾があたった時に、ちょっとノックバックさせたい　

#マズルフラッシュ
#サウンドの変更シーケンスコマンド実装
#BGM(バックスクロール時と切り替え)
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

var GameStartBtnEnable = true

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


#debug ここスタート入力二発とか入ってきちゃうので弾くようにしないとまずい　		
		if Input.is_action_just_pressed("Shot") or  Input.is_action_just_pressed("ui_accept"):
			if CmdId == 0:
				GameStart()
			elif CmdId == 1:
				GameQuit()
				
		#if Input.is_action_just_pressed("SpawnEnemy"):
		#	DebugBoss = DebugBossScn.instance()
		#	get_parent().add_child(DebugBoss)

#Game Start
func GameStart():
	if GameStartBtnEnable == false:
		return
	
	#連続してスタートボタンおせないようにしてるフラグ
	GameStartBtnEnable = false
	
	$GameStart.play()
	yield(get_tree().create_timer(2), "timeout")

	
	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
	GameScene = GameMainScen.instance()
	add_child(GameScene)

#	var gamescn = GameMainScen.instance()
#	add_child(gamescn)
	GameScene.GameStartInit()
	
	$CanvasTitle.visible = false
	$CanvasBg.visible = false
	
	#ゲームボタン連続おせないフラグを戻す
	GameStartBtnEnable = true

#	var aa= get_node("/root/GameMain/GameMain_Node2D")
#	aa.GameStartInit()

#Quit
func GameQuit():
	get_tree().quit()
	
#Start Button Down スタートボタン押下	
func _on_BtnStart_button_down() -> void:
	GameStart()

#Quit Button Down 終了ボタン押下
func _on_BtnQuit_button_down() -> void:
	GameQuit()

