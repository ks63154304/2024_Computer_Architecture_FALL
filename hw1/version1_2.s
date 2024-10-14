.data
number:   .word 123
str1:     .string "The steps to Reduce a Number to Zero of "  # First part of the output message
str2:     .string " is "                 # Second part of the output message
.text
main:
        lw a1, number             # Load the argument (10000) into register a1
        jal ra, numberOfSteps     # Jump-and-link to the 'numberOfSteps' function
        mv a1, a0                 # Move the result (count) from a0 to a1 for printing
        lw a0, number             # Reload input argument(10000) to a0 for printing
        jal ra, printResult       # Call the function to print the result
        li a7, 10                 # System call code for exiting the program
        ecall                     # Make the exit system call


# numberOfSteps
# a1: Input argument (number)
# a0: Output argument (count)

numberOfSteps:
        addi sp, sp, -4  
        sw ra, 0(sp)
        li a0, 0                 # Set count number to 0  
        li t0, 2                 # Save dividor(2) in temporary register t0
start:
        beqz a1, end             # If number is 0, count won't be 0. prevent this condition
        mv t1, a1                # Save dividend(number) in temporary register t1
        bgt t0, t1, ldend        # If dividend is less than divisor, skip longdivision
        # CLZ of input number 
        li t4, 0                 # n = 0
        li t2, 0x0000FFFF        # Save 0x0000FFFF in temporary register t2
        bgt t1, t2, S1           # If t1 is greater than t2, skip following instrcution
        addi t4, t4, 16          # n += 16
        slli t1, t1, 16          # x <<= 16
S1:        
        li t2, 0x00FFFFFF        # Save 0x00FFFFFF in temporary register t2
        bgt t1, t2, S2           # If t1 is greater than t2, skip following instrcution
        addi t4, t4, 8           # n += 8
        slli t1, t1, 8           # n += 8
S2:   
        li t2, 0x0FFFFFFF        # Save 0x0FFFFFFF in temporary register t2
        bgt t1, t2, S3           # If t1 is greater than t2, skip following instrcution
        addi t4, t4, 4           # n += 8
        slli t1, t1, 4           # n += 8
S3:   
        li t2, 0x3FFFFFFF        # Save 0x3FFFFFFF in temporary register t2
        bgt t1, t2, S4           # If t1 is greater than t2, skip following instrcution
        addi t4, t4, 2
        slli t1, t1, 2
S4:   
        li t2, 0x7FFFFFFF        # Save 0x7FFFFFFF in temporary register t2
        bgt t1, t2, longdivision
        addi t4, t4, 1

longdivision:
        # number divide 2
        li t1, 30         # CLZ of 2 is 30
        sub t5, t1, t4    # Difference between clz of divisor and clz of dividend
        sll t2, t0, t5    # Align the most significant digit of divisor and dividend
        li t3, 0          # Set quotient in temporary register t3
        li t4, 0          # Record number of divisor shift
        mv t1, a1         # Restore number to temporary register t1
ldloop:
        bgt t2, t1, skip  # If divisor is larger than dividend, skip substraction
        sub t1, t1, t2
        addi t3, t3, 1
skip:        
        beq  t4, t5, ldend # If number of divisor shift is eqaul to number of alignment shift
        slli t3, t3, 1     # 
        srli t2, t2, 1
        addi t4, t4, 1
        j ldloop
ldend:
        beqz t1, even
        addi a1, a1, -1
        addi a0, a0, 1  #count add 1 
        j start
even:
        mv a1, t3       #t2 record the quotient of 2 divide number
        addi a0, a0, 1  #count add 1 
        j start
end:
        lw ra, 0(sp)    
        addi sp, sp, 4
        ret


# This function prints the factorial result in the format:
# a0: The original input value (number)
# a1: The number of Steps to Reduce a Number to Zero  (count)
printResult:
        mv t0, a0                  # Save original input value (X) in temporary register t0
        mv t1, a1                  # Save factorial result (Y) in temporary register t1

        la a0, str1                # Load the address of the first string ("Factorial value of ")
        li a7, 4                   # System call code for printing a string
        ecall                      # Print the string

        mv a0, t0                  # Move the original input value (X) to a0 for printing
        li a7, 1                   # System call code for printing an integer
        ecall                      # Print the integer (X)

        la a0, str2                # Load the address of the second string (" is ")
        li a7, 4                   # System call code for printing a string
        ecall                      # Print the string

        mv a0, t1                  # Move the factorial result (Y) to a0 for printing
        li a7, 1                   # System call code for printing an integer
        ecall                      # Print the integer (Y)

        ret                        # Return to the caller