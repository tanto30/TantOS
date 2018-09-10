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
}__attribute__((packed));

typedef struct gdt_ptr {
    unsigned short limit;
    unsigned int base;
};

void init_gdt();

#endif //OS2_GDT_H
