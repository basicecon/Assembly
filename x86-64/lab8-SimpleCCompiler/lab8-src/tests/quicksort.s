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
	movq 120(%rsp), %rbx
	#Assign to Local var i
	movq %rbx, 104(%rsp)
for_start_0:
	movq 104(%rsp), %rbx
	movq 112(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setle %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je for_end_0
	jmp for_statement_0
for_increment_0: 
continue_start_0: 
	movq 104(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var i
	movq %rbx, 104(%rsp)
	jmp for_start_0
for_statement_0: 
	#top=0

	# push string "%d\n" top=0
	movq $string0, %rbx
	movq 104(%rsp), %r10
	#Obtain Local var a
	movq 128(%rsp), %rax
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
.global print
print:
# Save registers
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	#Save arguments
	movq %rdi, 128(%rsp)
	#top=0

	# push string "==%s==\n" top=0
	movq $string1, %rbx
	movq 128(%rsp), %r10
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
.text
.global quicksortsubrange
quicksortsubrange:
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
if_start_1:
	movq 120(%rsp), %rbx
	movq 112(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setge %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_1

	# push 0
	movq $0,%rbx
	movq %rbx, %rax
	jmp function_return_3
	jmp if_end_1
if_else_1:
if_end_1:
	movq 112(%rsp), %rbx
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	#Assign to Local var x
	movq %rbx, 104(%rsp)
	movq 120(%rsp), %rbx
	#Assign to Local var l
	movq %rbx, 96(%rsp)
	movq 112(%rsp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	#Assign to Local var g
	movq %rbx, 88(%rsp)
while_start_2:
continue_start_2: 
	movq 96(%rsp), %rbx
	movq 88(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je while_end_2
while_start_3:
continue_start_3: 
	movq 96(%rsp), %rbx
	movq 88(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	movq 96(%rsp), %r10
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10
	movq 104(%rsp), %r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setl %al
	movq %rax, %r10

	# &&
	andq %r10,%rbx
	cmpq $0, %rbx
	je while_end_3
	movq 96(%rsp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Local var l
	movq %rbx, 96(%rsp)
	jmp while_start_3
while_end_3:
break_end_3: 
while_start_4:
continue_start_4: 
	movq 96(%rsp), %rbx
	movq 88(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	movq 88(%rsp), %r10
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %r10
	addq %r10, %rax
	movq (%rax), %r10
	movq 104(%rsp), %r13

	# greater
	cmpq %r13,%r10
	movq $0, %rax
	setg %al
	movq %rax, %r10

	# &&
	andq %r10,%rbx
	cmpq $0, %rbx
	je while_end_4
	movq 88(%rsp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	#Assign to Local var g
	movq %rbx, 88(%rsp)
	jmp while_start_4
while_end_4:
break_end_4: 
if_start_5:
	movq 96(%rsp), %rbx
	movq 88(%rsp), %r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_5
	movq 96(%rsp), %rbx
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	#Assign to Local var tmp
	movq %rbx, 80(%rsp)
	movq 96(%rsp), %rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 88(%rsp), %rbx
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	movq %rbx, (%rbp)
	movq 88(%rsp), %rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 80(%rsp), %rbx
	movq %rbx, (%rbp)
	jmp if_end_5
if_else_5:
if_end_5:
	jmp while_start_2
while_end_2:
break_end_2: 
	movq 112(%rsp), %rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 96(%rsp), %rbx
	#Obtain Local var a
	movq 128(%rsp), %rax
	imulq $8, %rbx
	addq %rbx, %rax
	movq (%rax), %rbx
	movq %rbx, (%rbp)
	movq 96(%rsp), %rbx
	#Assign to Local var a
	movq 128(%rsp), %rbp
	imulq $8, %rbx
	addq %rbx, %rbp
	movq 104(%rsp), %rbx
	movq %rbx, (%rbp)
	movq 128(%rsp), %rbx
	movq 120(%rsp), %r10
	movq 96(%rsp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
	movq %rax, %rbx
	movq 128(%rsp), %rbx
	movq 88(%rsp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	movq 112(%rsp), %r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
	movq %rax, %rbx
function_return_3:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
.text
.global quicksort
quicksort:
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

	# push 0
	movq $0,%r10
	movq 120(%rsp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
	movq %rax, %rbx
function_return_4:	addq $128, %rsp
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
	#top=0

	# push string "Hello" top=0
	movq $string2, %rbx
     # func=print nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call print
	movq %rax, %rbx

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

	# push string "-------- Before -------\n" top=0
	movq $string3, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	movq 120(%rsp), %rbx

	# push 0
	movq $0,%r10
	movq 128(%rsp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx
	movq 120(%rsp), %rbx
	movq 128(%rsp), %r10
     # func=quicksort nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksort
	movq %rax, %rbx
	#top=0

	# push string "-------- After -------\n" top=0
	movq $string4, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	movq 120(%rsp), %rbx

	# push 0
	movq $0,%r10
	movq 128(%rsp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx
function_return_5:	addq $128, %rsp
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	ret
string0:
	.string "%d\n"

string1:
	.string "==%s==\n"

string2:
	.string "Hello"

string3:
	.string "-------- Before -------\n"

string4:
	.string "-------- After -------\n"

