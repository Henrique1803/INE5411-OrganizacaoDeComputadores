.data
	num0: .byte 63     # valor do byte para representar o número 0
	num1: .byte 6      # valor do byte para representar o número 1
	num2: .byte 91     # valor do byte para representar o número 2
	num3: .byte 79     # valor do byte para representar o número 3
	num4: .byte 102    # valor do byte para representar o número 4
	num5: .byte 109    # valor do byte para representar o número 5
	num6: .byte 125    # valor do byte para representar o número 6
	num7: .byte 7      # valor do byte para representar o número 7
	num8: .byte 127    # valor do byte para representar o número 8
	num9: .byte 111    # valor do byte para representar o número 9


.text
	li $s0, 0xFFFF0010 #carrega o endereço do display da direita em reg $s0

	la $t0, num0     #carrega o endereço de num0 no reg $t0
	li $t2, 0   #carrega o valor 0 para o reg $t2, que será o contador do loop
	li $t3, 10   #carrega o valor 10 para o reg $t3, que servirá como o comparador do loop


Loop:	lb $t1, 0($t0)   #carrega o conteúdo de num0 para $t0
	sb $t1, ($s0)   #passa o conteúdo de num0 para o endereço do display
	addi $t2, $t2, 1   #soma um no contador, ou seja, soma um em $t2
	addi $t0, $t0, 1   #soma um no endereço base, que é o endereço de num0;
	beq $t2, $t3, Exit #se o contador != comparador, ele refaz o loop, se não, da um jump para Exit
	j Loop

Exit:	nop