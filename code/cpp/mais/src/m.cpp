// Some C++

#include <iostream>  // cin, cout...
#include <iomanip>   // setprecision
#include <algorithm> // sort
#include <string>
#include <vector>
#include <ios>

// C
#include <cstdlib>
#include <cstring>

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

union u_tag {
  char c[4];
  int ival;
} u;

int main() {
  sayhi();
  int a, b, p;
  char * cstr;//, *p;

  string test = "Teste bacana";
  string str = "55";
  cstr = new char [str.size()+1];
  strcpy (cstr, str.c_str());

  p = atoi(cstr) + 5;
  cout << "P: " << p << endl;
  int age = 20;
  int x = 8;
  //int ary[3];           warning: extended initializer lists only
  //  ary = { 1,2,3 };    available with -std=c++0x or -std=gnu++0x
  int ary[5][5];
  ary[1][1] = 8;
  x += age;

  float flutua = 56.887;
  double boia  = 56.9999;
  cout << "Float -> " << flutua;
  cout << " Doube -> " << boia << endl;

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

  string stest = "Hey there";
  string stest2(10, '*');
  cout << endl << stest + "..." << stest2 << endl;
  cout << stest.size() << " chars" << endl;


  cout << "\nBYTEC\n";
  char bytec = '1';
  cout << int(bytec);

  char* cmdbuf;

  cout << "\n" "auto " "concat" << endl;

  vector<double> vtest;
  vtest.push_back(9.1);
  vtest.push_back(8.1);
  vtest.push_back(5.1);
  double xx = vtest[1];

  typedef vector<double>::size_type vec_sz;
  vec_sz size = vtest.size();

  sort(vtest.begin(), vtest.end());

  cout << "Vector..." << size << " - " << xx << endl;


  for(int i=0; i< size; i++) {
    cout << "V[" << i << "] " << vtest[i] << endl;
  }

  //  cout << "\nCMDBUF: " << *cmdbuf;


  cout << endl;
  return 0;

}

