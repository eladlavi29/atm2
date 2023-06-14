.global _start

.section .text
_hw3_unicorn:
	#your code here
	#rsi contains the prev leaf
	xor %rsi, %rsi
	#rdi contains the iterator
	movq root(%rip), %rdi	 
	testq %rdi, %rdi
	je end_HW1
	
	#rdx contains the new node's val
	movq new_node(%rip), %rdx
	
	#find the father of the fathr of new node
	loop1_HW1:	
		mov %rdi, %rsi
		#Check if the current node has the same val as val
		cmp %rdx, (%rdi)
		je end_HW1
				
		#Iterate through the tree
		cmp %rdx, (%rdi) #if current node val >= new node val
		ja newNodeValIsSmaller_HW1
		
		#if current node val < new node val
		mov 16(%rdi), %rdi
		jmp newNodeValIsSmallerEnd_HW1
		
		newNodeValIsSmaller_HW1:
		mov 8(%rdi), %rdi
		
		newNodeValIsSmallerEnd_HW1:
		
		testq %rdi, %rdi
		jne loop1_HW1
		
	#set the new node to be a son of the father	
	cmp %rdx, (%rsi) #if father val >= new node val
	ja newNodeIsLeftSon_HW1
	
	#if current node val < new node val
	movq $new_node, 16(%rsi)
	jmp newNodeIsLeftSonEnd_HW1
	
	newNodeIsLeftSon_HW1:
	movq $new_node, 8(%rsi)
	
	newNodeIsLeftSonEnd_HW1:	
		
end_HW1:

