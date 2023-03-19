extends Area2D

func _on_Coins_body_entered(body):
	if body.name == ("Player"):
		GlobalVar.moedas += 1
		queue_free()
