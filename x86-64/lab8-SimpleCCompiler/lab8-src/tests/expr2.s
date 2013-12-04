# Reserve space
.data
	.comm	g, 8
.text
.global compute
compute:
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
	movq g(%rip),%rbx

	# push 9
	movq $9,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var j
	movq %rbx, 112(%rsp)
	movq 128(%rsp), %rbx
	movq 120(%rsp), %r10

	# +
	addq %r10,%rbx
	movq 112(%rsp), %r10

	# *
	imulq %r10,%rbx
	#Assign to Local var h
	movq %rbx, 104(%rsp)
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

	# push 9
	movq $9,%rbx
	#Assign to Global var g
	movq %rbx, g(%rip)

	# push 2
	movq $2,%rbx

	# push 5
	movq $5,%r10
     # func=compute nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call compute
	movq %rax, %rbx
	#Assign to Local var j
	movq %rbx, 128(%rsp)
	#top=0

	# push string "j=%d g=%d\n" top=0
	movq $string0, %rbx
	movq 128(%rsp), %r10
	movq g(%rip),%r13
     # func=printf nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
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
	.string "j=%d g=%d\n"

