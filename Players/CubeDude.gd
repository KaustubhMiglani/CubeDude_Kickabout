extends KinematicBody

var motion=Vector3()

export var player_id=1

const speed =10

var can_move=true

var my_spawn

func _ready():
	my_spawn=get_tree().get_root().find_node("Player%sstart" %player_id,true,false)
	$Particles.emitting=false
const up= Vector3(0,1,0)

func _physics_process(delta):
	move()
	animate()
	face_forward()
func move():
	var x =Input.get_action_strength("left_%s" % player_id) - Input.get_action_strength("right_%s" % player_id) 
	var z =Input.get_action_strength("up_%s" % player_id) - Input.get_action_strength("down_%s" % player_id) 
	
	motion=Vector3(-x,0,-z)
	if(can_move):
		move_and_slide(motion.normalized() * speed,up)

func animate():
	if(motion.length()>0 and can_move):
		get_node("AnimationPlayer").play("Arms Cross Walk")
	else:
		get_node("AnimationPlayer").stop()


func face_forward():
	if(motion.x!=0 or motion.y!=0):
		if(can_move):
			look_at(Vector3(-motion.x,0,motion.z)*speed,up)

func freeze():
	can_move=false
func reset():
	$Particles.emitting=false
	can_move=true
	translation=my_spawn.translation
func enable(goal_id):
	if(player_id==goal_id):
		$Particles.emitting=true
