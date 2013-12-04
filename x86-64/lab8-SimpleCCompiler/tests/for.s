# Reserve space
.data
	.comm	i, 8
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

	# push 0
	movq $0,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
for_start_0:
	movq i(%rip),%rbx

	# push 15
	movq $15,%r10

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
	movq i(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp for_start_0
for_statement_0: 
	#top=0

	# push string "i=%d\n" top=0
	movq $string0, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp for_increment_0
for_end_0: 
break_end_0: 
	#top=0

	# push string "OK\n" top=0
	movq $string1, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
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
	.string "i=%d\n"

string1:
	.string "OK\n"

