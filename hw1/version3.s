.data
number:   .word 10000
str1:     .string "The steps to Reduce a Number to Zero of "  # First part of the output message
str2:     .string " is "                 # Second part of the output message
.text
main:
        lw a1, number
        jal ra, numberOfSteps     
        mv a1, a0
        lw a0, number
        jal ra, printResult
        li a7, 10                  # System call code for exiting the program
        ecall                      # Make the exit system call


# numberOfSteps
# a1: Input argument (number)
# a0: Output argument (count)

numberOfSteps:
        addi sp, sp, -4  
        sw ra, 0(sp)
        beqz a1, end             # if number is 0, count won't be 0. prevent this condition
        # length funtion
        li a0, 0                 # set clz to 0
        mv t0, a1                # Save original input value (number) in temporary register t0
        mv t1, a1                # Save original input value (number) in temporary register t0
        srli t0, t0, 16          
        bne t0, x0, S1   
        addi a0, a0, 16
        slli t1, t1, 16          
S1:
        mv t0, t1
        srli t0, t0, 24
        bne t0, x0, S2
        addi a0, a0, 8
        slli t1, t1, 8   
S2:
        mv t0, t1
        srli t0, t0, 28
        bne t0, x0, S3
        addi a0, a0, 4
        slli t1, t1, 4
S3:
        mv t0, t1
        srli t0, t0, 30
        bne t0, x0, S4
        addi a0, a0, 2
        slli t1, t1, 2
S4:
        mv t0, t1
        srli t0, t0, 31
        bne t0, x0, S5
        addi a0, a0, 1 
S5:
        li t1, 32
        sub a0, t1, a0           # 32 - clz 
        # count funtion
        li t1, 0x55555555
        and t2, a1, t1
        srli a1, a1, 1
        and a1, a1, t1
        add a1, a1, t2
        li t1, 0x33333333
        and t2, a1, t1
        srli a1, a1, 2
        and a1, a1, t1
        add a1, a1, t2
        li t1, 0x0F0F0F0F
        and t2, a1, t1
        srli a1, a1, 4
        and a1, a1, t1
        add a1, a1, t2 
        li t1, 0x00FF00FF
        and t2, a1, t1
        srli a1, a1, 8
        and a1, a1, t1
        add a1, a1, t2
        li t1, 0x0000FFFF
        and t2, a1, t1
        srli a1, a1, 16
        and a1, a1, t1
        add a1, a1, t2  
        # length(num) - 1 + count(num)
        add a0, a0, a1
        addi a0, a0, -1    
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