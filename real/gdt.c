//
// Created by tanto on 9/10/2018.
//

#include "gdt.h"
struct gdt_entry gdt_entries[5];
struct gdt_ptr gdt_ptr_pointer;
#define LIMIT_MAX 0xffffffff

void gdt_set(signed int index, unsigned int base, unsigned int limit, unsigned char access, unsigned char gran){
    gdt_entries[index].base_low = base & 0xffff;
    gdt_entries[index].base_mid = base >> 16 & 0xff;
    gdt_entries[index].base_high = base >> 24 & 0xff;
    gdt_entries[index].limit_low = limit & 0xffff;
    gdt_entries[index].granularity = (limit >> 16 & 0x0f) | (gran & 0xf0);
    gdt_entries[index].access = access;
}

void init_gdt(){
    gdt_ptr_pointer.limit = (sizeof(gdt_entries[0])*5)-1;
    gdt_ptr_pointer.base = (unsigned int)gdt_entries;

    gdt_set(0, 0, 0, 0, 0);
    gdt_set(1, 0, LIMIT_MAX, 0x9a, 0xc0);
    gdt_set(2, 0, LIMIT_MAX, 0x92, 0xc0);
    gdt_set(3, 0, LIMIT_MAX, 0xfa, 0xc0);
    gdt_set(4, 0, LIMIT_MAX, 0xf2, 0xc0);

    __asm__ __volatile__ (
            "lgdt (%eax) \n\t"
            "mov %cr0, %eax \n\t"
            "or $0x1, %eax \n\t"
            "mov %eax, %cr0"
            );
}