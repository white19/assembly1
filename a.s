@this is comment

@the information that tells arm-none-eabi-as what arch. to assemble to 
	.cpu arm926ej-s
	.fpu softvfp

@this is code section
@note, we must have the main function for the simulator's linker script
	.text
	.align	2   @align 4 byte
	.global	main
main:

    @prologue
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

    @code body

@copy string
	ldr r2, =string1	@dest
	ldr r3, [r1, #4]	@src
	bl strcpy
	
	ldr r0, =output
	ldr r1, =string1
	bl printf
@@@@@@@@@@@

@count size
@	ldr r3, =string1	@src
@	bl size
	@ldr r0, =counter
	@mov r1, r5
	@bl printf

@@@@@@@@@@@	

@to reverse	

	@ldr r2, =string2	@dest
	@ldr r3, =string1	@src
	@ldrb r7, =string0	@\0
	@add r2, r2, r5		@string_rev[n]
	
	@ldrb	r4, [r7],#0
	@strb	r4,	[r2],#-1 @set \0
	
	@bl reverse
	
	
	
	
	@ldr r0, =output
	@ldr r1, =string2
	@bl printf
@@@@@@@@@@@@@@@@@@@@@@@	
	
	mov r0, #1
	bl fun

	mov	r0, #0
	
	@epilogue
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
	
@another function
strcpy:
	ldrb	r4, [r3],#1
	
	cmp r4, #' '
	beq strcpy
	cmp r4, #'9'
	ble lessThan1
	cmp r4, #'Z'
	ble lessThanA
	
continue:
	strb	r4,	[r2],#1
	cmp r4, #0
	bne strcpy
	bx lr
	
reverse:	
	ldrb r4, [r3],#1
	strb r4, [r2],#-1
	cmp r4, #0
	bne reverse
	bx lr

lower:
	sub r4, r4, #'A'
	add r4, r4, #'a'
	b continue
lessThan1:
	cmp r4, #'1'
	blt continue
	b strcpy
lessThanA:
	cmp r4, #'A'
	blt continue
	b lower
size:
	ldrb r4, [r3],#1
	cmp r4, #0
	add r5, r5, #1
	bne size
	sub r5, r5, #1
	bx lr
fun:
    add r0, r0, #1    
    bx lr

@data section

Label1:
    .word   0x77777777
    .short  0x1122
    .align 2
    .byte   0x31, 0x32, 0x33, 0x34

string0:
	.asciz	"\0"
string1:
	.asciz "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
string2:
	.asciz "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
output:
	.asciz "%s\n"
counter:
	.asciz "r5:%d\n"
test:
	.asciz "text\n"
    
    .end
    
    
