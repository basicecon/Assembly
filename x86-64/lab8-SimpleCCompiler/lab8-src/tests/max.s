.text
.global max
max:
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
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	#Assign to Local var m
	movq %rbx, 104(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 112(%rsp)
for_start_0:
	movq 112(%rsp), %rbx
	movq 120(%rsp), %r10

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
if_start_1:
	movq 104(%rsp), %rbx
	movq 112(%rsp), %r10
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_1
	movq 112(%rsp), %rbx
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	#Assign to Local var m
	movq %rbx, 104(%rsp)
	jmp if_end_1
if_else_1:
if_end_1:
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
# Reserve space
.data
	.comm	a, 8
# Reserve space
.data
	.comm	n, 8
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

	# push 10
	movq $10,%rbx
	#Assign to Global var n
	movq %rbx, n(%rip)

	# push 10
	movq $10,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Global var a
	movq %rbx, a(%rip)

	# push 0
	movq $0,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 8
	movq $8,%rbx
	movq %rbx, (%rbp)

	# push 1
	movq $1,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 7
	movq $7,%rbx
	movq %rbx, (%rbp)

	# push 2
	movq $2,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 1
	movq $1,%rbx
	movq %rbx, (%rbp)

	# push 3
	movq $3,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 9
	movq $9,%rbx
	movq %rbx, (%rbp)

	# push 4
	movq $4,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 11
	movq $11,%rbx
	movq %rbx, (%rbp)

	# push 5
	movq $5,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 83
	movq $83,%rbx
	movq %rbx, (%rbp)

	# push 6
	movq $6,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 7
	movq $7,%rbx
	movq %rbx, (%rbp)

	# push 7
	movq $7,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 13
	movq $13,%rbx
	movq %rbx, (%rbp)

	# push 8
	movq $8,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 94
	movq $94,%rbx
	movq %rbx, (%rbp)

	# push 9
	movq $9,%rbx
	#Assign to Global var a
	movq a(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 1
	movq $1,%rbx
	movq %rbx, (%rbp)

	# push 0
	movq $0,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
for_start_2:
	movq i(%rip),%rbx
	movq n(%rip),%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_2
	jmp for_statement_2
for_increment_2: 
continue_start_2: 
	movq i(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp for_start_2
for_statement_2: 
	#top=0

	# push string "%d: %d\n" top=0
	movq $string0, %rbx
	movq i(%rip),%r10
	movq i(%rip),%r13
	#Obtain Global var a
	movq a(%rip), %rax
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
	jmp for_increment_2
for_end_2: 
break_end_2: 
	#top=0

	# push string "n=%d\n" top=0
	movq $string1, %rbx
	movq n(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "max=%d\n" top=0
	movq $string2, %rbx
	movq a(%rip),%r10
	movq n(%rip),%r13
     # func=max nargs=2
     # Move values from reg stack to reg args
	movq %r13, %rsi
	movq %r10, %rdi
	call max
	movq %rax, %r10
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
	.string "%d: %d\n"

string1:
	.string "n=%d\n"

string2:
	.string "max=%d\n"

