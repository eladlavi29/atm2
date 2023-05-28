.globl my_ili_handler

.text
.align 4, 0x90


my_ili_handler:
	
	pushq %rbp
	movq %rsp, %rbp
	
	pushq %rax
	pushq %rbx
	pushq %rcx
	pushq %rdx
	pushq %r9
	pushq %r10
	pushq %r11
	pushq %r12
	pushq %r13

	movq %rdi, %r12

	movq $0, %r13
	
	movq 8(%rbp), %r9
	movq (%r9), %rax
	
	cmpb $0x0f, %al 
	jne external_funcs
	shrq $8, %rax
	incq %r13
	

external_funcs:
    	movq %rax, %rdi
	call what_to_do 

	
	cmpq $0, %rax
	jne continue
	
	movq %r12,%rdi
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %rdx
	popq %rcx
	popq %rbx
	popq %rax

	movq %rbp, %rsp
	popq %rbp

	jmp *old_ili_handler
	
continue:
	
	movq $0, %r11
	movq %rax, %rdi
	movq 8(%rbp), %r9
	incq %r9
	cmpq $1, %r13
	jne go_back
	incq %r9
go_back: movq %r9, 8(%rbp)
	

end:
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %rdx
	popq %rcx
	popq %rbx
	popq %rax
	movq %rbp, %rsp
	popq %rbp
	iretq
