.data
.balign 4
message1: .asciz "Enter a string: "
.balign 4
message2: .asciz "length is %d\n"
.balign 4
scan_pattern: .asciz "%s"
.balign 4
string_read: .word 0
.balign 4
return: .word 0
.text
.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

	ldr r0, address_of_message1
	bl printf

	str lr, [sp, #-4]!
	sub sp, sp, #104

	ldr r0, address_of_scan_pattern
	mov r1, sp
	bl scanf

	mov r0, sp
	eor r1, r1, r1	

/* go through all the char*/
loop:
	ldrb r2, [r0], #1
	cmp r2, #0
	beq end
	add r1, r1, #1
	bal loop
end:
	ldr r0, address_of_message2
	bl printf
	
	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr

address_of_message1: .word message1
address_of_message2: .word message2
address_of_scan_pattern: .word scan_pattern
address_of_string_read: .word string_read
address_of_return: .word return
.global printf
.global scanf
