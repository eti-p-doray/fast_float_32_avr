//
//  USART.cpp
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-04.
//
//

#include "USART.h"
#include <avr/io.h>
#include <stdlib.h>



void USART::init(uint32_t baud) {
    UCSR0A |= (1<<U2X0);
    UCSR0B |= (1<<TXEN0) ;
    UCSR0C |= (1<<UCSZ00) | (1<<UCSZ01);
    
    UBRR0 = int16_t( F_CPU/(8*baud) - 1 );
}

void USART::write(uint8_t newdata) {
    while(!(UCSR0A&(1<<UDRE0)));
    UDR0 = newdata;
}


void USART::write(FastFloat data) {
    USART::write(uint8_t(data.get()>>24));
    USART::write(uint8_t(data.get()>>16));
    USART::write(uint8_t(data.get()>>8));
    USART::write(uint8_t(data.get()));
}
