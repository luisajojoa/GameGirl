
#ifndef INIT_H
#define INIT_H

#include <generated/csr.h>
#include <stdio.h>

void lcd_write(unsigned char rs, unsigned int data);
void lcd_initialize(void);
void busy_wait(unsigned int ds);
void SD_configure(void);
void SD_write_8(unsigned int value);
unsigned int SD_read(unsigned char dato,unsigned char addr);
void sd_init (void);

#endif

