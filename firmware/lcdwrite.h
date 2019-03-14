
#ifndef LCDWRITE_H
#define LCDWRITE_H

#include <generated/csr.h>

void lcd_write(unsigned char rs, unsigned int data);
void lcd_initialize(void);
void busy_wait(unsigned int ds);

#endif

