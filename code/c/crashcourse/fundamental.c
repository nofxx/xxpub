#include <stdio.h>

main()
{
  int x = 1, y = 5, z;
  int xo = 045;
  int xh = 0x8F;
  
  
  float xx, yy = 23.6e-2;
  double zz = 23.1L;
  
  char a;
  char c = 'x';
  
  
  x = y + 5;
  xx = 23.344;
  printf("%d %d %d\n", x, xo, yy);
  x++;
  y = ( x > 100) ? 10 : 20;
  printf("x++:  x=%d, y=%d\n", x, y);
  
  primidor(2);
  // int input;
  // scanf("%d", &input);
}

void primidor(int algo)
{
  int total;
  total = 100 * algo;
  printf("Total %d \n", total);
}

// Table 1: Keywords (K & R, p. 192)
// Data Type Declarations                 Control Flow Statements
// auto float long  static  unsigned        break do  if
// char enum  register  struct  void        case  else  return
// const  extern  short typedef volatile    continue  for switch
// double int signed  union                 default  goto  while

// arithmetic operators
// *, / , %, +, -

// logical operators
// <,>, <=, >=, ==, !=, &&, ||

// =, +=, -=, *=, /=, %= !
// ++, --

// !
// !(0) ==> 1
// !(any non-zero value) ==> 0
// conditional, compact if-else as an expression instead of a statement
// ?
// (type)
// casts object into a different type
// , (comma)
// combines separate expressions into one
// evaluates them from left to right
// the value of the whole expression is the value of the right most sub-expression