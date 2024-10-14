#include <stdio.h>
#include <stdint.h>
#include <iostream>

int length(uint32_t num) {
    uint32_t clz = 0;
    if ((num >> 16) == 0) {
        clz += 16;
        num <<= 16;
    }
    if ((num >> 24) == 0) {
        clz += 8;
        num <<= 8;
    }
    if ((num >> 28) == 0) {
        clz += 4;
        num <<= 4;
    }
    if ((num >> 30) == 0) {
        clz += 2;
        num <<= 2;
    }
    if ((num >> 31) == 0) {
        clz += 1;
    }
    return 32 - clz;
}

int count(uint32_t num) {
    num = (num & 0x55555555) + ((num >> 1) & 0x55555555);
    num = (num & 0x33333333) + ((num >> 2) & 0x33333333);
    num = (num & 0x0F0F0F0F) + ((num >> 4) & 0x0F0F0F0F);
    num = (num & 0x00FF00FF) + ((num >> 8) & 0x00FF00FF);
    num = (num & 0x0000FFFF) + ((num >> 16) & 0x0000FFFF);
    return num;
}

int numberOfSteps(uint32_t num) {
    if(num==0) return 0; //if number is 0, count won't be 0. prevent this condition
    return length(num) - 1 + count(num);
}

int main(){

    uint32_t number = 10000;
    uint32_t result = numberOfSteps(number);
    std::cout << "The steps to Reduce a Number to Zero of " << number << " is " << result << std::endl;

    return 0;
}