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

	# push string "9>8=%d\n" top=0
	movq $string0, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setl %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<9=%d\n" top=0
	movq $string1, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setl %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<8=%d\n" top=0
	movq $string2, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setl %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<9=%d\n" top=0
	movq $string3, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setl %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=8=%d\n" top=0
	movq $string4, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setge %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8>=9=%d\n" top=0
	movq $string5, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setge %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=9=%d\n" top=0
	movq $string6, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setge %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=9=%d\n" top=0
	movq $string7, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setge %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=8=%d\n" top=0
	movq $string8, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setle %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<=9=%d\n" top=0
	movq $string9, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setle %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=9=%d\n" top=0
	movq $string10, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setle %al
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=9=%d\n" top=0
	movq $string11, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# less
	cmpq %r13,%r10
	movq $0, %rax
	setle %al
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
	.string "9>8=%d\n"

string1:
	.string "8<9=%d\n"

string2:
	.string "9<8=%d\n"

string3:
	.string "8<9=%d\n"

string4:
	.string "9>=8=%d\n"

string5:
	.string "8>=9=%d\n"

string6:
	.string "9>=9=%d\n"

string7:
	.string "9>=9=%d\n"

string8:
	.string "9<=8=%d\n"

string9:
	.string "8<=9=%d\n"

string10:
	.string "9<=9=%d\n"

string11:
	.string "9<=9=%d\n"

