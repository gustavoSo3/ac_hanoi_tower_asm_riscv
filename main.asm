## Made by
#	Gustavo Jose Hernandez Sotres
#	Alberto Sandoval Castro
#	03/02/2022
##

addi s0, zero, 3			## Here we load the value N for how many disks we will use

add t1, zero, s0			## t1 is used on prep to generate te base tower and its disks and get the initial
					## addresses of the 3 sticks,
addi t2, zero, 1			## t2 is just used for the comparition for when to end going forward on
					## on the address

prep: 
	lui t0, 0x10010			## t0 will be used to store the addres we are currentlly on
					## we set the upper word to 0x10010 because the initial address is x10010000
LOOP_A:
					# At the same time we move up on the addres for the same stick, we fill it
					# with the disks
	sw t1, 0(t0)			## we store te bigger disk on the first address
	addi t1, t1, -1			## we decrease the number of disk
	addi t0, t0, 4			## and we add 4 to get the next word address
	bge t1, t2, LOOP_A		## we check if we hare at the lower value disk, if we ain't we go back to loop_A
	
					## In the case we finished filling the disks we store that address as the
					## address for the first stack and allso the second
					## since the second stack is empty and the stacks space are next to
					## each other if the first stack is full and the second is empty, they will have
					## the same address		
					# NOTE: We store the inital address of the stacks on s1,s2,s3
	addi t0, t0, -4			## we go back 1, for logic reasons
	add s1, zero, t0		## We store the address of the first stack
	add s2, zero, t0		## We store the address of the second stack
	add t1, zero, s0		## We reset t2 to have the value of N
LOOP_B:
	addi t1, t1, -1			## and we keep moving forward, only this time, we dont store numbers
	addi t0, t0, 4			## we just use the loop to move to the start addres of the 3rd stack
	bge t1, t2, LOOP_B
	
	add s3, zero, t0		## here t0 has te start addres of the 3rd stack, so we save it.


main:			# Here well call the first time the hanoid_recursive section 
			# and jump to the end of the program recursive
	add a0, zero, s0	## we move the arguments to the function,	
	add a1, zero, s1	## a0 = N, a1 = SOURCE, a2 = TARGET a3 = AUXILIARY
	add a2, zero, s2
	add a3, zero, s3
	jal ra, hanoi_recursive	## here we call the hanoi_recursive function, and we store the return address on
				## ra
	jal zero, end		## this is were we will return when the program finishes to we just jump to
				## the end of the program and don't store the return address
	
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
