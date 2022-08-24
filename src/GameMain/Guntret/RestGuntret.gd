extends Node2D

var RestGuntret = 5

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
#var RestGuntretList = [] #$sp01,$sp02,$sp03,$sp04,$sp05]
onready var RestGuntretList = [$sp01,$sp02,$sp03,$sp04,$sp05]

func SetRestGuntert(var rest):
	RestGuntret = rest

func DeleteGuntret() -> int:
	RestGuntret-=1
	return RestGuntret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
		
	for spr in RestGuntretList.size():
		var sptmp : Area2D
		sptmp = RestGuntretList[spr]
		sptmp.visible = false
		
		#RestGuntretList[spr].visible = false
		#$sp01.visible = false
	if RestGuntret < 0:
		return
	
	for spr in range(RestGuntret):
		RestGuntretList[spr].visible = true
	
