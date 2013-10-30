	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"two.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%s\000"
	.align	2
.LC1:
	.ascii	"string is %s\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #104
	ldr	r2, .L2
	sub	r3, fp, #104
	mov	r0, r2
	mov	r1, r3
	bl	__isoc99_scanf
	ldr	r2, .L2+4
	sub	r3, fp, #104
	mov	r0, r2
	mov	r1, r3
	bl	printf
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Debian 4.6.3-8+rpi1) 4.6.3"
	.section	.note.GNU-stack,"",%progbits
