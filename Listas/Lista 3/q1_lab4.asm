.data
	input_raiz: .asciiz "valor N para calcular a raiz: "
	input_iteracoes: .asciiz "digite o número de iterações: "
	output: .asciiz "raiz de N: "
	estimativa: .double 1
	num2: .double 2
	
.text

	li $v0, 4
	la $a0, input_raiz
	syscall
	
	li $v0, 7
	syscall
	mov.d $f2, $f0
	
	li $v0, 4
	la $a0, input_iteracoes
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $t1, estimativa
	l.d $f4, 0($t1) #guarda e etimativa
	
	la $t1, num2
	l.d $f6, 0($t1) #guarda o número dois
	
	jal raiz
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 3
	mov.d $f12, $f8
	syscall
	
	j fim

raiz:
	li $t1, 0 #contador
	li $t2, 1 #estimativa inicial = 1
loop:
	bge $t1, $t0, fim_loop
	div.d $f8, $f2, $f4
	add.d $f4, $f8, $f4
	div.d $f4, $f4, $f6
	addi $t1, $t1, 1
	j loop
fim_loop:
	jr $ra
	
fim:
	nop
	
