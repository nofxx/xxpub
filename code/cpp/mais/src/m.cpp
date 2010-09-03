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
  cout << "Hey there!" << endl;
}

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
  int ary[3];
  ary = { 1,2,3 };
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

  // unsigned long n;
  // do {
  //   cout << "Enter number (0 to end): ";
  //   cin >> n;
  //   cout << "You entered: " << n << "\n";
  // } while (n != 0);
  // return 0;


  a = b = 5;
  a++;
  cout << test << endl;
  cout << a << endl;
  cout << "Sum is " << add(4,5) << endl;
  return 0;

}


