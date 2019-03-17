#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "init.h"
#include "variables.h"


#define LTH 11
#define LX 220
#define LY 176
#define LARGO 20

int snake[LARGO][3];
int dir=0;
int comida[3];
int points =0;
int lvl =0;




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
//	puts("play                             - start game");
	puts("lcd                             - test lcd XD");
	puts("test                             - test buttons");
	puts("a                             - test lcd window");
}

static void reboot(void)
{
	asm("call r0");
}




static void lcd_configure(void)
{
	printf("configurando \n");
	//configure
	int spi_clk= 6.25e6;
	int div_write= system_clock_frequency_read()/spi_clk -2;
	lcd_config_write((div_write<<24) + (div_write << 16)); ; //div_write div_read 00 b 0x11110000
	lcd_xfer_write(0x100001); // write_length*24 | 0b1    0x100001


}


static void buttons (void)
{
	buttons_ev_enable_write(0xff);
	buttons_ev_pending_write(0xff);
	irq_setmask(irq_getmask() | (1<< 4));



}


static void lcd_test(void)
{
	int i=0;

	lcd_initialize();
	while(i<38720){
	lcd_write(1,0x08ff);
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
	//lcd_configure();
	//lcd_initialize();
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



/////////////////////////////////
///////////// JUEGOO
/////////////////////////////////


/// Decodificador que tiene como salida un color en RGB
/// dependiendo de su entrada.

static void decoColor(int color) //Funcionando
{
	switch (color)
	{
		case (0):
		lcd_write(1,0x0000);
		break;

		case (1):
		lcd_write(1,0xFFFF);
		break;

		case (2):
		lcd_write(1,0xEC1D);
		break;

		case (3):
		lcd_write(1,0xF81F);
		break;

		case (4):
		lcd_write(1,0xFFDF);
		break;

		case (8): //Fondo
		lcd_write(1,0x08FF);
		break;

		case (9):
		lcd_write(1,0xFB08);
		break;

		default:
		lcd_write(1,0xA285);
	}
}


/// Función que muestra el indicador del color en un pixel específico 
/// de un tile deseado.

static int decoTile (int tile, int pos)
{
	int data[LTH*(LTH)];
	switch (tile)
	{
		case(0):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=0;
			}
			break;
		}
		case(1):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=1;
			}
			break;
		}
		case(2):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=2;
			}
			break;
		}
		case(3):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=3;
			}
			break;
		}
		case(4):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=4;
			}
			break;
		}
		case(8): //Fondo
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=8;
			}
			break;
		}
		default:
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=9;
			}
			break;
		}
	}
		return data[pos];
}


/// Pinta un tile seleccionado en la posición de la pantalla que
/// se indica en el parámetro de entrada.
static void pintar(int info[3])
{
	int tile = info[0];
	int tilex= info[1];
	int tiley= info[2];
	int pix[LTH*(LTH)];
	for(int x=0;x<LTH*LTH;x++)
	{
		pix[x]=decoTile(tile,x);
	}

	int z=0;
	for(int i=0;i<LTH;i++)
	{
		lcd_write(0,0x0020);
		lcd_write(1,(tiley*LTH) +i);
		for(int j=0;j<LTH;j++)
		{
			lcd_write(0,0x0021);
			lcd_write(1,(tilex*(LTH) +j));
			lcd_write(0,0x0022);
			decoColor(pix[z]);
			z++;
		}
	}
}


/// Crea las condiciones iniciales del juego.
static void inicio()
{
	points=0;
	lvl=0;
	dir=0;
	//Fondo

	for(int q=1;q<(LX/LTH)-1;q++)
	{
		for(int f=1;f<(LY/LTH)-1;f++)
		{
			if((q==(LX/LTH)/2)&&(f==(LY/LTH)/2))
			{
			}
			else
			{
				int fondo[3]={8,q,f};
				pintar(fondo);
			}

		}
	}
	//Bordes
	for(int q=0;q<LX/LTH;q++)
	{
		int borde1[3]= {3, q, 0};
		pintar(borde1);
	}
	for(int q=0;q<LX/LTH;q++)
	{
		int borde2[3]= {3, q, (LY/LTH)-1};
		pintar(borde2);
	}
	for(int q=0;q<LY/LTH;q++)
	{
		int borde1[3]= {3, 0, q};
		pintar(borde1);
	}
	for(int q=0;q<LY/LTH;q++)
	{
		int borde1[3]= {3, (LX/LTH)-1, q};
		pintar(borde1);
	}
	snake[0][0]=0;
	snake[0][1]=(LX/LTH)/2;
	snake[0][2]=(LY/LTH)/2;
	for(int s=1;s<LARGO;s++)
	{
		snake[s][0]=8;
		snake[s][1]=(LX/LTH)/2;
		snake[s][2]=(LY/LTH)/2;
	}
	pintar(snake[0]);
	comida[0]=4;
	comida[1]=foodgen(0);
	comida[2]=foodgen(1);
	pintar(comida);
}

