/*1. Escreva um algoritmo que leia e mostre em vetor de 20 elementos inteiros.
A seguir, conte quantos valores pares existem no vetor.*/
#include <stdio.h>

main(void) {
  int v[20],x=1,i=0;
  printf("Informe os 5 valores inteiros: \n");
  while(x<20) {
    scanf("%d\n",&v[x]);
    if(v[x]%2==0)
      i++;
      x++;
    }
    printf("Tem %d pares",i);
    getchar();               
}