//
// Created by tanto on 9/23/2018.
//

#include "kernel.h"
#include "modules/screen.h"

void kernel_main(void);
void kernel_main(void){
    clear_screen();
    print("Successfully jumped to kernel");
    print("Welcome to TantOS");
    print("Initializing kernel");
    while (1);
}