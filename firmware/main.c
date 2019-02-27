#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>

static void busy_wait(unsigned int ds)
{
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(SYSTEM_CLOCK_FREQUENCY/10*ds);
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}


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
	puts("led                             - led test");
	puts("sw                             - switch test");
	puts("lcd                             - test lcd");
	puts("lcd-buttons                             - test lcd with buttons");
}

static void reboot(void)
{
	asm("call r0");
}


static void led_test(void)
{
	int i;
	printf("led_test...\n");
	for(i=0; i<32; i++) {
		leds_out_write(i);
		busy_wait(1);
	}
}

static void switch_test(void)
{
	int i=1;
	while(i){
		printf("switch_test...\n");
		leds_out_write(switches_in_read());
	}
}


static void lcd_configure(void)
{
	//configure
	int div_read= 17;
	int div_write= 17;
	lcd_config_write(0x11110000); ; //div_write div_read 00 b 0x11110000
	lcd_xfer_write(0x100001); // write_length*24 | 0b1    0x100001

}


static void lcd_write(unsigned char rs, unsigned int data)
{
	rs_out_write(rs);
	lcd_mosi_data_write(data<<16);
	lcd_start_write(1);
	while(lcd_active_read()){}

//	rs_out_write(rs);
//	uint32_t val1 = (data << 16); printf("Shift value1 is %d \n", val1);
//	lcd_mosi_data_write(val1<<); // POR DEFINIR PORQUE NECESITA ARGUMENTO
//	lcd_start_write(1);
//	while(lcd_active_read()){};

	
//	printf("entré \n");
//	printf("pending %d \n", lcd_pending_read());


}







