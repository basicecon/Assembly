# Reserve space
.data
	.comm	g, 8
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

	# push 20
	movq $20,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Local var h
	movq %rbx, 128(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var h
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 65
	movq $65,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 1
	movq $1,%rbx
	#Assign to Local var h
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 66
	movq $66,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 2
	movq $2,%rbx
	#Assign to Local var h
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 67
	movq $67,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 3
	movq $3,%rbx
	#Assign to Local var h
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 0
	movq $0,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)
	#top=0

	# push string "h=%s\n" top=0
	movq $string0, %rbx
	movq 128(%rsp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 20
	movq $20,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Global var g
	movq %rbx, g(%rip)

	# push 0
	movq $0,%rbx
	#Assign to Global var g
	movq g(%rip), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 68
	movq $68,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 1
	movq $1,%rbx
	#Assign to Global var g
	movq g(%rip), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 69
	movq $69,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 2
	movq $2,%rbx
	#Assign to Global var g
	movq g(%rip), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 70
	movq $70,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)

	# push 3
	movq $3,%rbx
	#Assign to Global var g
	movq g(%rip), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 0
	movq $0,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)
	#top=0

	# push string "g=%s\n" top=0
	movq $string1, %rbx
	movq g(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
function_return_1:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "h=%s\n"

string1:
	.string "g=%s\n"

