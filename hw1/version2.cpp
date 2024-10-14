#include <stdio.h>
#include <stdint.h>
#include <iostream>

int numberOfSteps(uint32_t num) {
    if(num==0) return 0; //if number is 0, count won't be 0. prevent this condition
    uint32_t count = 0;
    while (num!=0) {
        count += (num & 0x1) + 1;
        num >>= 1;
    }
    return count - 1;
}
int main(){

    uint32_t number = 10000;
    uint32_t result = numberOfSteps(number);
    std::cout << "The steps to Reduce a Number to Zero of " << number << " is " << result << std::endl;

    return 0;
}