static void lcd_initialize(void){
	// INICIALIZANDO
	lcd_write(0,0x0010); //Start Byte Direccion
	lcd_write(1,0x0000);//Direccion
	lcd_write(0,0x0011); //Start Byte Direccion
	lcd_write(1,0x0000);//Direccion


	//Power Control 3
	lcd_write(0,0x0012);
	lcd_write(1,0x0000);

	//Power Control 4
	lcd_write(0,0x0013);
	lcd_write(1,0x0000);


	//Power Control 5
	lcd_write(0,0x0014);
	lcd_write(1,0x0000);
	busy_wait(0.4);
	
	//Power-on
	//Power Control 2
	lcd_write(0,0x0011);
	lcd_write(1,0x0018);

	//Power Control 3
	lcd_write(0,0x0012);
	lcd_write(1,0x6121);

	//Power Control 4
	lcd_write(0,0x0013);
	lcd_write(1,0x006F);
	//Power Control 5
	lcd_write(0,0x0014);
	lcd_write(1,0x495F);

	//Power Control 1 
	lcd_write(0,0x0010);
	lcd_write(1,0x0800);


	busy_wait(0.1);

	//Power Control 2
	lcd_write(0,0x0011);
	lcd_write(1,0x103B);


	busy_wait(0.5);

	//Driver Output control
	lcd_write(0,0x0001);
	lcd_write(1,0x011C);


	//LCD AC Driving control
	lcd_write(0,0x0002);
	lcd_write(1,0x0100);


	//Entry Mode
	lcd_write(0,0x0003);
	lcd_write(1,0x1038);


	//Disp control
	lcd_write(0,0x0007);
	lcd_write(1,0x0000);


	//Blank Period Control1
	lcd_write(0,0x0008);
	lcd_write(1,0x0808);

	//Frame Cycle Control
	lcd_write(0,0x000B);
	lcd_write(1,0x1100);


	//Interface control
	lcd_write(0,0x000C);
	lcd_write(1,0x0000);


	//Osc Control
	lcd_write(0,0x000F);
	lcd_write(1,0x0D01);


	//VCI Recycling
	lcd_write(0,0x0015);
	lcd_write(1,0x0020);


	//Ram Addr 1
	lcd_write(0,0x0020);
	lcd_write(1,0x0000);


	//Ram Addr 2
	lcd_write(0,0x0021);
	lcd_write(1,0x0000);



///sET GRAM AREA
	lcd_write(0,0x0030);
	lcd_write(1,0x0000);


	lcd_write(0,0x0031); //Start Byte Direccion
	lcd_write(1,0x00DB);//Start Byte Power Control 1


	lcd_write(0,0x0032); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

	lcd_write(0,0x0033); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1


	lcd_write(0,0x0034); //Start Byte Direccion
	lcd_write(1,0x00DB);//Start Byte Power Control 1


	lcd_write(0,0x0035); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

	lcd_write(0,0x0036); //Start Byte Direccion
	lcd_write(1,0x00AF);//Start Byte Power Control 1


	lcd_write(0,0x0037); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 

	lcd_write(0,0x0038); //Start Byte Direccion
	lcd_write(1,0x00DB);//Start Byte Power Control 1

	lcd_write(0,0x0039); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

//// SET GAMMA CURVE

	lcd_write(0,0x0050); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

	lcd_write(0,0x0051); //Start Byte Direccion
	lcd_write(1,0x0808);//Start Byte Power Control 1

	lcd_write(0,0x0052); //Start Byte Direccion
	lcd_write(1,0x080A);//Start Byte Power Control 1

	lcd_write(0,0x0053); //Start Byte Direccion
	lcd_write(1,0x000A);//Start Byte Power Control 1

	lcd_write(0,0x0054); //Start Byte Direccion
	lcd_write(1,0x0A08);//Start Byte Power Control 1

	lcd_write(0,0x0055); //Start Byte Direccion
	lcd_write(1,0x0808);//Start Byte Power Control 1


	lcd_write(0,0x0056); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

	lcd_write(0,0x0057); //Start Byte Direccion
	lcd_write(1,0x0A00);//Start Byte Power Control 1

	lcd_write(0,0x0058); //Start Byte Direccion
	lcd_write(1,0x0710);//Start Byte Power Control 1

	lcd_write(0,0x0059); //Start Byte Direccion
	lcd_write(1,0x0710);//Start Byte Power Control 1



///DISP_CTRL1
	lcd_write(0,0x0007); //Start Byte Direccion
	lcd_write(1,0x0012);//Start Byte Power Control 1
	
	busy_wait(0.5);

	lcd_write(0,0x0007); //Start Byte Direccion
	lcd_write(1,0x1017);//Start Byte Power Control 1

///ENTRY MODE

	lcd_write(0,0x0003); //Start Byte Direccion
	lcd_write(1,0x1038);//Start Byte Power Control 1

/// HORIZONTAL_WINDOW_ADDR1
	lcd_write(0,0x0036); //Start Byte Direccion
	lcd_write(1,0x00AF);//Start Byte Power Control 1

/// HORIZONTAL_WINDOW_ADDR2
	lcd_write(0,0x0037); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1
/// VERTICAL_WINDOW_ADDR1
	lcd_write(0,0x0038); //Start Byte Direccion
	lcd_write(1,0x00DB);//Start Byte Power Control 1
/// VERTICAL_WINDOW_ADDR1
	lcd_write(0,0x0039); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1
/// RAM_ADDR_SET1
	lcd_write(0,0x0020); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1
/// RAM_ADDR_SET2
	lcd_write(0,0x0021); //Start Byte Direccion
	lcd_write(1,0x0000);//Start Byte Power Control 1

//WRITE DATA TO GRAM
	/// HORIZONTAL_WINDOW_ADDR1
	lcd_write(0,0x0022); //Start Byte Direccion



}

static void lcd_test(void)
{
	int i=0;
	lcd_configure();
	lcd_initialize();

	while(i<9680){
	lcd_write(1,"0x08ff");
	i++;
	}
	i=0;
	while(i<9680){
	lcd_write(1,0x001f);
	i++;
	}
	i=0;
	while(i<19360){
	lcd_write(1,0xffe0);
	i++;
	}
}


static void lcdbuttons_test(void)
{
	int xmax=220;
	int ymax=176;
	while(1){

	switch(buttons_in_read()){
		case 1:
			lcd_write(1,0xffe0);
			break;
		case 2:
			lcd_write(1,0x001f);
			break;
		case 4:
			lcd_write(1,0xffff);
			break;
		case 8:
			lcd_write(1,0x0000);
			break;
		case 16:
			lcd_write(1,0xaaaa);
			break;
	}}
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
	else if(strcmp(token, "led") == 0)
		led_test();
	else if(strcmp(token, "sw") == 0)
		switch_test();
	else if(strcmp(token, "lcd") == 0)
		lcd_test();
	else if(strcmp(token, "lcd-buttons") == 0)
		lcdbuttons_test();
	prompt();
}

int main(void)
{
	irq_setmask(0);
	irq_setie(1);
	uart_init();
	

	puts("\nLab004 - CPU testing software built "__DATE__" "__TIME__"\n");
	help();
	prompt();

	while(1) {
		console_service();
	}

	return 0;
}
