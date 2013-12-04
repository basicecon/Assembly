.text
.global main
main:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments

	# push 8
	movq $8,%rbx

	# push 20
	movq $20,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Local var a
	movq %rbx, 128(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
for_start_0:
	movq 120(%rsp), %rbx

	# push 20
	movq $20,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_0
	jmp for_statement_0
for_increment_0: 
continue_start_0: 
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
	jmp for_start_0
for_statement_0: 
	movq 120(%rsp), %rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 3
	movq $3,%rbx
	movq 120(%rsp), %r10

	# *
	imulq %r10,%rbx
	movq %rbx, (%rbp)
	jmp for_increment_0
for_end_0: 
break_end_0: 
	#top=0

	# push string "Ok so far\n" top=0
	movq $string0, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
for_start_1:
	movq 120(%rsp), %rbx

	# push 20
	movq $20,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_1
	jmp for_statement_1
for_increment_1: 
continue_start_1: 
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
	jmp for_start_1
for_statement_1: 
	#top=0

	# push string "%d: %d\n" top=0
	movq $string1, %rbx
	movq 120(%rsp), %r10
	movq 120(%rsp), %r13
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %r13
	addq %r13, %rax
	movq (%rax), %r13
     # func=printf nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp for_increment_1
for_end_1: 
break_end_1: 
function_return_1:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "Ok so far\n"

string1:
	.string "%d: %d\n"