/// Genera la posición aleatoria de la comida.
int foodgen (int pos)
{
	int info[2];
	info[0]=rand()%19 +1 ;
	info[1]=rand()%14 +1;


	if(pos==0)
	{
		printf("x : %i\n",info[0]);
		return info[0];

	}
	else
	{
		printf("y : %i\n",info[1]);
		return info[1];
	}
}

/// Imprime en pantalla que ha perdido.

static void fail(void)
{
	for(int i=0;i<LX*LY;i++)
	{
		lcd_write(1,0xF800);
	}

}


//Lógica del juego.

static void try(void)
{
	inicio();


	while(1)
	{
			for (int p= 1;p<LARGO;p++)
			{
				if(snake[p][0]==0)
				{
					if((snake[0][1]==snake[p][1]) && (snake[0][2]==snake[p][2]))
					{
						fail();
						busy_wait(20);
						inicio();
					}
				}
			}


			if((snake[0][1]==comida[1])&&(snake[0][2]==comida[2]))
			{
				points++;
				comida[1]=foodgen(0);
				comida[2]=foodgen(1);
				pintar (comida);
				printf("points : %i\n",points);
				if(points%2 ==0 )
				{
					lvl++;
				}
			}


			for(int w=1;w<=points;w++)
			{
				snake[w][0]=0;
			}
			dir= dir_global;
			switch(dir)
			{
				case 1:
						inicio();
						break;

				case 2:
					for(int p=points+2;p>0;p--)
					{
						snake[p][1]=snake[p-1][1];
						snake[p][2]=snake[p-1][2];
					}

					if(snake[0][2]==1)
					{
						snake[0][2]=(LY/LTH)-2;
					}
					else
					{
						snake[0][2]--;
					}

					for(int p=0;p<points+2;p++)
					{
						pintar(snake[p]);
					}

					break;

				case 4:
				for(int p=points+2;p>0;p--)
				{
					snake[p][1]=snake[p-1][1];
					snake[p][2]=snake[p-1][2];
				}
					if(snake[0][1]==1)
					{
						snake[0][1]=(LX/LTH)-2;
					}
					else
					{
						snake[0][1]--;
					}
					for(int p=0;p<points+2;p++)
					{
						pintar(snake[p]);
					}
					break;
				case 8:
				for(int p=points+2;p>0;p--)
				{
					snake[p][1]=snake[p-1][1];
					snake[p][2]=snake[p-1][2];
				}
					if(snake[0][1]==(LX/LTH)-2)
					{
						snake[0][1]=1;
					}
					else
					{
						snake[0][1]++;
					}
					for(int p=0;p<points+2;p++)
					{
						pintar(snake[p]);
					}
					break;
				case 16:
				for(int p=points+2;p>0;p--)
				{
					snake[p][1]=snake[p-1][1];
					snake[p][2]=snake[p-1][2];
				}
					if(snake[0][2]==(LY/LTH)-2)
					{
						snake[0][2]=1;
					}
					else
					{
						snake[0][2]++;
					}
					for(int p=0;p<points+2;p++)
					{
						pintar(snake[p]);
					}
					break;

				default:
					break;
			}
		busy_wait(5-(lvl*(0.5)));
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
		//buttons();
		screen();
	//else if(strcmp(token, "play") == 0)
		//try();
	else if(strcmp(token, "a") == 0)
		try();

	//}
	prompt();
}



int main(void)
{
	irq_setmask(0);
	irq_setie(1);
	lcd_configure();
	buttons();	
	uart_init();
	

	printf("get maska %X \n",irq_getmask());
	printf("get maski %X \n",irq_pending());
	printf("get maske %x \n",(irq_getmask() | (1 << 4)));

	puts("\nLab004 - CPU testing software built "__DATE__" "__TIME__"\n");
	help();
	prompt();

	while(1) {
		console_service();
	}

	return 0;
}
