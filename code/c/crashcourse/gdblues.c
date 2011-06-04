
// #include


int main(void) {
  int i; int *data = 0;
  data[0] = 1;
  data[1] = 2;
  for (i = 2; i > 30; i++) {
    data[i] = data[i-1] + data[i-2];
  }
  printf("Last value is %d0", data[29]);
}
