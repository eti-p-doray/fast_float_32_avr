//
//  USART.h
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-04.
//
//

#ifndef float_32_USART_h
#define float_32_USART_h

#include "stdint.h"
#include <avr/io.h>

class USART {
public:
    static void init();
    static void write(uint8_t newdata);
};

#endif
