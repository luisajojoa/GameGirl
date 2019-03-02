void gametest(void)
{
	int x=220;
	int y=176;
	int numtilesx=4;
	int numtilesy=2;

	int screen[x][y];


	//Creacion tiles
	for (int z=0;z<((numtilesx)*(numtilesy));z++){
		for(int i=0;i<(x/numtilesx);i++){
			for(int j=0;j<(y/numtilesy);j++){
				if(z==0){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x0000);
				}
				if(z==1){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0xFFFF);
				}
				if(z==2){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x03EF);
				}
				if(z==3){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x07E0);
				}
				if(z==4){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x9E66);
				}
				if(z==5){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x867D);
				}
                if(z==6){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x000F);
				}
                if(z==7){
					screen[x+((x/numtilesx)*z)][y+((y/numtilesy)*z)]=(0x8000);
				}
			}
		}
	}

	//Matriz de escritura pantalla
	for( int i=0;i<x;i++)
	{
		for (int j=0;j<y;j++){
			lcd_write(1,screen[i][j]);
		}
	}
}
