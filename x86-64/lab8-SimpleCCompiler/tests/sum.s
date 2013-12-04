.text
.global sum
sum:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments
	movq %rdi, 128(%rsp)
	movq %rsi, 120(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var s
	movq %rbx, 104(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 112(%rsp)
for_start_0:
	movq 112(%rsp), %rbx
	movq 128(%rsp), %r10

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
	movq 112(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 112(%rsp)
	jmp for_start_0
for_statement_0: 
	movq 104(%rsp), %rbx
	movq 112(%rsp), %r10
	#Obtain Local var a
	movq 120(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10

	# +
	addq %r10,%rbx
	#Assign to Local var s
	movq %rbx, 104(%rsp)
	jmp for_increment_0
for_end_0: 
break_end_0: 
	movq 104(%rsp), %rbx
	movq %rbx, %rax
	jmp function_return_1
function_return_1:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
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

	# push 5
	movq $5,%rbx

	# push 8
	movq $8,%r10

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
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 4
	movq $4,%rbx
	movq %rbx, (%rbp)

	# push 1
	movq $1,%rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 3
	movq $3,%rbx
	movq %rbx, (%rbp)

	# push 2
	movq $2,%rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 1
	movq $1,%rbx
	movq %rbx, (%rbp)

	# push 3
	movq $3,%rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 7
	movq $7,%rbx
	movq %rbx, (%rbp)

	# push 4
	movq $4,%rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 6
	movq $6,%rbx
	movq %rbx, (%rbp)

	# push 5
	movq $5,%rbx
	movq 128(%rsp), %r10
     # func=sum nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call sum
	movq %rax, %rbx
	#Assign to Local var s
	movq %rbx, 120(%rsp)
	#top=0

	# push string "sum=%d\n" top=0
	movq $string0, %rbx
	movq 120(%rsp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
function_return_2:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "sum=%d\n"

