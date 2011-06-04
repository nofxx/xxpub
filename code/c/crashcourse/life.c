/*********************************************************/
/*                                                       */
/* Game of Life                                          */
/*                                                       */
/*********************************************************/

   /* Based upon an article from Scientific American */
   /* in 1970. Simulates the reproduction of cells   */
   /* which depend on one another. The rules are     */
   /* that cells will only survive if they have a    */
   /* certain number of neighbours to support them   */
   /* but not too many, or there won't be enough     */
   /* food!                                          */

#include <stdio.h>

#define SIZE          20
#define MAXNUM        15
#define INBOUNDS      (a>=0)&&(a<SIZE)&&(b>=0)&&(b<SIZE)
#define NORESPONSE     1

/*********************************************************/
/* Level 0                                               */
/*********************************************************/

main ()

{ int count[SIZE][SIZE];
  char array[SIZE][SIZE];
  int generation = 0;

printf ("Game of Life\n\n\n");
InitializeArray(array);

while (NORESPONSE)
   {
   CountNeighbours(array,count);
   BuildNextGeneration(array,count);
   UpdateDisplay(array,++generation);

   printf ("\n\nQ for quit. RETURN to continue.\n");
   if(quit()) break;
   }
}

/**********************************************************/
/* Level 1                                                */
/**********************************************************/

InitializeArray (array)     /* Get starting conditions */

char array[SIZE][SIZE];

{ int i,j;
  char ch;

printf ("\nEnter starting setup. Type '.' for empty");
printf ("\nand any other character for occupied.\n");
printf ("RETURN after each line.\n\n");
printf ("Array size guide:\n\n");

for (i=0; i++ < SIZE; printf("%c",'^'));
printf ("\n\n");

for (i = 0; i < SIZE; i++)
   {
   for (j = 0; j < SIZE; j++)
      {
      scanf ("%c",&ch);
      if (ch == '.')
         {
         array[i][j] = '.';
         }
      else
         {
         array[i][j] = '*';
         }
      }
   skipgarb();
   }

printf ("\n\nInput is complete. Press RETURN.");
skipgarb();
}

/********************************************************/

CountNeighbours (array,count) /* count all neighbours */

char array[SIZE][SIZE];
int count[SIZE][SIZE];

{ int i,j;

for (i = 0; i < SIZE; i++)
   {
   for (j = 0; j < SIZE; j++)
      {
      count[i][j] = numalive(array,i,j);
      }
   }
}

/*******************************************************/

BuildNextGeneration (array,count)

/* A cell will survive if it has two or three  */
/* neighbours. New life will be born to a dead */
/* cell if there are exactly three neighbours  */

char array[SIZE][SIZE];
int count[SIZE][SIZE];

{ int i,j;

for (i = 0; i < SIZE; i++)
   {
   for (j = 0; j < SIZE; j++)
      {
      if (array[i][j] == '*')
         {
         switch (count[i][j])
            {
            case 2 :
            case 3 : continue;

            default: array[i][j] = '.';
                     break;
            }
         }
      else
         {
         switch (count[i][j])
            {
            case 3 : array[i][j] = '*';
                     break;
            default: continue;
            }
         }
      }
   }
}

/*******************************************************/

UpdateDisplay (array,g)     /* print out life array */

char array[SIZE][SIZE];
int g;

{ int i,j;

printf ("\n\nGeneration %d\n\n",g);

for (i = 0; i < SIZE; i++)
   {
   for (j = 0; j < SIZE; j++)
      {
      printf("%c",array[i][j]);
      }
   printf("\n");
   }
}

/*******************************************************/
/* Level 2                                             */
/*******************************************************/

numalive (array,i,j)

/* Don't count array[i,j] : only its neighbours */
/* Also check that haven't reached the boundary */
/* of the array                                 */

char array[SIZE][SIZE];
int i,j;

{ int a,b,census;

census = 0;

for (a = (i-1); (a <= (i+1)); a++)
   {
   for (b = (j-1); (b <= (j+1)); b++)
      {
      if (INBOUNDS && (array[a][b] == '*'))
         {
         census++;
         }
      }
   }

if (array[i][j] == '*') census--;

return (census);
}

/********************************************************/
/* Toolkit input                                        */
/********************************************************/

quit()

{ char ch;

while (NORESPONSE)
   {
   scanf ("%c",&ch);
   if (ch != '\n') skipgarb();
   switch (ch)
      {
      case 'q' : case 'Q' : return (1);
      default  :            return (0);
      }
   }
}

/********************************************************/

skipgarb ()

{
while (getchar() != '\n')
   {
   }
}

