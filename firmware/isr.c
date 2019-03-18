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
	switch(pend){
		case 16:
			dir_global=1;
			break;
		case 2:
			if (dir_global!=16){ dir_global=2;}
			break;
		case 4:
			if (dir_global!=8) {dir_global=4;}
			break;
		case 8:
			if (dir_global!=4) {dir_global=8;}
			break;
		case 1:
			if (dir_global!=2){ dir_global=16;}
			break;	
		default:			
			break;
	}


	buttons_ev_pending_write(0xff);	
	buttons_ev_enable_write(0xff);

}



