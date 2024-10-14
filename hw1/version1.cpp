#include <stdio.h>
#include <stdint.h>
#include <iostream>

int numberOfSteps(uint32_t num) {
    uint32_t count=0;
    while(num!=0){
        if(num%2==0){//number is even
            num/=2;
        }
        else{//number is odd
            num-=1;
        }
        count++;
    }
    return count;
}

int main(){

    uint32_t number = 10000;
    uint32_t result = numberOfSteps(number);
    std::cout << "The steps to Reduce a Number to Zero of " << number << " is " << result << std::endl;

    return 0;
}