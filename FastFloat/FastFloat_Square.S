//
//  FastFloat_Square.s
//  FastFloat2.0
//
//  Created by Etienne Pierre-Doray on 2014-04-20.
//
//

__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__ = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text

    
Cop = 22
Bop = 23
Aop = 24
Eop = 25

Cans = 22
Bans = 23
Aans = 24
Eans = 25

Ctp = 18
Btp = 19
Atp = 20

zero = 26
stst = 26
.global	_ZN17fast_float_32_avr6squareENS_9FastFloatE
	.type	_ZN17fast_float_32_avr6squareENS_9FastFloatE, @function
_ZN17fast_float_32_avr6squareENS_9FastFloatE:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	//brvc    L_square_v
    lsl     Cop
    rol     Bop
    rol     Aop
    rol     Eop

    add     Eop,    Eop
    subi    Eop,    0x7F

    movw    Ctp,    Cop
    mov     Atp,    Aop

    clr     zero
	mul     Atp,   Atp
	mov    Bans,  r0
    mov    Aans,  r1
	mul     Btp,   Btp
	mov     Cans,  r1
	fmul     Atp,   Ctp
    adc     Bans,   zero
    adc     Aans,   zero
	add     Cans,  r1
	adc     Bans,  zero
	adc     Aans,  zero
    fmul     Atp,   Btp
    adc     Aans,   zero
	add     Cans,  r0
	adc     Bans,  r1
	adc     Aans,  zero

    //lsr     Eans
    sec
    ror     Aans
    ror     Bans
    ror     Cans

    adc     Cans,   Ctp
    adc     Bans,   Btp
    adc     Aans,   Atp

    brcc    L_square_nc
        ror     Aans
        ror     Bans
        ror     Cans
        adc     Cans,   zero
        adc     Bans,   zero
        adc     Aans,   zero
        inc     Eans
    L_square_nc:

    lsl     Aans
    ror     Eans
    ror     Aans
    cbr     Eans,   0x80

	clr     r1

	ret

	.size	_ZN17fast_float_32_avr6squareENS_9FastFloatE, .-_ZN17fast_float_32_avr6squareENS_9FastFloatE
