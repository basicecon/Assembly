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
	#top=0

	# push string "Hello world" top=0
	movq $string0, %rbx
	#Assign to Local var h
	movq %rbx, 128(%rsp)
	#top=0

	# push string "h[6]=%c\n" top=0
	movq $string1, %rbx

	# push 6
	movq $6,%r10
	#Obtain Local var h
	movq 128(%rsp), %rax
	imulq $1, %r10
	addq %r10, %rax
	movb (%rax), %cl
	movq %rcx, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "This is a great class!!" top=0
	movq $string2, %rbx
	#Assign to Global var g
	movq %rbx, g(%rip)
	#top=0

	# push string "g[11]=%c\n" top=0
	movq $string3, %rbx

	# push 11
	movq $11,%r10
	#Obtain Global var g
	movq g(%rip), %rax
	imulq $1, %r10
	addq %r10, %rax
	movb (%rax), %cl
	movq %rcx, %r10
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
	.string "Hello world"

string1:
	.string "h[6]=%c\n"

string2:
	.string "This is a great class!!"

string3:
	.string "g[11]=%c\n"

