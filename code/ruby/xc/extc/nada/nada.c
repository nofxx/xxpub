#include "ruby.h" 
static int id_push; 
static VALUE t_init(VALUE self) 
{ 
  VALUE arr; 
  arr = rb_ary_new(); 
  rb_iv_set(self, "@arr", arr); 
  return self; 
} 

static VALUE t_add(VALUE self, VALUE obj) 
{ 
  VALUE arr; 
  arr = rb_iv_get(self, "@arr"); 
  rb_funcall(arr, id_push, 1, obj); 
  return arr; 
} 
VALUE cTest; 

static VALUE t_calc(VALUE self, VALUE obj)
{
  VALUE point; 
  point = rb_iv_get(self, "@point");    
  float r;
  r = rb_float_new(point);
  return r + 10;
}
VALUE cTest;

void Init_nada() { 
  cTest = rb_define_class("Nada", rb_cObject); 
  rb_define_method(cTest, "initialize", t_init, 0); 
  rb_define_method(cTest, "add", t_add, 1); 
  rb_define_method(cTest, "somero", t_calc, 1);
  id_push = rb_intern("push"); 
}