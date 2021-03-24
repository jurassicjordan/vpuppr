extends CanvasLayer

const MODEL_VIEW_LEFT: Resource = preload("res://screens/gui/ModelViewLeft.tscn")
const MODEL_VIEW_RIGHT: Resource = preload("res://screens/gui/ModelViewRight.tscn")

enum Views { MODEL, POSE, FEATURES, PRESETS }

onready var button_bar: ButtonBar = $TopContainer/ButtonBar
onready var left_container: MarginContainer = $LeftContainer
onready var right_container: MarginContainer = $RightContainer

var current_view: int = Views.MODEL

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	button_bar.model_button.connect("pressed", self, "_on_model_button_pressed")
	button_bar.pose_button.connect("pressed", self, "_on_pose_button_pressed")
	button_bar.features_button.connect("pressed", self, "_on_features_button_pressed")
	button_bar.presets_button.connect("pressed", self, "_on_presets_button_pressed")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_gui"):
		for c in get_children():
			c.visible = not c.visible

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_model_button_pressed() -> void:
	_switch_view_to(Views.MODEL)

func _on_pose_button_pressed() -> void:
	_switch_view_to(Views.POSE)

func _on_features_button_pressed() -> void:
	_switch_view_to(Views.FEATURES)

func _on_presets_button_pressed() -> void:
	_switch_view_to(Views.PRESETS)

###############################################################################
# Private functions                                                           #
###############################################################################

func _switch_view_to(view: int) -> void:
	if view == current_view:
		return
	current_view = view
	
	var new_left_content: Control
	var new_right_content: Control
	
	match view:
		Views.MODEL:
			new_left_content = MODEL_VIEW_LEFT.instance()
			new_right_content = MODEL_VIEW_RIGHT.instance()
		Views.POSE:
			pass
		Views.FEATURES:
			pass
		Views.PRESETS:
			pass
		_:
			push_error("Unhandled view in in GuiLayer")
	
	for c in left_container.get_children():
		c.free()
	for c in right_container.get_children():
		c.free()
	
	left_container.add_child(new_left_content)
	right_container.add_child(new_right_content)

###############################################################################
# Public functions                                                            #
###############################################################################


