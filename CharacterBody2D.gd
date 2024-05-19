extends CharacterBody2D

var speed = 200
var magnetic_strength = 10

@onready var magnetic_field: Area2D = $MagneticField

func _ready():
    magnetic_field.body_entered.connect(self._on_body_entered)
    magnetic_field.body_exited.connect(self._on_body_exited)

var magnetic_bodies = []

func _on_body_entered(body: Node):
    if body is RigidBody2D:
        magnetic_bodies.append(body)

func _on_body_exited(body: Node):
    if body is RigidBody2D:
        magnetic_bodies.erase(body)

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    if Input.is_action_pressed('ui_cancel'):
        get_tree().quit()
    if Input.is_action_pressed('ui_select'):
        for body in magnetic_bodies:
            apply_magnetic_force(body)
    self.velocity = velocity
    move_and_slide()

func apply_magnetic_force(body: RigidBody2D):
    var distance = global_position.distance_to(body.global_position)
    var force_magnitude = magnetic_strength / pow(distance, 2)

    var direction = (global_position - body.global_position).normalized()
    print("magForce: ", direction * force_magnitude)
    body.apply_central_impulse(direction * magnetic_strength)
