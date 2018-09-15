//
// Created by tanto on 9/10/2018.
//

#include "printing.h"

void print_nl(void){
    __asm__ __volatile__ ("mov $0xe0a, %ax \n\t int $0x10 \n\t mov $0xe0d, %ax \n\t int $0x10");
}

void print(const char *s){
    while(*s){
        __asm__ __volatile__("int  $0x10" : : "a"(0x0E00 | *s), "b"(7));
        s++;
    }
    print_nl();
}