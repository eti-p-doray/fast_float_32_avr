//
//  USART.h
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-04.
//
//

#ifndef USART_h
#define USART_h

#include "stdint.h"
#include <avr/io.h>

#include "FastFloat.h"

using namespace fast_float_32_avr;

class USART {
public:
    static void init(uint32_t baud);
    static void write(uint8_t newdata);
    static void write(FastFloat data);
};

#endif
