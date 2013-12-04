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

	# push string "9==8%d\n" top=0
	movq $string0, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	sete %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9==9=%d\n" top=0
	movq $string1, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	sete %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9!=8%d\n" top=0
	movq $string2, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setne %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9!=9=%d\n" top=0
	movq $string3, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setne %al
	movq %rax, %r10
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
	.string "9==8%d\n"

string1:
	.string "9==9=%d\n"

string2:
	.string "9!=8%d\n"

string3:
	.string "9!=9=%d\n"

