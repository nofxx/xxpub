#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
//typedef enum {FALSE=0, TRUE} Boolean


typedef int Cents;
typedef char *String;

typedef struct {int age; char *name} person;
person people;

#define ABS(x) ((x) < 0) ? -(x) : (x)
#define MAX(a,b)       (a < b) ? (b) : (a)


struct UData {
  char name[10];
  int test;
  float foo;
};

struct XData {
  char *name;
  int test;
  float foo;
};

union ChorI {
  char c;
  int i;
};

int megacorp; // static, global...
extern int megacorp_i; // access from other files

/* methods before main! */
void primidor(int algo)
{
  int total;
  total = 100 * algo;
  printf("Total %d \n", total);
}

void space(){
  printf("\n-------------\n");
}

main()
{
  /* * * * * * * * * * * * * * * * * * * * * *

    PRIMITIVES

  */

  const m = 0;

  int x = 1, y = 5, z;
  int xo = 045;
  int xh = 0x8F;

  float xx, yy = 23.6e-2;
  double zz = 23.1L;
  double jazz = 23.1535e-33;


  char a;
  char c = 'x';
  char uc = toupper(c);

  int cn = (int)c;
  printf("x to i: %d\n", cn);

  short int si;
  long int li;
  signed int ssi;
  unsigned int ui;

  // Typedef
  String foo = "hellou";
  printf(foo);

  // Extra
  volatile char *gas = "O2";
  static char *eletric = "zzz";
  printf(gas);
  space();

  int abx = -5;
  abx = ABS(abx);
  printf("ABS preprocessor func: %i\n", abx);


  size_t sizt;
  sizt = 10;

  printf("Sizt: %i\n", sizt);

  // scanf (“%d %d”, &num1, &num2); //inputs the operands

  printf("\n-------------------\n");

  x = y + 5;
  xx = 23.344;
  printf("%d %d %d\n", x, xo, yy);

  x++;
  y = ( x > 100) ? 10 : 20;
  printf("x++:  x=%d, y=%d\n", x, y);

  int n = 4;

  int b = ~(1 << 2);
  if(b == -0b101)
    printf("IGUAL\n");

  printf("x: %d y: %d", n, b);
  primidor(2);
  // int input;
  // scanf("%d", &input);


  /* * * * * * * * * * * * * * * * * * * * * *

    ARRAY

  */
  printf("\n-------- Array\n");

  char buf[3];
  char out[50];
  buf[1] = 'a';
  buf[0] = 'y';
  buf[2] = 'x';

  int j;
  for(j = 0; j < 3; j++) {
    printf("Buf #%d: %c\n", j, buf[j]);
  }


  int ary[] = {10, 20, 30};
  int oary[10] = {1, 2};

  int st = ary[1];
  int len = sizeof(ary) / sizeof(int);

  printf("Buf: %c, Ary: %d, st: %d\n", buf[0], oary[1], st); // %s SEGFAULTS!
  printf("Ary: %x, Buf: %x, st: %d\n", ary, buf, st);
  printf("Ary len: %d", len);



  /* * * * * * * * * * * * * * * * * * * * * *

    LOOP

  */
  printf("\n-------- Loop\n");

  int i;
  for(i=0; i<3; i++) {
    sprintf(out, "Buf %i: %c\n", i, buf[i]);
  }
  printf(out);
  printf(buf);

  while(x > 0) {
    printf("X maior q zero...%i ", x);
    x--;
  }

  int cc = 0;
  while(1==1){
    cc++;
    if(cc % 2 == 0)
      continue;

    printf("CC -> %i", cc);

    if(cc >= 10)
      break;

    cc++;
  }

  /* * * * * * * * * * * * * * * * * * * * * *

    Strings

  */
  printf("\n-------- Strings\n");

  char mString[100];
  char *a1 = "oioioi";

  strcpy(mString, a1);

  printf(mString);

  char otherBuffer[10];
  char *hoho = "bla";

  strcpy(otherBuffer, "\nhi");
  strcat(otherBuffer, "hoho");
  strcat(otherBuffer, hoho);

  printf(otherBuffer);


  /*Specifier Meaning

    %c – Print a character
    %d – Print a Integer/Long Integer
    %i – Print a Integer
    %e – Print float value in exponential form.
    %f – Print float value
    %g – Print using %e or %f whichever is smaller
    %o – Print actual value
    %s – Print a string
    %x – Print a hexadecimal integer (Unsigned) using lower case a – f
    %X – Print a hexadecimal integer (Unsigned) using upper case A – F
    %a – Print a unsigned integer.
    %p – Print a pointer value
    %hx – hex short
    %lo – octal long
    %ld – long decimal integer
  */

  /* * * * * * * * * * * * * * * * * * * * * *

    TYPECAST

  */
  printf("\n-------- Typecast\n");

  char fu = (char)i;
  printf("Fu %c", fu);

  for ( i = 0; i < 256; i++ ) {
    /* Note the use of the int version of x to output a number and the use
     * of (char) to typecast the x into a character which outputs the
     * ASCII character that corresponds to the current number
     */
    //if(i % 10 == 0)
      //      printf("\n");
      //    printf( "%d = %c - ", i, i );
  }

  printf("\n");

  char numb = "55";
  int numbi;
  //numbi = atoi(numb);

  printf("Number: ");

  char *frase = "weed is all you need";

  n = strlen(frase);

  printf("\n-------- Strings\n");

  printf("A frase \"%s\" tem %d letras", frase, n);



  char t1[20]; // = "oi";
  char t2[] = "oix";

  strcpy(t1, t2);

  if(strcmp(t1, t2) == 0)
    printf("A1 igual A2");

  strcat(t1, t2);

  printf("T1 eh %s", t1); //  strupr(t1));


  /* * * * * * * * * * * * * * * * * * * * * *

    POINTERS

  */

  printf("\n-------- Pointers\n");

  int letra_m = 0b1101101;
  int *ponta;

  ponta = &letra_m; // address of letra_m

  printf("Ponta vale s: '%s', d: %d, x: %x, p: %p!\n", ponta, ponta, ponta);

  int outra_m = *ponta;
  printf("%cutante e point %c address %d\n", outra_m, *ponta, (int)ponta);

  char outro_char = (char*)ponta;

  *ponta = 88; // changes letra_m !

  printf("%cutante e char %c\n", outra_m, outro_char);
  printf("%cutante\n", letra_m);

  *ponta = 109;
  printf("%cutante\n", letra_m);

  char *bigstring = "blablablablabla";
  puts(bigstring);

  /* * * * * * * * * * * * * * * * * * * * * *

    STRUCTS

  */

  printf("\n-------- Structs\n");

  struct UData ud;
  struct UData *ptr;
  ptr = &ud;

  *ud.name = "foo";
  ud.test = 1;
  ptr->foo = 2.89; // ud.foo

  printf("%s test %i\n", ud.name, ud.test);
  printf("%s test %i\n", ptr->name, ptr->test);

  struct XData xd;
  struct XData *xptr;
  xptr = &xd;

  xd.name = malloc(100);
  strcpy(xd.name, "joe hi");

  printf("%s test %i\n", xd.name, xd.test);

  static struct XData sd = { "Foooo", 1, 2.2 };

  printf("%s test %i\n", sd.name, sd.test);

  union ChorI ch;
  ch.i = 99;
  printf("CH.c %c", ch.c);

  printf("\n<--------- FIM\n");
}


size_t strlen(const char *str) {
  size_t i;
  for(i = 0U; str[i]; ++i); //When the loop exits, i is the length of the string
  return i;
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
