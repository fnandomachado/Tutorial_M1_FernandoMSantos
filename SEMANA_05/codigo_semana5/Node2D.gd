extends Node2D

#var teste = false variável desnecessária
#var valor = 0 variável desnecessária
var numero = 0 # "numero" estava com um acento
var lista = [] #faltou declarar "var" antes da lista
var nome
var cont = 0
var i

func _on_Button_pressed():
	#Coletando dados inseridos pelo usuário
	numero = int($LineEdit.text) #Faltou vcolocar o cifrão e ajeitar a variável "numero"
	nome = ($LineEdit2.text) #a variável "nome" não havia sido declarada
#esse código acima não iria funcionar de maneira adequada, pois não "armazenaria" adequadamente os dados do usuário
	print (numero)
	print (nome)
	
func _on_Button2_pressed():
	#Incrementando o número inserido pelo usuário
	for i in range(10):
		numero+=i #a variável foi escrita incorretamente
		lista.append(numero) #a variável foi escrita incorretamente
	$Label.text = str(numero) #não converteu o número em string
	print (numero)


func _on_Button3_pressed():
	#Mudando o nome do usuário de acordo com os dados da lista
	cont=0 #variável não declarada
	i=numero
	if(i%2==1):
		cont+=1
		$Label4.text = str(nome)
	if(cont!=0):
		nome = str(nome+"baldo")
		$Label4.text = str(nome)
	print(nome)
			
