# The library with functions for arithmetic operations on the array values.

.global sum_two_quad_arrays, sub_two_quad_arrays

.section .data

.section .text

    sum_two_quad_arrays:
        # A function to sum the content of two arrays of quadwords. The result is stored into the second array.
        # Args:
        #     %rdi: A pointer to the first array with quadwords inside.
        #     %rsi: A pointer to the second array with quadwords inside.
        #     %rdx: The number of elements to sum. For example, if you have arrays [1, 2, 3] and [5, 2, 7], and you sum them with %rdx = $2
        #            the result will be [6, 4, 7] because the function summed only the first 2 elements.
        #            It's an error to use a number greater than the number of elements in one of the arrays
        # Return: nothing.

        # Create the stack frame.
        push %rbp
        movq %rsp, %rbp
        subq $0, %rsp

        # %rcx is the counter of iterations.
        xorq %rcx, %rcx
        # %r8 is the carry flag value holder.
        xorq %r8, %r8

        stqa_first_iter:
            # Exit if it's the end.
            cmpq %rcx, %rdx
            jbe stqa_exit
            # Move the value of the first array.
            movq (%rdi, %rcx, 8), %rax
            # Add to the second.
            addq %rax, (%rsi, %rcx, 8)
            # Save the carriage flag value.
            adcq $0, %r8
            # increment the iteration counter.
            incq %rcx

        stqa_sum_loop:
            # Exit if it's the end.
            cmpq %rcx, %rdx
            jbe stqa_exit
            # Reset the first value buffer.
            movq $0, %rax
            # Add the carry.
            addq %r8, %rax
            # Reset the carry.
            movq $0, %r8
            # Add the value of the first array.
            addq (%rdi, %rcx, 8), %rax
            # Save the carriage flag value.
            adcq $0, %r8
            # Add to the second.
            addq %rax, (%rsi, %rcx, 8)
            # Save the carriage flag value.
            adcq $0, %r8
            # increment the iteration counter.
            incq %rcx
            # Repeat.
            jmp stqa_sum_loop

        stqa_exit:
            # Leave.
            movq %rbp, %rsp
            popq %rbp
            ret

    sub_two_quad_arrays:
        # A function to subtract the content of the first array of quadwords from the second. The result is stored into the second array.
        # Args:
        #     %rdi: A pointer to the first array with quadwords inside.
        #     %rsi: A pointer to the second array with quadwords inside.
        #     %rdx: The number of elements to subtract. Works the same way as the one in the the sum_two_quad_arrays.
        # Return: nothing.

        # Create the stack frame.
        push %rbp
        movq %rsp, %rbp
        subq $0, %rsp

        # %rcx is the counter of iterations.
        xorq %rcx, %rcx
        # %r8 is the carry flag value holder.
        xorq %r8, %r8

        subtqa_first_iter:
            # Exit if it's the end.
            cmpq %rcx, %rdx
            jbe subtqa_exit
            # Move the value of the first array.
            movq (%rdi, %rcx, 8), %rax
            # Subtruct from the second.
            subq %rax, (%rsi, %rcx, 8)
            # Save the carriage flag value.
            adcq $0, %r8
            # increment the iteration counter.
            incq %rcx

        subtqa_sub_loop:
            # Exit if it's the end.
            cmpq %rcx, %rdx
            jbe subtqa_exit
            # Reset the first value buffer.
            movq $0, %rax
            # Add the carry.
            addq %r8, %rax
            # Reset the carry.
            movq $0, %r8
            # Add the value of the first array.
            addq (%rdi, %rcx, 8), %rax
            # Save the carriage flag value.
            adcq $0, %r8
            # Subtruct from the second.
            subq %rax, (%rsi, %rcx, 8)
            # Save the carriage flag value.
            adcq $0, %r8
            # increment the iteration counter.
            incq %rcx
            # Repeat.
            jmp subtqa_sub_loop

        subtqa_exit:
            # Leave.
            movq %rbp, %rsp
            popq %rbp
            ret



