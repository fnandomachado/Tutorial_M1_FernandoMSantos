extends Area2D #CLICK NA GELADEIRA

func _on_Area2D_body_entered(body: Node) -> void: 
	ScreenTransition.change_scene("res://tela de fim.tscn")

