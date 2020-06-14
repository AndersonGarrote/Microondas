extends Control

var radiation = 0
var item
var points = 0

var comidas = [
	["Pipoca", 5, preload("res://comidas/pipoca.svg")],
	["Frango", 8, preload("res://comidas/frango.svg")],
	["Arroz", 2, preload("res://comidas/arroz.svg")],
	["Sopa", 3, preload("res://comidas/sopa.svg")],
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
	$CenterContainer/Porta/Comida.set_text(item[0] + ": " + str(item[1]) + " rad")

func _on_Mais_pressed():
	radiation = min(radiation + 1, 9)

func _on_Menos_pressed():
	radiation = max(radiation - 1, 0)

func _on_Timer_timeout():
	$Timer.stop()
	if item[1] == radiation:
		points += 1
		$CenterContainer/Porta/Pontos.text = "Pontos: " + str(points)
		$CenterContainer/Microondas/Prato.set_texture(item[2])
		$AnimationPlayer.play("Abrir Porta")
		
	else:
		$AnimationPlayer.play("Explodir")
	$Timer2.start(1)

func _on_Timer2_timeout():
	$Timer2.stop()
	start_round()
