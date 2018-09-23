//
// Created by tanto on 9/23/2018.
//

#ifndef OS2_PORTS_H
#define OS2_PORTS_H

#include <stdint.h>

uint8_t port_byte_in (uint16_t port);
void port_byte_out (uint16_t port, uint8_t data);
uint16_t port_word_in (uint16_t port);
void port_word_out (uint16_t port, uint16_t data);

#endif //OS2_PORTS_H
