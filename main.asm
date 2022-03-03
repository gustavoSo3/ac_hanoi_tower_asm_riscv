## Made by
#	Gustavo Jose Hernandez Sotres
#	Alberto Sandoval Castro
#	03/02/2022
##


# Start addres x10010000

addi s0, zero, 8 ## Here we load the value N for how many disks we will use

add t1, zero, s0
addi t2, zero, 1

prep: 
	lui t0, 0x10010
LOOP_A:
	sw t1, 0(t0)
	addi t1, t1, -1
	addi t0, t0, 4
	bge t1, t2, LOOP_A
	
	add s1, zero, t0
	addi s1, s1, -4
	addi t0, t0, -4
	add s2, zero, t0
	addi t2, zero, 1
	add t1, zero, s0
LOOP_B:
	addi t1, t1, -1
	addi t0, t0, 4
	bge t1, t2, LOOP_B
	
	add s3, zero, t0


main: # Here well call the first time the hanoid_recursive section and jump to the end of the program recursive
	add a0, zero, s0
	add a1, zero, s1
	add a2, zero, s2
	add a3, zero, s3
	jal ra, hanoi_recursive
	jal zero, end
	
hanoi_recursive: # This is the section that will be call recursivelly 
	addi sp, sp, -4
	sw ra, 0(sp)
	
	add t0, zero, a0
	add t1, zero, a1
	add t2, zero, a2
	add t3, zero, a3
	
	beq t0, zero, end_hanoi_recursive
	
	addi a0, t0, -1
	add a1, zero, t1
	add a2, zero, t3
	add a3, zero, t2
	jal ra, hanoi_recursive
	addi t0, a0, 1
	add t1, zero, a1
	add t2, zero, a3
	add t3, zero, a2
	
	lw t6, 0(t1)
	sw zero, 0(t1)
	beq t6, zero, no_move
	addi t1, t1, -4
	addi t2, t2, 4
	sw t6, 0(t2)
	
no_move:
	
	addi a0, t0, -1
	add a1, zero, t3
	add a2, zero, t2
	add a3, zero, t1
	jal ra, hanoi_recursive
	addi t0, a0, 1
	add t1, zero, a3
	add t2, zero, a2
	add t3, zero, a1
	
end_hanoi_recursive:
	lw ra, 0(sp)
	addi sp, sp, 4
	
	add a0, zero, t0
	add a1, zero, t1
	add a2, zero, t2
	add a3, zero, t3
	
	jalr zero, ra, 0

end: # This is just the en of the program.
	jal zero, end
