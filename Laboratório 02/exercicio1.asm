.data
	num0: .byte 63     # valor do byte para representar o n�mero 0
	num1: .byte 6      # valor do byte para representar o n�mero 1
	num2: .byte 91     # valor do byte para representar o n�mero 2
	num3: .byte 79     # valor do byte para representar o n�mero 3
	num4: .byte 102    # valor do byte para representar o n�mero 4
	num5: .byte 109    # valor do byte para representar o n�mero 5
	num6: .byte 125    # valor do byte para representar o n�mero 6
	num7: .byte 7      # valor do byte para representar o n�mero 7
	num8: .byte 127    # valor do byte para representar o n�mero 8
	num9: .byte 111    # valor do byte para representar o n�mero 9


.text
	li $s0, 0xFFFF0010 #carrega o endere�o do display da direita em reg $s0

	la $t0, num0     #carrega o endere�o de num0 no reg $t0
	li $t2, 0   #carrega o valor 0 para o reg $t2, que ser� o contador do loop
	li $t3, 10   #carrega o valor 10 para o reg $t3, que servir� como o comparador do loop


Loop:	lb $t1, 0($t0)   #carrega o conte�do de num0 para $t0
	sb $t1, ($s0)   #passa o conte�do de num0 para o endere�o do display
	addi $t2, $t2, 1   #soma um no contador, ou seja, soma um em $t2
	addi $t0, $t0, 1   #soma um no endere�o base, que � o endere�o de num0;
	beq $t2, $t3, Exit #se o contador != comparador, ele refaz o loop, se n�o, da um jump para Exit
	j Loop

Exit:	nop