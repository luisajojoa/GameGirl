#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "lcdwrite.h"



static char *readstr(void)
{
	char c[2];
	static char s[64];
	static int ptr = 0;

	if(readchar_nonblock()) {
		c[0] = readchar();
		c[1] = 0;
		switch(c[0]) {
			case 0x7f:
			case 0x08:
				if(ptr > 0) {
					ptr--;
					putsnonl("\x08 \x08");
				}
				break;
			case 0x07:
				break;
			case '\r':
			case '\n':
				s[ptr] = 0x00;
				putsnonl("\n");
				ptr = 0;
				return s;
			default:
				if(ptr >= (sizeof(s) - 1))
					break;
				putsnonl(c);
				s[ptr] = c[0];
				ptr++;
				break;
		}
	}

	return NULL;
}

static char *get_token(char **str)
{
	char *c, *d;

	c = (char *)strchr(*str, ' ');
	if(c == NULL) {
		d = *str;
		*str = *str+strlen(*str);
		return d;
	}
	*c = 0;
	d = *str;
	*str = c+1;
	return d;
}

static void prompt(void)
{
	printf("RUNTIME>");
}

static void help(void)
{
	puts("Available commands:");
	puts("help                            - this command");
	puts("reboot                          - reboot CPU");
//	puts("led                             - led test");
	puts("buttons                             - switch test");
	puts("lcd                             - test lcd XD");
	puts("test                             - test lcd with buttons");
	puts("win                             - test lcd window");
}

static void reboot(void)
{
	asm("call r0");
}




static void lcd_configure(void)
{
	printf("configurando \n");
	//configure
	int spi_clk= 1.25e6;
	int div_write= system_clock_frequency_read()/spi_clk;
	lcd_config_write((div_write<<24) + (div_write << 16)); ; //div_write div_read 00 b 0x11110000
	lcd_xfer_write(0x100001); // write_length*24 | 0b1    0x100001


}


static void buttons (void)
{
	buttons_ev_enable_write(0xff);
	buttons_ev_pending_write(0xff);
	irq_setmask(irq_getmask() | (1<< 3));
	printf("get maska %d \n",irq_getmask());
	printf("get maski %d \n",irq_pending());
	printf("get maske %d \n",(irq_getmask() | (1 << 3)));


}


static void lcd_test(void)
{
	int i=0;
	lcd_configure();
	lcd_initialize();
	while(i<38720){
	lcd_write(1,0x0000);
	i++;
	}
	printf("terminó de escribir lcd \n");
}


static void screen(void)
{

/*
Utilizando los registros 0h0020 y 0h0021 se ajusta la dirección de la RAM donde se desea escribir.

lcd_write(0,0x0020);  Se escribe la dirección de Y [ de 0-175 pixeles (0-00haf)]
lcd_write(0,0x0021);   Se escribe la dirección de X [ de 0-219 pixeles (0-00hdb)]

*/
	lcd_configure();
	lcd_initialize();
	int yMin= 58;
	int yMax= 117;
	int xMin= 73;
	int xMax= 147;
	for(int i=yMin; i< yMax; i++)
	{
		lcd_write(0,0x0020);
		lcd_write(1, i)	;
		for (int j = xMin; j < xMax; j++)
		{
			lcd_write(0,0x0021);
			lcd_write(1,j);
			lcd_write(0,0x0022);
			lcd_write(1,0xf000);
		}
	}
}



static void console_service(void)
{
	char *str;
	char *token;

	str = readstr();
	if(str == NULL) return;
	token = get_token(&str);
	if(strcmp(token, "help") == 0)
		help();
	else if(strcmp(token, "reboot") == 0)
		reboot();
	/*else if(strcmp(token, "led") == 0)
		led_test();
	else if(strcmp(token, "sw") == 0)
		switch_test();
*/
	else if(strcmp(token, "lcd") == 0){
		lcd_test();
	}
	else if(strcmp(token, "test") == 0)
		screen();
	else if(strcmp(token, "buttons") == 0)
		buttons();
	prompt();
}

int main(void)
{
	irq_setmask(0);
	irq_setie(1);
	buttons();	
	uart_init();
	

	printf("get maska %X \n",irq_getmask());
	printf("get maski %X \n",irq_pending());
	printf("get maske %x \n",(irq_getmask() | (1 << 3)));

	puts("\nLab004 - CPU testing software built "__DATE__" "__TIME__"\n");
	help();
	prompt();

	while(1) {
		console_service();
	}

	return 0;
}
