/*
 Pointers

 http://www.cprogramming.com/tutorial/c

 */
#include <stdlib.h>
#include <stdio.h>

int main()
{
  int x, numb;
  int *apont, *p;

  int *pta = malloc(sizeof(int));
  int *ptb = malloc(sizeof(*ptb));

  apont = &x;

  printf( "Numbero: " ); // Read it, "assign the address of x to p"

  scanf( "%d", &x );  // Put a value in x, we could also use p here

  printf( "=> %d\n", *apont );

  getchar();

  free(pta);
  free(ptb);
  return 0;
}
