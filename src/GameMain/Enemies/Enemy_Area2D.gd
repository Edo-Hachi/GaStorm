#Enemy_Area2D
extends Area2D

var EnemyExplodeParticle = preload("res://src/GameMain/Particle/EnemyExplode.tscn") 
var EnemyRefrectParticle = preload("res://src/GameMain/Particle/EnemyRefrect.tscn") 

enum MoveTypeID  {
	Type01=0,
	Loop01L,
	Loop01R
}

var RootNode
var MoveType = MoveTypeID.Type01
var FlameCounter = 0	#随時更新　
var localCounter = 0	#タイマ計測用

#var Speed = 150
var Speed = 20

var MoveSeq = 0

var EnemyID	#ObjectID
var Alive = true
var Matrix : Vector2	#隊列位置
var MatrixWorldPos : Vector2	#隊列位置実座標
var Life : int = 1
var ScoreMulti = 1	#スコア計算時の係数
var BackScroll = false

#エネミーの攻撃強度	　
var EnemyAttackRate : int =   4000	
var EnemyShotRate : int = 4000
var EnemyAim : bool = false

#var ReturnToHomeState = 0

#エネミーの行動ステート
var EnemyState = GlobalNode.EnemyStateID.STAT_LOOP

enum ATTACKSTATE{
	Prepar = 0,
	MoveAttack = 1
}
var EnemyAtackState = ATTACKSTATE.Prepar
var PreparCnt = 0


func SetEnemyId(var enemyid):
	EnemyID = enemyid
	#$AnimatedSprite.animation = "Green"

func SetEnemyColor(var enemyColor : int):
	match enemyColor:
		GlobalNode.EnemyColor.Green:
			$AnimatedSprite.animation = "Green"
			Life = 1
			ScoreMulti = Life
		GlobalNode.EnemyColor.Red:
			$AnimatedSprite.animation = "Red"
			Life = 2
			ScoreMulti = Life
		GlobalNode.EnemyColor.Yellow:
			$AnimatedSprite.animation = "Yellow"
			Life = 1
		GlobalNode.EnemyColor.Purple:
			$AnimatedSprite.animation = "Puraple"
			Life = 3
			ScoreMulti = Life
		GlobalNode.EnemyColor.Black:
			$AnimatedSprite.animation = "Black"
			Life = 1
			ScoreMulti = Life

			
func SetEnemyMatrix(var matrix : Vector2, var matri_xworld : Vector2):
	Matrix = matrix
	MatrixWorldPos = matri_xworld
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Alive = true
	#ReturnToHomeState = 1	#ホームポジションに戻ってない　

func SetMoveType(var movetype):
#	MoveType = movetype
	pass

func SetPositon(var x, var y):
	pass
#	position.x = x
#	position.y = y

func SetEnemyState(var stat):
	#print("SetEnemyState Called")
	EnemyState = stat

#フォーメーションアニメーション開始（GameMainでの全エネミーホームポジション達成条件成立から投げられてくる）
func ActivateFormation():
	EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
	pass

#エネミーの攻撃発生強度設定　
func SetEnemyAttackRate(var atack : float, var shot : float , var aim:bool):
	EnemyAttackRate = atack
	EnemyShotRate  = shot
	EnemyAim  = aim

func EnemyFormationMove(delta: float):
	var x1 = 12 * 3
	var x2 = 8 * 3
	var x3 = 4 * 3
	var x4 = 2 * 3
	
	if GlobalNode.EnemyFormationFinished == true:
		if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.OUTER:
			match int(Matrix.x):
				0:
					position.x -= x1 * delta
					position.y += x1/2 * delta
				1:
					position.x -= x2 * delta
					position.y += x2/2 * delta
				2:
					position.x -= x3 * delta
					position.y += x3/2 * delta
				3:
					position.x -= x4 * delta
					position.y += x4/2 * delta
				4:
					position.x += x4 * delta
					position.y += x4/2 * delta
				5:
					position.x += x3 * delta
					position.y += x3/2 * delta
				6:
					position.x += x2 * delta
					position.y += x2/2 * delta
				7:
					position.x += x1 * delta
					position.y += x1/2 * delta
			pass

		if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.HOME:
			position = position.move_toward(MatrixWorldPos, 40 * delta)
			pass

#Invader Mode!!
#func EnemyInvaderMove(delta: float):
#	if GlobalNode.InvaderCanMove==false:
#		return
#
#	if GlobalNode.InvaderMove == 0:
#		GlobalNode.InvaderOffsetX -= 4 * delta
#		if GlobalNode.InvaderOffsetX < -64:
#			GlobalNode.InvaderMove = 1
#			GlobalNode.InvaderOffsetY +=32
#	else:
#		GlobalNode.InvaderOffsetX += 4 * delta
#		if 64 < GlobalNode.InvaderOffsetX:
#			GlobalNode.InvaderMove = 0
#			GlobalNode.InvaderOffsetY +=32
#
#	position.x = MatrixWorldPos.x + GlobalNode.InvaderOffsetX
#	position.y = MatrixWorldPos.y + GlobalNode.InvaderOffsetY

