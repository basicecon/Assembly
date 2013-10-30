.data
.balign 4
message1: .asciz "Enter five number: "
.balign 4
message2: .asciz "The sum is %d\n"
.balign 4
scan_pattern: .asciz "%d"
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.text
.global main 
main:
  ldr r1, address_of_return
  str lr, [r1]
	ldr r0, address_of_message1
	bl printf
  
  add fp, sp, #0
  sub sp, sp, #20
  
  /*leanred from gcc output, without the init segmentation fault*/
  mov r3, #0
  str r3, [fp, #-4]

  mov r4, #0
  mov r2, #4
  mov r5, #0
/*scan five number*/
loop: 
	cmp r4, #5
	beq end
	
  sub r1, fp, #20
  add r1, r1, r5

	ldr r0, address_of_scan_pattern
	bl scanf	
 
  add r5, r5, #4
	add r4, r4, #1
	bal loop
end:

/*sum up five numbers*/
  mov r4, #0
  mov r2, #4
  mov r5, #0
  mov r6, #0
loop2: 
	cmp r4, #5
	beq end2
	
  sub r1, fp, #20
  add r3, r1, r5
  ldr r1, [r3]   
  add r6, r6, r1
  
  add r5, r5, #4
	add r4, r4, #1
	bal loop2
end2:

  ldr r0, address_of_message2
  mov r1, r6
  bl printf
 
	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr
address_of_message1: .word message1
address_of_message2: .word message2
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_return: .word return
.global printf
.global scanf
