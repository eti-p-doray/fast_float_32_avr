//
//  FastFloat.h
//  float_32
//
//  Created by Etienne Pierre-Doray on 2013-08-18.
//
//

#ifndef FastFloat_FastFloat_h
#define FastFloat_FastFloat_h
#include "stdint.h"
#include <avr/io.h>

namespace fast_float_32_avr {

class FastFloat {
public:
    inline FastFloat() {};//Default constructor
    inline FastFloat(const float value);//Constructor which takes a float type
    inline FastFloat(const int32_t value);//Constructor which takes a int32_t type
    inline FastFloat(const int16_t value);//Constructor which takes a int16_t type
    inline FastFloat(const int8_t value);//Constructor which takes a int8_t type
    inline FastFloat(const uint8_t nexp, const uint8_t nlsb, const int16_t nmsb);//Constructor which takes raw byte
    
    inline operator float();//Conversion operator to float type
    inline operator int32_t();//Conversion operator to int32_t type
    inline operator int16_t();//Conversion operator to int16_t type
    inline operator int8_t();//Conversion operator to int8_t type
    
    inline FastFloat& operator=(const FastFloat value);
    inline FastFloat& operator=(const float value);
    inline FastFloat& operator=(const int32_t value);
    inline FastFloat& operator=(const int16_t value);
    inline FastFloat& operator=(const int8_t value);
 
    inline int32_t get();
    
    friend FastFloat operator+(const FastFloat op1, const FastFloat op2);
    inline friend FastFloat operator-(const FastFloat op1, FastFloat op2);
    friend FastFloat operator*(const FastFloat op1, const FastFloat op2);
    friend FastFloat operator/(const FastFloat op1, const FastFloat op2);
    friend FastFloat square(const FastFloat op);
    
    inline FastFloat operator+=(const FastFloat op2);
    inline FastFloat operator-=(const FastFloat op2);
    inline FastFloat operator*=(const FastFloat op2);
    bool operator==(const FastFloat op2);
    bool operator<(const FastFloat op2);
    bool operator<=(const FastFloat op2);
    bool operator>(const FastFloat op2);
    bool operator>=(const FastFloat op2);
    
    FastFloat abs();
    FastFloat ldexp(const int8_t power);
    FastFloat pow(const uint8_t power);
    FastFloat sqrt();
    FastFloat log();
    
    FastFloat sin();
    FastFloat cos();
    FastFloat arcsin();
    FastFloat arccos();
    
private:
    uint8_t exp;
    uint8_t lsb;
    int16_t msb;
    
    void toFastFloat(float value);
    void toFastFloat(int32_t value);
    void toFastFloat(int16_t value);
    void toFastFloat(int8_t value);
    
    float tofloat();
    int32_t toint32_t();
    int16_t toint16_t();
    int8_t toint8_t();
    
    static FastFloat sqrtval[2];
};
    
    FastFloat operator-(const FastFloat op1, FastFloat op2) {
        op2.msb -= 0x8000;
        return op1+op2;
    }
    
    FastFloat::FastFloat(const float value) {
        toFastFloat(value);
    }
    
    FastFloat::FastFloat(const int32_t value) {
        toFastFloat(value);
    }
    
    FastFloat::FastFloat(const int16_t value) {
        toFastFloat(value);
    }
    
    FastFloat::FastFloat(const int8_t value) {
        toFastFloat(value);
    }
    
    FastFloat::FastFloat(const uint8_t nexp, const uint8_t nlsb, const int16_t nmsb) {
        exp = nexp;
        lsb = nlsb;
        msb = nmsb;
    }
    
    FastFloat::operator float() {
        return tofloat();
    }
    
    FastFloat::operator int32_t() {
        return toint32_t();
    }
    
    FastFloat::operator int16_t() {
        return toint16_t();
    }
    
    FastFloat::operator int8_t() {
        return toint8_t();
    }
    
    FastFloat& FastFloat::operator=(const FastFloat value) {
        exp = value.exp;
        lsb = value.lsb;
        msb = value.msb;
        return *this;
    }
    
    FastFloat& FastFloat::operator=(const float value) {
        toFastFloat(value);
        return *this;
    }
    
    FastFloat& FastFloat::operator=(const int32_t value) {
        toFastFloat(value);
        return *this;
    }
    
    FastFloat& FastFloat::operator=(const int16_t value) {
        toFastFloat(value);
        return *this;
    }
    
    FastFloat& FastFloat::operator=(const int8_t value) {
        toFastFloat(value);
        return *this;
    }
    
    int32_t FastFloat::get() {
        return *(int32_t*)this;
    }
    
    FastFloat FastFloat::operator+=(const FastFloat op2) {
        *this = *this + op2;
        return *this;
    }
    
    FastFloat FastFloat::operator-=(const FastFloat op2) {
        *this = *this - op2;
        return *this;
    }
    
    FastFloat FastFloat::operator*=(const FastFloat op2) {
        *this = *this * op2;
        return *this;
    }
    
}  // namespace fast_float_32_avr

#endif
