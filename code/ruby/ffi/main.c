#include "xlib.h"

int main()
{
 double c, d ;
  int errcode ;
  struct SomeObject *objptr ;

  c = calculate_something(42, 98.6) ;
  if ((errcode = error_code()) != 0) {
    /* fprintf(stderr, "error calculating something: %d\n", errcode); */
    return 1;
  }

  objptr = create_object("my object") ;
  d = calculate_something_else(c, objptr) ;
  free_object(objptr) ;

  /* fprintf(stdout, "calculated %f\n", d); */
  return 0;
}
