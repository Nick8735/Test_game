extends VBoxContainer

@export var world_environment: WorldEnvironment


func _on_tonemap_mode_item_selected(index: int) -> void:
	world_environment.environment.tonemap_mode = index
	# Hide whitepoint if not relevant (Linear tonemapping does not use a whitepoint).
	%Whitepoint.visible = world_environment.environment.tonemap_mode != Environment.TONE_MAPPER_LINEAR

func _on_exposure_value_changed(value: float) -> void:
	world_environment.environment.tonemap_exposure = value
	$TonemapMode/Exposure/Value.text = str(value).pad_decimals(1)


func _on_whitepoint_value_changed(value: float) -> void:
	world_environment.environment.tonemap_white = value
	$TonemapMode/Whitepoint/Value.text = str(value).pad_decimals(1)


func _on_color_correction_item_selected(index: int) -> void:
	# Use alphabetical order in the `example_luts` folder.
	match index:
		0:  # None
			world_environment.environment.adjustment_color_correction = null
		1:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/detect_white_clipping.png")
		2:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/frozen.png")
		3:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/heat.png")
		4:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/incandescent.png")
		5:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/posterized.png")
		6:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/posterized_outline.png")
		7:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/rainbow.png")
		8:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/1d/toxic.png")
		9:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/brighten_shadows.png")
		10:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/burned_blue.png")
		11:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/cold_color.png")
		12:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/detect_white_clipping.png")
		13:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/dithered.png")
		14:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/hue_shift.png")
		15:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/posterized.png")
		16:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/sepia.png")
		17:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/stressed.png")
		18:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/warm_color.png")
		19:
			world_environment.environment.adjustment_color_correction = preload("res://example_luts/3d/yellowen.png")


func _on_saturation_value_changed(value: float) -> void:
	world_environment.environment.adjustment_saturation = value
	$ColorCorrection/Saturation/Value.text = str(value).pad_decimals(1)


func _on_debanding_toggled(button_pressed: bool) -> void:
	get_viewport().use_debanding = button_pressed
