.global	keyMixing, byteSubstitution, shiftRows, cipher

.section	.data
sbox:	.byte	99,124,119,123,-14,107,111,-59,48,1,103,43,-2,-41,-85,118
		.byte	-54,-126,-55,125,-6,89,71,-16,-83,-44,-94,-81,-100,-92,114,-64
		.byte	-73,-3,-109,38,54,63,-9,-52,52,-91,-27,-15,113,-40,49,21
		.byte	4,-57,35,-61,24,-106,5,-102,7,18,-128,-30,-21,39,-78,117
		.byte	9,-125,44,26,27,110,90,-96,82,59,-42,-77,41,-29,47,-124
		.byte	83,-47,0,-19,32,-4,-79,91,106,-53,-66,57,74,76,88,-49
		.byte	-48,-17,-86,-5,67,77,51,-123,69,-7,2,127,80,60,-97,-88
		.byte	81,-93,64,-113,-110,-99,56,-11,-68,-74,-38,33,16,-1,-13,-46
		.byte	-51,12,19,-20,95,-105,68,23,-60,-89,126,61,100,93,25,115
		.byte	96,-127,79,-36,34,42,-112,-120,70,-18,-72,20,-34,94,11,-37
		.byte	-32,50,58,10,73,6,36,92,-62,-45,-84,98,-111,-107,-28,121
		.byte	-25,-56,55,109,-115,-43,78,-87,108,86,-12,-22,101,122,-82,8
		.byte	-70,120,37,46,28,-90,-76,-58,-24,-35,116,31,75,-67,-117,-118
		.byte	112,62,-75,102,72,3,-10,14,97,53,87,-71,-122,-63,29,-98
		.byte	-31,-8,-104,17,105,-39,-114,-108,-101,30,-121,-23,-50,85,40,-33
		.byte	-116,-95,-119,13,-65,-26,66,104,65,-103,45,15,-80,84,-69,22
	
.section	.text
keyMixing:
	#rdi contains input
	#rsi contains key
	#Assign local vars int i and j
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $4, -4(%rbp)
		
	loop1_keyMixing:
		movl $4, -8(%rbp)
		loop2_keyMixing:
			movb (%rsi), %r10b
			xorb %r10b, (%rdi)
			
			incq %rdi
			incq %rsi
			
			decl -8(%rbp)
			cmpl $0, -8(%rbp)
			jg loop2_keyMixing
			
		decl -4(%rbp)
		cmpl $0, -4(%rbp)
		jg loop1_keyMixing
	
	leave
	ret


byteSubstitution:
	#rdi contains input
	#Assign local vars int i and j
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $4, -4(%rbp)
	
	lea sbox(%rip), %rsi
		
	loop1_byteSubstitution:
		movl $4, -8(%rbp)
		loop2_byteSubstitution:
			xor %r10, %r10
			movb (%rdi), %r10b
			movb (%rsi,%r10,1), %r11b
			movb %r11b, (%rdi) 
			
			incq %rdi
			
			decl -8(%rbp)
			cmpl $0, -8(%rbp)
			jg loop2_byteSubstitution
			
		decl -4(%rbp)
		cmpl $0, -4(%rbp)
		jg loop1_byteSubstitution
	
	leave
	ret


shiftRows:
	#rdi contains input
	#Assign local vars int i, j and l 
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, -4(%rbp)
			
	loop1_shiftRows:
		#insert the current array address in r11
		movl $0, -8(%rbp)
		xor %r10, %r10
		movl -4(%rbp), %r10d
		lea (%rdi, %r10, 4), %r11
		
		loop2_shiftRows:
			#shift the current array once
			movl $0, -12(%rbp)
			mov %r11, %r10
			loop3_shiftRows:
				#bubble up the first element using swaps
				movb (%r11), %al
				movb 1(%r11), %dl
				movb %dl, (%r11)
				movb %al, 1(%r11)
				
				incq %r11
				incl -12(%rbp)
				cmpl $3, -12(%rbp)
				jl loop3_shiftRows
			mov %r10, %r11	
			
			#for i times
			incl -8(%rbp)
			mov -4(%rbp), %r10
			cmp %r10, -8(%rbp)
			jl loop2_shiftRows
						
		incl -4(%rbp)
		cmpl $4, -4(%rbp)
		jl loop1_shiftRows
	
	leave
	ret

cipher:
	ret
