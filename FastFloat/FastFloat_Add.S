//
//  FastFloat_Add.s
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

ShiftV = 21
Cop2 = 18
Bop2 = 19
Aop2 = 20
Eop2 = 21

Cans = 22
Bans = 23
Aans = 24
Eans = 25

ExpD = 31
Ctp = 26
Btp = 27
Atp = 30
Etp = 31

stst = 31
.global	_ZN17fast_float_32_avrplENS_9FastFloatES0_
	.type	_ZN17fast_float_32_avrplENS_9FastFloatES0_, @function
_ZN17fast_float_32_avrplENS_9FastFloatES0_:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    lsl     Aop2
    rol     Eop2
    ror     Aop2

    lsl     Aop1
    rol     Eop1
    ror     Aop1

    mov     stst,    Aop1
    eor     stst,    Aop2
    bst     stst,    7

    movw    Ctp,     Cop1
    movw    Atp,     Aop1
    sub     ExpD,    Eop2
    brne    L_plus_expneq
        rjmp L_plus_expeq
    L_plus_expneq:
    brsh    L_plus_regset
        neg     ExpD
        movw    Cop1,   Cop2
        movw    Aop1,   Aop2
        movw    Cop2,   Ctp
        mov     Aop2,   Atp
    L_plus_regset:

    sbr     Aop2,   0x80
    cpi     ExpD,   0x09
	brlo   L_plus_ExpDs9
        cpi     ExpD,   0x11
        brsh   L_plus_ExpDb11
            subi    ExpD,   0x08
            mov     Cop2,   Bop2
            mov     Bop2,   Aop2
            clr     Aop2
            rjmp    L_plus_ExpDs9
        L_plus_ExpDb11:
            cpi    ExpD,    0x19
            brlo   L_plus_ExpDs19
                lsl     Aans
                ror     Eans
                ror     Aans
                ret
            L_plus_ExpDs19:
            subi    ExpD,   0x10
            mov     Cop2,   Aop2
            clr     Aop2
            clr     Bop2
	L_plus_ExpDs9:
     
	cpi    ExpD,   0x05
	brsh   L_plus_ExpDb5
        movw    Ctp,    Cop2
        mov     Atp,    Aop2
        dec     ExpD
        breq    L_plus_Mantshifted//5
        lsr     Atp
        ror     Btp
        ror     Ctp
        dec     ExpD
        breq    L_plus_Mantshifted//10
        lsr     Atp
        ror     Btp
        ror     Ctp
        dec     ExpD
        breq    L_plus_Mantshifted//15
        lsr     Atp
        ror     Btp
        ror     Ctp
        rjmp    L_plus_Mantshifted//20
	L_plus_ExpDb5:
        cpi     ExpD,    0x07
        brsh    L_plus_ExpDb7
            cpi     ExpD,    0x06
            brsh    L_plus_ExpDb6
                ldi     ShiftV, 0x10
                rjmp    L_plus_ShiftVset//11
            L_plus_ExpDb6:
                ldi     ShiftV, 0x08
                rjmp    L_plus_ShiftVset
        L_plus_ExpDb7:
            cpi     ExpD,   0x08
            brlo    L_plus_ExpDs8
                ldi     ShiftV, 0x02
                rjmp    L_plus_ShiftVset
            L_plus_ExpDs8:
                ldi     ShiftV, 0x04

    L_plus_ShiftVset:
	mul    Aop2,   ShiftV
	mov    Btp,    r0
    mov    Atp,    r1
	mul    Cop2,   ShiftV
	mov     Ctp,    r1
	mul    Bop2,   ShiftV
	add     Ctp,    r0
	adc     Btp,    r1//10
    clr     r1


    L_plus_Mantshifted:
    brtc    L_plus_expneqSbitsame
        bst     Aans,    7
        dec     Eans
        lsl     Cans
        rol     Bans
        rol     Aans
        sub     Cans,    Ctp
        sbc     Bans,    Btp
        sbc     Aans,    Atp
        brcc    L_plus_v
        brpl    L_plus_ansdenorm

        lsl     Aans
        ror     Eans
        ror     Aans
        bld     Eans,    7
        ret//14//18
    L_plus_expneqSbitsame:
        bst     Aans,    7
        cbr     Aans,   0x80
        sec
        ror     Atp
        ror     Btp
        ror     Ctp
        adc     Cans,    Ctp
        adc     Bans,    Btp
        adc     Aans,    Atp
        brcc    L_plus_nv2
        L_plus_v:
            ror     Aans
            ror     Bans
            ror     Cans
            adc     Cans,   r1
            adc     Bans,   r1
            adc     Aans,   r1
            inc     Eans
        L_plus_nv2:

        lsl     Aans
        ror     Eans
        ror     Aans
        bld     Eans,    7
        ret//11/15

    L_plus_expeq:
        brts    L_plus_expeqSbitnsame

        add     Cans,    Cop2
        adc     Bans,    Bop2
        adc     Aans,    Aop2
        L_plus_normalization:
            ror     Aans
            ror     Bans
            ror     Cans
            adc     Cans,   r1
            adc     Bans,   r1
            adc     Aans,   r1
            inc     Eans
        lsl     Aans
        ror     Eans
        ror     Aans
        ret

        L_plus_expeqSbitnsame:
        bst     Aans,    7
        sub     Cans,     Cop2
        sbc     Bans,     Bop2
        sbc     Aans,     Aop2
        
        brmi    L_plus_ansnneg
            bst     Aop2,    7
            neg     Aans
            neg     Bans
            sbc     Aans,   r1
            neg     Cans
            sbc     Bans,   r1
            sbc     Aans,   r1
        L_plus_ansnneg:
        L_plus_ansdenorm:

        andi     Aans,   0x7f
        brne   L_plus_denorms8
            tst     Bans
            brne    L_plus_denorms10
                tst     Cans
                brne    L_plus_nonnul
                    ldi     Eop1,    0x00
                    lsl     Aans
                    ror     Eans
                    ror     Aans
                    ret
                L_plus_nonnul:
                    mov     Aans,    Cans
                    clr     Aans
                    clr     Cans
                    subi    Eop1,    0x10
                    rjmp   L_plus_denorms8
            L_plus_denorms10:
                mov    Aans,    Bans
                mov    Bans,    Cans
                clr    Cans
                subi   Eop1,    0x08
        L_plus_denorms8:

        cpi    Aans,    0x10
        brlo   L_plus_denormb4
            brmi    L_plus_ansnorm
            dec     Eans
            lsl     Cans
            rol     Bans
            rol     Aans
            brmi    L_plus_ansnorm
            dec     Eans
            lsl     Cans
            rol     Bans
            rol     Aans
            brmi    L_plus_ansnorm
            dec     Eans
            lsl     Cans
            rol     Bans
            rol     Aans
            rjmp    L_plus_ansnorm
        L_plus_denormb4:
            movw    Ctp,    Cans
            mov     Atp,    Aans
            cpi     Atp,    0x04
            brlo    L_plus_denormb6
                cpi     Atp,    0x08
                brlo    L_plus_denormb5
                    ldi     ShiftV,  0x10
                    subi    Eop1,    0x04
                    rjmp    L_plus_normset
                L_plus_denormb5:
                    ldi    ShiftV,  0x20
                    subi   Eop1,    0x05
                    rjmp   L_plus_normset
            L_plus_denormb6:
                cpi    Atp,    0x02
                brlo   L_plus_denormb7
                    ldi    ShiftV,  0x40
                    subi   Eop1,    0x06
                    rjmp   L_plus_normset
                L_plus_denormb7:
                    ldi    ShiftV,  0x80
                    subi   Eop1,    0x07
        L_plus_normset:
        mul     Btp,    ShiftV
        mov    Bans,   r0
        mov    Aans,   r1
        mul     Atp,    ShiftV
        add     Aans,   r0
        mul     Ctp,    ShiftV
        mov     Cans,   r0
        add     Bans,   r1
        clr     r1

	L_plus_ansnorm:

    lsl     Aans
    ror     Eans
    ror     Aans
    bld     Eans,   7
	ret
	.size	_ZN17fast_float_32_avrplENS_9FastFloatES0_, .-_ZN17fast_float_32_avrplENS_9FastFloatES0_
    
