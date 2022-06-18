.data
String1: .asciiz "Give me n: "  
String2: .asciiz "Give me k: "
CRLF: .asciiz "\n"
StringMain: .asciiz "Please enter n >= k >= 0"
i: .word 1
factorial_n: .word 1
factorial_k: .word 1
factorial_n_k: .word 1
par: .asciiz "("
comma: .asciiz ","
par2: .asciiz ")"
ison: .asciiz  "="

.text
.globl main
main:
	
	li $v0,4
	la $a0,String1
	syscall
	
	li $v0,5
	syscall #read
	move $t0,$v0
	
	
	
	la $a0,CRLF
	li $v0,4
	syscall #new line
	
	li $v0,4
	la $a0,String2
	syscall
	
	li $v0,5
	syscall 
	move $t1,$v0
	
  
	
	ble $t0,$t1,done
	ble $t1,0,done 
	jal combinations 
	
	
	
	

	


#-----------------------------------------

	#$to =n
	#$t1 =k
	#$t2 =i
	#$t3=n-k
	#$t4=k*(n-k)
	#$s1 = result
	
	#$a1=fac_n
	#$a2=fac_k
	#$a3=fac_n_k
	
	

#------------------------------------------

combinations:	
	move $a0,$v0
	blt $t0,0,exit #<
	blt $t1,0,exit#<
	
	lw $t2,i
	lw $a1,factorial_n
	
	lw $a2,factorial_k
	
	lw $a3,factorial_n_k
	
	
	

	
loop1:
	
	blt $t0,$t2,loop #<
	mul $a1,$a1,$t2
	add $t2,$t2,1 	#i=i+1
	jal loop1
	
loop:
	sub $t2,$t2,$t0 #i=i-n gia na ginei iso me 1
	jal loop2
	
	
	
loop2:
	
	bgt $t2,$t1,l2 #i>k kalese to l2 gia na ginei i=1
	mul $a2,$a2,$t2
	add $t2,$t2,1
	jal loop2
	
l2:
	sub $t2,$t2,$t1 #i=i-k gia na ginei iso me 1
	jal loop3
	
loop3:
	
	
	sub $t3,$t0,$t1 #n-k
	blt $t3,$t2,exit #(k-n)<i pigaine sto exit
	mul $a3,$a3,$t2
	add $t2,$t2,1
	jal loop3 #trexei
	
	
		

done:	li $v0,4
	la $a0,StringMain
	syscall
	
exit:
	mul $s0,$a2,$a3
	div $s1,$a1,$s0
	
	li $v0,4
	la $a0,par
	syscall
	
	li $v0,1
	la $a0,($t0)
	syscall
	
	li $v0,4
	la $a0,comma
	syscall
	
	li $v0,1
	la $a0,($t1)
	syscall
	
	li $v0,4
	la $a0,par2
	syscall
	
	li $v0,4
	la $a0,ison
	syscall
	
	move $a0,$s1
	li $v0,1
	syscall #print result
	
	la $a0,CRLF
	li $v0,4
	syscall
	
	
	 
	
	li $v0,10
	syscall #exit
	
	
	
