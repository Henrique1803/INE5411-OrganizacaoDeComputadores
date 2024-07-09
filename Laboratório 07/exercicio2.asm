.data
	matriz: .space 1024 #16*16*4 bytes
.text
	li $s0, 16 		     # comparador dos loops
	li $t0, 0		     # contador do primeiro loop
	li $t1, 0		     # contador do segundo loop
	li $t2, 0 		     # contador para preencher a matriz
	li $t3, 0		     # endereço a ser acessado na matriz
	la $s1, matriz	             # endereço base da matriz
	
	
laco_coluna:
	li $t1, 0
	bge $t0, $s0, fim_laco_coluna
	
laco_linha:
	bge $t1, $s0, fim_laco_linha
	
	mul $t3, $t1, $s0
	add $t3, $t0, $t3
	mul $t3, $t3, 4
	add $t3, $s1, $t3
	
	sw $t2, 0($t3)
	
	addi $t2, $t2, 1

	addi $t1, $t1, 1
	
	j laco_linha
	
fim_laco_linha:
	
	addi $t0, $t0, 1
	
	j laco_coluna
	
fim_laco_coluna:
	nop
