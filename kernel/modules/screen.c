//
// Created by tanto on 9/25/2018.
//

#include "screen.h"
#include "ports.h"
#include <stdint.h>

///////////////////////
//// PRIVATE

int get_cursor_offset() {
    /* Use the VGA ports to get the current cursor position
     * 1. Ask for high byte of the cursor offset (data 14)
     * 2. Ask for low byte (data 15)
     */
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8; /* High byte: << 8 */
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset * 2; /* Position * size of character cell */
}

void set_cursor_offset(int offset) {
    /* Similar to get_cursor_offset, but instead of reading we write data */
    offset /= 2;
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (uint8_t)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, (uint8_t)(offset & 0xff));
}

void put_char(char chr){
    int offset = get_cursor_offset();
    uint8_t *vidmem = (uint8_t*) VIDEO_ADDRESS;
    vidmem[offset] = chr;
    vidmem[offset+1] = WHITE_ON_BLACK;
    set_cursor_offset(offset+2);
}

void line_down(){
    set_cursor_offset((get_cursor_offset()/(2*MAX_COLS)+1)*(2*MAX_COLS));
}

///////////////////////
//// PUBLIC

void clear_screen() {
    int screen_size = MAX_COLS * MAX_ROWS;
    uint8_t *screen = (uint8_t*) VIDEO_ADDRESS;

    for (int i = 0; i < screen_size; i++) {
        screen[i*2] = ' ';
        screen[i*2+1] = WHITE_ON_BLACK;
    }
    set_cursor_offset(0);
}

void print(char *msg){
    int i = 0;
    while(msg[i] != 0) {
        put_char(msg[i++]);
    }
    line_down();
}