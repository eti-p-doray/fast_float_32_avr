//
//  FastFloat_Mul.s
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

    
Cop1 = 22
Bop1 = 23
Aop1 = 24
Eop1 = 25

Cop2 = 18
Bop2 = 19
Aop2 = 20
Eop2 = 21

Cans = 22
Bans = 23
Aans = 24
Eans = 25

Ctp = 27
Btp = 30
Atp = 31

zero = 26
stst = 0
.global	_ZN17fast_float_32_avrmlENS_9FastFloatES0_
	.type	_ZN17fast_float_32_avrmlENS_9FastFloatES0_, @function
_ZN17fast_float_32_avrmlENS_9FastFloatES0_:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0

    lsl     Cop2
    rol     Bop2
    rol     Aop2
    rol     Eop2
    rol     stst

    lsl     Cop1
    rol     Bop1
    rol     Aop1
    rol     Eop1
    adc     stst,   r1
    bst     stst,   0

    add     Eop1,   Eop2
    brmi    L_mult_nv
    brcs    L_mult_nv
        rjmp    L_mult_v

    L_mult_nv:
    subi    Eans,   0x7f


    /*L_ready:
    lds r31,192
    sbrs r31,5
    rjmp L_ready
    sts 198,Eans*/

    clr     zero
	mul     Aop1,   Aop2
	movw    Btp,    r0
	mul     Bop1,   Bop2
	mov     Ctp,    r1
	mul     Aop1,   Bop2
	add     Ctp,    r0
	adc     Btp,    r1
	adc     Atp,    zero
	mul     Aop1,   Cop2
	add     Ctp,    r1
	adc     Btp,    zero
	adc     Atp,    zero
	mul     Aop2,   Bop1
	add     Ctp,    r0
	adc     Btp,    r1
	adc     Atp,    zero
	mul     Aop2,   Cop1
	add     Ctp,    r1
	adc     Btp,    zero
	adc     Atp,    zero
    clr     r1

    add     Cans,   Ctp
    adc     Bans,   Btp
    adc     Aans,   Atp
    sbci    zero,   0x00

    //sec
    add     Cans,   Cop2
    adc     Bans,   Bop2
    adc     Aans,   Aop2
    sbci    zero,   0x00
    
    /*L_ready:
    lds r31,192
    sbrs r31,5
    rjmp L_ready
    sts 198,Eop*/


    brpl    L_mult_nc
        cpi     zero,   0xff
        ror     Aans
        ror     Bans
        ror     Cans
        inc     Eans
    L_mult_nc:

    ror     Eans
    ror     Aans
    ror     Bans
    ror     Cans
    adc     Cans,   r1
    adc     Bans,   r1
    adc     Aans,   r1
    adc     Eans,   r1

    bld     Eans,   7
	ret

    L_mult_v:
        /*brpl    L_mult_underflow
            ldi     Aans,   0x7f
            ret
        L_mult_underflow:*/
        ldi     Eans,   0x00
        ret
	.size	_ZN17fast_float_32_avrmlENS_9FastFloatES0_, .-_ZN17fast_float_32_avrmlENS_9FastFloatES0_

