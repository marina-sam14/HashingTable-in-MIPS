.data
str_first:  .asciiz "Type an option\n"
str_insert: .asciiz "(1)Insert\n"
str_remove: .asciiz "(2)Remove\n"
str_search: .asciiz "(3)Search\n"
str_show:   .asciiz "(4)Show all\n"
str_exit:   .asciiz "(0)Exit\n"
str_key:    .asciiz "Type a key\n"
.align 2
HashTable:  .space  16
sep:        .asciiz " --> "

.align 2
.text
.globl main
main:       
    addi $t0, $zero, 0  #t0 = array's base
    addi $t1, $zero, -1     #t1 = content null 

populate:       sw   $t1, HashTable($t0)
    addi $t0, $t0, 4
    bne  $t0, 64, populate

#starts menu
do_while:
    li $v0, 4
    la $a0, str_first
    syscall
    li $v0, 4
    la $a0, str_insert
    syscall
    li $v0, 4
    la $a0, str_remove
    syscall
    li $v0, 4
    la $a0, str_search
    syscall
    li $v0, 4
    la $a0, str_show
    syscall
    li $v0, 4
    la $a0, str_exit
    syscall
    li $v0, 5
    syscall

#switch()
    addi $t1, $zero, 1
    beq   $v0, $t1, case1
    addi $t1, $zero, 0
    beq   $v0, $t1, case0

case1:      
    li $v0, 4
    la $a0, str_key
    syscall
    j insert

case0:
    li $v0, 10
    syscall


#Functions

insert:     
    li $v0, 5
    syscall
    add $t2, $zero, $v0     #stores scanf return in t2

    jal hash

    li  $v0,9             #malloc
    li  $a0,8             
    syscall

    add  $s1, $zero, $v0           # $s1 = &(first node)
        sw  $s1, HashTable($t3)   #stores s1 in hash position in array
        move  $s0, $s1

    add $t0, $zero, $t2             
        sw $t0, 0($s1)      #stores int in the first 4 bytes allocated

        li $s2, 2             # counter = 2


loop: 
    li $v0, 4
    la $a0, str_key
    syscall
    li $v0, 5
    syscall
    add $t2, $zero, $v0     #stores v0 in t2

    li $t9, -1          #stop inserting
    beq $v0, $t9, fim

    jal hash

        li $v0,9             
        li $a0,8             
        syscall        

    # point to previous
        sw $v0,4($s1)        # $s1 = &(previous)

    #new is current
        move $s1,$v0

    #malloc struct
        sw $t2,0($s1)

        addi $s2,$s2,1         # counter++
        b loop

fim:
    sw $zero,4($s1)     # stores null in the last 4 bytes
    lw $s0, HashTable($t3)
        j do_while           



hash:               
    li $a1, 16  
    div $t2, $a1
    mfhi $t3    
    jr $ra