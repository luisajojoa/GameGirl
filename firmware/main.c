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
	puts("reboot                           - restart game");
	puts("play                             - start game");
	puts("puntaje                             - start game");
}

static void reboot(void)
{
	asm("call r0");
}




static void lcd_configure(void)
{
	//printf("configurando \n");
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
		lcd_write(1,0x0000); //negro
		break;

		case (1):
		lcd_write(1,0xFFFF);  //blanco
		break;

		case (2):
		lcd_write(1,0xEC1D); //violeta
		break;

		case (3):
		lcd_write(1,0xF81F); //Magenta
		break;

		case (4):
		lcd_write(1,0xFFDF); //snow
		break;
		case (8):
		lcd_write(1,0x03E0); //dark green
		break;
		case (6):
		lcd_write(1,0x07E0); //Green
		break;

		case (5): //Borde
		lcd_write(1,0xFEA0); //light green
		break;

		case (9):
		lcd_write(1,0xFB08); //tomato
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
		case(5):
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=5;
			}
			break;
		}
		case(8): //Borde
		{
			for(int v=0; v<LTH*(LTH);v++)
			{
				data[v]=8;
			}
			break;
		}
		case(100):
		{
			return num0Uno[pos];
		}
		case(101):
		{
			return num0Dos[pos];
		}
		case(110):
		{
			return num1Uno[pos];

		}
		case(111):
		{
			return num1Dos[pos];

		}
		case(120):
		{
			return num2Uno[pos];

		}
		case(121):
		{
			return num2Dos[pos];
		}		
		case(130):
		{
			return num2Uno[pos];
		}
		case(131):
		{
			return num3Dos[pos];

		}
		case(140):
		{
			return num4Uno[pos];
		}
		case(141):
		{
			return num4Dos[pos];

		}
		case(150):
		{
			return num5Uno [pos];

		}
		case(151):
		{
			return num3Dos[pos];
		}
		case(160):
		{
			return num5Uno[pos];

		}
		case(161):
		{
			return num6Dos[pos];

		}
		case(170):
		{
			return num7Uno[pos];
		}
		case(171):
		{
			return num1Dos[pos];

		}
		case(180):
		{
			return num8Uno[pos];

		}
		case(181):
		{
			return num6Dos[pos];

		}
		case(190):
		{
			return num8Uno[pos];

		}
		case(191):
		{
			return num4Dos[pos];

		}
		case(200):
		{
			return snakeHeadRight[pos];
		}
		case(201):
		{
			return snakeHeadUp[pos];
		}
		case(202):
		{
			return snakeHeadLeft[pos];
		}
		case(203):
		{
			return snakeHeadDown[pos];
		}
		case(204):
		{
			return bod[pos];
		}
		case(205):
		{
			return food[pos];
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
void pintar(int info[3])
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
		for(int j=LTH;j>0;j--)
		{
			lcd_write(0,0x0021);
			lcd_write(1,(tilex*(LTH) +j));
			lcd_write(0,0x0022);
			decoColor(pix[121-z]);
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
		for(int f=1;f<(LY/LTH)-2;f++)
		{
			if((q==(LX/LTH)/2)&&(f==(LY/LTH)/2) || ((q==comida[1])&& (f==comida[2])))
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
		int borde1[3]= {5, q, 0};
		pintar(borde1);
	}
	for(int q=0;q<LX/LTH;q++)
	{
		int borde2[3]= {5, q, (LY/LTH)-1};
		pintar(borde2);
		int borde9[3]= {5, q, (LY/LTH)-2};
		pintar(borde9);
	}
	for(int q=0;q<LY/LTH;q++)
	{
		int borde1[3]= {5, 0, q};
		pintar(borde1);
	}
	for(int q=0;q<LY/LTH;q++)
	{
		int borde1[3]= {5, (LX/LTH)-1, q};
		pintar(borde1);
	}
	snake[0][0]=200;
	snake[0][1]=(LX/LTH)/2;
	snake[0][2]=(LY/LTH)/2;
	for(int s=1;s<LARGO;s++)
	{
		snake[s][0]=8;
		snake[s][1]=(LX/LTH)/2;
		snake[s][2]=(LY/LTH)/2;
	}
	pintar(snake[0]);
	comida[0]=205;
	puntaje(points);
}
void paintScore(int numero, int pot){
	int cuadro= 100+(numero*10);
	int draw[3];
	if(pot==0)
	{
		draw[0]=cuadro;
		draw[1]=16;
		draw[2]=15;
		pintar(draw);
		draw[0]=cuadro+1;
		draw[1]=16;
		draw[2]=14;
		pintar(draw);
	}else{
		draw[0]=cuadro;
		draw[1]=17;
		draw[2]=15;
		pintar(draw);
		draw[0]=cuadro+1;
		draw[1]=17;
		draw[2]=14;
		pintar(draw);
	}


}

void puntaje (int puntos){
	paintScore(puntos/10,0);
	paintScore(puntos%10,1);
}

/// Genera la posición aleatoria de la comida.
int foodgen (int pos)
{
	int info[2];
	info[0]=rand()%17 +1 ;
	info[1]=rand()%12 +1;


	if(pos==0)
	{
		return info[0];

	}
	else
	{
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
	gameGirlIntro();
}


//Lógica del juego.

static void try(void)
{
	comida[1]=foodgen(0);
	comida[2]=foodgen(1);
	inicio();
	pintar(comida);


	while(1)
	{
			for (int p= 1;p<LARGO;p++)
			{
				if(snake[p][0]==204)
				{
					if((snake[0][1]==snake[p][1]) && (snake[0][2]==snake[p][2]))
					{
						fail();
						busy_wait(20);
						comida[1]=foodgen(0);
						comida[2]=foodgen(1);
						inicio();
						pintar(comida);
					}
				}
			}


			if((snake[0][1]==comida[1])&&(snake[0][2]==comida[2]))
			{
				points++;
				comida[1]=foodgen(0);
				comida[2]=foodgen(1);
				puntaje(points);
				if(points%2 ==0 )
				{
					lvl++;
				}
			}
			pintar (comida);

			for(int w=1;w<=points;w++)
			{
				snake[w][0]=204;
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
						snake[0][2]=(LY/LTH)-3;
					}
					else
					{
						snake[0][2]--;
					}
					snake[0][0]=203;
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
					snake[0][0]=202;
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
					snake[0][0]=200;
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
					if(snake[0][2]==(LY/LTH)-3)
					{
						snake[0][2]=1;
					}
					else
					{
						snake[0][2]++;
					}
					snake[0][0]=201;
					for(int p=0;p<points+2;p++)
					{
						pintar(snake[p]);
					}
					break;

				default:
					break;
			}
		busy_wait(4.5-(lvl*(0.6)));
	}
}


void gameGirlIntro(void){
	int a=0xF81F;
	int b=0xA145;
	screen(0,176,0,220,b);

	screen(58,68,50,90,a);
	screen(68,98,90,110,a);
	screen(58,68,100,110,a);
	screen(88,98,80,90,a);
	screen(68,118,40,60,a);
	screen(118,128,50,100,a);	
	screen(108,118,90,110,a);	

	screen(58,68,140,180,a);
	screen(68,98,180,200,a);
	screen(58,68,190,200,a);
	screen(88,98,170,180,a);
	screen(68,118,130,150,a);
	screen(118,128,140,190,a);	
	screen(108,118,180,200,a);	
	busy_wait(5);

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

	else if(strcmp(token, "play") == 0)
		try();
	else if(strcmp(token, "puntaje") == 0)
		gameGirlIntro();
	prompt();
}



int main(void)
{
	irq_setmask(0);
	irq_setie(1);
	lcd_configure();
	lcd_initialize();
	buttons();	
	uart_init();
	help();
	gameGirlIntro();
	try();
	prompt();


	while(1) {
		console_service();
	}

	return 0;
}
