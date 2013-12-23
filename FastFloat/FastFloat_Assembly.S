//
//  FastFloat_Assembly.s
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-10-23.
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

//in memory : E-C-B-A

///////////////////////////* void tofloat32_t(float value) *//////////////////////////////
Cans = 20
Bans = 21
Aans = 22
Eans = 23
.global	_ZN17fast_float_32_avr9FastFloat11toFastFloatEf
	.type	_ZN17fast_float_32_avr9FastFloat11toFastFloatEf, @function
_ZN17fast_float_32_avr9FastFloat11toFastFloatEf:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rol     Aans
    rol     Eans
    ror     Aans
    subi    Eans,   0x7f
	movw    r30,    r24
	st      Z+,r23
    st      Z+,r20
    st      Z+,r21
    st      Z,r22
/* epilogue start */
	ret
	.size	_ZN17fast_float_32_avr9FastFloat11toFastFloatEf, .-_ZN17fast_float_32_avr9FastFloat11toFastFloatEf


/////////////////////////* void tofloat32_t(int32_t value) *///////////////////////////
ShiftV = 18
Dans = 20
Cans = 21
Bans = 22
Aans = 23
Eans = 24
Ctp = 25
Btp = 26
Atp = 27
.global	_ZN17fast_float_32_avr9FastFloat11toFastFloatEl
	.type	_ZN17fast_float_32_avr9FastFloat11toFastFloatEl, @function
_ZN17fast_float_32_avr9FastFloat11toFastFloatEl:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24//return
    clr     Eans
    bst     Aans,   7
    brtc    L_int32toffloat_ansnneg
        neg     Aans
        neg     Bans
        sbic     Aans,   0x00
        neg     Cans
        sbic     Bans,   0x00
        sbic     Aans,   0x00
        neg     Dans
        sbic     Cans,   0x00
        sbic     Bans,   0x00
        sbic     Aans,   0x00
    L_int32toffloat_ansnneg:
    ldi     Eans,   0x1f
    tst     Aans
    brne   L_int32toffloat_denorms8
        tst     Cans
        breq    L_int32toffloat_denormb18
            tst     Bans
            breq    L_int32toffloat_denormb10
                mov     Aans,   Bans
                mov     Bans,   Cans
                mov     Cans,   Dans
                clr     Dans
                ldi     Eans,   0x07
                rjmp    L_int32toffloat_denorms8
            L_int32toffloat_denormb10:
                movw    Bans,   Dans
                clr     Dans
                clr     Cans
                ldi     Eans,   0x0f
                rjmp    L_int32toffloat_denorms8
        L_int32toffloat_denormb18:
            tst     Dans
            brne    L_int32toffloat_denorms20
                ldi     Eans,   0x80
                st      Z+,     Eans
                st      Z+,     __zero_reg__
                st      Z+,     __zero_reg__
                st      Z,      __zero_reg__
                ret
            L_int32toffloat_denorms20:
                mov     Aans,   Dans
                clr     Dans
                clr     Cans
                clr     Bans
                ldi     Eans,   0x80

    L_int32toffloat_denorms8:

    L_int32toffloat_ansnnorm:
    dec     Eans
    lsl     Dans
    rol     Cans
    rol     Bans
    rol     Aans
    brpl    L_int32toffloat_ansnnorm

L_int32toffloat_ansnorm:
    bld     Aans,   7
    st      Z+,Eans
    st      Z+,Cans
    st      Z+,Bans
    st      Z,Aans

/* epilogue start */
	ret
	.size	_ZN17fast_float_32_avr9FastFloat11toFastFloatEl, .-_ZN17fast_float_32_avr9FastFloat11toFastFloatEl


///////////////////////////* void tofloat32_t(int16_t value) */////////////////////////////////
ShiftV = 18
Bans = 22
Aans = 23
Eans = 24
Btp = 20
Atp = 21
.global	_ZN17fast_float_32_avr9FastFloat11toFastFloatEi
	.type	_ZN17fast_float_32_avr9FastFloat11toFastFloatEi, @function
