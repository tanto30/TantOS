// GDT - Stores the segments of protected mode


#include "screen.h"

void main(){
    clear_screen();
    kprint("SUCCESS");
    kprint("Welcome to TantOS");
    kprint("Setting GDT");

    //init_gdt();
    while(1);
}