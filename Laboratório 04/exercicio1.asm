.data 
	string_input: .asciiz "Insira um valor x: "
	string_iteracoes: .asciiz "Insira um n�mero de itera��es para o m�todo: "
	string_result: .asciiz "A raiz de x �: "
	string_esperado: .asciiz "\nResultado esperado: "
	string_erro_abs: .asciiz "\nErro absoluto: "
	estimativa: .double 1
	num2: .double 2.0
	
.text
	li $v0, 4 			# seta a opera��o de impress�o de string
	la $a0, string_input		# passa um ponteiro que aponta para string_input para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 7			# seta a opera��o de leitura de double
	syscall				# faz a leitura do double, e salva em $f0
	
	li $v0, 4 			# seta a opera��o de impress�o de string
	la $a0, string_iteracoes	# passa um ponteiro que aponta para string_iteracoes para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 5			# seta a opera��o de leitura de int
	syscall				# faz a leitura de int que ser� o n� de itera��es
	move $t1, $v0			# move o valor lido que est� em $v0 para $t0
	
	la $s0, estimativa		# passa o endere�o de estimativa para $s0
	l.d $f2, 0($s0)			# passa o conte�do que est� em $s0 para $f2
	
	la $s1, num2			# passa o endere�o de num2 para $s1
	l.d $f6, 0($s1)			# passa o conte�do que est� em $s1 para $f6 ($f6 = 2)
	
	jal raiz_quadrada		# faz a chamada da fun��o raiz_quadrada, e desvia para a label
	j exit				# quando a fun��o terminar, da um jump para a label exit
	
raiz_quadrada:
	beq $t0, $t1, fim_funcao	# compara se o $t0 == $t1 (i == n� de itera��es), se sim, desvia para a label fim_funcao
	
	div.d $f4, $f0, $f2		# divide o valor de x (que est� em $f0) pela estimativa $f2 e salva em $f4
	add.d $f4, $f4, $f2		# soma em $f4 o valor de $f4 com $f2
	div.d $f4, $f4, $f6		# faz a divis�o de $f4 por 2 e salva em $f4
	mov.d $f2, $f4			# passa o valor em $f4 (resultado do c�lculo da estimativa) para $f2 (estimativa)
	
	addi $t0, $t0, 1		# incrementa o comparador do la�o ($t0) em 1
	j raiz_quadrada
	
fim_funcao:
	jr $ra				# faz o retorno para seguir a execu��o correta ap�s o t�rmino da fun��o

exit:
	li $v0, 4 			# seta a opera��o de impress�o de string
	la $a0, string_result		# passa um ponteiro que aponta para string_input para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 3			# seta a opera��o de impress�o de double
	mov.d $f12, $f2			# move o valor do c�lculo da raiz_quadrada usando o m�todo iterativo de Newton que est� em $f2 para $f12, para imprimir o double no console
	syscall				# faz a impress�o do double
	
	sqrt.d $f8, $f0			# faz a opera��o de raiz usando a instru��o em $f8
	
	li $v0, 4 			# seta a opera��o de impress�o de string
	la $a0, string_esperado	        # passa um ponteiro que aponta para string_input para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 3			# seta a opera��o de impress�o de double
	mov.d $f12, $f8			# move o valor do c�lculo da raiz_quadrada  usando a instru��o sqrt.d que est� em $f8 para $f12, para imprimir o double no console
	syscall				# faz a impress�o do double
	
	sub.d $f12, $f8, $f2		# faz o c�lculo do erro absoluto ($f8 resultado esperado - $f2 valor obtido) e salva em $f12
	abs.d $f12, $f12		# faz o m�dulo do erro absoluto
	
	li $v0, 4 			# seta a opera��o de impress�o de string
	la $a0, string_erro_abs		# passa um ponteiro que aponta para string_input para $a0
	syscall				# faz a impress�o da string
	
	li $v0, 3			# seta a opera��o de impress�o de double
	syscall				# faz a impress�o do double
	
	
	
	
	
	
	
