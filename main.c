#include <stdio.h>

int mirrorbmp1(void* image,int width,int hight);


int main(int argc, char *argv[]) 
{
	unsigned char *content; 
	char *path;
	int size;
	int level;
	int* width;
	int* hight;
	unsigned int headersize;
	short int bpp;
	char bytes[4];
	
	if (argc < 2) {
        printf("wymagane podanie 1 parametr: nazwa pliku obrazu bmp");
        return 0;
    }
	path = argv[1];
	
	
	
	size = load_file_to_memory(path, &content);
	headersize = *(content+14);
	
	if( headersize != 108)
	{
		printf("nieprawidłowy naglowek pliku!\n");
		printf("oczekiwano 108 bajtow!\n");
		printf("mamy %u!\n",headersize);
		return 0;
	}
	bytes[0]=*(content+28);
	bytes[1]=*(content+29);
	
	width = (int*)(content+18);
	
	if( *width < 0)
	{
		printf("nieprawidłowa szerokość obrazu!\n");
		printf("oczekiwano wartości powyżej 0!\n");
		printf("mamy %d!\n",*width);
		return 0;
	}
	printf("Szerokość: %d\n",*width);
	
	hight=(int*)(content+22);
	if( *hight < 0)
	{
		printf("nieprawidłowa wysokość obrazu!\n");
		printf("oczekiwano wartości powyżej 0!\n");
		printf("mamy %d!\n",*hight);
		return 0;
	}
	printf("Wysokość: %d\n",*hight);
	
	bpp = *(content+28);
	if( bpp != 1)
	{
		printf("nieprawidłowa rozdzielczość pikseli!\n");
		printf("oczekiwano wartości 8 bpp!\n");
		printf("mamy %hi!\n",bpp);
		return 0;
	}
	
	
	int htmp=(*hight);
	int wtmp=(*width);

	
	//int mirrorbmp1(void* image,int width,int hight);
	unsigned int r=mirrorbmp1((content+headersize),wtmp,htmp);
        printf("r=%d\n",r);
	
	save_file_from_memory(size, &content);
	return 0;
}


int load_file_to_memory(char *filename, char **result) 
{ 
	int size = 0;
	FILE *f = fopen(filename, "rb");
	if (f == NULL) 
	{ 
		printf("Nie mozna otworzyc pliku\n");
		*result = NULL;
		exit(-1); 
	} 
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	if (size < 0) 
	{ 
		printf("Błąd przy określaniu wielkości pliku\n");
		exit(-3);
	} 
	fseek(f, 0, SEEK_SET);
	*result = (char *)malloc(size+1);
	if (size != fread(*result, sizeof(char), size, f)) 
	{ 
		printf("błąd podczas odczytywania pliku\n");
		free(*result);
		exit(-2);
	} 
	fclose(f);
	(*result)[size] = 0;
	return size;
}

int save_file_from_memory(int size, char **content)
{
		FILE *ptr_fp;
		if((ptr_fp = fopen("mirror.bmp", "wb")) == NULL)
		{
			printf("Unable to open file!\n");
			exit(-1);
		}else printf("Opened file successfully for writing.\n");

		if(size != fwrite(*content, sizeof(char), size, ptr_fp) )
		{
			printf("Write error!\n");
			exit(1);
		}else printf("Write was successful.\n");
		fclose(ptr_fp);
		free(*content);
		return 0;
}
