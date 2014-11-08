//
//  Div.s
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


car = 25
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
Dans = 25

Ctp4 = 18
Btp4 = 19
Atp4 = 20
Dtp4 = 21

Dtp1 = 18
Ctp1 = 19
Btp1 = 20
Atp1 = 21

Dtp2 = 22
Ctp2 = 23
Btp2 = 24
Atp2 = 25

Dtp3 = 26
Ctp3 = 27
Btp3 = 30
Atp3 = 31

zero = 2
stst = 2
IniG = 16
car2 = 16
.global	_ZN17fast_float_32_avrdvENS_9FastFloatES0_
	.type	_ZN17fast_float_32_avrdvENS_9FastFloatES0_, @function
_ZN17fast_float_32_avrdvENS_9FastFloatES0_:
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
    push    zero
    push    IniG

    ldi     IniG,   0xf1
    mov     Btp3,   Bop2
    mov     Atp3,   Aop2
    lsl     Btp3
    rol     Atp3

    rol     Eop2
    rol     stst
    lsl     Aop1
    rol     Eop1
    adc     stst,   r1
    sub     Eop1,   Eop2
    subi    Eop1,   0x81
    bst     Eop1,   0
    ror     stst
    ror     Eop1
    lsr     Aop1
    sbr     Aop1,   0x80
    sbr     Aop2,   0x80
    push    Eop1
    clr     zero

    mul     IniG,   Atp3
    mov     IniG,   r1
    subi    IniG,   0xe2

	mul     IniG,   Aop2
	movw    Btp3,   r0
	mul     IniG,   Cop2
	movw    Dtp3,   r0
	mul     IniG,   Bop2
	add     Ctp3,   r0
	adc     Btp3,   r1
	adc     Atp3,   zero

    sub     Ctp3,   Cop2
    sbc     Btp3,   Bop2
    sbc     Atp3,   Aop2
    cpi     IniG,   0x14
    brlo    L_divi_IniGoverf
        sub     Ctp3,   Cop2
        sbc     Btp3,   Bop2
        sbc     Atp3,   Aop2
    L_divi_IniGoverf:

    clr     car
    mul     Aop1,   Atp3
	movw    Btp1,   r0
	mul     Btp3,   Bop1
	movw    Dtp1,   r0
	mul     Atp3,   Bop1
	add     Ctp1,   r0
	adc     Btp1,   r1
	adc     Atp1,   zero
	mul     Atp3,   Cop1
    add     Dtp1,   r0
	adc     Ctp1,   r1
	adc     car,   zero
	//adc     Atp1,   zero
    mul     Btp3,   Cop1
    add     Dtp1,   r1
	adc     Ctp1,   zero
	adc     car,   zero
	//adc     Atp1,   zero
	mul     Aop1,   Btp3
	add     Ctp1,   r0
	adc     Btp1,   r1
	adc     Atp1,   zero
	mul     Aop1,   Ctp3
    add     Dtp1,   r0
	adc     Ctp1,   r1
	adc     car,   zero
	//adc     Atp1,   zero
    mul     Bop1,   Ctp3
    add     Dtp1,   r1
	adc     Ctp1,   zero
	adc     car,   zero
	//adc     Atp1,   zero
    mul     Aop1,   Dtp3
    add     Dtp1,   r1
	adc     Ctp1,   zero
	adc     Btp1,   car
	adc     Atp1,   zero

    cpi     Atp3,   0x80
    brsh    L_divi_tp3overf
        add     Ctp1,   Cop1
        adc     Btp1,   Bop1
        adc     Atp1,   Aop1
    L_divi_tp3overf:
    ror     Atp1
    ror     Btp1
    ror     Ctp1
    ror     Dtp1

    neg     IniG

    mul     IniG,   Btp1
    movw    Cans,   r0
    mul     IniG,   Dtp1
    mov     Dans,   r1
	mul     IniG,   Atp1
    mov     Aans,   r1
    add     Bans,   r0
    adc     Aans,   zero
	mul     IniG,   Ctp1
    add     Dans,   r0
    adc     Cans,   r1
    adc     Bans,   zero
    adc     Aans,   zero

    cpi     IniG,   0xec
    brsh    L_divi_overf
        add     Dans,   Dtp1
        adc     Cans,   Ctp1
        adc     Bans,   Btp1
        adc     Aans,   Atp1
    L_divi_overf:

    movw    Btp1,   Btp3
    mov     Ctp1,   Ctp3

    fmulsu  Atp1,   Btp1
    movw    Btp3,   r0
    fmul    Btp1,   Ctp1
    adc     Btp3,   zero
    mov     Ctp3,   r1
    muls    Atp1,   Atp1
    add     Atp3,   r0
    mul     Btp1,   Btp1
    add     Ctp3,   r0
    adc     Btp3,   r1
    adc     Atp3,   zero
    fmulsu  Atp1,   Ctp1
    sbc     Atp3,   zero
    add     Ctp3,   r0
	adc     Btp3,   r1
	adc     Atp3,   zero

	movw    Ctp4,   Cans
	movw    Atp4,   Aans

    clr     car2
    mul     Atp4,   Atp3
	add     Cans,   r0
	adc     Bans,   r1
	adc     Aans,   zero
    mul     Btp4,   Atp3
    add     Dans,   r0
	adc     Cans,   r1
	adc     car2,    zero
	//adc     Dtp2,   zero
	mul     Atp4,   Btp3
    add     Dans,   r0
	adc     Cans,   r1
	adc     car2,   zero
	//adc     Atp2,   zero
    mul     Atp4,   Ctp3
    add     Dans,   r1
	adc     Cans,   zero
	adc     car2,   zero
	//adc     Dtp2,   zero
    mul     Atp3,   Ctp4
    add     Dans,   r1
	adc     Cans,   zero
	adc     car2,   zero
	//adc     Dtp2,   zero
    mul     Btp3,   Btp4
    add     Dans,   r1
	adc     Cans,   zero
    adc     Bans,   car2
	adc     Aans,   zero

    movw    Btp1,   Btp3

    mul     Atp1,   Atp1
    movw    Btp3,   r0
    fmul    Atp1,   Btp1
    adc     Atp3,   zero
    add     Btp3,   r1
    adc     Atp3,   zero

    mul     Atp3,   Bans
    add     Dans,   r1
	adc     Cans,   zero
	adc     Bans,   zero
	adc     Aans,   zero
    mul     Btp3,   Cans
    add     Dans,   r1
	adc     Cans,   zero
	adc     Bans,   zero
	adc     Aans,   zero
    mul     Atp3,   Aans
    add     Dans,   r0
	adc     Cans,   r1
	adc     Bans,   zero
	adc     Aans,   zero

    pop     0
    bld     Aans,   7

    brmi    L_divi_ansdenorm
        lsl     Dans
        rol     Cans
        rol     Bans
        rol     Aans
        bld     Aans,   7
        subi    Aans,   0x80
        sbc     0,       zero
    L_divi_ansdenorm:
    rol     Dans
    adc     Cans,   zero
    adc     Bans,   zero
    adc     Aans,   zero
    adc     0,      zero

    clr     r1

    mov     Eans,    0
    pop    IniG
    pop    zero
/* epilogue start */
	ret
	.size	_ZN17fast_float_32_avrdvENS_9FastFloatES0_, .-_ZN17fast_float_32_avrdvENS_9FastFloatES0_