_ZN17fast_float_32_avr9FastFloat11toFastFloatEi:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24//return
    bst     Aans,   7
    brtc    L_int16toffloat_ansnneg
        neg     Aans
        neg     Bans
        sbic     Aans,   0x00
    L_int16toffloat_ansnneg:
    ldi     Eans,   0x0f
    tst     Aans
    brne   L_int16toffloat_denorms8
        tst     Bans
        breq    L_int16toffloat_denorms10
            mov     Aans,   Bans
            clr     Bans
            ldi    Eans,   0x07
            rjmp    L_int16toffloat_denorms8
        L_int16toffloat_denorms10:
            ldi     Eans,   0x80
            st      Z+,     Eans
            st      Z+,     __zero_reg__
            st      Z+,     __zero_reg__
            st      Z,      __zero_reg__
            ret

    L_int16toffloat_denorms8:

    L_int16toffloat_ansnnorm:
    dec     Eans
    lsl     Bans
    rol     Aans
    brpl    L_int16toffloat_ansnnorm

    L_int16toffloat_ansnorm:
    bld     Aans,   7
    st      Z+,     Eans
    st      Z+,     __zero_reg__
    st      Z+,     Bans
    st      Z,      Aans

/* epilogue start */
	ret
	.size	_ZN17fast_float_32_avr9FastFloat11toFastFloatEi, .-_ZN17fast_float_32_avr9FastFloat11toFastFloatEi


/////////////////////////* void tofloat32_t(int8_t value) *///////////////////////////////
ShiftV = 18
Aans = 23
Eans = 24
.global	_ZN17fast_float_32_avr9FastFloat11toFastFloatEa
	.type	_ZN17fast_float_32_avr9FastFloat11toFastFloatEa, @function
_ZN17fast_float_32_avr9FastFloat11toFastFloatEa:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24//return
    bst     Aans,   7
    brtc    L_int8toffloat_ansnneg
        neg     Aans
    L_int8toffloat_ansnneg:
    ldi     Eans,   0x07
    tst     Aans
    brne   L_int8toffloat_ansnnul
        st      Z+,     Eans
        st      Z+,     __zero_reg__
        st      Z+,     Bans
        st      Z,      Aans
        ret

    L_int8toffloat_ansnnul:

    L_int8toffloat_ansnnorm:
    dec     Eans
    lsl     Aans
    brpl    L_int8toffloat_ansnnorm

    L_int8toffloat_ansnorm:
    bld     Aans,   7
    st      Z+,     Eans
    st      Z+,     __zero_reg__
    st      Z+,     __zero_reg__
    st      Z,      Aans
	ret
	.size	_ZN17fast_float_32_avr9FastFloat11toFastFloatEa, .-_ZN17fast_float_32_avr9FastFloat11toFastFloatEa


//////////////////////////* float tofloat() *//////////////////////////
Cans = 22
Bans = 23
Aans = 24
Eans = 25
.global	_ZN17fast_float_32_avr9FastFloat7tofloatEv
	.type	_ZN17fast_float_32_avr9FastFloat7tofloatEv, @function
_ZN17fast_float_32_avr9FastFloat7tofloatEv:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24
    ld     Eans,Z+
    ld      Cans,Z+
    ld      Bans,Z+
    ld      Aans,Z
    subi    Eans,   0x81
    rol     Aans
    ror     Eans
    ror     Aans
	ret
	.size	_ZN17fast_float_32_avr9FastFloat7tofloatEv, .-_ZN17fast_float_32_avr9FastFloat7tofloatEv


//////////////////////////* int32_t toint32_t() *//////////////////////////
ShiftV = 21
Dans = 22
Cans = 23
Bans = 24
Aans = 25
Eans = 20
Dtp = 26
Ctp = 27
Btp = 30
Atp = 31
.global	_ZN17fast_float_32_avr9FastFloat9toint32_tEv
	.type	_ZN17fast_float_32_avr9FastFloat9toint32_tEv, @function
