//
// Created by tanto on 9/10/2018.
//

#ifndef OS2_GDT_H
#define OS2_GDT_H

typedef struct gdt_entry {
    unsigned short limit_low;
    unsigned short base_low;
    unsigned char base_mid;
    unsigned char access;
    unsigned char granularity;
    unsigned char base_high;
}__attribute__((packed)) gdt_entry;

typedef struct gdt_ptr {
    unsigned short limit;
    unsigned int base;
}__attribute__((packed)) gdt_ptr;

void init_gdt(void);
void gdt_set(signed int index, unsigned int base, unsigned int limit, unsigned char access, unsigned char gran);
#endif //OS2_GDT_H
