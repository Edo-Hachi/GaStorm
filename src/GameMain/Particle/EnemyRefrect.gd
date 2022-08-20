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


#func DrawRect(var prt : PARTICLE, var weight):
#	var rect : Rect2
#	rect.position.x = prt.x - prt.sizex/2
#	rect.position.y = prt.y - prt.sizey/2
#	rect.size.x = prt.sizex
#	rect.size.y = prt.sizey
#
#	draw_rect(rect,prt.color, true, weight)


#Pset
func DrawPset(var prt : PARTICLE, var weight):
	
	var rect : Rect2
	rect.position.x = prt.x
	rect.position.y = prt.y
	rect.size.x = weight
	rect.size.y = weight
		
	draw_rect(rect,prt.color,false, weight)

#Particleデータ初期化　
func InitParticle(var x, var y):
	for i in range(PrtMax):
		var _prt = PARTICLE.new()

		_prt.x = x
		_prt.y = y
		
		_prt.sizex = randi()%10 + 10
		_prt.sizey = randi()%10 + 10
	
		_prt.spdx  = rand_range(-1,1) * (randi() % 150 + 1)
		_prt.spdy  = (randi() % 100 + 1) * -1
		
		_prt.life = randi()%20 + 1
		_prt.color = ColorN("white")
		
		PrtList.append(_prt)
	
func SetParticle(var x, var y, var prtmax):
	PosX = x
	PosY = y
	PrtMax = prtmax
	
func _ready() -> void:
	InitParticle(PosX, PosY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var ColorList = ColorList_yelw
	var ColorList = ColorList_blue

		
	for prt in PrtList:
		if 0 < prt.life:
			prt.x += prt.spdx * delta
			prt.y += prt.spdy * delta
			
			prt.sizex -= 8 * delta
			prt.sizey -= 10 * delta
			
			prt.spdx *= 0.95	#少しづつスピードダウンさせてる
			prt.spdy *= 0.95
			
			prt.life -= 1
				

	update()

func _draw():
	var cnt = 0

	for prt in PrtList:
		if 0 < prt.life:
			DrawPset(prt, 1)
			cnt+=1
	
	#すべてのパーティクルがなくなったらオブジェクト破棄　
	if cnt == 0:
		queue_free()
