extends Control

func _input(_event):
	# Quit when Esc is pressed
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Generate a random seed for the shader
	#$Canvas.material.set_shader_parameter("randi", randi())
	$Canvas.material.set_shader_parameter("randf", randf())
