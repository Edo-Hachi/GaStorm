#EnemyExplode
extends Node2D

class PARTICLE :
	var x	#Spawn Pos
	var y
	
	var sizex	#rect size
	var sizey

	var spdx	#Move Speed
	var spdy
	
	var life	#EnemyLifeParam
	var color

var ColorList_yelw = ["white", "yellow", "orange", "saddlebrown", "dimgray"]
var ColorList_blue = ["lightblue", "lightskyblue", "cyan", "dodgerblue", "navyblue"]

var PrtList = []

var PosX
var PosY
var PrtMax = 30

#var PosX = 128
#var PosY = 128


func DrawRect(var prt : PARTICLE, var weight):
	var rect : Rect2
	rect.position.x = prt.x - prt.sizex/2
	rect.position.y = prt.y - prt.sizey/2
	rect.size.x = prt.sizex
	rect.size.y = prt.sizey

	draw_rect(rect,prt.color, true, weight)


#Pset
func DrawPset(var prt : PARTICLE):
	
	var rect : Rect2
	rect.position.x = prt.x
	rect.position.y = prt.y
	rect.size.x = 1
	rect.size.y = 1
		
	draw_rect(rect,prt.color,false,1)

#Particleデータ初期化　
func InitParticle(var x, var y):
	for i in range(PrtMax):
		var _prt = PARTICLE.new()

		_prt.x = x
		_prt.y = y
		
		_prt.sizex = randi()%10 + 5
		_prt.sizey = randi()%10 + 5
			
		_prt.spdx  = rand_range(-1,1) * (randi() % 150 + 50)
		_prt.spdy  = rand_range(-1,1) * (randi() % 150 + 50)
		
		_prt.life = randi()%25 + 5
		_prt.color = ColorN("white")

		#1つ目のパーティクルのみサイズ、lifeを固定にした
		if i == 0:
			_prt.sizex=15
			_prt.sizey=15
			_prt.spdx=0
			_prt.spdy=0
			_prt.life=40
		
		PrtList.append(_prt)
	

func SetParticle(var x, var y, var prtmax):
	PosX = x
	PosY = y
	PrtMax = prtmax
	
func _ready() -> void:
	InitParticle(PosX, PosY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ColorList = ColorList_yelw
	#var ColorList = ColorList_blue
	
	for prt in PrtList:
		if 0 < prt.life:
			prt.x += prt.spdx * delta
			prt.y += prt.spdy * delta
			
			prt.sizex -= 10 * delta
			prt.sizey -= 10 * delta
			
			prt.spdx *= 0.9	#少しづつスピードダウンさせてる
			prt.spdy *= 0.9
			
			prt.life -= 1
			
			if 10 < prt.life:
				prt.color = ColorN(ColorList[3])
			if 15 < prt.life:
				prt.color = ColorN(ColorList[2])
			if 18 < prt.life:
				prt.color = ColorN(ColorList[1])
			if 20 < prt.life:
				prt.color = ColorN(ColorList[0])

			if prt.life < 9:
				prt.color = ColorN(ColorList[4])
	
	update()

func _draw():
	var cnt = 0

	for prt in PrtList:
		if 0 < prt.life:
			DrawRect(prt, 1)
			cnt+=1
	
	#すべてのパーティクルがなくなったらオブジェクト破棄　
	if cnt == 0:
		queue_free()
