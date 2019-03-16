
#include "init.h"

unsigned OFFLINE      = (1 << 0);
unsigned CS_POLARITY  = (1 << 3);
unsigned CLK_POLARITY = (1 << 4);
unsigned CLK_PHASE    = (1 << 5);
unsigned LSB_FIRST    = (1 << 6);
unsigned HALF_DUPLEX  = (1 << 7);
unsigned DIV_READ     = (1 << 16);
unsigned DIV_WRITE    = (1 << 24);

// xfer mapping
unsigned WRITE_LENGTH = (1 << 16);
unsigned READ_LENGTH  = (1 << 24);

 void lcd_write(unsigned char rs, unsigned int data)
{
	rs_out_write(rs);
	lcd_mosi_data_write(data<<16);
	lcd_start_write(1);
	while(lcd_active_read()){}

}

void busy_wait(unsigned int ds)
{
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(SYSTEM_CLOCK_FREQUENCY/10*ds);
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}


void lcd_initialize(void){

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

// Horizontal address position

	//END
	lcd_write(0,0x0036); 
	lcd_write(1,0x0084);
	
	//START
	lcd_write(0,0x0037); 
	lcd_write(1,0x002C);
//Vertical address position
	//END
	lcd_write(0,0x0038); 
	lcd_write(1,0x00A5);
	//START
	lcd_write(0,0x0039);
	lcd_write(1,0x0037);

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





//SDDDD

//sd card
void SD_configure(void) {
	int sdFreq= 400e3;
	int div_write= system_clock_frequency_read()/sdFreq - 2;
	SD_config_write((div_write<<24) + (div_write << 16));
    //Divisior para
    //reloj de 5MHz(16)
	//100M/400k = div_write + 2...248
	SD_xfer_write(1 | 8*WRITE_LENGTH);
}

void SD_write_8(unsigned  int value){
	SD_mosi_data_write(value << 24) ;
	SD_start_write(1);
	while (SD_pending_read() & 0x1);
}

unsigned int SD_read(unsigned char dato,unsigned char addr){
	unsigned int val = ((dato << 16) | ((addr & 0xff) << 8));
	SD_xfer_write(1 | 0*WRITE_LENGTH | 8*READ_LENGTH);//antes 8 de lectura
	SD_mosi_data_write(val << (32-24));
	SD_start_write(1);
	while (SD_pending_read() & 0x1);
	return (SD_miso_data_read());// & 0xff
}


void sd_init (void){
	printf("Inicializando SD...\n");
	SD_configure();
	GPO_out_write(1);
	unsigned int i=11;
	while(i>0){
		SD_write_8(255);
		i--;
	}

	GPO_out_write(0);
	SD_write_8(255);
	SD_write_8(255);

do{
	//SD en estado IDLE(CMD0)
	//HEX: 40 00 00 00 00   95
	//     sb/cmd/argument/CRC7|1
	//DEC: 64 00 00 00 00   149
		SD_write_8(64);
		SD_write_8(00);
		SD_write_8(00);
		SD_write_8(00);
		SD_write_8(00);
		SD_write_8(0x95);
		SD_write_8(0xFF);
		SD_write_8(0xFF);
		SD_write_8(0xFF);
		printf("Final CMD0 :%x \n",SD_miso_data_read());

} while (SD_miso_data_read()==0xFFFF);
	GPO_out_write(1);//AGREGADO
	SD_write_8(0xFF);
	GPO_out_write(0);//AGREGADO
	SD_write_8(0xFF);
	printf("FINAL  :%x\n",SD_miso_data_read() );


	//Envía (CMD58)
	// HEX: 7A 00 00 00 00 FF
	// DEC: 122 00 00 00 00 255
	SD_write_8(122);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(255);
	SD_write_8(255);//Espera


	SD_write_8(255);//Espera
	SD_write_8(255);//Espera
  printf("CMD58: IDLE %x\n",SD_miso_data_read() );
	SD_write_8(255);//Espera
	SD_write_8(255);//Espera
	SD_write_8(255);//Espera
	SD_write_8(255);//Espera



	//Envía condiciones de operación(CMD8)
	// HEX: 48 00 00 00 00 FF
	// DEC: 72 00 00 00 00 255
	//Dicen que el CRC7 es 0x87 en lugar de FF
	// arg: 0x00 00 01 AA ?
	GPO_out_write(0);//AGREGADO
	printf("Coincide? :%x\n",SD_miso_data_read() );
	SD_write_8(72);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(1);
	SD_write_8(170);
	SD_write_8(0x87);//0x87
	SD_write_8(255);
	printf("Espera respuesta1: %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Espera respuesta2: %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Espera respuesta3: %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Espera respuesta4: %x\n",SD_miso_data_read() );

	SD_write_8(255);
	SD_write_8(255);
	printf("CMD8: voltage %x\n",SD_miso_data_read () << 24);
	printf("CMD8: voltage %x\n",SD_miso_data_read ()<< 24);


GPO_out_write(1);//AGREGADO
SD_write_8(255);

unsigned int res=0;
GPO_out_write(0);//AGREGADO
// uint8_t tmp =20;
// 	while (tmp ) {
// 		tmp--;
// 		busy_wait(10);
while (res != 0x80000000) {
	//Envía condiciones de operación(ACMD41)
	// HEX: 77 00 00 00 00 01(cmd55)
	// DEC: 119 00 00 00 00 1
	// posible CRC7: 65


	SD_write_8(119);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(00);
	SD_write_8(1);
	SD_write_8(255);//Espera
	SD_write_8(255);//Espera
	SD_write_8(255);//Espera

	//HEX: 69 40 00 00 00 FF(acmd41)
	// DEC: 105 00 00 00 00 1
	//posible CRC7: E5 si el argumento es 0 ó 77 si el argumento es
	// arg:0x 40 00 00 00
	SD_write_8(255);//Espera
	SD_write_8(105);
	SD_write_8(0x40);
	SD_write_8(0);
	SD_write_8(0);
	SD_write_8(0);
	SD_write_8(0x77);
	SD_write_8(255);
	SD_write_8(255);
	SD_write_8(255);
	res = SD_miso_data_read();
	printf("ACMD ULTIMO:%x\n", res);

}
GPO_out_write(1);//AGREGADO


//La respuesta debe ser 00, si es 1 se debe reenviar
//la orde y si es 5 se puede usar cmd1 en lugar de acmd41



//LEER
//HEX: 51 00 00 00 08 FF (CMD17)
//DEC: 81 00 00 00 08 255
//while(SD_miso_data_read()!=80000001){
	GPO_out_write(0);//AGREGADO
	SD_write_8(81);
	SD_write_8(0);
	SD_write_8(0);
	SD_write_8(40);
	SD_write_8(01);
	SD_write_8(255);
	printf("Lectura 1. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 2. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 3. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 4. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 5. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 6. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 7. %x\n",SD_miso_data_read() );
	SD_write_8(255);
	printf("Lectura 8. %x\n",SD_miso_data_read() );
//}

GPO_out_write(1);//AGREGADO
printf("Inicialización terminada.\n" );
}


