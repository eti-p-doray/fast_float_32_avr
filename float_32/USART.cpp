//
//  USART.cpp
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-04.
//
//

#include "USART.h"
#include <avr/io.h>

void USART::init() {
    UCSR0A = 0x02;
    UCSR0B = 0x18;
    UCSR0C = 0x06;
    UBRR0H = 0x00;
    UBRR0L = 0x67;
}

void USART::write(uint8_t newdata) {
    while(!(UCSR0A&(1<<UDRE0)));
    UDR0 = newdata;
}
