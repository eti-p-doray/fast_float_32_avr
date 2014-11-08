//
//  FastFloat.h
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-18.
//
//

#ifndef FastFloat_h
#define FastFloat_h
#include "stdint.h"
#include <avr/io.h>

namespace fast_float_32_avr {

class FastFloat {
public:
    inline FastFloat() {};//Default constructor
    inline FastFloat(const double value);//Constructor which takes a double type
    
    inline operator double();//Conversion operator to double type
    
    inline FastFloat& operator=(const FastFloat value);
    inline FastFloat& operator=(const double value);
 
    inline int32_t get();
    
    friend FastFloat operator+(const FastFloat a, const FastFloat b);
    inline FastFloat operator-(FastFloat b);
    inline FastFloat operator-();
    friend FastFloat operator*(const FastFloat a, const FastFloat b);
    friend FastFloat operator/(const FastFloat a, const FastFloat b);
    friend FastFloat Inverse(const FastFloat a);
    friend FastFloat square(const FastFloat op);
    
    inline FastFloat operator+=(const FastFloat b);
    inline FastFloat operator-=(const FastFloat b);
    inline FastFloat operator*=(const FastFloat b);

    FastFloat pow(const uint8_t power);
    
private:
    double data;
    
    inline void toFastFloat(double value);
    inline double tofloat();
};
    
    double FastFloat::tofloat() {
        return data;
    }
    
    void FastFloat::toFastFloat(double value) {
        data = value;
    }

    
    FastFloat FastFloat::operator-(FastFloat b) {
        b = -b;
        return *this+b;
    }
    
    FastFloat FastFloat::operator-() {
        FastFloat ans;
        ans.data = -data;
        return ans;
    }
    
    FastFloat::FastFloat(const double value) {
        toFastFloat(value);
    }
    
    FastFloat::operator double() {
        return tofloat();
    }
    
    FastFloat& FastFloat::operator=(const FastFloat value) {
        data = value.data;
        return *this;
    }
    
    FastFloat& FastFloat::operator=(const double value) {
        toFastFloat(value);
        return *this;
    }
    
    int32_t FastFloat::get() {
        return *(int32_t*)this;
    }
    
    FastFloat FastFloat::operator+=(const FastFloat b) {
        *this = *this + b;
        return *this;
    }
    
    FastFloat FastFloat::operator-=(const FastFloat b) {
        *this = *this - b;
        return *this;
    }
    
    FastFloat FastFloat::operator*=(const FastFloat b) {
        *this = *this * b;
        return *this;
    }
    
    FastFloat FastFloat::pow(const uint8_t power) {
        FastFloat cur = *this;
        FastFloat ans = 0.0f;
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
    
}  // namespace fast_float_32_avr

#endif
