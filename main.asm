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
	# we are goning to store the the base address of the 3 sticks on a0, a1, a2
	lui a0, 0x10010			## Here we set te base addres where we will save first stick info on a0
	add t0, a0, s0			## We store on t0 the addres for the next stick a0 + N => a0 + s0
	add a1, zero, t0		## We store it on a1
	add t0, a1, s0			## We store on t0 the addres for the next stick a1 + N => a1 + s0
	add a2, zero, t0		## We store it on a2
	
	add t1, zero, s0
	add t0, zero, a0
loop:
	sw t1, 0(t0)
	addi t0, t0, 4
	addi t1, t1, -1
	
	addi t3, zero, 1
	
	bge t1, t3, loop
	

main: # Here well call the first time the hanoid_recursive section and jump to the end of the program

hanoid_recursive: # This is the section that will be call recursivelly 

end: # This is just the en of the program.
