
#ifndef INIT_H
#define INIT_H

#include <generated/csr.h>
#include <stdio.h>


int bod[121];
int cora[121];
int food[121];
int snakeHeadUp[121];
int snakeHeadDown[121];
int snakeHeadRight[121];
int snakeHeadLeft[121];
int gTitle[40][40];
int num1Uno[121];
int num1Dos[121];
int num2Uno[121];
int num2Dos[121];
int num3Dos[121];
int num5Uno[121];
int num4Dos[121];
int num6Dos[121];
int num7Uno[121];
int num8Uno[121];
int num0Uno[121];
int num0Dos[121];
int num4Uno[121];
void lcd_write(unsigned char rs, unsigned int data);
void busy_wait(unsigned int ds);
void lcd_initialize(void);
void screen(int yMin, int yMax, int xMin, int xMax, int a);



#endif

