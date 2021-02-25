extends CanvasLayer

func update_score(score,player):
	var score_label=get_node("Banner/HBoxContainer/Player%sScore" % player)
	score_label.text=str(score)
func _ready():
	pass

func _on_Button_pressed():
	get_tree().reload_current_scene()

func game_over(player):
	get_node("Popup/VBoxContainer/Label").text="Player "+str(player)+" wins"
	get_node("Popup").popup_centered()
