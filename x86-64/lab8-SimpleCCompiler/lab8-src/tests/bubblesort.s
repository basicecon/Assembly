.text
.global mysort
mysort:
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
	movq 128(%rsp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 112(%rsp)
for_start_0:
	movq 112(%rsp), %rbx

	# push 0
	movq $0,%r10

	# greater
	cmpq %r10,%rbx
	movq $0, %rax
	setg %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_0
	jmp for_statement_0
for_increment_0: 
continue_start_0: 
	movq 112(%rsp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 112(%rsp)
	jmp for_start_0
for_statement_0: 

	# push 0
	movq $0,%rbx
	#Assign to Local var j
	movq %rbx, 104(%rsp)
for_start_1:
	movq 104(%rsp), %rbx
	movq 112(%rsp), %r10

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
	movq 104(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var j
	movq %rbx, 104(%rsp)
	jmp for_start_1
for_statement_1: 
if_start_2:
	movq 104(%rsp), %rbx
	#Obtain Local var a
	movq 120(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	movq 104(%rsp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	#Obtain Local var a
	movq 120(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10

	# greater
	cmpq %r10,%rbx
	movq $0, %rax
	setg %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_2
	movq 104(%rsp), %rbx
	#Obtain Local var a
	movq 120(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	#Assign to Local var tmp
	movq %rbx, 96(%rsp)
	movq 104(%rsp), %rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 104(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Obtain Local var a
	movq 120(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	movq %rbx, (%rbp)
	movq 104(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 96(%rsp), %rbx
	movq %rbx, (%rbp)
	jmp if_end_2
if_else_2:
if_end_2:
	jmp for_increment_1
for_end_1: 
break_end_1: 
	jmp for_increment_0
for_end_0: 
break_end_0: 
function_return_1:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
.text
.global printArray
printArray:
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
	movq %rdx, 112(%rsp)
	#top=0

	# push string "----------- %s -----------\n" top=0
	movq $string0, %rbx
	movq 128(%rsp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	#Assign to Local var i
	movq %rbx, 104(%rsp)
for_start_3:
	movq 104(%rsp), %rbx
	movq 120(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_3
	jmp for_statement_3
for_increment_3: 
continue_start_3: 
	movq 104(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 104(%rsp)
	jmp for_start_3
for_statement_3: 
	#top=0

	# push string "%d\n" top=0
	movq $string1, %rbx
	movq 104(%rsp), %r10
	#Obtain Local var a
	movq 112(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp for_increment_3
for_end_3: 
break_end_3: 
function_return_2:	addq $128, %rsp
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

	# push 10
	movq $10,%rbx
	#Assign to Local var n
	movq %rbx, 128(%rsp)
	movq 128(%rsp), %rbx

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
	movq %rbx, 120(%rsp)

	# push 0
	movq $0,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 8
	movq $8,%rbx
	movq %rbx, (%rbp)

	# push 1
	movq $1,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 7
	movq $7,%rbx
	movq %rbx, (%rbp)

	# push 2
	movq $2,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 1
	movq $1,%rbx
	movq %rbx, (%rbp)

	# push 3
	movq $3,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 9
	movq $9,%rbx
	movq %rbx, (%rbp)

	# push 4
	movq $4,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 11
	movq $11,%rbx
	movq %rbx, (%rbp)

	# push 5
	movq $5,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 83
	movq $83,%rbx
	movq %rbx, (%rbp)

	# push 6
	movq $6,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 7
	movq $7,%rbx
	movq %rbx, (%rbp)

	# push 7
	movq $7,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 13
	movq $13,%rbx
	movq %rbx, (%rbp)

	# push 8
	movq $8,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 94
	movq $94,%rbx
	movq %rbx, (%rbp)

	# push 9
	movq $9,%rbx
	#Assign to Local var a
	movq 120(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp

	# push 1
	movq $1,%rbx
	movq %rbx, (%rbp)
	#top=0

	# push string "Before" top=0
	movq $string2, %rbx
	movq 128(%rsp), %r10
	movq 120(%rsp), %r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx
	movq 128(%rsp), %rbx
	movq 120(%rsp), %r10
     # func=mysort nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call mysort
	movq %rax, %rbx
	#top=0

	# push string "After" top=0
	movq $string3, %rbx
	movq 128(%rsp), %r10
	movq 120(%rsp), %r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx
function_return_3:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "----------- %s -----------\n"

string1:
	.string "%d\n"

string2:
	.string "Before"

string3:
	.string "After"

