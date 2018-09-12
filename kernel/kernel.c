// GDT - Stores the segments of protected mode

#include "printing.h"
#include "gdt.h"

void main(){
    int i = 0;
    print("SUCCESS");
    print("Welcome to TantOS");
    print("Setting GDT");

    init_gdt();
    while(1);
}