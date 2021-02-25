extends Spatial

var player1score=0
var player2score=0

var target_score=3


func _ready():
	$SpotLight.hide()
	pass

func reset_pitch():
	get_tree().call_group("game_pieces","reset")
	$SpotLight.hide()
func _on_GoalDetector_body_entered(body, goal_id):
	#print("Player ",goal_id," has scored the goal")
	get_tree().call_group("game_pieces","freeze")
	get_tree().call_group("game_pieces","enable",goal_id)
	get_node("Timer").start()
	update_score(goal_id)
	$Airhorn.play()
	var pos
	if(goal_id==1):
		pos=$Player1.translation
	else:
		pos=$Player2.translation
	$SpotLight.look_at(pos,Vector3(0,1,0))
	$SpotLight.show()
func _on_Timer_timeout():
	reset_pitch()

func update_score(goal_id):
	var new_score
	match goal_id:
		1:
			player1score+=1
			new_score=player1score
		2:
			player2score+=1
			new_score=player2score
	get_node("CanvasLayer").update_score(new_score,goal_id)
	check_game_over(goal_id,new_score)
func check_game_over(player,score):
	if(score==target_score):
		get_node("Timer").queue_free()
		get_node("CanvasLayer").game_over(player)
