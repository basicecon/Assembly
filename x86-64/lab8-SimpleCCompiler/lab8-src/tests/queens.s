# Reserve space
.data
	.comm	queens, 8
# Reserve space
.data
	.comm	solid, 8
.text
.global abs
abs:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments
	movq %rdi, 128(%rsp)
if_start_0:
	movq 128(%rsp), %rbx

	# push 0
	movq $0,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_0

	# push -1
	movq $-1,%rbx
	movq 128(%rsp), %r10

	# *
	imulq %r10,%rbx
	movq %rbx, %rax
	jmp function_return_1
	jmp if_end_0
if_else_0:
if_end_0:
	movq 128(%rsp), %rbx
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
.global check
check:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments
	movq %rdi, 128(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
for_start_1:
	movq 120(%rsp), %rbx
	movq 128(%rsp), %r10

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
if_start_2:
	movq 120(%rsp), %rbx
	#Obtain Global var queens
	movq queens(%rip), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	movq 128(%rsp), %r10
	#Obtain Global var queens
	movq queens(%rip), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	sete %al
	movq %rax, %rbx
	movq 120(%rsp), %r10
	#Obtain Global var queens
	movq queens(%rip), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10
	movq 128(%rsp), %r13
	#Obtain Global var queens
	movq queens(%rip), %rax
	imulq $8, %r13
	addq %r13, %rax
	movq (%rax), %r13

	# -
	subq %r13,%r10
     # func=abs nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call abs
	movq %rax, %r10
	movq 128(%rsp), %r13
	movq 120(%rsp), %r14

	# -
	subq %r14,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	sete %al
	movq %rax, %r10

	# ||
	orq %r10,%rbx
	cmpq $0, %rbx
	je if_else_2

	# push 0
	movq $0,%rbx
	movq %rbx, %rax
	jmp function_return_2
	jmp if_end_2
if_else_2:
if_end_2:
	jmp for_increment_1
for_end_1: 
break_end_1: 

	# push 1
	movq $1,%rbx
	movq %rbx, %rax
	jmp function_return_2
function_return_2:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
.text
.global bruteforce
bruteforce:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments
	movq %rdi, 128(%rsp)
if_start_3:
	movq 128(%rsp), %rbx

	# push 8
	movq $8,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	sete %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_3
	#top=0

	# push string "Solution #%2ld = [ " top=0
	movq $string0, %rbx
	movq solid(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	movq solid(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var solid
	movq %rbx, solid(%rip)

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
for_start_4:
	movq 120(%rsp), %rbx

	# push 8
	movq $8,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_4
	jmp for_statement_4
for_increment_4: 
continue_start_4: 
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
	jmp for_start_4
for_statement_4: 
	#top=0

	# push string "%ld " top=0
	movq $string1, %rbx
	movq 120(%rsp), %r10
	#Obtain Global var queens
	movq queens(%rip), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp for_increment_4
for_end_4: 
break_end_4: 
	#top=0

	# push string "]\n" top=0
	movq $string2, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, %rax
	jmp function_return_3
	jmp if_end_3
if_else_3:
if_end_3:

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
for_start_5:
	movq 120(%rsp), %rbx

	# push 8
	movq $8,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_5
	jmp for_statement_5
for_increment_5: 
continue_start_5: 
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 120(%rsp)
	jmp for_start_5
for_statement_5: 
	movq 128(%rsp), %rbx
	#Assign to Global var queens
	movq queens(%rip), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 120(%rsp), %rbx
	movq %rbx, (%rbp)
if_start_6:
	movq 128(%rsp), %rbx
     # func=check nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call check
	movq %rax, %rbx

	# push 0
	movq $0,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setne %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_6
	movq 128(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
	movq %rax, %rbx
	jmp if_end_6
if_else_6:
if_end_6:
	jmp for_increment_5
for_end_5: 
break_end_5: 

	# push 0
	movq $0,%rbx
	movq %rbx, %rax
	jmp function_return_3
function_return_3:	addq $128, %rsp
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

	# push 8
	movq $8,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Global var queens
	movq %rbx, queens(%rip)

	# push 1
	movq $1,%rbx
	#Assign to Global var solid
	movq %rbx, solid(%rip)

	# push 0
	movq $0,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
	movq %rax, %rbx
function_return_4:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "Solution #%2ld = [ "

string1:
	.string "%ld "

string2:
	.string "]\n"

