	.file	"main.cpp"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 8 */
/* stack size = 10 */
.L__stack_usage = 10
	call _ZN5USART4initEv
	ldi r20,lo8(-27)
	ldi r21,lo8(-48)
	ldi r22,lo8(50)
	ldi r23,lo8(64)
	movw r24,r28
	adiw r24,5
	call _ZN17fast_float_32_avr9FastFloat11toFastFloatEf
	ldi r20,lo8(92)
	ldi r21,lo8(-113)
	ldi r22,lo8(50)
	ldi r23,lo8(64)
	movw r24,r28
	adiw r24,1
	call _ZN17fast_float_32_avr9FastFloat11toFastFloatEf
	ldi r24,lo8(71)
	call _ZN5USART5writeEh
	ldi r24,lo8(-79)
	call _ZN5USART5writeEh
	ldd r24,Y+8
	call _ZN5USART5writeEh
	ldd r24,Y+7
	call _ZN5USART5writeEh
	ldd r24,Y+6
	call _ZN5USART5writeEh
	ldd r24,Y+5
	call _ZN5USART5writeEh
	ldd r24,Y+4
	call _ZN5USART5writeEh
	ldd r24,Y+3
	call _ZN5USART5writeEh
	ldd r24,Y+2
	call _ZN5USART5writeEh
	ldd r24,Y+1
	call _ZN5USART5writeEh
	sts 128,__zero_reg__
	ldi r24,lo8(1)
	sts 129,r24
	sts 132+1,__zero_reg__
	sts 132,__zero_reg__
	ldi r22,lo8(5)
	movw r24,r28
	adiw r24,5
	call _ZN17fast_float_32_avr9FastFloat3powEh
	movw r12,r22
	movw r14,r24
	lds r16,132
	lds r17,132+1
	mov r24,r15
	call _ZN5USART5writeEh
	mov r24,r14
	call _ZN5USART5writeEh
	mov r24,r13
	call _ZN5USART5writeEh
	mov r24,r12
	call _ZN5USART5writeEh
	mov r24,r17
	call _ZN5USART5writeEh
	mov r24,r16
	call _ZN5USART5writeEh
	ldi r18,lo8(76)
	ldi r19,lo8(29)
.L5:
	sbi 0x5,5
	ldi r20,lo8(33)
.L3:
	movw r24,r18
/* #APP */
 ;  110 "/usr/local/CrossPack-AVR-20131216/avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r20,lo8(-(-1))
	brne .L3
	cbi 0x5,5
	ldi r20,lo8(33)
.L6:
	movw r24,r18
/* #APP */
 ;  110 "/usr/local/CrossPack-AVR-20131216/avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r20,lo8(-(-1))
	brne .L6
	rjmp .L5
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.1"