_ZN17fast_float_32_avr9FastFloat9toint32_tEv:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24
    ld      Eans,   Z+
    ld      Cans,   Z+
    ld      Bans,   Z+
    ld      Aans,   Z

    bst     Aans,    7
    sbr     Aans,   0x80
    cpi     Eans,   0x20
    brlt    L_ffloattoint32_expl20
        ser     Aans//overflow
        ser     Bans
        ser     Cans
        ser     Dans
        ret
    L_ffloattoint32_expl20:
    subi     Eans,   0x18
	brge   L_ffloattoint32_Expb18
        subi    Eans,   0xf0
        brlt    L_ffloattoint32_Exps8
            subi    Eans,   0x08
            brlt    L_ffloattoint32_Exps10
                mov     Dans,   Cans
                mov     Cans,   Bans
                mov     Bans,   Aans
                clr     Aans
                rjmp    L_ffloattoint32_Expb18
            L_ffloattoint32_Exps10:
                movw    Dans,   Bans
                clr     Bans
                clr     Aans
                rjmp    L_ffloattoint32_Expb18
        L_ffloattoint32_Exps8:
            subi    Eans,   0xf8
            brge    L_ffloattoint32_Expb0
                clr     Aans
                clr     Bans
                clr     Cans
                clr     Dans
                ret
            L_ffloattoint32_Expb0:
                mov     Dans,   Aans
                clr     Cans
                clr     Bans
                clr     Aans

	L_ffloattoint32_Expb18:

    subi    Eans,   0x08
    L_ffloattoint32_Mantnshifted:
    lsr     Aans
    ror     Bans
    ror     Cans
    ror     Dans
    inc     Eans
    brne    L_ffloattoint32_Mantnshifted

L_ffloattoint32_Mantshifted:
    brtc    L_ffloattoint32_Ansnneg
        neg     Aans
        neg     Bans
        sbic     Aans,   0x00
        neg     Cans
        sbic     Bans,   0x00
        sbic     Aans,   0x00
        neg     Dans
        sbic     Cans,   0x00
        sbic     Bans,   0x00
        sbic     Aans,   0x00
    L_ffloattoint32_Ansnneg:
	ret
		.size	_ZN17fast_float_32_avr9FastFloat9toint32_tEv, .-_ZN17fast_float_32_avr9FastFloat9toint32_tEv


//////////////////////////* int16_t toint16_t() *//////////////////////////
ShiftV = 21
Bans = 24
Aans = 25
Eans = 20
Btp = 22
Atp = 23
.global	_ZN17fast_float_32_avr9FastFloat9toint16_tEv
	.type	_ZN17fast_float_32_avr9FastFloat9toint16_tEv, @function
_ZN17fast_float_32_avr9FastFloat9toint16_tEv:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24
    ld      Eans,   Z
    ldd      Bans,   Z+2
    ldd      Aans,   Z+3

    bst     Aans,    7
    sbr     Aans,   0x80
    cpi     Eans,   0x10
    brlt    L_ffloattoint16_expl10
        ser     Aans//overflow
        ser     Bans
        ret
    L_ffloattoint16_expl10:
    subi     Eans,   0x08
	brge   L_ffloattoint16_Expb8
        subi    Eans,   0x00
        brlt    L_ffloattoint16_Expb0
            clr     Aans
            clr     Bans
            ret
        L_ffloattoint16_Expb0:
            mov     Bans,   Aans
            clr     Aans

	L_ffloattoint16_Expb8:

    subi    Eans,   0x08
    L_ffloattoint16_Mantnshifted:
    lsr     Aans
    ror     Bans
    inc     Eans
    brne    L_ffloattoint16_Mantnshifted

L_ffloattoint16_Mantshifted:
    brtc    L_ffloattoint16_Ansnneg
        neg     Aans
        neg     Bans
        sbic    Aans,   0x00
    L_ffloattoint16_Ansnneg:
	ret
		.size	_ZN17fast_float_32_avr9FastFloat9toint16_tEv, .-_ZN17fast_float_32_avr9FastFloat9toint16_tEv


