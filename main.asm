## Made by
#	Gustavo Jose Hernandez Sotres
#	Alberto Sandoval Castro
#	03/02/2022
##

.data
.text

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
	
	add a0, zero, t0
	addi a0, a0, -4
	
	add t1, zero, s0
LOOP_B:
	addi t1, t1, -1
	addi t0, t0, 4
	bge t1, t2, LOOP_B
	
	add a1, zero, t0
	addi a1, a1, -4
	
	add t1, zero, s0
LOOP_C:
	addi t1, t1, -1
	addi t0, t0, 4
	bge t1, t2, LOOP_C
	
	add a2, zero, t0
	addi a2, a2, -4


main: # Here well call the first time the hanoid_recursive section and jump to the end of the program recursive

hanoi_recursive: # This is the section that will be call recursivelly 

end: # This is just the en of the program.
