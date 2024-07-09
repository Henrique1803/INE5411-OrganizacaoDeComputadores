.data
	stringresult: .asciiz "A soma dos elementos do array é: "
	B: .word 10 20 30 40 50
.text
	
	la $a0, B               # Carrega o endereço base do vetor para o reg $a0 que será usado como argumento da função
	li $a1, 5		# Carrega o valor 3 para o reg $a1 que representa o tamanho do vetor, e servirá como comparador
	
	jal somaArray
	j exit

somaArray:
    	addi $sp, $sp, -8	# Ajusta a stack reservando espaço para 2 itens
    	sw $ra, 4($sp)		# Guarda endereço de retorno
    	sw $a1, 0($sp)		# Guarda argumento (n)
    
    	bne $a1, $zero, L1  	# Verifica se o tamanho é zero, para começar a dar o retorno das chamadas de funções ou chamar novamente a função

    	li $v0, 0		# Se for igual a zero, devolve 0
    	jr $ra			# Retornar

L1:
	addi $a1, $a1, -1	# Nova chamada
	jal somaArray		# Chama somaArray com o novo n decrementado
	
	# Ponto de retorno da chamada recursiva (começa a desempilhar)
    
    	lw $a1, 0($sp)	  	# Recupera o argumento passado
    	lw $ra, 4($sp)		# Recupera o endereço de retorno
    	add $sp, $sp, 8		# Libera o espaço da pilha
    
    	li $t1, 4              # Tamanho de cada elemento do array (em bytes)
    	mul $t2, $a1, $t1      # Multiplica o índice pelo tamanho do elemento
    	add $t2, $a0, $t2      # Soma o valor do vetor no índice atual no reg $t2
	
    	lw $t3, 0($t2)         # Carrega o valor do último endereço do array[tamanho - 1]
    	add $v0, $v0, $t3      # Soma o valor de array[tamanho - 1] à soma do restante do array
    	jr $ra		       # Faz o retorno para voltar a execução correta do programa com base em $ra
    
exit:
	move $t0, $v0		# Passa o resultado retornado no fim da função somaArray para o reg $t0
	
	li $v0, 4 		# Seta a operação de impressão de string
	la $a0, stringresult 	# Passa o endereço da variável a ser impressa
	syscall			# Imprime a string no console
	
	li $v0, 1 		# Seta a operação de impressão de int
	move $a0, $t0           # Passa o inteiro que será impresso no console para o reg $a0
	syscall			# Faz a impressão do inteiro
	