//////////////////////////* int8_t toint8_t() *//////////////////////////
ShiftV = 21
Aans = 24
Eans = 20
Atp = 25
.global	_ZN17fast_float_32_avr9FastFloat9toint8_tEv
	.type	_ZN17fast_float_32_avr9FastFloat9toint8_tEv, @function
_ZN17fast_float_32_avr9FastFloat9toint8_tEv:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    movw    r30,    r24
    ld      Eans,   Z
    ldd      Aans,   Z+3

    bst     Aans,    7
    sbr     Aans,   0x80
    cpi     Eans,   0x8
    brlt    L_ffloattoint8_expl8
        ser     Aans//overflow
        ret
    L_ffloattoint8_expl8:
    cpi     Eans,   0x00
	brge   L_ffloattoint8_Expb0
        clr     Aans
        ret

	L_ffloattoint8_Expb0:

    subi    Eans,   0x08
    L_ffloattoint8_Mantnshifted:
    lsr     Aans
    inc     Eans
    brne    L_ffloattoint8_Mantnshifted

L_ffloattoint8_Mantshifted:
    brtc    L_ffloattoint8_Ansnneg
        neg     Aans
    L_ffloattoint8_Ansnneg:
	ret
		.size	_ZN17fast_float_32_avr9FastFloat9toint8_tEv, .-_ZN17fast_float_32_avr9FastFloat9toint8_tEv


//////////////////////////* FastFloat operator+(FastFloat op1, FastFloat op2) *//////////////////////////
Eop1 = 22
Cop1 = 23
Bop1 = 24
Aop1 = 25

ShiftV = 18
Eop2 = 18
Cop2 = 19
Bop2 = 20
Aop2 = 21

Eans = 22
Cans = 23
Bans = 24
Aans = 25

ExpD = 26
Etp = 26
Ctp = 27
Btp = 30
Atp = 31

stst = 26
.global	_ZN17fast_float_32_avrplENS_9FastFloatES0_
	.type	_ZN17fast_float_32_avrplENS_9FastFloatES0_, @function
_ZN17fast_float_32_avrplENS_9FastFloatES0_:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    mov     stst,    Aop1
    eor     stst,    Aop2
    bst     stst,    7

    movw    Btp,     Bop1
    movw    Etp,     Eop1
    sub     ExpD,    Eop2
    brne    L_plus_expneq
        rjmp L_plus_expeq
    L_plus_expneq:
    brge    L_plus_regset
        neg     ExpD
        movw    Eop1,   Eop2
        movw    Bop1,   Bop2
        movw    Bop2,   Btp
        mov     Cop2,   Ctp
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
                ret
            L_plus_ExpDs19:
            subi    ExpD,   0x10
            mov     Cop2,   Aop2
            clr     Aop2
            clr     Bop2
	L_plus_ExpDs9:
     
	cpi    ExpD,   0x05
	brsh   L_plus_ExpDb5
        movw    Btp,    Bop2
        mov     Ctp,    Cop2
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
	movw    Btp,    r0
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
        bld     Aans,    7
        ret//14//18
    L_plus_expneqSbitsame:
        bst     Aans,    7
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
        bld     Aans,    7
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
                    ldi     Eop1,    0x80
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

        cpi    Atp,    0x10
        brlo   L_plus_denormb4
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
            movw    Btp,    Bans
            mov     Ctp,    Cans
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
        movw    Bans,   r0
        mul     Atp,    ShiftV
        add     Aans,   r0
        mul     Ctp,    ShiftV
        mov     Cans,   r0
        add     Bans,   r1
        clr     r1

	L_plus_ansnorm:
    bld     Aans,   7
	ret
	.size	_ZN17fast_float_32_avrplENS_9FastFloatES0_, .-_ZN17fast_float_32_avrplENS_9FastFloatES0_
    


//////////////////////////* FastFloat operator*(FastFloat op1, FastFloat op2) *//////////////////////////
Eop1 = 22
Cop1 = 23
Bop1 = 24
Aop1 = 25

