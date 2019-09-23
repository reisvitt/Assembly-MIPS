#******************************************************************
# Autor: Vitor Reis
# Funcao: Programa que informa o maior número de um vetor de 10 
#         posições, usando E/S. O programa exibe a frase 
#         “O maior numero eh: “ seguida do maior número verificado
#          no vetor.
# Data: 23 de setembro de 2019
#******************************************************************

.data
    A: .asciiz "Insira "
    B: .asciiz "º valor: "
    C: .asciiz "O maior numero eh: "
    input: .space 41
.text
.globl main

main:
    li $t0, 1 # endereco RAM
    li $t1, 0 #index array
    li $t3, 9 #tamanho maximo do index do array
    jal entradaDeDados

    li $t0, 1
    li $t2, 0
    lb $s0, input($t0) #primeiro elemento do array eh o maior ate o momento

    j verificarMaior

entradaDeDados:
    la $a0, A; # exibe primeira frase
    li $v0, 4
    syscall

    addi $a0, $t1, 1 #exibe index
    li $v0, 1
    syscall

    la $a0, B; # exibe segunda frase
    li $v0, 4
    syscall

    li $v0, 5 #ler inteiro
    syscall

    j salvarInteiroNoArray

salvarInteiroNoArray:
    sw $v0, input($t0); #salva o valor de $a0 no input com index $t0
    addi $t0, $t0, 4 # 4 eh o tamanho de cada inteiro
    addi $t1, $t1, 1 #index do array
    
    ble $t1, $t3, entradaDeDados #$t3 tamanho maximo do index do array
    jr $ra #volta para a main



verificarMaior:
    lw $t4, input($t0)
    slt $t5, $t4, $s0 #se $t4 for maior que $s0, $t5 = 0
    beq $t5, $zero, maior

    ble $t3, $t2, final # se $t3 <= $t2, ir para o final
    addi $t0, $t0, 4 #incrementa 4 no endereco de memoria RAM
    addi $t2, $t2, 1 #incrementa 1 no index
    j verificarMaior


maior:
    add $s0, $t4, $zero #joga o valor de $t4 em $s0
    
    ble $t3, $t2, final # se $t3 <= $t2, ir para o final
    addi $t0, $t0, 4 #incrementa 4 no endereco de memoria RAM
    addi $t2, $t2, 1 #incrementa 1 no index
    j verificarMaior

final:

    la $a0, C # exibe a ultima msg
    li $v0, 4
    syscall

    add $a0, $s0, $zero #exibe maior numero
    li $v0, 1
    syscall

    li $v0, 10 # exit
    syscall