#func EnemyInvaderMove(delta: float):
#
#	if GlobalNode.InvaderMove == 0:
#		position.x -= 30 * delta
#		if position.x < 32:
#			GlobalNode.InvaderMove = 1
#			GlobalNode.InvaderOffsetY += 32
#	else:
#		position.x +=  30 * delta
#		if position.x > GlobalNode.ScreenWidth - 32:
#			GlobalNode.InvaderMove = 0
#			GlobalNode.InvaderOffsetY += 32
#
#	position.y = MatrixWorldPos.y + GlobalNode.InvaderOffsetY
func EnemyInvaderMove(delta: float):
	if GlobalNode.InvaderDir == 0:
		position.x -= 30 * delta
		if position.x < 32:
			GlobalNode.InvaderDir = 1
			GlobalNode.EnemyOffsetY += 8
	else:
		position.x +=  30 * delta
		if position.x > GlobalNode.ScreenWidth - 32:
			GlobalNode.InvaderDir = 0
			GlobalNode.EnemyOffsetY += 8
		
	position.y = MatrixWorldPos.y + GlobalNode.EnemyOffsetY

#弾発射
func ShotBullet():
	#-1だったら弾の発射は行わない　
	if EnemyShotRate == -1:
		return
	
	if randi()%EnemyShotRate == 1:
		if EnemyAim == false:
			get_parent().ShotEnemyBullet(position, 0) #真下狙い
		else:
			if randi()%2:
				get_parent().ShotEnemyBullet(position, 0) #直狙い
			else:
				get_parent().ShotEnemyBullet(position, 1) #真下狙い

func _process(delta: float) -> void:
	match EnemyState:
		#出現ループ中処理
		GlobalNode.EnemyStateID.STAT_LOOP:
			#適当に弾をばらまく
			if 10 < position.y:
				ShotBullet()
			
		#ホームポジションへの移動
		GlobalNode.EnemyStateID.STAT_GOHOME:
			#print("Call Go Home")
			position = position.move_toward(MatrixWorldPos, Speed * delta)
			rotation += 30
			Speed += 5
			
			if position == MatrixWorldPos:
				#EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
				rotation = 0
				
				#フォーメーションアニメ実行ステートに移行
				EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
				return
		
		#隊列編成時処理
		GlobalNode.EnemyStateID.STAT_FORMATION:
#			if GlobalNode.InvaderMode == true: #if GlobalNode.GameSeqActive == false:
#				if GlobalNode.InvaderCanMove == true:
#					EnemyInvaderMove(delta)
#					return
			#else:
			#通常の編隊アニメーション
			EnemyFormationMove(delta)
		GlobalNode.EnemyStateID.STAT_FORMATION: # ,GlobalNode.EnemyStateID.STAT_ATTACK: 
			if GlobalNode.EnemyInvader == true && GlobalNode.SeqState == false:
				EnemyInvaderMove(delta)
			else:
				EnemyFormationMove(delta)
			
			#エネミーの死亡フラグが立っていたら弾く	
			if Alive == false:
				return	
			
			#弾を発射するか？
			ShotBullet()
				
			#攻撃を行うか？
			if EnemyAttackRate != -1:
				if randi()%EnemyAttackRate == 1:
					EnemyState = GlobalNode.EnemyStateID.STAT_ATTACK
					FlameCounter=0
					PreparCnt = 0
		
		GlobalNode.EnemyStateID.STAT_ATTACK: #攻撃中
#			if GlobalNode.InvaderMode == true: # && GlobalNode.GameSeqActive == false:
#				return

			FlameCounter+=1
			match EnemyAtackState:
				ATTACKSTATE.Prepar:
					PreparCnt+=1

					#通常の編隊アニメーション
					EnemyFormationMove(delta)

					#EnemyFormationMove(delta)
					if 0 <= FlameCounter and FlameCounter < 30:
						$AnimatedSprite.self_modulate = Color(1,0,0)
					elif 30<=FlameCounter and FlameCounter < 60:
						$AnimatedSprite.self_modulate = Color(1,1,1)
					else:
						FlameCounter = 0
					
					#2秒たったら攻撃開始
					if (60 * 2) < PreparCnt:
						EnemyAtackState = ATTACKSTATE.MoveAttack
						$AnimatedSprite.self_modulate = Color(1,1,1)
						return
				
				#左右ふらふらしながら下降
				ATTACKSTATE.MoveAttack:
					position.y += 100 * delta
					if 0 <= FlameCounter and FlameCounter < 30:
						position.x -= 30 * delta
					elif 30<=FlameCounter and FlameCounter < 60:
						position.x += 30 * delta
					else:	
						FlameCounter = 0
					
					#エネミーの攻撃
					ShotBullet()
					
					# 画面外に出たらホームポジションへ戻す　
					if GlobalNode.ScreenHeight + 32 <  position.y:
						position.y = -32
						position.x = randi()%GlobalNode.ScreenWidth + 1
						EnemyState = GlobalNode.EnemyStateID.STAT_GOHOME
						EnemyAtackState = ATTACKSTATE.Prepar
					
	
#プレイヤー機、プレイヤーショットに当たった
func _on_EnemyObject_area_entered(area: Area2D) -> void:
	#自機、ショットに当たった場合は自分（エネミー）削除フラグを立てる
	Life -= 1
	
	if 0<= Life:
		var ref = EnemyRefrectParticle.instance()
		ref.SetParticle(position.x, position.y, 20)
		#func SetParticle(var x, var y, var prtmax):
		get_parent().add_child(ref)
		
		$SoundRefrect.play()
	
	elif Life < 0:
		
		#Enemy is Dead	
		var explode = EnemyExplodeParticle.instance()
		explode.SetParticle(position.x, position.y, 40)
		get_parent().add_child(explode)	
		
		$SoundExplode.play()
			
		#画面を揺らす
		get_parent().DispShakeStart(3,10)		
		
		Alive = false	
		visible = false
		
		GlobalNode.PlayerScore += 100 * ScoreMulti

		#コリジョンも不使用にする disabled = true
		$CollisionShape2D.set_deferred("disabled", true)

		get_parent().DeleteEnemy()