Eop2 = 18
Cop2 = 19
Bop2 = 20
Aop2 = 21

Eans = 22
Cans = 23
Bans = 24
Aans = 25

Ctp = 27
Btp = 30
Atp = 31

zero = 26
stst = 26
.global	_ZN17fast_float_32_avrmlENS_9FastFloatES0_
	.type	_ZN17fast_float_32_avrmlENS_9FastFloatES0_, @function
_ZN17fast_float_32_avrmlENS_9FastFloatES0_:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    add     Eop1,   Eop2
	//brvc    L_mult_v
    mov     stst,   Aop1
    eor     stst,   Aop2
    bst     stst,   7
    lsl     Cop2
    rol     Bop2
    rol     Aop2
    sbr     Aop1,   0x80

    clr     zero
	mul     Aop1,   Aop2
	movw    Btp,  r0
	mul     Bop1,   Bop2
	mov     Ctp,  r1
	mul     Aop1,   Bop2
	add     Ctp,  r0
	adc     Btp,  r1
	adc     Atp,  zero
	mul     Aop1,   Cop2
	add     Ctp,  r1
	adc     Btp,  zero
	adc     Atp,  zero
	mul     Aop2,  Bop1
	add     Ctp,  r0
	adc     Btp,  r1
	adc     Atp,  zero
	mul     Aop2,   Cop1
	add     Ctp,  r1
	adc     Btp,  zero
	adc     Atp,  zero

    sec
    adc     Cans,   Ctp
    adc     Bans,   Btp
    adc     Aans,   Atp

    brcc    L_mult_nc
        ror     Aans
        ror     Bans
        ror     Cans
        adc     Cans,   zero
        adc     Bans,   zero
        adc     Aans,   zero
        inc     Eans
    L_mult_nc:

    bld     Aans,   7
	clr     r1
	ret

    /*L_mult_v:
        brpl    L_mult_underflow
            ldi     Aans,   0x7f
            ret
        L_mult_underflow:
            ldi     Aans,   0x80
            ret*/
	.size	_ZN17fast_float_32_avrmlENS_9FastFloatES0_, .-_ZN17fast_float_32_avrmlENS_9FastFloatES0_


//////////////////////////* FastFloat square(FastFloat op) *//////////////////////////
Eop = 22
Cop = 23
Bop = 24
Aop = 25

Eans = 22
Cans = 23
Bans = 24
Aans = 25

Ctp = 19
Btp = 20
Atp = 21

zero = 26
stst = 26
.global	_ZN17fast_float_32_avr6squareENS_9FastFloatE
	.type	_ZN17fast_float_32_avr6squareENS_9FastFloatE, @function
_ZN17fast_float_32_avr6squareENS_9FastFloatE:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
    add     Eop,   Eop
	//brvc    L_square_v
    bst     Aop,   7
    lsl     Cop
    rol     Bop
    rol     Aop

    movw    Btp,    Bop
    mov     Ctp,    Cop

    clr     zero
	mul     Atp,   Atp
	movw    Bans,  r0
	mul     Btp,   Btp
	mov     Cans,  r1
	fmul     Atp,   Btp
    adc     Aans,   zero
	add     Cans,  r0
	adc     Bans,  r1
	adc     Aans,  zero
	fmul     Atp,   Ctp
    adc     Bans,   zero
    adc     Aans,   zero
	add     Cans,  r1
	adc     Bans,  zero
	adc     Aans,  zero

    sec
    ror     Aans
    ror     Bans
    ror     Cans

    add     Cans,   Ctp
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

    bld     Aans,   7
	clr     r1
    /*L_ready:
    lds r31,192
    sbrs r31,5
    rjmp L_ready
    sts 198,Eop*/
	ret

    /*L_square_v:
        brpl    L_square_underflow
            ldi     Aans,   0x7f
            ret
        L_square_underflow:
            ldi     Aans,   0x80
            ret*/
	.size	_ZN17fast_float_32_avr6squareENS_9FastFloatE, .-_ZN17fast_float_32_avr6squareENS_9FastFloatE


