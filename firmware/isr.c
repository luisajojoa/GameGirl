#include <generated/csr.h>
#include <irq.h>
#include <uart.h>
#include <stdio.h>
extern void periodic_isr(void);

void buttonTest(void);
void isr(void);

void isr(void)
{
	unsigned int irqs;

	irqs = irq_pending() & irq_getmask();
	
	if(irqs & (1 << UART_INTERRUPT))
		uart_isr();
	if(irqs & (1 << 3))
		buttonTest();

	
}
void buttonTest()
{

	unsigned int pend = buttons_ev_pending_read();
	printf("%X\n", pend);
/*	switch(buttonsPending){
		case 1:
			leds_out_write(0x01);
			break;
		case 2:
			leds_out_write(0x02);
			break;
		case 4:
			leds_out_write(0x04);
			break;
		case 8:
			leds_out_write(0x08);
			break;	
		default:
			leds_out_write(0xff);
			break;
	}*/

		if (pend & 0x01) {
			printf("a\n");

			leds_out_write(0x01);
		}
		//00000010
		if (pend & 0x02) {
			printf("b\n");
			buttons_ev_pending_write(0x02);
			leds_out_write(0x02);
			buttons_ev_enable_write(0xff);
		}
		//00000100
		if (pend & 0x04) {
			printf("c\n");
			leds_out_write(0x04);
		}
		//00001000
		if (pend & 0x08) {
			printf("d\n");
			leds_out_write(0x08);
		}else{
			printf("%X",pend);
			printf("hola");
		}
	buttons_ev_pending_write(0xff);	
	buttons_ev_enable_write(0xff);


}

