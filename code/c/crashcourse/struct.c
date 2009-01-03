#include <stdio.h>

struct moto
{
  unsigned short int rodas;
  char nome[20];
  unsigned long int numberao;
};

int main(void)
{
  struct moto motocleta = {2, "josemar", 8429829};
  printf("Rodas : %hu\n", motocleta.rodas);
  puts("hey ho");
  return 0;
}