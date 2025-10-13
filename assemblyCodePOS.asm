.data
msg_a: .asciiz "Insira o valor de A: "
msg_b: .asciiz "Insira o valor de B: "
msg_c: .asciiz "Insira o valor de C: "
msg_s: .asciiz "O valor de S e: "

.text

# Exibir_msg_a
la $a0, msg_a
jal ler_valor #chama funcao
move $s0, $v0

# Exibir_msg_b
la $a0, msg_b
jal ler_valor
move $s1, $v0

# Exibir_msg_c
la $a0, msg_c
jal ler_valor
move $s2, $v0

jal calcular
move $s3, $v0

la $a0, msg_s
move $a1, $s3
jal saida

li $v0, 10
syscall

#/////////////////////////////////////////////

ler_valor:
li $v0, 4
syscall
	
# Ler msg_a
li $v0, 5
syscall
	
jr $ra

calcular:	
# Negar a,b,c
xori $s3,$s0,0000000000000001 #!a
xori $s4,$s1,0000000000000001 #!b
xori $s5,$s2,0000000000000001 #!c

# (A + B + !C)*(A + !B + C)*(A + !B + !C)*(!A + B + C)
or $t0, $s0, $s1
or $t0, $t0, $s5

or $t1, $s0, $s4
or $t1, $t1, $s2

or $t3, $s0, $s4
or $t3, $t3, $s5

or $t4, $s3, $s1
or $t4, $t4, $s2

and $t5, $t0, $t1
and $t6, $t5, $t3
and $t7, $t6, $t4

move $v0, $t7
jr $ra

# Exibir saida
saida:
li $v0, 4
syscall		    # imprime mensagem									

li $v0, 1
move $a0, $a1
syscall             # imprime valor

jr $ra
