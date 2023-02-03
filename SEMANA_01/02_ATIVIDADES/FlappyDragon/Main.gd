extends Node

# para se aumentar a velociadade horizontal do dragão pode-se mudar a variável x

var status = 1 # serve para dizer se o jogador está jogando ou não (1 = está jogando [dragão em movimento], 0 = não está jogando [dragão parado])
var vscore = 0 # pontuação do jogador (inicia em 0 e aumenta ao passar pelas colunas)
var x = 15 # variação de posição no eixo das abcissas (efeito multiplicador)
var y = 1.5 # variação de posição no eixo das ordenadas (efeito multiplicador)

func _ready():
	$gameover.hide()


func _process(delta):
	
	if status == 1:
		
		$background.position.x -= 1*x
		if ($background.position.x) < -200:
			$background.position.x = 600
			
		$columns.position.x -= 2*x
		if ($columns.position.x) < -550:
			$columns.position.x = rand_range(0, 350) - 50
			$columns.position.y = rand_range(0, 400) - 200

		$dragon.position.y += y

		if $dragon.position.y > 480:
			$dragon.position.y = 480
			status = 0

		if $dragon.position.y < -20:
			$dragon.position.y = -20
			
		if Input.is_action_pressed("ui_down"):
			$dragon.position.y += 2

		if Input.is_action_pressed("ui_up"):
			$dragon.position.y -= 4
			
	elif status == 0:
		
		$dragon/dragonImages.playing = false
		$gameover.show()

		if Input.is_action_pressed("ui_accept"):
			$score.set_text("0")
			vscore = 0
			status = 1
			$dragon/dragonImages.playing = true
			$dragon.position.y = 0 
			$columns.position.x = 400 
			$gameover.hide()
			
func _on_columns_body_shape_entered(body_id, body, body_shape, local_shape):
	if (local_shape < 2):
		status = 0

func _on_columns_body_shape_exited(body_id, body, body_shape, local_shape):
	if (local_shape == 2):
		vscore += 1 
		$score.set_text(str(vscore))
