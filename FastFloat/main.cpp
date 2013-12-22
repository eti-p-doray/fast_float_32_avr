/* Name: main.c
 * Author: <insert your name here>
 * Copyright: <insert your copyright message here>
 * License: <insert your license reference here>
 */

#include "stdint.h"
#include <avr/io.h>
#include <util/delay.h>
#include "USART.h"
#include "FastFloat.h"
#include "math.h"
#include <stdlib.h>

using namespace fast_float_32_avr;

void main(void)
{
    USART::init();
    FastFloat a = 1.5f;
    FastFloat b = 2.0f;
    FastFloat c = 0;
    uint16_t i = 0;
        
    USART::write(0x47);
    USART::write(0xB1);
    USART::write(uint8_t(a.get()>>24));
    USART::write(uint8_t(a.get()>>16));
    USART::write(uint8_t(a.get()>>8));
    USART::write(uint8_t(a.get()));
    USART::write(uint8_t(b.get()>>24));
    USART::write(uint8_t(b.get()>>16));
    USART::write(uint8_t(b.get()>>8));
    USART::write(uint8_t(b.get()));
    
    TCCR1A = 0x00;
    TCCR1B = 0x01;
    TCNT1 = 0x00;

    c = a+b;
    i = TCNT1;
    
    USART::write(uint8_t(c.get()>>24));
    USART::write(uint8_t(c.get()>>16));
    USART::write(uint8_t(c.get()>>8));
    USART::write(uint8_t(c.get()));
    USART::write(uint8_t(i>>8));
    USART::write(uint8_t(i));
    
    
    for(;;){
        PORTB |= (1<<PORTB5);
        char i;
        for(i = 0; i < 33; i++){
            _delay_ms(30);  // max is 262.14 ms / F_CPU in MHz
        }
        PORTB &= ~(1<<PORTB5);
        for(i = 0; i < 33; i++){
            _delay_ms(30);  // max is 262.14 ms / F_CPU in MHz
        }
    }

}

