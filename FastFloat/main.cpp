// Copyright 2013 Etienne Pierre-Doray. All rights reserved.
// Use of this source code is governed by a GNU General Public
//License that can be found in the LICENSE file.

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
    FastFloat a = 2.0f;//This is the simpliest way to set a FastFloat variable
    FastFloat b = 1.0f;
    FastFloat c = 0;
        
    USART::write(0x47);//This is the initializer I use to communicate with my computer
    USART::write(0xB1);
    USART::write(uint8_t(a.get()>>24));//This is a "temporary" way to send data through serial
    USART::write(uint8_t(a.get()>>16));
    USART::write(uint8_t(a.get()>>8));
    USART::write(uint8_t(a.get()));
    USART::write(uint8_t(b.get()>>24));
    USART::write(uint8_t(b.get()>>16));
    USART::write(uint8_t(b.get()>>8));
    USART::write(uint8_t(b.get()));
    
    uint16_t i = 0;
    TCCR1A = 0x00;
    TCCR1B = 0x01;
    TCNT1 = 0x00;//The counter registers are set for test purpose

    c = a+b;
    
    i = TCNT1;//This gives the # clock cycle of the operation
    
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

