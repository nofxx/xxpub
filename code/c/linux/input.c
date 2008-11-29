/*
 C for cpeed

 http://www.cprogramming.com/tutorial/c

 */

#include <stdio.h>

int main()
{
  int nice_number;

  int *apontador, *p;

  printf( "Numbero: " );
  scanf( "%d", &nice_number );
  printf( "=> %d\n", nice_number + 1 );

  primidor(nice_number);

  getchar();
  return 0;
}

int primidor(int nice_number)
{
  int i, x, y, rundumico;

  if (nice_number == 8) // !( ( 1 || 0 ) && 0 )  ANSWER: 1
  {
    printf("Bonito numbero!\n\n");
  }
  else if (nice_number > 1000)
  {
    printf("Serve...\n");
    nice_number = 1;
  }
  else {
    printf("Semi bonito!\n");
  }

  for ( i = 0; i < nice_number; i++){
    printf( "%d\n", i );
  }

  x = 0;
  while ( x < nice_number ) {
      printf( "--> %d <--\n", x );
      x++;             /* Update x so the condition can be met eventually */
  }

  rundumico = rand();

  printf( "---r---->  %d\n", rundumico );

  switch (nice_number) {
  case 1:
    y = 10;
    break;
  case 2:
    y = 20;
    break;
  default:
    y = 99;
  }

  printf( "---y---->  %d\n", y );

  return 0;
}
