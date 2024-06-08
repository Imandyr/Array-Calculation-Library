# The library with functions for arithmetic operations on the array values.


.global sum_2_arrays


.section .data

    .equ SUM_2_ARRAYS_STACK_SIZE, 0


.section .text

    sum_2_arrays:
        # Create the stack frame.
        push %rbp
        movq %rsp, %rbp
        subq $SUM_2_ARRAYS_STACK_SIZE, %rsp

        # Return back.
        movq %rbp, %rsp
        popq %rbp
        movq $13, %rax
        ret


