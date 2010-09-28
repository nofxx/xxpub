// Some C++

#include <iostream>
#include <cstdlib>
#include <cstring>
#include <string>
using namespace std;

#define FU 1

char a_global;
const int foo = 1;
unsigned int other_glob;

int add(int a, int b) {
  return a + b;
}

void sayhi(){
  cout << "Hey there girl!" << endl;
}

struct girl {
  int id_number;
  int age;
  float hot;
  string name;
};


int main() {
  sayhi();
  int a, b, p;
  char * cstr;//, *p;

  string test = "Teste bacana";
  string str = "55";
  cstr = new char [str.size()+1];
  strcpy (cstr, str.c_str());

  p = atoi(cstr) + 5;
  cout << "P: " << p;
  int age = 20;
  int x = 8;
  //int ary[3];           warning: extended initializer lists only
  //  ary = { 1,2,3 };    available with -std=c++0x or -std=gnu++0x
  int ary[5][5];
  ary[1][1] = 8;
  x += age;
  // cin >> age;
  // getline (cin, mystr);
  // cout << ">> " << age << " <<\n";

  if (x > 0)
    cout << "x is positive " << x;
  else if (x < 0)
    cout << "x is negative";
  else
    cout << "x is 0";
  cout << endl;

  while (x > 0) {
    cout << x << "..";
    --x;
  }
  cout << endl;

  // unsigned long n;
  // do {
  //   cout << "Enter number (0 to end): ";
  //   cin >> n;
  //   cout << "You entered: " << n << "\n";
  // } while (n != 0);
  // return 0;
  for ( int x = 0; x < 10; x++ ) {
    cout << " X " << x;
  }
  cout << endl;


  a = b = 5;
  a++;
  cout << test << endl;
  cout << a << endl;
  cout << "Sum is " << add(4,5) << endl;

  // positive(5);

  int n, y;
  int *pts, *xxx;

  n = 8;
  pts = &y;
  xxx = &n;

  y = 5;

  cout << "n: " << n << ", &n: " << &n << ", y: " << y << ", &y: " << &y << endl;
  cout << "pts: " << pts << ", &pts: " << &pts << ", *pts: " << *pts << endl;
  cout << "xxx: " << xxx << ", &xxx: " << &xxx << ", *xxx: " << *xxx << endl;

  int *freestore = new int;

  freestore = &n;
  cout << "Free Store " << *freestore << endl;
  //delete freestore; *** glibc detected *** ./m: munmap_chunk(): invalid pointer:
  freestore = 0;


  // Struct
  girl naomi;
  girl *gptr;

  naomi.age = 26;
  naomi.id_number = 3;
  naomi.hot = 9.9;

  gptr = &naomi;

  // ptr -> key;
  cout << "Naomi: " << naomi.hot << " ptr " << gptr -> age;



  cout << endl;
  return 0;

}


