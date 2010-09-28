#include <string>

using namespace std;

int more() {
  int ax;
  ax = 10;
  return 1;
}


void positive(int n) {
  string txt;
  if (n == 0) {
    txt = "zero";
  } else if (n > 0) {
    txt = "> zero";
  } else {
    txt = "negative";
  }
  // cout << txt;

}

void nameit(int n) {
  string txt;
  switch(n) {
  case 1:
    txt = "um";
    break;
  case 2:
    txt = "dois";
    break;
  default:
    txt = "qql";
    break;
  }
}

