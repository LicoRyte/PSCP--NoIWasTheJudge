extends Node

var card_1 : PackedScene
var card_2 : PackedScene
var card_3 : PackedScene
@onready var card_name: Label = $CanvasLayer/Control/VBoxContainer/Card/PanelContainer2/Label
@onready var card_des: Label = $CanvasLayer/Control/VBoxContainer/Description/PanelContainer2/Label
@onready var card_stat: Label = $CanvasLayer/Control/VBoxContainer/tag/PanelContainer2/Label


func _ready() -> void:
	GameEvents._card_description.connect(update_label)

var card_storage = {
	
}

var blacklist = {
	
}

func card_random():
	pass

func update_label(name : String, des : String, tag : String):
	card_name.text = name
	card_des.text = des
	card_stat.text = tag
