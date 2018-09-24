//
// Created by tanto on 9/25/2018.
//

#ifndef OS2_SCREEN_H
#define OS2_SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define RED_ON_WHITE 0xf4

/* Screen i/o ports */
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

void clear_screen();
void print(char *message);
void print_backspace();

#endif //OS2_SCREEN_H
