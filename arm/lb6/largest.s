.data
.balign 4
message: .asciz "Enter two numbers: "
.balign 4
final_message: .asciz "max is %d\n"
.balign 4
scan_pattern: .asciz "%d %d"
.balign 4
number1: .word 0
number2: .word 0
max: .word 0
.balign 4
return: .word 0
.balign 4
return2: .word 0

.text
.global main
main:
	ldr r1, address_of_return
	str lr, [r1]
	
	ldr r0, address_of_message
	bl printf

	/*scan the number from stdin*/
	ldr r0, address_of_scan_pattern 
	ldr r1, address_of_number1
	ldr r2, address_of_number2
	bl scanf

	/*load number in registers*/
	ldr r1, address_of_number1
	ldr r1, [r1]
	ldr r2, address_of_number2
	ldr r2, [r2]
  
  cmp r2, r1
	ble .L1 
	mov r1, r2

.L1:
	ldr r0, address_of_final_message
	bl printf 

	ldr lr, address_of_return 
	ldr lr, [lr]
	bx lr
address_of_message: .word message
address_of_final_message: .word final_message
address_of_scan_pattern: .word scan_pattern
address_of_number1: .word number1
address_of_number2: .word number2
address_of_return: .word return

.global printf
.global scanf
