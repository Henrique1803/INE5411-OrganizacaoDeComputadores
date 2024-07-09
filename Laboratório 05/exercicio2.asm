.data
	string_n: .asciiz "Digite o valor de n: "
	string_result: .asciiz "O fatorial de n �: "

.text				
	li $v0, 4			# seta a opera��o de impress�o de string
	la $a0, string_n		# passa a string que ser� impressa para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 5			# seta a opera��o de leitura de inteiro
	syscall				# faz a leitura do inteiro n
	move $t0, $v0			# move o valor lido para $t0
	
	move $a0, $t0			# move o valor de n ($t0) para $a0
	
	jal fatorial			# chama a fun��o fatorial
	j exit				# desvia para a label exit
	
fatorial:				
	addi $sp, $sp, -8		# aumenta a stack para armazenar dois valores
	sw $ra, 4($sp)			# guarda o reg $ra da chamada atual da fun��o na stack
	sw $a0, 0($sp)			# guarda o valor de n da chamada atual da fun��o na stack
	
	beq $a0, $zero, return		# desvia para a label return se n == 0
	
	addi $a0, $a0, -1		# sen�o, decrementa n
	jal fatorial			# faz a chamada recursiva da fun��o fatorial
	
return:			
	lw $ra, 4($sp)			# carrega da stack o endere�o de retorno da chamada atual da fun��o fatorial
	lw $a0, 0($sp)			# carrega da stack o n da chamada atual da fun��o fatorial 
	addi $sp, $sp, 8		# incrementa o $sp em 8, para retirar os valores carregados da stack
	
	beq $a0, $zero, caso_base	# desvia se n == 0 (caso base de retorno)
	mul $s0, $s0, $a0		# multiplica $s0 por $a0 (n)
	
	jr $ra				# retorna para o endere�o de retorno armazenado por $ra

caso_base:
	li $s0, 1			# faz $s0 iniciar em 1 (0! == 1)
	
	jr $ra				# retorna para o endere�o de retorno

exit:
	li $v0, 4			# seta a opera��o de impress�o de string			
	la $a0, string_result		# passa a string que ser� impressa para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 1			# seta a opera��o de impress�o de int
	move $a0, $s0			# move o int a ser impresso para $a0
	syscall				# faz a impress�o do int
