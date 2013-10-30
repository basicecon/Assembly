	.data
	.comm	a,8

	.text
format:
	.string "%d"
format2:
	.string "%d\n" 
format3:
	.string "sort\n"
format4:
	.string "Sorted:\n"

.global main 
main:

	movq	$format3, %rdi
	movq 	$0, %rax
	call 	printf

	movq	$0, %rbx
/*input*/
while1:	
	subq 	$8, %rsp
	addq	$1, %rbx	
	movq 	$format, %rdi
	movq	%rsp, %rsi
	movq	$0, %rax
	call 	scanf 

	cmp		$-1, %eax
	jle		endw
	jmp		while1
endw:

/*sort*/

	
for1:
	movq 	$1, %r10
	movq 	$2, %r11    /*j = 2 - n*/
for2:
	
	movq	%r11, %r12  /*array[j]*/
	imulq	$8, %r12	
	movq	%rsp, %rsi
	addq	%r12, %rsi
	movq	(%rsi), %r13
	movq	%rsi, %r8

	movq	%r11, %r12  /*array[j-1]*/  
	subq 	$1, %r12
	imulq	$8, %r12	
	movq	%rsp, %rsi
	addq	%r12, %rsi
	movq	(%rsi), %r14

	cmpq	%r13, %r14
	jle		endcmp
	movq	%r13, (%rsi)
	movq	%r14, (%r8)
	movq	%r11, %r10

endcmp:
	addq	$1, %r11
	cmpq	%r11, %rbx
	jl		endfor2
	jmp		for2
endfor2:
	cmpq	$1, %r10
	je		endfor1
	jmp		for1
endfor1:
	movq 	$1, %r15

	movq	$format4, %rdi
	movq 	$0, %rax
	call 	printf

loop_print:
	movq	%r15, %r12  /*array[j]*/
	imulq	$8, %r12	
	movq	%rsp, %rsi
	addq	%r12, %rsi
	movq	(%rsi), %rsi
	movq	$format2, %rdi
	movq 	$0, %rax
	call 	printf
	inc		%r15
	cmpq 	%r15, %rbx
	je	 	end_print
	jmp 	loop_print
end_print:
	

/*clean up*/
while2:	
	addq 	$8, %rsp
	subq	$1,	%rbx
	cmpq	$0, %rbx
	je 		end2
	jmp		while2
end2:
	ret

