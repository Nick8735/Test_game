extends Area2D

signal attack_finished

enum States { IDLE, ATTACK }
var state = null

enum AttackInputStates { IDLE, LISTENING, REGISTERED }
var attack_input_state = AttackInputStates.IDLE
var ready_for_next_attack = false
const MAX_COMBO_COUNT = 3
var combo_count = 0

var attack_current = {}
var combo = [{
		"damage": 1,
		"animation": "attack_fast",
		"effect": null
	},
	{
		"damage": 1,
		"animation": "attack_fast",
		"effect": null
	},
	{
		"damage": 3,
		"animation": "attack_medium",
		"effect": null
	}]

var hit_objects = []

func _ready():
	$AnimationPlayer.animation_finished.connect(self._on_animation_finished)
	body_entered.connect(self._on_body_entered)
	_change_state(States.IDLE)


func _change_state(new_state):
	match state:
		States.ATTACK:
			hit_objects = []
			attack_input_state = AttackInputStates.LISTENING
			ready_for_next_attack = false

	match new_state:
		States.IDLE:
			combo_count = 0
			$AnimationPlayer.stop()
			visible = false
			monitoring = false
		States.ATTACK:
			attack_current = combo[combo_count -1]
			$AnimationPlayer.play(attack_current["animation"])
			visible = true
			monitoring = true
	state = new_state


func _unhandled_input(event):
	if not state == States.ATTACK:
		return
	if attack_input_state != AttackInputStates.LISTENING:
		return
	if event.is_action_pressed("attack"):
		attack_input_state = AttackInputStates.REGISTERED


func _physics_process(_delta):
	if attack_input_state == AttackInputStates.REGISTERED and ready_for_next_attack:
		attack()


func attack():
	combo_count += 1
	_change_state(States.ATTACK)


# Use with AnimationPlayer func track.
func set_attack_input_listening():
	attack_input_state = AttackInputStates.LISTENING


# Use with AnimationPlayer func track.
func set_ready_for_next_attack():
	ready_for_next_attack = true


func _on_body_entered(body):
	if not body.has_node("Health"):
		return
	if body.get_rid().get_id() in hit_objects:
		return
	hit_objects.append(body.get_rid().get_id())
	body.take_damage(self, attack_current["damage"], attack_current["effect"])


func _on_animation_finished(_name):
	if not attack_current:
		return

	if attack_input_state == AttackInputStates.REGISTERED and combo_count < MAX_COMBO_COUNT:
		attack()
	else:
		_change_state(States.IDLE)
		emit_signal("attack_finished")


func _on_StateMachine_state_changed(current_state):
	if current_state.name == "Attack":
		attack()
