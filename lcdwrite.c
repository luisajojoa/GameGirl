
#include "lcdwrite.h"
 void lcd_write(unsigned char rs, unsigned int data)
{
	rs_out_write(rs);
	lcd_mosi_data_write(data<<16);
	lcd_start_write(1);
	while(lcd_active_read()){}

}
