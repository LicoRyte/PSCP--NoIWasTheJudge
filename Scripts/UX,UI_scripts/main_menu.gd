extends Control


func _on_Start_button_pressed() -> void:
	SceneManager.change_scene("arena")
	GameEvents.reset_game()

func _on_Setting_button_2_pressed() -> void:
	print("press setting")


func _on_Exit_button_3_pressed() -> void:
	get_tree().quit()
