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
        li a0, 0        #set count nunber to 0  
start:
        beqz a1, end
        andi t0, a1, 0x1
        addi t0, t0, 1
        add a0, t0, a0
        srli a1, a1, 1
        j start
end:
        addi a0, a0, -1 
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