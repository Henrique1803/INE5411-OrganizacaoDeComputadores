.data 
	stringa: .asciiz "Digite o valor de a: "
	stringb: .asciiz "Digite o valor de b: "
	stringresult: .asciiz "A mutiplica��o de a * b �: "

.text
	
	li $v0, 4 		# seta a opera��o de impress�o de string
	la $a0, stringa 	# passa o endere�o da vari�vel a ser impressa
	syscall  		# realiza a impress�o da stringa
	
	li $v0, 5 		# seta a opera��o de leitura de um int pelo teclado
	syscall			# faz a leitura no console
	move $t0, $v0		# move o valor lido pelo console para o reg $t0
	
	li $v0, 4 		# seta a opera��o de impress�o de string
	la $a0, stringb 	# passa o endere�o da vari�vel a ser impressa
	syscall			# realiza a impress�o da string
	
	li $v0, 5 		# seta a opera��o de leitura de um int pelo teclado
	syscall			# faz a leitura no console
	move $t1, $v0		# move o valor lido pelo console para o reg $t1
	
	li $v0, 0		# carrega o valor 0 para o reg $v0, que ser� o reg de retorno utilizado na fun��o
	move $a0, $t0		# passa o valor de a que est� em $t0 para o reg $a0
	move $a1, $t1		# passa o valor de b que est� em $t1 para o reg $a1
	
	jal funcao		# vai para a fun��o, e $ra � carregado com endere�o de retorno, que aponta para a pr�xima instru��o
	j exit
	
funcao:
	
	addi $sp, $sp, -4 	 # aumenta a stack
	sw $ra, 0($sp)		 # d� um push no endere�o de retorno da fun��o
	
	beq $a1, $zero, return   # verifica se o segundo parametro � zero, para come�ar a dar o retorno das chamadas de fun��es
	
	addi $a1, $a1, -1        # decrementa o $a1 para chamar a fun��o recursivamente
	jal funcao	         # chamando a fun��o recursivamente
	add $v0, $v0, $a0        # efetua a soma dos retornos de cada chamada de fun��o

return:
	lw $ra, 0($sp) 		 # carrega o endere�o de retorno da chamada atual para o $ra, para a fun��o saber aonde deve voltar na continua��o da execu��o
	addi $sp, $sp, 4	 # diminui a stack, incrementa o stack pointer
	jr $ra			 # retorna para o endere�o de execu��o de $ra
	
exit:
	move $t0, $v0
	
	li $v0, 4 		# seta a opera��o de impress�o de string
	la $a0, stringresult 	# passa o endere�o da vari�vel a ser impressa
	syscall
	
	li $v0, 1 		# seta a opera��o de impress�o de int
	move $a0, $t0		# move o resultado da opera��o para o reg $a0
	syscall			# faz a impress�o do resultado no console


