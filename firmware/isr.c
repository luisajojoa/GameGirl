#include <generated/csr.h>
#include <irq.h>
#include <uart.h>

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
void buttonTest(void)
{
	button_ev_pending_write(1);
	leds_out_write(!leds_out_read());
	button_ev_enable_write(1);
}

