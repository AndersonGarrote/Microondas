extends Control

var radiation = 0
var item

var comidas = [
	["Pipoca", 4],
	["Frango", 9],
	["Arroz", 3],
	["Salada", 0],
]

func _ready():
	randomize()
	start_round()

func _process(delta):
	$Tempo.text = str("00" + str(int($Timer.time_left)))
	$"Radiação".text = str("00" + str(int(radiation)))

func start_round():
	$Timer.start(4)
	$AnimationPlayer.play("Fechar Porta")
	item = comidas[randi() % comidas.size()]
	$Comida.set_text(item[0] + ": " + str(item[1]) + " rad")


func _on_Mais_pressed():
	radiation = min(radiation + 1, 9)

func _on_Menos_pressed():
	radiation = max(radiation - 1, 0)

func _on_Timer_timeout():
	if item[1] == radiation:
		$AnimationPlayer.play("Abrir Porta")
	else:
		$AnimationPlayer.play("Explodir")
	$Timer2.start(1)

func _on_Timer2_timeout():
	start_round()
