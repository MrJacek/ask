#include <stdio.h>

int mirrorbmp1(void* image,int width,int hight);
char *int2bin(int a, char *buffer, int buf_size);

#define BUF_SIZE 33
int main(int argc, char *argv[]) 
{
	unsigned char *content; 
	char *path;
	int* width;
	int* hight;
	int size;
	unsigned int headersize;
	char bytes[4];
	char buffer[BUF_SIZE];
	buffer[BUF_SIZE - 1] = '\0';
	
	if (argc < 2) {
        printf("wymagane podanie 1 parametr: nazwa pliku obrazu bmp");
        return 0;
    }
	path = argv[1];
	
	size = load(path, &content);
	headersize = *(content+14);
	
	if( headersize != 108)
	{
		printf("nieprawidłowy naglowek pliku!\n");
		printf("oczekiwano 108 bajtow!\n");
		printf("mamy %u!\n",headersize);
		return 0;
	}
	
	width = (int*)(content+18);
	hight=(int*)(content+22);
	int htmp=(*hight);
	int wtmp=(*width);

	//int mirrorbmp1(void* image,int width,int hight);
	unsigned int r=mirrorbmp1((content+headersize),wtmp,htmp);
    printf("eax=%s\n",int2bin(r, buffer, BUF_SIZE - 1));
	printf("eax=%d\n",r);
	save(size, &content);
	return 0;
}


int load(char *filename, char **result) 
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
char *int2bin(int a, char *buffer, int buf_size) {
    buffer += (buf_size - 1);
	int i=31;
    for (i; i >= 0; i--) {
        *buffer-- = (a & 1) + '0';

        a >>= 1;
    }

    return buffer;
}

#define BUF_SIZE 33


int save(int size, char **content)
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