//////////////////////////* FastFloat operator/(FastFloat op1, FastFloat op2) *//////////////////////////
car = 22
Eop1 = 22
Cop1 = 23
Bop1 = 24
Aop1 = 25

Eop2 = 18
Cop2 = 19
Bop2 = 20
Aop2 = 21

Eans = 22
Cans = 23
Bans = 24
Aans = 25

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

    mov     stst,   Aop1
    eor     stst,   Aop2
    bst     stst,   7
    sbr     Aop2,   0x80
    sbr     Aop1,   0x80
    clr     zero

	sub     Eop1,   Eop2
    /*brvc    L_divi_nv
        brpl    L_divi_underflow
            ldi     Eans,   0x7f
            ret
        L_divi_underflow:
            ldi     Eans,   0x80
            ret
    L_divi_nv:*/
    push    Eop1

    ldi     IniG,   0xf1
    movw    Btp3,   Bop2
    lsl     Btp3
    rol     Atp3
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
	adc     Atp1,   car
	//adc     Atp1,   zero

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
	mul     IniG,   Atp1
	movw    Btp2,   r0
	mul     IniG,   Ctp1
	movw    Dtp2,   r0
    mul     IniG,   Btp1
	add     Ctp2,   r0
	adc     Btp2,   r1
	adc     Atp2,   zero
    mul     IniG,   Dtp1
    add     Dtp2,   r1
	adc     Ctp2,   zero
	adc     Btp2,   zero
	adc     Atp2,   zero

    cpi     IniG,   0xec
    brsh    L_divi_overf
        add     Dtp2,   Dtp1
        adc     Ctp2,   Ctp1
        adc     Btp2,   Btp1
        adc     Atp2,   Atp1
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

	movw    Btp1,   Btp2
	movw    Dtp1,   Dtp2

    clr     car2
    mul     Atp1,   Atp3
	add     Ctp2,   r0
	adc     Btp2,   r1
	adc     Atp2,   zero
    mul     Btp1,   Atp3
    add     Dtp2,   r0
	adc     Ctp2,   r1
	adc     car2,    zero
	//adc     Dtp2,   zero
	mul     Atp1,   Btp3
    add     Dtp2,   r0
	adc     Ctp2,   r1
	adc     car2,   zero
	//adc     Atp2,   zero
    mul     Atp1,   Ctp3
    add     Dtp2,   r1
	adc     Ctp2,   zero
	adc     car2,   zero
	//adc     Dtp2,   zero
    mul     Atp3,   Ctp1
    add     Dtp2,   r1
	adc     Ctp2,   zero
	adc     car2,   zero
	//adc     Dtp2,   zero
    mul     Btp3,   Btp1
    add     Dtp2,   r1
	adc     Ctp2,   zero
    adc     Btp2,   car2
	adc     Atp2,   zero

    movw    Btp1,   Btp3

    mul     Atp1,   Atp1
    movw    Btp3,   r0
    fmul    Atp1,   Btp1
    adc     Atp3,   zero
    add     Btp3,   r1
    adc     Atp3,   zero

    mul     Atp3,   Aans
    add     Dans,   r0
	adc     Cans,   r1
	adc     Bans,   zero
	adc     Aans,   zero
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

    pop     0

    brmi    L_divi_ansdenorm
        dec     0
        lsl     Dans
        rol     Cans
        rol     Bans
        rol     Aans
    L_divi_ansdenorm:
    rol     Dans
    adc     Cans,   zero
    adc     Bans,   zero
    adc     Aans,   zero
    brcc    L_divi_ansoverf
        inc     0
    L_divi_ansoverf:

    bld     Aans,   7
    clr     r1
    mov     Eans,    0
    pop    zero
    pop    IniG
/* epilogue start */
	ret
	.size	_ZN17fast_float_32_avrdvENS_9FastFloatES0_, .-_ZN17fast_float_32_avrdvENS_9FastFloatES0_
