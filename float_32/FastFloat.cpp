//
//  FastFloat.cpp
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-11-24.
//
//

#include "FastFloat.h"

#include <stdio.h>

using namespace fast_float_32_avr;

FastFloat FastFloat::sqrtval[2] = {FastFloat(0xfe,0xb4,0x76c8), FastFloat(0xfe,0x35,0x7a5e)};

bool FastFloat::operator==(const FastFloat op2) {
    if ((exp == op2.exp) and (msb == op2.msb) and (lsb == op2.lsb)) {
        return true;
    }
    else {
        return false;
    }
}

bool FastFloat::operator<(const FastFloat op2) {
    if (exp<op2.exp) {
        return true;
    }
    else if (exp>op2.exp) {
        return false;
    }
    else {
        if (msb<op2.msb) {
            return true;
        }
        else if (msb>op2.msb) {
            return false;
        }
        else {
            if ( ((lsb<op2.lsb) and (msb>0)) or ((lsb>op2.lsb) and (lsb<0)) ) {
                return true;
            }
            else {
                return false;
            }
        }
    }
}

bool FastFloat::operator>(const FastFloat op2) {
    if (*this<op2) {
        return false;
    }
    else {
        return true;
    }
}

bool FastFloat::operator<=(const FastFloat op2) {
    if ((*this<op2) or (*this==op2)) {
        return true;
    }
    else {
        return false;
    }
}

bool FastFloat::operator>=(const FastFloat op2) {
    if ((*this>op2) or (*this==op2)) {
        return true;
    }
    else {
        return false;
    }
}

FastFloat FastFloat::abs() {
    FastFloat ans = *this;
    ans.msb &= 0x7fff;
    return ans;
}

FastFloat FastFloat::ldexp(const int8_t power) {
    FastFloat ans = *this;
    ans.exp+=power;
    return ans;
}

FastFloat FastFloat::pow(const uint8_t power) {
    FastFloat cur = *this;
    FastFloat ans(0x00,0x00,0x0000);
    uint8_t j = 0xfe;
    for (uint8_t i=0x01; i<=0x80; i<<=1, j-=i) {
        if (power&i) {
            ans *= cur;
        }
        if ((power&j)==0) {
            break;
        }
        cur = square(cur);
    }
    return ans;

}

FastFloat FastFloat::sqrt() {
    FastFloat x(0x00,lsb,msb);
    if ((exp%2)==1) {
        x.ldexp(-1);
    }
    FastFloat ans = x;
    ans = FastFloat::sqrtval[0] * ans + FastFloat::sqrtval[1];
    ans = (ans+x/ans).ldexp(-1);
    ans = (ans+x/ans).ldexp(-1);
    ans.exp += exp>>1;
    return ans;
}
