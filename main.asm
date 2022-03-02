## Made by
#	Gustavo Jose Hernandez Sotres
#	Alberto Sandoval Castro
#	03/02/2022
##

.data
.text

# Start addres x10010000

addi s0, zero, 3 ## Here we load the value N for how many disks we will use

prep:	# We will use this to set the N of disks and fill the disk on order from n to 1 in the space thery must be
	# we are goning to store the the start address of the 3 sticks on a0, a2, a4
	# and a1, a3, a5 to store the end, this will be used to take the top most disk
	
	addi t2, zero, 2	## this is used for comparison when we have the last addres
	
	lui a0, 0x10010		## Here we set te base addres where we will save first stick info on a0
	
	# This loops are used to advance nx4 the to get the address of start and end of each stick(array) space
	add t0, zero, a0
	add t1, zero, s0
loop_A: # We use this loop to advance to the end of this array space (A)

	addi t0, t0, 4		## We move t0 4 addreses up
	addi t1, t1, -1		## we decrease the copy of n
	bge t1, t2, loop_A	## we check if we are n-1 places moved
	add a1, zero, t0	## we move the end addres to a1
	addi t0, t0, 4		## we add 4 to get the next start address
	
	## we repeat 2 more times to get the addres of the start and end of the arrays
	add a2, zero, t0	
	add t1, zero, s0
loop_B: # We use this loop to advance to the end of this array space (B)

	addi t0, t0, 4
	addi t1, t1, -1
	bge t1, t2, loop_B
	add a3, zero, t0
	addi t0, t0, 4
	
	add a4, zero, t0
	add t1, zero, s0
loop_C: # We use this loop to advance to the end of this array space (C)

	addi t0, t0, 4
	addi t1, t1, -1
	bge t1, t2, loop_C
	add a5, zero, t0
	
#### Here we fill the first array space with the disks
	add t0, zero, a0	## We get the start addres of stick A
	add t1, zero, s0	## We get the values we are going to save we start to N and this will go dow to 1
	addi t2, zero, 1	## this is used for comparison of the current disk value and 1
loop:	# this loop is used to go from N to 1
	sw t1, 0(t0)		## We store on memory the current disk value
	addi t0, t0, 4		## we move the current addres 4 values up to store the next word
	addi t1, t1, -1		## we decrease the value of the current disk we are saving
	
	
	bge t1, t2, loop	## if our disk value is 1 or greater we go back to the loop

main: # Here well call the first time the hanoid_recursive section and jump to the end of the program

hanoid_recursive: # This is the section that will be call recursivelly 

end: # This is just the en of the program.
