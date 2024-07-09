.data 
	stringa: .asciiz "Digite o valor de a: "
	stringb: .asciiz "Digite o valor de b: "
	stringresult: .asciiz "A mutiplicação de a * b é: "

.text
	
	li $v0, 4 		# seta a operação de impressão de string
	la $a0, stringa 	# passa o endereço da variável a ser impressa
	syscall  		# realiza a impressão da stringa
	
	li $v0, 5 		# seta a operação de leitura de um int pelo teclado
	syscall			# faz a leitura no console
	move $t0, $v0		# move o valor lido pelo console para o reg $t0
	
	li $v0, 4 		# seta a operação de impressão de string
	la $a0, stringb 	# passa o endereço da variável a ser impressa
	syscall			# realiza a impressão da string
	
	li $v0, 5 		# seta a operação de leitura de um int pelo teclado
	syscall			# faz a leitura no console
	move $t1, $v0		# move o valor lido pelo console para o reg $t1
	
	li $v0, 0		# carrega o valor 0 para o reg $v0, que será o reg de retorno utilizado na função
	move $a0, $t0		# passa o valor de a que está em $t0 para o reg $a0
	move $a1, $t1		# passa o valor de b que está em $t1 para o reg $a1
	
	jal funcao		# vai para a função, e $ra é carregado com endereço de retorno, que aponta para a próxima instrução
	j exit
	
funcao:
	
	addi $sp, $sp, -4 	 # aumenta a stack
	sw $ra, 0($sp)		 # dá um push no endereço de retorno da função
	
	beq $a1, $zero, return   # verifica se o segundo parametro é zero, para começar a dar o retorno das chamadas de funções
	
	addi $a1, $a1, -1        # decrementa o $a1 para chamar a função recursivamente
	jal funcao	         # chamando a função recursivamente
	add $v0, $v0, $a0        # efetua a soma dos retornos de cada chamada de função

return:
	lw $ra, 0($sp) 		 # carrega o endereço de retorno da chamada atual para o $ra, para a função saber aonde deve voltar na continuação da execução
	addi $sp, $sp, 4	 # diminui a stack, incrementa o stack pointer
	jr $ra			 # retorna para o endereço de execução de $ra
	
exit:
	move $t0, $v0
	
	li $v0, 4 		# seta a operação de impressão de string
	la $a0, stringresult 	# passa o endereço da variável a ser impressa
	syscall
	
	li $v0, 1 		# seta a operação de impressão de int
	move $a0, $t0		# move o resultado da operação para o reg $a0
	syscall			# faz a impressão do resultado no console


