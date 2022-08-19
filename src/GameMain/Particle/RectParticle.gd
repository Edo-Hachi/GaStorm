extends Node2D

class PARTICLE :
	
	var x
	var y
	var spdx	#Move Speed
	var spdy

	#var rect : Rect2
	var size

	var age		#EnemyLifeParam
	var color



var ColorList_yelw = ["white", "yellow", "orange", "saddlebrown", "dimgray"]
var ColorList_blue = ["lightblue", "lightskyblue", "cyan", "dodgerblue", "navyblue"]

var PrtList = []
export var PrtMax = 40

var PosX = 128
var PosY = 128


func DrawRect(var prt : PARTICLE):
	var rect :Rect2
	
#	rect.position.x = prt.x - prt.size
#	rect.position.y = prt.y - prt.size
#	rect.size.x = prt.size / 2
#	rect.size.y = prt.size / 2
#	draw_rect(rect, prt.color)
	
	
	rect.position.x = prt.x
	rect.position.y = prt.y
	rect.size.x = prt.age /1.3 #+randi()%2
	rect.size.y = prt.age /1.3 #+randi()%2
	draw_rect(rect, prt.color)

func InitRect(var x, var y):
	for i in range(PrtMax):
		var _prt = PARTICLE.new()

		_prt.x = x
		_prt.y = y

		_prt.spdx  = rand_range(-1,1) * (randi() % 400 + 20)
		_prt.spdy  = rand_range(-1,1) * (randi() % 400 + 20)
		
		_prt.size = randi()%30 + 1
		
		_prt.age = randi()%25 + 10
		_prt.color = ColorN("white")
		
		PrtList.append(_prt)

func SetParticle(var x, var y, var prtmax):
	PosX = x
	PosY = y
	PrtMax = prtmax
	
func _ready() -> void:
	InitRect(PosX, PosY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collist = ColorList_yelw
	#var collist = ColorList_blue
	
	for prt in PrtList:
		if 0 < prt.age:
			prt.x += prt.spdx * delta
			prt.y += prt.spdy * delta
			
			prt.spdx *= 0.8	#少しづつスピードダウンさせてる
			prt.spdy *= 0.8
			
			prt.size-=3
			prt.age -= 1
			
			if 15 < prt.age:
				prt.color = ColorN(collist[3])
			if 20 < prt.age:
				prt.color = ColorN(collist[2])
			if 25 < prt.age:
				prt.color = ColorN(collist[1])
			if 28 < prt.age:
				prt.color = ColorN(collist[0])

			if prt.age < 10:
				prt.color = ColorN(collist[4])	

	update()

func _draw():
	var cnt = 0

	for prt in PrtList:
		if 0 < prt.age:
			DrawRect(prt)
			cnt+=1
	
	#すべてのパーティクルがなくなったらオブジェクト破棄　
	if cnt == 0:
		queue_free()
