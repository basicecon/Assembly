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
if_start_1:
	movq i(%rip),%rbx

	# push 6
	movq $6,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_1
	movq i(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp continue_start_0
	jmp if_end_1
if_else_1:
if_end_1:
	jmp for_increment_0
for_end_0: 
break_end_0: 
	#top=0

	# push string "for i=%d\n" top=0
	movq $string1, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
while_start_2:
continue_start_2: 
	movq i(%rip),%rbx

	# push 15
	movq $15,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je while_end_2
	#top=0

	# push string "i=%d\n" top=0
	movq $string2, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
if_start_3:
	movq i(%rip),%rbx

	# push 8
	movq $8,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_3
	movq i(%rip),%rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp continue_start_2
	jmp if_end_3
if_else_3:
if_end_3:
	movq i(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp while_start_2
while_end_2:
break_end_2: 
	#top=0

	# push string "while i=%d\n" top=0
	movq $string3, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
do_while_start_4:
	#top=0

	# push string "i=%d\n" top=0
	movq $string4, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
if_start_5:
	movq i(%rip),%rbx

	# push 10
	movq $10,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je if_else_5
	movq i(%rip),%rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
	jmp continue_start_4
	jmp if_end_5
if_else_5:
if_end_5:
	movq i(%rip),%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	#Assign to Global var i
	movq %rbx, i(%rip)
continue_start_4: 
	movq i(%rip),%rbx

	# push 15
	movq $15,%r10

	# less
	cmpq %r10,%rbx
	movq $0, %rax
	setl %al
	movq %rax, %rbx
	cmpq $0, %rbx
	je do_while_end_4
	jmp do_while_start_4
do_while_end_4:
break_end_4: 
	#top=0

	# push string "do/while i=%d\n" top=0
	movq $string5, %rbx
	movq i(%rip),%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "OK\n" top=0
	movq $string6, %rbx
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
	.string "for i=%d\n"

string2:
	.string "i=%d\n"

string3:
	.string "while i=%d\n"

string4:
	.string "i=%d\n"

string5:
	.string "do/while i=%d\n"

string6:
	.string "OK\n"

