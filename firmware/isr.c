#include <generated/csr.h>
#include <irq.h>

#include <uart.h>
#include <stdio.h>
#include "variables.h"

extern void periodic_isr(void);

void buttonTest(void);

void isr(void);

void isr(void)
{
	unsigned int irqs;

	irqs = irq_pending() & irq_getmask();
	
	if(irqs & (1 << UART_INTERRUPT))
		uart_isr();
	if(irqs & (1 << 4))
		buttonTest();
}

void buttonTest(void)
{

	unsigned int pend = buttons_ev_pending_read();
	printf("boton click %d \n",pend);
	switch(pend){
		case 16:
			dir_global=1;
			leds_out_write(dir_global);
			break;
		case 2:
			if (dir_global!=16){ dir_global=2;}
			leds_out_write(dir_global);
			break;
		case 4:
			if (dir_global!=8) {dir_global=4;}
			leds_out_write(dir_global);
			break;
		case 8:
			if (dir_global!=4) {dir_global=8;}
			leds_out_write(dir_global);
			break;
		case 1:
			if (dir_global!=2){ dir_global=16;}
			leds_out_write(dir_global-1);
			break;	
		default:
			leds_out_write(0xff);
			break;
	}


	buttons_ev_pending_write(0xff);	
	buttons_ev_enable_write(0xff);

}



