#include <stdio.h>

int result=0;
void removeNumber(const char* str);
void mirrorbmp8(void* image,int width,int hight);


int main( int argc, const char* argv[] )
{


	
	
	int image[100][3]; // first number here is 1024 pixels in my image, 3 is for RGB values
	FILE *streamIn;
	streamIn = fopen("./sw.bmp", "r");
	if (streamIn == (FILE *)0){
		printf("File opening error ocurred. Exiting program.\n");
		return 1;
	}
	char magic[42];
	fread(magic,1,sizeof(magic),streamIn);
	printf("Magic: %s",magic->bfType);
	
	fclose(streamIn);

    return 0;
}
