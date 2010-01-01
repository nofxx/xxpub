// Rock

/* Data Types
http://www.eqqon.com/index.php/Ruby_C_Extension

T_NIL		nil
T_OBJECT	ordinary object
T_CLASS		class
T_MODULE	module
T_FLOAT		floating point number
T_STRING	string
T_REGEXP	regular expression
T_ARRAY		array
T_FIXNUM	Fixnum(31bit integer)
T_HASH		associative array
T_STRUCT	(Ruby) structure
T_BIGNUM	multi precision integer
T_FILE		IO
T_TRUE		true
T_FALSE		false
T_DATA		data
T_SYMBOL	symbol

Internal:
T_ICLASS
T_MATCH
T_UNDEF
T_VARMAP
T_SCOPE
T_NODE

== Check

void Check_Type(VALUE value, int type)
Faster fixnum & nil
FIXNUM_P(obj)
NIL_P(obj)
TYPE(value)
FIXNUM_P(value)
NIL_P(value)
void Check_Type(VALUE value, int type)
void Check_SafeStr(VALUE value)

== Conversion

C -> Ruby

INT2NUM(int)  	-> Fixnum or Bignum
INT2FIX(int) 	-> Fixnum (faster)
INT2NUM(long or int) 	-> Fixnum or Bignum
INT2FIX(long or int) 	-> Fixnum (faster)
CHR2FIX(char) 	-> Fixnum
rb_str_new2(char *) 	-> String
rb_float_new(double) 	-> Float

StringValue(value)
StringValuePtr(value)
StringValueCStr(value)

Ruby -> C

int  	NUM2INT(Numeric)  	(Includes type check)
int 	FIX2INT(Fixnum) 	(Faster)
unsigned int 	NUM2UINT(Numeric) 	(Includes type check)
unsigned int 	FIX2UINT(Fixnum) 	(Includes type check)
long 	NUM2LONG(Numeric) 	(Includes type check)
long 	FIX2LONG(Fixnum) 	(Faster)
unsigned long 	NUM2ULONG(Numeric) 	(Includes type check)
char 	NUM2CHR(Numeric or String) 	(Includes type check)
char * 	STR2CSTR(String) 	
char * 	rb_str2cstr(String, int *length) 	Returns length as well
double 	NUM2DBL(Numeric)

VALUE str, arr;
RSTRING(str)->len -> length of the Ruby string
RSTRING(str)->ptr -> pointer to string storage
RARRAY(arr)->len  -> length of the Ruby array
RARRAY(arr)->capa -> capacity of the Ruby array
RARRAY(arr)->ptr  -> pointer to array storage

== String

char * STR2CSTR(String)     #converte uma String Ruby em um ponteiro de char em C (char *)
VALUE rb_str_new2(char *)   #cria uma String em Ruby baseado em uma String em C

rb_str_new(const char *ptr, long len)             Creates a new Ruby string.
rb_str_new2(const char *ptr)                      Creates a new Ruby string from a C string.  This is equivalent to rb_str_new(ptr, strlen(ptr)).
rb_tainted_str_new(const char *ptr, long len)     Creates a new tainted Ruby string.  Strings from external data sources should be tainted.
rb_tainted_str_new2(const char *ptr)              Creates a new tainted Ruby string from a C string.
rb_str_cat(VALUE str, const char *ptr, long len)  Appends len bytes of data from ptr to the Ruby string.

== Array

rb_ary_new()                                      Creates an array with no elements.
rb_ary_new2(long len)                             Creates an array with no elements, allocating internal buffer for len elements.
rb_ary_new3(long n, ...)                          Creates an n-element array from the arguments.
rb_ary_new4(long n, VALUE *elts)                  Creates an n-element array from a C array.
rb_ary_push(VALUE ary, VALUE val)
rb_ary_pop(VALUE ary)
rb_ary_shift(VALUE ary)
rb_ary_unshift(VALUE ary, VALUE val)
*/

#include <ruby.h>
#include <stdio.h>

VALUE rb_mXC, rb_cRock, rb_mXmath;

static VALUE 
putis(VALUE self, VALUE string){
	Check_Type(string, T_STRING);
	printf("%s", RSTRING(string)->ptr);
	return Qnil;
}

static VALUE 
xcat(VALUE self, VALUE string) {
	//CheckType(string, T_STRING);
	VALUE foo;
	char *res = "C";
  // char *rub = STR2CSTR(string);
  // char *out;
  // 
  // //out = (char *)calloc(strlen(str1) + strlen(str2 ) + 1, sizeof(char));
  // out = (char *)malloc((strlen(rub) + strlen(res) + 1) *sizeof(char)); 
  // 
  // strcat(out, res);
  // strcat(out, rub);
	foo = rb_str_cat(string, res, strlen(res));//rb_str_new2(out);
	//free(out);
	return foo;
}

static VALUE 
xcalc(VALUE self, VALUE val) {
	double foo;
	double c_val = NUM2DBL(val);
	foo = 3.3 + c_val;		
	return rb_float_new(foo);
}

static VALUE readbool(VALUE self, VALUE val) {
	int c_val;
	c_val = NUM2INT(val);
	if (c_val > 10) {
		return Qtrue; //INT2NUM(8); 
  } else {
		return Qfalse;
	}
}

static VALUE dist(VALUE self, VALUE a, VALUE b) {
  double c_a = NUM2DBL(a);
  double c_b = NUM2DBL(b);
  return rb_float_new(c_a - c_b);  
}

static VALUE ary(VALUE self, VALUE in_ary) {

  int len = RARRAY(in_ary)->len;
  VALUE* dataPtr = RARRAY(in_ary)->ptr;
  // Create new Ruby Array that is the same size as the one passed in.
  VALUE out_ary = rb_ary_new2(len);
  // Process each element in the input array
  // and place result in the corresponding element of the output array.
  int i, j, s_len, b;
  long v;
  for (i = 0; i < len; ++i) {
    VALUE value = dataPtr[i];
    int type = TYPE(value);
    switch (type) {
      case T_STRING: // make uppercase
      s_len = RSTRING(value)->len;
      char* s = RSTRING(value)->ptr;
      for (j = 0; j < s_len; ++j) {
        s[j] = toupper(s[j]);
      }
      break;
      case T_FIXNUM: // square
      v = FIX2INT(value);
      value = INT2FIX(v * v);
      break;
      case T_TRUE:
      value = Qfalse; // INT2FIX(!b);
      break;
      case T_FALSE: // flip
      //b = FIX2INT(value);
      value = Qtrue; // INT2FIX(!b);
      break;
    } // of switch
    rb_ary_store(out_ary, i, value);
  }
  return out_ary;
} // end of process function

void 
Init_rock()
{
	rb_mXC = rb_define_module("XC");
	rb_mXmath = rb_define_module("Xmath");
	rb_cRock = rb_define_class_under(rb_mXC, "Rock", rb_cObject);

	rb_define_method(rb_cRock, "putis", putis, 1);
  rb_define_method(rb_cRock, "xcat", xcat, 1);
  rb_define_singleton_method(rb_mXmath, "xcalc", xcalc, 1);
  rb_define_singleton_method(rb_mXmath, "readbool", readbool, 1);
  rb_define_singleton_method(rb_mXmath, "dist", dist, 2);
  rb_define_singleton_method(rb_mXmath, "ary", ary, 1);
	//rb_define_method(rb_mXC, "hello_world", hello_world, 0);

}

