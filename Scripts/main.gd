extends Control


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	fix_visuals()

func fix_visuals():
	$"BG/Usable Area".size = Vector2(
		size.x - 20,
		size.y - 20,
	)
	$"BG/Usable Area".position = Vector2i(
		10,
		10,
	)
	
