#.align 2 # the assembler will place the next byte at an address evenly divisible by integer
.text
.globl _main
_main:
	sw $a1,N
	addi $s0,$zero,0 #base
	addi $t0,$zero,0 #index midenismos
	sw $s0,HashTable($t0) #0 stin prwti thesi
		addi $t0,$t0,4 #+4 bytes gia ton next int
for:
	sw $s6,HashTable($t0) 
		addi $t0,$t0,4 #sw $s1,HashTable($t0) next
	
#sw $s1,0 #keys
#for:
 #   sw   $t1, HashTable($t0)
  #  addi $t0, $t0, 4
   # bne  $t0, 64, for
   
   addi $sp,$sp,-16 #stoiva gia 4 int
   

do_while:
    li $v0, 4
    la $a0, str_first
    syscall
    li $v0, 4
    la $a0, str_insert
    syscall
    li $v0, 4
    la $a0, str_find
    syscall
    li $v0, 4
    la $a0, str_show
    syscall
    li $v0, 4
    la $a0, str_exit
    syscall
    li $v0, 5
    syscall #choose an integer 
    
    
#methods#


insert:
	addi $sp,$sp,8 #2 vars
    	addi $t1,0 #int position;
    	jal findKey
    	li $v0, 5 #read an integer
    	syscall
    	sw $t2
    	jal hash
    	#add $t2, $zero, $v0
    	bne $t2,-1,existkey
    	beq $t2,-1,if
    
findKey:
	addi $sp,$sp,8 
	sw $s2,k #int k
	addi $t1,0 #int position;
	addi $t4,0 #int i = 0
	addi $t5,0 #int found = 0
	div $t1,$s2,$s1
	jal find_while
	jr $ra
find_while:
	bge $t4,$s1 and bnez $t4,$zero, outf
	addi $t4,$t4,1
	bne HashTable($t1),$s2,find_else
	sw $t5,1
	
find_else:
	addi $t1,$t1,1
	div $t1,$t1,$a1
outf:
	bne $t5,1,outelse
	jr $t1
outelse:
	jr -1
	
	
    
existkey:
	la $a0,exist_key
	li $v0,4
	syscall #print string
if:
	bgt $s1,10,else
	#int position
	
	
	
	
else:
	la $a0,full_hash
	li $v0,4
	syscall #print string
hash:               
    li $a1, 40 #arxiko kleidi/megethos pinaka
    div $t2, $a1
    mfhi $t3     #move the result to $t3
    jr $ra
 
addi $t0,$zero,0 
 
display:
	beq $t0,40,exit
	lw $t6,HashTable($t0)
	
	addi $t0,$t0,4
	
	li $v0,1
	move $a0,$t6
	syscall
	
	la $a0,Space
	li $v0,4
	syscall #new line
	
	j display
	
exit:
	li,$v0,10
	syscall
	

.data
HashTable:  .space  40 #megethos 4 bytes * 10
N: .word 10
str_first:  .asciiz "Type an option\n"
str_insert: .asciiz "(1)Insert Key"
str_find: .asciiz "(2)Find Key"
str_show: .asciiz "(3)Display Hash Table")
str_exit:   .asciiz "(4)Exit\n"
str_key:    .asciiz "\nChoice?"
new_key:    .asciiz "Give new key (greater than zero): "
zero_key:    .asciiz "Key must be greater than zero"
seaech_key:  .ascizz "Give key to search: "
notfound_key: .asciiz "Key not in hash table"
value_key: .asciiz "Key value = "
table_pos: .asciiz "Table posiition = "
exist_key: .asciiz "Key is already in hash table"
full_hash: .asciiz "Hash table is full"
print_pos_key: .asciiz "\nos key\n"
telos: .word 0
Space: .asciiz " "
.align 2

sep:        .asciiz " --> "
key: .word 0

