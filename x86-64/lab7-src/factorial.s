	.text
.globl fact
	.type	fact, @function
fact:
	/* double fact(int n) */
	/* n = %rdi */
	movq 	$1, %rax
	movq 	$1, %rsi
while:
	cmpq 	%rdi, %rsi
	je 	afterw	
	addq 	$1, %rsi
	imulq 	%rsi, %rax
	jmp 	while 
afterw:
	cvtsi2sd	%rax, %xmm0
	ret
