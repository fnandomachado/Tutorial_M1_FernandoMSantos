extends StaticBody2D
#CÓDIGO DOS ESPINHOS

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.damage()
