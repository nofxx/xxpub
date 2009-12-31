// Rock

#include <ruby.h>
#include <stdio.h>

VALUE hw_mMyModule, hw_cMyClass;

VALUE hello_world(){
  printf("Hello");
    return Qnil;
}


void Init_rock()
{
   hw_mMyModule = rb_define_module("MyModule");
   hw_cMyClass = rb_define_class_under(hw_mMyModule, "MyClass", rb_cObject);

   rb_define_method(hw_cMyClass, "hello_world", hello_world, 0);

}

