.text
.global mystrlen
mystrlen:
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
	#Assign to Local var l
	movq %rbx, 120(%rsp)
while_start_0:
continue_start_0: 
	movq 120(%rsp), %rbx
	#Obtain Local var s
	movq 128(%rsp), %rax
	imulq $1, %rbx
	addq %rbx, %rax
	movb (%rax), %cl
	movq %rcx, %rbx
	cmpq $0, %rbx
	je while_end_0
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var l
	movq %rbx, 120(%rsp)
	jmp while_start_0
while_end_0:
break_end_0: 
	movq 120(%rsp), %rbx
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
.global mystrcpy
mystrcpy:
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
while_start_1:
continue_start_1: 

	# push 0
	movq $0,%rbx
	#Obtain Local var s2
	movq 120(%rsp), %rax
	imulq $1, %rbx
	addq %rbx, %rax
	movb (%rax), %cl
	movq %rcx, %rbx
	cmpq $0, %rbx
	je while_end_1

	# push 0
	movq $0,%rbx
	#Assign to Local var s1
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 0
	movq $0,%rbx
	#Obtain Local var s2
	movq 120(%rsp), %rax
	imulq $1, %rbx
	addq %rbx, %rax
	movb (%rax), %cl
	movq %rcx, %rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)
	movq 128(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var s1
	movq %rbx, 128(%rsp)
	movq 120(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var s2
	movq %rbx, 120(%rsp)
	jmp while_start_1
while_end_1:
break_end_1: 

	# push 0
	movq $0,%rbx
	#Assign to Local var s1
	movq 128(%rsp), %rbp
	imulq $1, %rbx
	addq %rbx, %rbp

	# push 0
	movq $0,%rbx
	movq %rbx, %rcx
	movb %cl, (%rbp)
function_return_2:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
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

	# push 30
	movq $30,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Local var h
	movq %rbx, 128(%rsp)
	movq 128(%rsp), %rbx
	#top=1

	# push string "Hello world" top=1
	movq $string0, %r10
     # func=mystrcpy nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call mystrcpy
	movq %rax, %rbx
	#top=0

	# push string "h=%s\n" top=0
	movq $string1, %rbx
	movq 128(%rsp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "l=%d\n" top=0
	movq $string2, %rbx
	movq 128(%rsp), %r10
     # func=mystrlen nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call mystrlen
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 30
	movq $30,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	#Assign to Global var g
	movq %rbx, g(%rip)
	movq g(%rip),%rbx
	#top=1

	# push string "This is a great course" top=1
	movq $string3, %r10
     # func=strcpy nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call strcpy
	movq %rax, %rbx
	#top=0

	# push string "g=%s\n" top=0
	movq $string4, %rbx
	movq g(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "l=%d\n" top=0
	movq $string5, %rbx
	movq g(%rip),%r10
     # func=mystrlen nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call mystrlen
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
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
	.string "Hello world"

string1:
	.string "h=%s\n"

string2:
	.string "l=%d\n"

string3:
	.string "This is a great course"

string4:
	.string "g=%s\n"

string5:
	.string "l=%d\n"

